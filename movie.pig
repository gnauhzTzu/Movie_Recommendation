movies = LOAD '/data/movies_data.csv' USING PigStorage(',') as (id,name,year,rating,duration);
DUMP movies;