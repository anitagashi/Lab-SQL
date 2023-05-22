USE sakila;

-- Lab4
#1 How many films are there for each category in the category table:
SELECT c.name AS category_name, COUNT(*) AS film_count 
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

#2 Total amount rung up by each staff member in August 2005:
SELECT s.staff_id, CONCAT(s.first_name, ' ', s.last_name) AS staff_name, SUM(p.amount) AS total_amount
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
WHERE p.payment_date >= '2005-08-01' AND p.payment_date <= '2005-08-31'
GROUP BY s.staff_id, staff_name;

#3 Actor who has appeared in the most films:
SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS actor_name, COUNT(*) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, actor_name
ORDER BY film_count DESC
LIMIT 1;

#4 Most active customer (the customer who has rented the most number of films):
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(*) AS film_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY film_count DESC
LIMIT 1;

#5 First and last names, as well as the address, of each staff member:
SELECT staff_id, first_name, last_name, address_id
FROM staff;

#6 Film and the number of actors listed for each film:
SELECT f.film_id, f.title, COUNT(*) AS actor_count
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.film_id, f.title;

#7 Total paid by each customer, listed alphabetically by last name:
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY c.last_name, c.first_name;

#8 Number of films per category:
SELECT c.category_id, c.name AS category_name, COUNT(*) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, category_name;

-- Lab5 

#1 Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, a.city_id, b.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city b ON a.city_id = b.city_id;

#2 Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

#3 Which film categories are longest?
SELECT c.name AS category_name, MAX(f.length) AS max_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

#4 Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(*) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC;

#5 List the top five genres in gross revenue in descending order.
SELECT c.name AS category_name, SUM(p.amount) AS total_revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 5;

#6 Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;

#7 Get all pairs of actors that worked together.
SELECT CONCAT(a1.first_name, ' ', a1.last_name) AS actor1, CONCAT(a2.first_name, ' ', a2.last_name) AS actor2
FROM actor a1
JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
WHERE a1.actor_id <> a2.actor_id;

-- BONUS 





