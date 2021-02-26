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

SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, cast(replace(replace (install_count,'+',''),',','')  as int) as install_count, a.primary_genre, p.content_rating from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating >= 4.5 AND p.content_rating = 'Teen' and a.primary_genre = 'Games'
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count, p.content_rating, a.primary_genre
HAVING AVG(p.review_count) > 445000
ORDER BY p.review_count DESC

