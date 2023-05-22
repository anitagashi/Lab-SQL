USE sakila;

-- Lab 1
#1 Select all the actors with the first name ‘Scarlett’.
SELECT * FROM actor
WHERE first_name = "Scarlett";

#2 How many physical copies of movies are available for rent in the store's inventory? How many unique movie titles are available?
SELECT COUNT(*)  FROM film;
SELECT COUNT(title)  FROM film;

#3 What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT min(length) as min_duration, max(length) as max_duration from film;

#4 What's the average movie duration expressed in format (hours, minutes)
Select Avg(length) , CONCAT(FLOOR(Avg(length)/60),'h ',round(MOD(Avg(length),60)),'m')  From film;

#5 How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name) AS distinct_last_names FROM actor;

#6 How many days was the company operating? Assume the last rental date was their closing date. (check DATEDIFF() function)
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days FROM rental;

#7 Show rental info with additional columns month and weekday. Get 20 results.
SELECT *, MONTH(rental_date) AS rental_month, DAYNAME(rental_date) AS rental_weekday FROM rental
LIMIT 20; 

#8 Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, 
       MONTH(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_weekday,
       CASE WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' ELSE 'workday' END AS day_type FROM rental
LIMIT 20;

#9 Get release years.
SELECT release_year FROM film;

#10 Get all films with ARMAGEDDON in the title.
SELECT * FROM film
WHERE title = "ARMAGEDDON";

SELECT * FROM film
WHERE title like "ARMAGEDD%";

#11 Get all films which title ends with APOLLO.
SELECT * FROM film
WHERE title LIKE '%APOLLO';

#12 Get 10 the longest films
SELECT * FROM film
ORDER BY length DESC
LIMIT 10;

#13 How many films include Behind the Scenes content?
SELECT *  FROM film
WHERE special_features = 'Behind the Scenes';

-- LAB 2 

#1 In the table actor, which are the actors whose last names are not repeated? For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd,
# Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. So we do not want to include this last name in our output. 
# Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list

SELECT last_name FROM actor GROUP BY last_name having COUNT(*) = 1;

#2 Which last names appear more than once? We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name 
#was present more than once

SELECT last_name FROM actor GROUP BY last_name having count(*) > 1;

#3 Using the rental table, find out how many rentals were processed by each employee.
SELECT staff_id, COUNT(*) AS rental_count FROM rental
GROUP BY staff_id;

#4 Using the film table, find out how many films were released each year.
SELECT release_year, COUNT(release_year) FROM film
GROUP BY release_year;

#5 Using the film table, find out for each rating how many films were there.
SELECT rating, COUNT(*) AS film_count FROM film
GROUP BY rating;

#6 What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT rating, ROUND(AVG(length), 2) AS average_length FROM film
GROUP BY rating;

#7 Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating FROM film 
GROUP BY rating
HAVING AVG(length) > 120;

#8 Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
SELECT title, length FROM film
WHERE length != Null or length > 0
ORDER BY 2;











