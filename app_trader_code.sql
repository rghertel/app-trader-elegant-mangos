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
--over avg review counts, and can play with filters to see specific genres and content rating
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
	AND CONCAT(a.primary_genre,', ', pta.genres) ILIKE '%games%' /* AND CONCAT(a.content_rating, ', ', pta.content_rating) ILIKE '%teen%'*/
ORDER BY rating DESC;

--Scott's Query
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
	
--Scott's Query edited to show a longer list than top 10 (got rid of install count and content rating filter)
WITH CTE as
(SELECT DISTINCT ON (name) *
FROM
	(SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, ROUND((a.rating+0.5)/0.5,0) as longevity, p.type, 
	cast(replace(replace (install_count,'+',''),',','')  as int) as install_count,
	a.primary_genre, p.content_rating from play_store_apps as p
	INNER JOIN app_store_apps as a
	ON a.name = p.name
	WHERE p.rating >= 4.3 AND a.primary_genre = 'Games' AND p.content_rating = 'Teen'
	GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre, a.rating
	HAVING AVG(p.review_count) > 445000) AS sub)
	
SELECT *
FROM CTE
ORDER BY rating DESC;

--Yared's Query to show lifespan of apps
select distinct app.name AS app_store_names, app.rating AS app_store_rating, app.price,
	CASE WHEN app.price <=1 then 10000 
	else 10000*app.price END AS Purchase_Price,
	ROUND((app.rating+0.5)/0.5,0) AS Life_span, 
	cast(app.review_count as bigint)*cast(replace(replace(play.install_count,'+',''),',','') as int)/play.review_count 
	AS app_install_count_est,
	play.name AS google_play_names, play.rating AS google_play_rating
FROM app_store_apps AS app
inner  JOIN play_store_apps AS play
ON app.name = play.name

select AppTraderIndex.life_span * 12 * 5000 as LifeTimeRevenue,AppTraderIndex.life_span * 12 * 1000 as Marketing_Cost  
from
(select distinct app.name AS app_store_names, app.rating AS app_store_rating, app.price,CASE WHEN app.price <=1 then 10000 else 10000*app.price END AS Purchase_Price,
ROUND((app.rating+0.5)/0.5,0) AS Life_span,cast(app.review_count as bigint)*cast(replace(replace(play.install_count,'+',''),',','') as int)/play.review_count AS app_install_count_est,
play.name AS google_play_names, play.rating AS google_play_rating
FROM app_store_apps AS app
inner  JOIN play_store_apps AS play
ON app.name = play.name
) as  AppTraderIndex

--Tim's query
SELECT DISTINCT ON (name) *
FROM
	(SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, RTRIM(p.install_count,'+') as install_count,
	a.primary_genre, p.content_rating from play_store_apps as p
	INNER JOIN app_store_apps as a
	ON a.name = p.name
	WHERE p.rating >= 4.5 AND p.content_rating = 'Teen' AND p.review_count < 1000000000 and a.primary_genre = 'Games'
	GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre
	HAVING AVG(p.review_count) > 445000
	ORDER BY p.review_count DESC) AS sub
	
--Trey's query
SELECT DISTINCT a.name , a.rating AS apple_rating, CAST(a.review_count AS INT) AS apple_highest_reviews, LOWER(REPLACE(a.primary_genre,'s','')) AS apple_genres, p.rating AS google_rating, p.review_count AS google_review_count, LOWER(p.category) AS google_genre, CONCAT(a.content_rating, ',', p.content_rating) AS rating_combined
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name
WHERE a.rating IS NOT NULL AND p.rating IS NOT NULL AND a.primary_genre = 'Games' AND p.category = 'GAME' AND p.content_rating = 'Teen'
GROUP BY rating_combined, a.name, a.rating, a.primary_genre, apple_highest_reviews, p.name, p.rating, p.review_count, p.genres, p.category
ORDER BY p.review_count desc
LIMIT 30; 

--audio apps
SELECT name, primary_genre
FROM app_store_apps AS a
WHERE primary_genre ILIKE '%music%' AND rating >= 4.5
UNION ALL 
SELECT name, genres
FROM play_store_apps AS p
WHERE genres ILIKE '%music%' AND rating >= 4.5;