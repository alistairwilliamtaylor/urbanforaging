CREATE DATABASE urbanforaging;

CREATE TABLE food (
    id SERIAL PRIMARY KEY,
    food_type TEXT,
    image_url TEXT,
    location_description TEXT
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email TEXT,
    password_digest TEXT
)

-- admin:
-- email = 'alistairwilliamtaylor@gmail.com'
-- password = 'pudding'

ALTER TABLE food ADD COLUMN user_id INTEGER;

UPDATE food SET user_id = 1;