-- ======================================
-- Drop tables (in correct dependency order)
-- ======================================

DROP TABLE IF EXISTS fact_games;

DROP TABLE IF EXISTS dim_players;
DROP TABLE IF EXISTS dim_openings;
DROP TABLE IF EXISTS dim_time_controls;
DROP TABLE IF EXISTS dim_dates;

-- ======================================
-- Create Tables
-- ======================================

-- Dimension: Players
CREATE TABLE dim_players (
    player_id SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    country TEXT,
    preferred_time_control TEXT
);

-- Dimension: Openings
CREATE TABLE dim_openings (
    opening_id SERIAL PRIMARY KEY,
    eco_code TEXT,
    opening_name TEXT,
    moves_sequence TEXT
);

-- Dimension: Time Controls
CREATE TABLE dim_time_controls (
    time_control_id SERIAL PRIMARY KEY,
    category TEXT,
    initial_time INT,
    increment INT
);

-- Dimension: Dates
CREATE TABLE dim_dates (
    date_id SERIAL PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    weekday TEXT
);

-- Fact Table: Games
CREATE TABLE fact_games (
    game_id SERIAL PRIMARY KEY,
    white_player_id INT REFERENCES dim_players(player_id),
    black_player_id INT REFERENCES dim_players(player_id),
    opening_id INT REFERENCES dim_openings(opening_id),
    time_control_id INT REFERENCES dim_time_controls(time_control_id),
    date_id INT REFERENCES dim_dates(date_id),
    result TEXT,
    moves_count INT,
    white_elo INT,
    black_elo INT
);
