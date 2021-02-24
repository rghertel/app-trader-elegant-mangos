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
order by times_downloaded DESC;

