-- ================================
-- Database Schema for Chess DW
-- ================================

-- Dimension Tables
CREATE TABLE dim_players (
    player_id SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    country TEXT,
    preferred_time_control TEXT
);

CREATE TABLE dim_openings (
    opening_id SERIAL PRIMARY KEY,
    eco_code TEXT,
    opening_name TEXT,
    moves_sequence TEXT
);

CREATE TABLE dim_time_controls (
    time_control_id SERIAL PRIMARY KEY,
    category TEXT, -- bullet/blob/blitz/rapid/classical
    initial_time INT,
    increment INT
);

CREATE TABLE dim_dates (
    date_id SERIAL PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    weekday TEXT
);

-- Fact Table
CREATE TABLE fact_games (
    game_id SERIAL PRIMARY KEY,
    white_player_id INT REFERENCES dim_players(player_id),
    black_player_id INT REFERENCES dim_players(player_id),
    opening_id INT REFERENCES dim_openings(opening_id),
    time_control_id INT REFERENCES dim_time_controls(time_control_id),
    date_id INT REFERENCES dim_dates(date_id),
    result TEXT,        -- white_win / black_win / draw
    moves_count INT,
    white_elo INT,
    black_elo INT
);
