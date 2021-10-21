--1. List all customers who live in
--Texas (use JOINs)

SELECT customer.first_name, customer.last_name, address.district
FROM address
JOIN customer
ON customer.address_id = address.address_id
WHERE district = 'Texas'

--2. Get all payments above $6.99
--with the Customer's Full Name

SELECT customer.first_name, customer.last_name, payment.amount
FROM customer
JOIN payment
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99
ORDER BY amount DESC

--3. Show all customers names who
--have made payments over
--$175(use subqueries)

--see second query for answer.
--not sure why this doesn't work. I feel like it's giving me 
--the total for ALL payment.amount, instead of for each customer's.
SELECT first_name, last_name, SUM (payment.amount)
FROM customer, payment
WHERE customer.customer_id IN (
    SELECT payment.customer_id
    FROM payment
    GROUP BY payment.customer_id
    HAVING SUM (amount) >175
)
GROUP BY customer.customer_id
ORDER BY customer.customer_id


--this works, but doesn't display the sums.
SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);


--4. List all customers that
--live in Nepal
--(use the city table)

SELECT customer.first_name, customer.last_name, country.country
FROM customer
JOIN address
ON address.address_id = customer.address_id
JOIN city
ON city.city_id = address.city_id
JOIN country
ON country.country_id = city.country_id
WHERE country.country = 'Nepal'

--5. Which staff member had the
--most transactions?

SELECT staff.first_name, staff.last_name, COUNT(payment.payment_id)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT(payment_id)DESC
LIMIT 1

--6. How many movies of each
--rating are there?

SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY COUNT (film_id)DESC

--7.Show all customers who have made a single payment
--above $6.99 (Use Subqueries)

SELECT customer.first_name, customer.last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY payment.customer_id
)

--8. How many free rentals?

SELECT COUNT (amount), amount
FROM payment
GROUP BY amount
ORDER BY amount
LIMIT 1