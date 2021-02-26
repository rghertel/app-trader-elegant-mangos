

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


