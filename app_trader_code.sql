--Count distinct columns in each table
SELECT COUNT(DISTINCT name)
FROM app_store_apps;
--7195

SELECT COUNT(DISTINCT name)
FROM play_store_apps;
--9659

--The play store has quite a few repeats, with review counts very similar (10349 rows in this query)
SELECT DISTINCT name
FROM play_store_apps
ORDER BY name;

--To remove duplicates, AVG review count (9678); MAYBE USE THIS AS CTE FOR OTHER QUERIES...
SELECT DISTINCT name, ROUND(AVG(review_count),0) AS review_count, rating, 
	ROUND(AVG(CAST(REPLACE(REPLACE(install_count,'+',''),',','') AS int)),0) AS install_count, price,
	genres, content_rating
FROM play_store_apps
GROUP BY name, rating, genres, price, content_rating
--OPTIONAL: ORDER BY price DESC;

--Average reviews for play store (444153)
SELECT ROUND(AVG(review_count),0) AS avg_review_count
FROM play_store_apps
WHERE review_count IS NOT NULL;

--Average reviews for app store (12893)
SELECT ROUND(AVG(CAST(review_count AS int)),0) AS avg_review_count
FROM app_store_apps
WHERE review_count IS NOT NULL;

--Use inner join on common name column to narrow down to games included both stores, and rating 4.5 and above, 
--and over avg review counts (50)
--Rows we're focusing on: review count, rating, install count, price, genre, and content rating
WITH pta AS (
SELECT DISTINCT name, ROUND(AVG(review_count),0) AS review_count, rating, 
	ROUND(AVG(CAST(REPLACE(REPLACE(install_count,'+',''),',','') AS int)),0) AS install_count, price,
	genres, content_rating
FROM play_store_apps
GROUP BY name, rating, genres, price, content_rating)

SELECT a.name AS app, CAST(a.review_count AS int) AS app_reviews, pta.review_count AS play_reviews, ROUND((a.rating+pta.rating)/2,1) AS rating, 
	pta.install_count AS play_install_count, a.price AS app_price, pta.price AS play_price, 
	CONCAT(a.primary_genre,', ', pta.genres) AS genre, CONCAT(a.content_rating, ', ', pta.content_rating) AS content_rated
FROM app_store_apps AS a
INNER JOIN pta
ON a.name = pta.name
WHERE ROUND((a.rating+pta.rating)/2,1) >= 4.5 AND CAST(a.review_count AS int) > 12893 AND pta.review_count > 444153
ORDER BY play_install_count DESC;