SELECT INITCAP(name), rating, install_count, play_review_count
FROM
	(SELECT p.name, p.review_count AS play_review_count, p.rating, p.genres,
 	CAST(REPLACE(RTRIM(p.install_count,'+'),',','') AS int) AS install_count,
	p.content_rating AS play_content_rating
	FROM play_store_apps AS p
	INNER JOIN app_store_apps AS a 
	ON a.name = p.name
	WHERE p.rating >= 4.5
	AND a.primary_genre = 'Games'
	AND p.CONTENT_Rating = 'Teen'
	GROUP BY p.name, p.review_count, p.rating, p.genres, p.content_rating, p.install_count
	ORDER BY p.review_count DESC) AS sub
