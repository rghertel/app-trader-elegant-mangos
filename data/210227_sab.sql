SELECT p.name, p.rating, p.review_count from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating > 4
HAVING AVG(p.review_count) > 445000
GROUP BY p.name



SELECT ROUND(AVG(review_count),2) from play_store_apps

SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, p.install_count, p.genres, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating > 4 AND p.content_rating = 'Teen'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.genres, p.content_rating
HAVING AVG(p.review_count) > 445000

SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, CAST(RTRIM(p.install_count,'+') as INT), p.genres, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating > 4 AND p.content_rating = 'Teen'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.genres, p.content_rating
HAVING AVG(p.review_count) > 445000
ORDER BY p.rating DESC

SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, CAST((RTRIM(p.install_count,'+')) as INT), p.genres, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating > 4 AND p.content_rating = 'Teen'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.genres, p.content_rating
HAVING AVG(p.review_count) > 445000
ORDER BY p.rating DESC

SELECT CAST(a.review_count AS INT), RIGHT(a.review_count,1)  FROM app_store_apps as a

SELECT TRIM(CAST(a.review_count AS INT), 1)  FROM app_store_apps as a

SELECT CAST(a.review_count AS INT), CAST(REPLACE(a.review_count,'2','1') as INT) FROM app_store_apps as a

SELECT CAST(TRIM(p.install_count,'+') as INT) FROM play_store_apps as p


SELECT CAST(p.install_count as INT) FROM (SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, RTRIM(p.install_count,'+'), 
								   p.genres, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating > 4 AND p.content_rating = 'Teen'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.genres, p.content_rating) as sub
HAVING AVG(p.review_count) > 445000

SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, RTRIM(p.install_count,'+'), p.genres, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating > 4 AND p.content_rating = 'Teen'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.genres, p.content_rating
HAVING AVG(p.review_count) > 445000
ORDER BY p.rating DESC

SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, cast(replace(replace (install_count,'+',''),',','')  as int) as install_count, a.primary_genre, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating >= 4.5 AND p.content_rating = 'Teen' and a.primary_genre = 'Games'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre
HAVING AVG(p.review_count) > 445000
ORDER BY p.review_count DESC

select  install_count,review_count,cast(replace(replace (install_count,'+',''),',','')  as int) from play_store_apps

select  AVG(cast(replace(replace (install_count,'+',''),',','')  as int)) from play_store_apps

SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, cast(replace(replace (install_count,'+',''),',','')  as int) as install_count, a.primary_genre, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating >= 4.5 
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre
HAVING AVG(p.review_count) > 445000 



SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, cast(replace(replace (p.install_count,'+',''),',','')  as int) as install_count, a.primary_genre, 
p.content_rating, ((p.review_count)/(cast(replace(replace (p.install_count,'+',''),',','')  as int)))*100 as adoption_ratio from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating >= 4.5 and cast(replace(replace (p.install_count,'+',''),',','')  as int) > 15000000 and a.primary_genre = 'Games'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre
HAVING AVG(p.review_count) > 445000 

SELECT SUM(review_count)/SUM(cast(replace(replace (install_count,'+',''),',','')  as int)) from play_store_apps
		
SELECT SUM(review_count) from play_store_apps

SELECT 4814617393/SUM(cast(replace(replace (install_count,'+',''),',','')  as int))*100 from play_store_apps


--this shows app with > 4.5 rating and > 455K reviews. Not filtered on content and genre
SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, cast(replace(replace (install_count,'+',''),',','')  as int) as install_count, a.primary_genre, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating >= 4.5
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre
HAVING AVG(p.review_count) > 445000
ORDER BY p.review_count DESC

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


SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, ROUND((app.rating+0.5)/0.5,0) as life_span, cast(replace(replace (install_count,'+',''),',','')  as int) as install_count, a.primary_genre, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating >= 4.5 AND p.content_rating = 'Teen' and a.primary_genre = 'Games'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre
HAVING AVG(p.review_count) > 445000
ORDER BY p.review_count DESC

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
	select distinct app.name AS app_store_names, app.rating AS app_store_rating, app.price,CASE WHEN app.price <=1 then 10000 else 10000*app.price END AS Purchase_Price,
ROUND((app.rating+0.5)/0.5,0) AS Life_span,cast(app.review_count as bigint)*cast(replace(replace(play.install_count,'+',''),',','') as int)/play.review_count AS app_install_count_est,
play.name AS google_play_names, play.rating AS google_play_rating
FROM app_store_apps AS app
inner  JOIN play_store_apps AS play
ON app.name = play.name;

select distinct app.name AS app_store_names, app.rating AS app_store_rating, app.price,CASE WHEN app.price <=1 then 10000 else 10000*app.price END AS Purchase_Price,
ROUND((app.rating+0.5)/0.5,0) AS Life_span,cast(app.review_count as bigint)*cast(replace(replace(play.install_count,'+',''),',','') as int)/play.review_count AS app_install_count_est,
play.name AS google_play_names, play.rating AS google_play_rating
FROM app_store_apps AS app
inner  JOIN play_store_apps AS play
ON app.name = play.name;
Order BY life_span DESC

SELECT DISTINCT(p.name), p.rating, p.review_count, ROUND((a.rating+0.5)/0.5,0) as longevity, p.type, cast(replace(replace (install_count,'+',''),',','')  as int) as install_count, a.primary_genre, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating >= 4.5 AND p.content_rating = 'Teen' and a.primary_genre = 'Games'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre, a.rating
HAVING AVG(p.review_count) > 445000
ORDER BY p.review_count DESC

SELECT DISTINCT ON (name) *
FROM
	(SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, ROUND((a.rating+0.5)/0.5,0) as longevity, p.type, cast(replace(replace (install_count,'+',''),',','')  as int) as install_count,
	a.primary_genre, p.content_rating from play_store_apps as p
	INNER JOIN app_store_apps as a
	ON a.name = p.name
	WHERE p.rating >= 4.4 AND p.content_rating = 'Teen' AND p.review_count < 1000000000 and a.primary_genre = 'Games'
	GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre, a.rating
	HAVING AVG(p.review_count) > 445000
	ORDER BY p.review_count DESC) AS sub
	
SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, cast(replace(replace (install_count,'+',''),',','')  as int) as install_count, a.primary_genre, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating >= 4.5 AND p.content_rating = 'Teen' and a.primary_genre = 'Games'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre
HAVING AVG(p.review_count) > 445000
ORDER BY p.review_count DESC

SELECT DISTINCT ON (name) *
FROM
	(SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, ROUND((a.rating+0.5)/0.5,0) as longevity, p.type, cast(replace(replace (install_count,'+',''),',','')  as int) as install_count,
	a.primary_genre, p.content_rating from play_store_apps as p
	INNER JOIN app_store_apps as a
	ON a.name = p.name
	WHERE p.rating >= 4.4 AND p.content_rating = 'Teen' AND p.review_count < 1000000000 and a.primary_genre = 'Games'
	GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre, a.rating
	HAVING AVG(p.review_count) > 445000
	ORDER BY p.review_count DESC) AS sub