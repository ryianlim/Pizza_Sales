/* Join CSV files (Orders & Order details) */
CREATE TABLE orders_table AS
SELECT order_details_id, order_details.order_id, pizza_id, quantity, date, time
FROM order_details
INNER JOIN orders ON order_details.order_id = orders.order_id;

/* Join CSV files (Pizzas & pizza types details) */
CREATE TABLE pizza_table AS 
SELECT pizza_types.pizza_type_id, pizza_types.name, pizza_types.category, pizza_types.ingredients, pizzas.pizza_id, pizzas.size, pizzas.price
FROM pizzas 
INNER JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id;

/* Join both new tables (Order table & Pizza table) */
CREATE TABLE pizza_order_table AS 
SELECT pizza_type_id, name, category, ingredients, pizza_table.pizza_id, size, price, 
orders_table.order_details_id, orders_table.order_id, orders_table.quantity, orders_table.date, orders_table.time 
FROM pizza_table
INNER JOIN orders_table ON pizza_table.pizza_id = orders_table.pizza_id;


/* Check for Duplicates */
SELECT 
pizza_type_id, name, category, ingredients, pizza_id, size, price, order_details_id, order_id, quantity, date, time, count(*) as cnt 
from pizza_order_table
group by pizza_type_id, name, category, ingredients, pizza_id, size, price, order_details_id, order_id, quantity, date, time
having count(*) > 1;

/* Check for Null Value */
SELECT *
FROM pizza_order_table 
WHERE pizza_type_id IS NULL AND name IS NULL AND category IS NULL AND ingredients IS NULL AND pizza_id IS NULL AND size IS NULL
AND price IS NULL AND order_details_id IS NULL AND order_id IS NULL AND quantity IS NULL AND date IS NULL AND time IS NULL;

select * from pizza_order_table