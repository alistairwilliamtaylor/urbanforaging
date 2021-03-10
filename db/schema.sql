CREATE DATABASE urbanforaging;

CREATE TABLE food (
    id SERIAL PRIMARY KEY,
    food_type TEXT,
    image_url TEXT,
    location_description TEXT
);