SELECT p.name, p.rating, p.review_count from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating > 4
HAVING AVG(p.review_count) > 445000
GROUP BY p.name



SELECT ROUND(AVG(review_count),2) from play_store_apps

SELECT DISTINCT(p.name), p.rating, p.review_count, p.type, p.install_count from play_store_apps as p
INNER JOIN app_store_apps as a
ON a.name = p.name
WHERE p.rating > 4
GROUP BY p.name, p.rating, p.review_count, p.type, p.install_count
HAVING AVG(p.review_count) > 445000



