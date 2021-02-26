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

SELECT DISTINCT a.name , a.rating AS apple_rating, CAST(a.review_count AS INT) AS apple_highest_reviews, a.primary_genre AS apple_genres, p.rating AS google_rating, p.review_count AS google_review_count, p.category AS google_genre
FROM app_store_apps AS a
INNER JOIN play_store_apps AS p
ON a.name = p.name
WHERE a.rating IS NOT NULL AND p.rating IS NOT NULL AND a.primary_genre = 'Games' AND p.category = 'GAME'
GROUP BY a.name, a.rating, a.primary_genre, apple_highest_reviews, p.name, p.rating, p.review_count, p.genres, p.category
ORDER BY p.review_count desc
LIMIT 27; 



