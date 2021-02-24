select *
from app_store_apps;

select *
from play_store_apps;


select distinct app.name AS app_store_names, app.rating AS app_store_rating, play.name AS google_play_names, play.rating AS google_play_rating
FROM app_store_apps AS app
inner JOIN play_store_apps AS play
ON app.name = play.name;



