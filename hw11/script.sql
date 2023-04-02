USE sakila;

-- Найти драму с таким-то актером про дантиста за такой-то год
SELECT f.film_id,
       f.title,
       f.description,
       f.release_year,
       f.special_features,
       c.name
  FROM sakila.film f
  JOIN sakila.film_category fc
    ON f.film_id = fc.film_id
  JOIN sakila.category c
    ON c.category_id = fc.category_id
  JOIN sakila.film_actor fa
    ON f.film_id = fa.film_id
  JOIN sakila.actor a
    ON a.actor_id = fa.actor_id
 WHERE f.description LIKE CONCAT('%', 'dentist', '%')
   AND f.release_year IN (2006)
   AND c.name IN ('Drama')
   AND a.last_name LIKE CONCAT('%', 'cage', '%');

-- На каких языках нет фильмов в базе данных
SELECT l.language_id,
       l.name,
       f.film_id
  FROM sakila.language l
  LEFT JOIN sakila.film f
    ON l.language_id = f.language_id
 WHERE f.film_id IS NULL

-- Найти данные по покупателю по последним цифрам телефона
SELECT CONCAT_WS (' ', c.first_name, c.last_name),
       c.email,
       a.address,
       a.phone
  FROM sakila.customer c
  LEFT JOIN sakila.address a
    ON c.address_id = a.address_id
 WHERE a.phone LIKE CONCAT('%', 456);

-- Найти id покупателей, которые потратили от 50 денег за 2 квартал 2005 года
SELECT p.customer_id,
       SUM(p.amount)
  FROM sakila.payment p
 WHERE p.payment_date BETWEEN '2005-04-01' AND '2005-06-30'
 GROUP BY p.customer_id
HAVING SUM(p.amount) >= 50
 ORDER BY SUM(p.amount) DESC;

-- Найти фильмы категории 'Comedy', 'Music' или 'New' менее, чем за 1 денег,
-- продолжительностью от 90 до 120 минут включительно и не в категории 'R' или 'G'
SELECT fl.FID,
       fl.title,
       fl.description,
       fl.category,
       fl.price,
       fl.length,
       fl.rating,
       fl.actors
  FROM sakila.film_list fl
 WHERE fl.category in ('Comedy', 'Music', 'New')
   AND fl.price < 1
   AND fl.rating NOT IN ('R', 'G')
   AND fl.length BETWEEN 90 AND 120

-- Найти самые дороогие фильмы в категории 'Action'
SELECT fl.FID,
       fl.title,
       fl.description,
       fl.category,
       fl.price,
       fl.length,
       fl.rating,
       fl.actors
  FROM sakila.film_list fl
 WHERE fl.category IN('Action')
   AND fl.price = (SELECT MAX(price)
                     FROM sakila.film_list
                    WHERE category IN('Action'));

-- Найти среднеюю цену и среднюю продолжительность фильмов категории 'Action' или рейтинга 'G' или 'R'
SELECT AVG(fl.price),
       AVG(fl.length)
  FROM sakila.film_list fl
 WHERE fl.category IN('Action')
    OR fl.rating IN('G', 'R')
