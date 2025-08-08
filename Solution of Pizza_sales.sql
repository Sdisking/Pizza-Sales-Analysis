Create database Pizza_hut;
Use Pizza_hut;
Create Table order_details (
order_details_id int primary key,
order_id int,
pizza_id varchar(30),
quantity int);

Create table orders(
order_id int primary key,
Date date,
time time);

Create Table pizza_types (
pizza_type_id varchar(20) primary key,
name varchar(50),
category varchar(20),
ingredients varchar(110));

create table pizzas (
pizza_id varchar(30) primary key,
pizza_type_id varchar(20),
size varchar(1),
price Float);

-- Basic:
-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS Total_Orders_Placed
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(price * quantity), 2) AS Total_Revenue
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    name, price
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    size, COUNT(order_id) AS Total_Ordered
FROM
    order_details
        JOIN
    Pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY size
ORDER BY Total_Ordered DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    name, SUM(quantity) AS No_of_orders
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY name
ORDER BY No_of_orders DESC
LIMIT 5;

-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    Category, SUM(quantity) AS QTY_Ordered
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(time) AS Hours, COUNT(order_id) as No_of_Orders
FROM
    orders
GROUP BY hours
ORDER BY hours;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name) AS Pizza_Types
FROM
    pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(Pizza_Ordered), 2) AS Avg_Pizza_ordered_per_day
FROM
    (SELECT 
        date, SUM(quantity) AS Pizza_Ordered
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY Date
    ORDER BY date) AS quantity_ordered;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.pizza_type_id,
    name,
    SUM(quantity * price) AS Total_Revenue
FROM
    Pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.pizza_type_id , name
ORDER BY Total_Revenue DESC
LIMIT 3;

-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    name,
    ROUND(SUM(price * quantity) / (SELECT 
                    ROUND(SUM(price * quantity), 2) AS Total_Revenue
                FROM
                    pizzas
                        JOIN
                    order_details ON pizzas.pizza_id = order_details.pizza_id) * 100,
            2) AS Revenue_Percentage
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY name;

-- Analyze the cumulative revenue generated over time.
select Date,round(sum(revenue) over(order by date),2) as Cumulative_revenue from
(select date,round(sum(price*quantity),2) as Revenue from orders 
JOIN order_details ON orders.order_id = order_details.order_id 
join pizzas on pizzas.pizza_id = order_details.pizza_id group by date) as Daily_Revenue;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select Category,name,Revenue from
(select *,rank() over(partition by category order by revenue desc) as Ranked from
(select category,name,round(sum(price*Quantity),2) as Revenue from Pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
join order_details ON pizzas.pizza_id = order_details.pizza_id group by Category,name order by category) as abc)as xyz where ranked <=3;

