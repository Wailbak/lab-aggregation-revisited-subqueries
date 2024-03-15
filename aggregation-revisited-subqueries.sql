USE sakila;


-- Selecting the first name, last name, and email address of all customers who have rented a movie.
SELECT DISTINCT
    c.first_name,
    c.last_name,
    c.email
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id;
---------------------------------------------------------------------------------------------------------------------------------------------

-- Calculating the average payment made by each customer
SELECT 
    c.customer_id, 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
    round(AVG(p.amount),2) AS average_payment
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, customer_name
ORDER BY 
    c.customer_id;
-------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Selecting the name and email address of all the customers who have rented the "Action" movies.

#Using : multiple join statements
SELECT DISTINCT
    c.first_name,
    c.last_name,
    c.email
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category cat ON fc.category_id = cat.category_id
WHERE 
    cat.name = 'Action';


#Using : sub queries with multiple WHERE clause and IN condition
SELECT 
    c.first_name,
    c.last_name,
    c.email
FROM 
    customer c
WHERE 
    c.customer_id IN (
        SELECT 
            r.customer_id
        FROM 
            rental r
        WHERE 
            r.inventory_id IN (
                SELECT 
                    i.inventory_id
                FROM 
                    inventory i
                WHERE 
                    i.film_id IN (
                        SELECT 
                            f.film_id
                        FROM 
                            film f
                        JOIN 
                            film_category fc ON f.film_id = fc.film_id
                        JOIN 
                            category cat ON fc.category_id = cat.category_id
                        WHERE 
                            cat.name = 'Action'
                    )
            )
    );

## we conclude that the two queries above give the same result
---------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating a new column classifying existing columns as either or high value transactions based on the amount of payment.
SELECT 
    payment_id,
    customer_id,
    amount,
    CASE 
        WHEN amount > 0 AND amount <= 2 THEN 'low'
        WHEN amount > 2 AND amount <= 4 THEN 'medium'
        WHEN amount > 4 THEN 'high'
    END AS value_classification
FROM 
    payment;















