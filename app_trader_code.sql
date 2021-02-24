--Count distinct columns in each table
SELECT COUNT(DISTINCT name)
FROM app_store_apps;
--7195

SELECT COUNT(DISTINCT name)
FROM play_store_apps;
--9659

--Create 2 CTEs to use instead of original tables, to filter out duplicates???
WITH apa AS (SELECT DISTINCT name, size_bytes, price, review_count, rating, primary_genre
			FROM app_store_apps)

WITH psa AS (SELECT DISTINCT name, size, price, review_count, rating, genres, install_count
			FROM play_store_apps)
			
--Use inner join on common name column to narrow down to games included both stores (553)
SELECT a.name AS app, a.rating AS app_rating, p.rating AS play_rating
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name
ORDER BY app;

--Select
SELECT DISTINCT name, app_rating, app_price, app_review_count, play_rating, 
play_price, play_review_count
FROM
	(SELECT a.name AS name, a.rating AS app_rating, a.price AS app_price, a.review_count AS app_review_count,
p.rating AS play_rating, p.price AS play_price, p.review_count AS play_review_count
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name) AS sub

ORDER BY name;

