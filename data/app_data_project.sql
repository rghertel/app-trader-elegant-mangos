select type, a.name AS app_store_names, a.rating AS app_store_rating, p.name AS google_play_names, p.rating AS google_play_rating, a.price, p.price AS google_price
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name
WHERE a.rating = 4.5
AND p.rating = 4.5; --price/type both stores

select primary_genre AS apple_genre, genres AS google_genres, a.rating, g.rating
FROM app_store_apps AS a
INNER JOIN play_store_apps AS g
ON a.rating = g.rating
ORDER BY g.rating; --

SELECT count (primary_genre) AS times_downloaded, primary_genre
FROM app_store_apps
group by primary_genre
order by times_downloaded DESC; -- games by a lot/ 3,862

SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, RTRIM(p.install_count,'+') as install_count, a.primary_genre, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating >= 4.5 AND p.content_rating = 'Teen' AND p.review_count < 1000000000 and a.primary_genre = 'Games'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre
HAVING AVG(p.review_count) > 445000
ORDER BY p.review_count DESC;-- Scott's Query

SELECT a.name, a.rating
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name
WHERE a.rating >= 4.0 AND p.rating >= 4.0
GROUP BY a.name, a.rating, p.name, p.rating
ORDER BY p.rating;

SELECT DISTINCT name, rating, max(review_count) AS HIGHEST_REVIEW, category
FROM play_store_apps
WHERE rating IS NOT NULL and category = 'GAME'
GROUP BY name, rating, category
ORDER BY highest_review desc
LIMIT 10;-- google

SELECT DISTINCT name, rating, CAST(review_count AS INT) AS HIGHEST_REVIEW, primary_genre
FROM app_store_apps
WHERE rating IS NOT NULL AND primary_genre = 'Games'
GROUP BY name, rating, primary_genre, highest_review
ORDER BY highest_review desc
LIMIT 10;-- apple

SELECT DISTINCT a.name , a.rating AS apple_rating, CAST(a.review_count AS INT) AS apple_highest_reviews, LOWER(REPLACE(a.primary_genre,'s','')) AS apple_genres, p.rating AS google_rating, p.review_count AS google_review_count, LOWER(p.category) AS google_genre, CONCAT(a.content_rating, ',', p.content_rating) AS rating_combined
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name 
WHERE a.rating IS NOT NULL AND p.rating IS NOT NULL AND a.primary_genre = 'Games' AND p.category = 'GAME' AND p.content_rating = 'Teen'
GROUP BY rating_combined, a.name, a.rating, a.primary_genre, apple_highest_reviews, p.name, p.rating, p.review_count, p.genres, p.category
ORDER BY p.review_count desc
LIMIT 30; -- my query

select distinct app.name AS app_store_names, app.rating AS app_store_rating, app.price,CASE WHEN app.price <=1 then 10000 else 10000*app.price END AS Purchase_Price,
ROUND((app.rating+0.5)/0.5,0) AS Life_span,cast(app.review_count as bigint)*cast(replace(replace(play.install_count,'+',''),',','') as int)/play.review_count AS app_install_count_est,
play.name AS google_play_names, play.rating AS google_play_rating
FROM app_store_apps AS app
inner  JOIN play_store_apps AS play
ON app.name = play.name
ORDER BY Life_span desc; -- 

SELECT DISTINCT ON (name) *
FROM
	(SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, ROUND((a.rating+0.5)/0.5,0) as longevity, p.type, cast(replace(replace (install_count,'+',''),',','')  as int) as install_count,
	a.primary_genre, p.content_rating from play_store_apps as p
	INNER JOIN app_store_apps as a
	ON a.name = p.name
	WHERE p.rating >= 4.5 AND p.content_rating = 'Teen' AND p.review_count < 1000000000 and a.primary_genre = 'Games'
	GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre, a.rating
	HAVING AVG(p.review_count) > 445000
	ORDER BY p.review_count DESC) AS sub
	
	SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, CAST(REPLACE(p.install_count,'+','') AS INT) as install_count, a.primary_genre, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating >= 4.5 AND p.content_rating = 'Teen' AND p.review_count < 100000000 and a.primary_genre = 'Games'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre
HAVING AVG(p.review_count) > 445000
ORDER BY p.review_count DESC;-- Scott's Query

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
	AND CONCAT(a.primary_genre,', ', pta.genres) ILIKE '%games%' /* AND CONCAT(a.content_rating, ', ', pta.content_rating) ILIKE '%teen%'*/
ORDER BY rating DESC;

SELECT CAST(a.review_count AS INT) AS apple_reviews, p.review_count AS goole_reviews, CAST(REPLACE(REPLACE(INSTALL_COUNT, '+', '') , ',','') AS INT) AS install_count,
			a.review_count AS int / install_count AS adoption_rate
FROM app_store_apps AS a
JOIN play_store_apps AS p
ON a.name = p.name;

SELECT CAST(a.review_count AS INT) / CAST(REPLACE(REPLACE(INSTALL_COUNT, '+', '') , ',','') AS INT) AS install_count, a.name
			FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name;

SELECT CAST(REPLACE(REPLACE(INSTALL_COUNT, '+', '') , ',','') AS INT) / CAST(p.review_count AS INT) AS adoption_rate, p.name AS google_app, install_count, p.review_count AS google_reviews, p.content_rating AS google_rating, p.category
			FROM play_store_apps AS p
INNER JOIN app_store_apps AS a
ON a.name = p.name
WHERE p.content_rating = 'Teen' AND p.category = 'GAME'
ORDER BY adoption_rate desc; --Scott's Adoption Rate Theory? 






