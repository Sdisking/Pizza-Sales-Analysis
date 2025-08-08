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
Retrieve the total number of orders placed.
Calculate the total revenue generated from pizza sales.
Identify the highest-priced pizza.
Identify the most common pizza size ordered.
List the top 5 most ordered pizza types along with their quantities.


## Intermediate:
Join the necessary tables to find the total quantity of each pizza category ordered.
Determine the distribution of orders by hour of the day.
Join relevant tables to find the category-wise distribution of pizzas.
Group the orders by date and calculate the average number of pizzas ordered per day.
Determine the top 3 most ordered pizza types based on revenue.

## Advanced:
Calculate the percentage contribution of each pizza type to total revenue.
Analyze the cumulative revenue generated over time.
Determine the top 3 most ordered pizza types based on revenue for each pizza category.

