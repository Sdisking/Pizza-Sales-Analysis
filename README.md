# Pizza-Sales-Analysis
# PROJECT OBJECTIVE
1) Analyze pizza sales data to extract business insights.
2) Answer business questions using SQL queries.
3) Focus on sales trends, pizza popularity, revenue, and order patterns.

# DATASET OVERVIEW
orders.csv – Contains order timestamps.
order_details.csv – Links orders with pizzas and quantity.
pizzas.csv – Pizza size and price.
pizza_types.csv – Type, category, and ingredients of pizzas.
Total Tables Used: 4

# Schema
```sql
Create database Pizza_hut;
Use Pizza_hut;
Create Table order_details (
order_details_id int primary key,
order_id int,
pizza_id varchar(30),
quantity int);
```
```sql
Create table orders(
order_id int primary key,
Date date,
time time);
```
```sql
Create Table pizza_types (
pizza_type_id varchar(20) primary key,
name varchar(50),
category varchar(20),
ingredients varchar(110));
```
```sql
create table pizzas (
pizza_id varchar(30) primary key,
pizza_type_id varchar(20),
size varchar(1),
price Float);
```
# Business Problems
## Basic:
1) Retrieve the total number of orders placed.
2) Calculate the total revenue generated from pizza sales.
3) Identify the highest-priced pizza.
4) Identify the most common pizza size ordered.
5) List the top 5 most ordered pizza types along with their quantities.


## Intermediate:
6) Join the necessary tables to find the total quantity of each pizza category ordered.
7) Determine the distribution of orders by hour of the day.
8) Join relevant tables to find the category-wise distribution of pizzas.
9) Group the orders by date and calculate the average number of pizzas ordered per day.
10) Determine the top 3 most ordered pizza types based on revenue.

## Advanced:
11) Calculate the percentage contribution of each pizza type to total revenue.
12) Analyze the cumulative revenue generated over time.
13) Determine the top 3 most ordered pizza types based on revenue for each pizza category.

# Solution
1) Retrieve the total number of orders placed.
```sqk
SELECT 
    COUNT(order_id) AS Total_Orders_Placed
FROM
    orders;
```

2) Calculate the total revenue generated from pizza sales.
```sql
SELECT 
    ROUND(SUM(price * quantity), 2) AS Total_Revenue
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;
```

3) Identify the highest-priced pizza.
```sql
SELECT 
    name, price
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY price DESC
LIMIT 1;
```

4) Identify the most common pizza size ordered.
```sql
SELECT 
    size, COUNT(order_id) AS Total_Ordered
FROM
    order_details
        JOIN
    Pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY size
ORDER BY Total_Ordered DESC
LIMIT 1;
```

5) List the top 5 most ordered pizza types along with their quantities.
```sql
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
```

6) Join the necessary tables to find the total quantity of each pizza category ordered.
```sql
SELECT 
    Category, SUM(quantity) AS QTY_Ordered
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category;
```

7) Determine the distribution of orders by hour of the day.
```sql
SELECT 
    HOUR(time) AS Hours, COUNT(order_id) as No_of_Orders
FROM
    orders
GROUP BY hours
ORDER BY hours;
```

8) Join relevant tables to find the category-wise distribution of pizzas.
```sql
SELECT 
    category, COUNT(name) AS Pizza_Types
FROM
    pizza_types
GROUP BY category;
```

9) Group the orders by date and calculate the average number of pizzas ordered per day.
```sql
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
```

10) Determine the top 3 most ordered pizza types based on revenue.
```sql
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
```

11) Calculate the percentage contribution of each pizza type to total revenue.
```sql
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
```

12) Analyze the cumulative revenue generated over time.
```sql
select Date,round(sum(revenue) over(order by date),2) as Cumulative_revenue from
(select date,round(sum(price*quantity),2) as Revenue from orders 
JOIN order_details ON orders.order_id = order_details.order_id 
join pizzas on pizzas.pizza_id = order_details.pizza_id group by date) as Daily_Revenue;
```

13) Determine the top 3 most ordered pizza types based on revenue for each pizza category.
```sql
select Category,name,Revenue from
(select *,rank() over(partition by category order by revenue desc) as Ranked 
from (select category,name,round(sum(price*Quantity),2) as Revenue 
from Pizza_types JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id 
join order_details ON pizzas.pizza_id = order_details.pizza_id 
group by Category,name order by category) as abc)as xyz where ranked <=3;
```

## 🔍 What I did:
**•	Queried and explored 4 relational tables using MySQL**

**•	Answered real-world business questions across basic, intermediate, and advanced levels**

**•	Applied joins, grouping, window functions, subqueries, and aggregations**

**•	Extracted key insights on:**

**o	Top-selling pizzas & revenue drivers 📊**

**o	Customer order behavior by hour 🕒**

**o	Category-wise sales performance 🍕**

**o	Daily trends & cumulative revenue over time 📈**

## 📌 Key Outcomes:
**•	Identified top 3 pizzas by revenue**

**•	Found peak order hours to support staffing decisions**

**•	Calculated revenue contribution of each pizza type**

**•	Used SQL to transform raw sales data into meaningful, strategic insights**

**✅ This project helped me strengthen my SQL skills for real-world analytics and reinforced the importance of data in making smart business decisions.**

**🛠️ Tools Used: MySQL, Excel | 📁 Datasets: orders, order_details, pizzas, pizza_types**

## SUMMARY & KEY TAKEAWAYS
**🔍 Explored a real-world sales dataset using structured SQL queries across varying complexity levels.**

**📈 Identified top-performing pizzas by order volume and revenue, as well as underperforming ones.**

**🕒 Discovered peak ordering hours and average daily order patterns to help optimize operations.**

**💰 Analyzed category-wise sales performance and cumulative revenue trends over time.**

**📊 Utilized advanced SQL techniques like window functions, ranking, and subqueries for deep insights.**

**🚀 Transformed raw sales data into actionable business intelligence, reinforcing SQL’s value in data-driven decision-making.**
