

select cast(review_count as int)
from app_store_apps;

select  install_count,review_count,cast(replace(replace (install_count,'+',''),',','')  as int)
from play_store_apps;
/*
For every half point that an app gains in rating, its projected lifespan increases by one year, 
in other words, an app with a rating of 0 can be expected to be in use for 1 year, an app with a 
rating of 1.0 can be expected to last 3 years, and an app with a rating of 4.0 can be expected
to last 9 years. Ratings should be rounded to the nearest 0.5 to evaluate an app's likely longevity. 
*/

--Purchasing Price in both stores
select distinct app.name AS app_store_names, app.rating AS app_store_rating, app.price,CASE WHEN app.price <=1 then 10000 else 10000*app.price END AS Purchase_Price,
ROUND((app.rating+0.5)/0.5,0) AS Life_span,cast(app.review_count as bigint)*cast(replace(replace(play.install_count,'+',''),',','') as int)/play.review_count AS app_install_count_est,
play.name AS google_play_names, play.rating AS google_play_rating
FROM app_store_apps AS app
inner  JOIN play_store_apps AS play
ON app.name = play.name;


select AppTraderIndex.life_span * 12 * 5000 as LifeTimeRevenue,AppTraderIndex.life_span * 12 * 1000 as Marketing_Cost  from 
(select distinct app.name AS app_store_names, app.rating AS app_store_rating, app.price,CASE WHEN app.price <=1 then 10000 else 10000*app.price END AS Purchase_Price,
ROUND((app.rating+0.5)/0.5,0) AS Life_span,cast(app.review_count as bigint)*cast(replace(replace(play.install_count,'+',''),',','') as int)/play.review_count AS app_install_count_est,
play.name AS google_play_names, play.rating AS google_play_rating
FROM app_store_apps AS app
inner  JOIN play_store_apps AS play
ON app.name = play.name
) as  AppTraderIndex

--Rachel's query 1
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
	AND CONCAT(a.primary_genre,', ', pta.genres) ILIKE '%games%' AND CONCAT(a.content_rating, ', ', pta.content_rating)
	ILIKE '%teen%'
ORDER BY rating DESC;

--Rachel's query 1
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