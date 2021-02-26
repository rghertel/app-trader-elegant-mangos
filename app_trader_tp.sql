SELECT DISTINCT p.name,a.review_count AS apple_review_count, p.review_count AS play_review_count, a.rating, p.install_count
FROM play_store_apps AS p
INNER JOIN app_store_apps AS a
USING (name)
WHERE p.rating > 4
AND A.rating > 4
AND P.CONTENT_Rating = 'Everyone'
ORDER BY p.review_count DESC