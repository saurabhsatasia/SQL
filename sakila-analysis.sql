use sakila;
/* Email Campaigns for customers of Store 2
First, Last name and Email address of customers from Store 2*/
SELECT first_name, last_name,email FROM customer
WHERE store_id = 2;

/* movie with rental rate of 0.99$*/
SELECT COUNT(*) FROM film WHERE rental_rate=0.99;

/* we want to see rental rate and how many movies are in each rental rate categories*/
SELECT rental_rate, COUNT(*) AS total_number_of_movies FROM film
GROUP BY rental_rate; /* OR GROUP BY 1*/

/*Which rating do we have the most films in?*/
SELECT rating, COUNT(*) AS total_number_of_movies FROM film
GROUP BY rating;

/*Which rating is most prevalant/widespread in each store?*/
SELECT s.store_id, f.rating, COUNT(f.rating) AS total_number_of_films
FROM store s
JOIN inventory i ON s.store_id = i.store_id
JOIN film f ON f.film_id = i.film_id
GROUP BY store_id, rating ;

/*We want to mail the customers about the upcoming promotion*/
SELECT c.customer_id, c.first_name, c.last_name, a.address FROM customer c
JOIN address a ON c.address_id = a.address_id ;

/* List of films by Film Name, Category, Language*/
SELECT f.title, c.name, l.name
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN language l ON l.language_id = f.language_id ;

/* How many times each movie has been rented out? */
SELECT i.film_id, f.title, COUNT(i.film_id) AS total_times_each_movies_rented
from rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
GROUP BY film_id
ORDER BY 3 DESC ; /*order by 3rd column in descending order*/

/*Revenue per Movie */
SELECT i.film_id, f.title, COUNT(i.film_id) AS total_times_each_movies_rented, f. rental_rate, COUNT(i.film_id)*f.rental_rate AS revenue_per_movie 
FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
GROUP BY film_id
ORDER BY 5 DESC
















