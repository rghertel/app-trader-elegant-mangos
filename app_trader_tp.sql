SELECT DISTINCT ON (name)*
FROM
	(SELECT DISTINCT p.name, a.review_count AS apple_review_count, p.review_count AS play_review_count, p.rating, a.primary_genre, p.genres,
	a.rating, RTRIM(p.install_count,'+') as install_count, RTRIM(a.content_rating, '+') AS apple_content_rating, p.content_rating AS play_content_rating
	FROM play_store_apps AS p
	INNER JOIN app_store_apps AS a 
	USING (name, rating)
	WHERE p.rating > 4
	AND A.rating > 4
	--AND P.CONTENT_Rating = 'Everyone'
	ORDER BY p.review_count DESC) as sub