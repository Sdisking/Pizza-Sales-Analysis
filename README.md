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


