use SAKILA;

-- Lab 6
#1 Drop the "picture" column from the "staff" table
ALTER TABLE staff
DROP COLUMN picture;

#2 Insert a new staff member named Tammy Sanders
INSERT INTO staff (first_name, last_name, address_id, email, store_id, active, username, password)
VALUES ('Tammy', 'Sanders', 5, 'tammy.sanders@example.com', 1, 1, 'tammy', '123456');


#3
#First, I need to get the necessary information to complete the rental entry in the RENTAL table. #HINT.

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

#Now we know the customer_id is 130.

SELECT I.inventory_id
FROM INVENTORY AS I
JOIN FILM AS F ON I.film_id = F.film_id
WHERE F.title = 'Academy Dinosaur' AND I.store_id = 1;

#Now we know the inventory values are from 1 to 4. I will choose the 2.

# rental_date = current date

# Staff_id = 3. IN this case I know is 3 because I remember they were just two employees.
# We don't have to fill the rest of the fields beacuse MySQL will return null values and that's all.
INSERT INTO RENTAL (rental_date, inventory_id, customer_id, staff_id)
VALUES (CURRENT_DATE(), 2, 130 , 3);

#Cheking it is in the table.
SELECT*FROM rental
WHERE customer_id = 130;
#Rental_id = 16051.

-- Lab 7

#1 How many copies of the film "Hunchback Impossible" exist in the inventory system
SELECT COUNT(*) AS num_copies
FROM inventory
WHERE film_id = (SELECT film_id FROM film WHERE title = 'Hunchback Impossible');

#2 List all films whose length is longer than the average of all the films.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);

#3 Use subqueries to display all actors who appear in the film "Alone Trip."

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (
  SELECT actor_id
  FROM film_actor
  WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip')
);

#4 Identify all movies categorized as family films.
SELECT category_id
FROM category
WHERE name = 'Family';

SELECT film_id
FROM film_category
WHERE category_id = 8;

SELECT * 
FROM film
WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id = 7);


#5 Get name and email from customers from Canada using subqueries.
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
  SELECT address_id
  FROM address
  WHERE city_id IN (
    SELECT city_id
    FROM city
    WHERE country_id = (SELECT country_id FROM country WHERE country = 'Canada')
  )
);

#6 Films starred by the most prolific actor. 
SELECT actor_id
FROM (
  SELECT actor_id, COUNT(*) AS film_count
  FROM film_actor
  GROUP BY actor_id
  ORDER BY film_count DESC
  LIMIT 1
) AS subquery;
#Actor_id: 107

SELECT title
FROM film
WHERE film_id IN (
  SELECT film_id
  FROM film_actor
  WHERE actor_id = 107
);

#7 Films rented by the most profitable customer.
SELECT f.film_id, f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.film_id, f.title
ORDER BY SUM(p.amount) DESC
LIMIT 1;

#8 Customers who spent more than the average payments.
SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
WHERE p.amount > (
  SELECT AVG(amount)
  FROM payment
);









































