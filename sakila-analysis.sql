use sakila;
/* Email Campaigns for customers of Store 2
First, Last name and Email address of customers from Store 2*/
SELECT first_name, last_name,email FROM customer
WHERE store_id = 2;

/* movie with rental rate of 0.99$*/
SELECT COUNT(*) FROM film WHERE rental_rate=0.99;

/* we want to see rental rate and how many movies are in each rental rate categories*/
SELECT rental_rate, COUNT(*) AS total_number_of_movies FROM film
GROUP BY rental_rate /* OR GROUP BY 1*/

/*Which rating do we have the most films in?*/
SELECT rating, COUNT(*) AS total_number_of_movies FROM film
GROUP BY rating


