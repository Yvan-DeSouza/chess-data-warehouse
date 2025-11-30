-- Displayings the total rows in all the tables
SELECT 'dim_players' AS table, COUNT(*)
FROM dim_players
UNION ALL
SELECT 'dim_openings', COUNT(*)
FROM dim_openings
UNION ALL
SELECT 'dim_time_controls', COUNT(*)
FROM dim_time_controls
UNION ALL
SELECT 'dim_dates', COUNT(*)
FROM dim_dates
UNION ALL
SELECT 'fact_games', COUNT(*) 
FROM fact_games;


-- List of the top ten most common openings
SELECT o.opening_name, COUNT(*) AS games_played
FROM fact_games f
JOIN dim_openings o ON f.opening_id = o.opening_id
GROUP BY o.opening_name
ORDER BY games_played DESC
LIMIT 10;

--Win rate for each opening
SELECT 
	o.opening_name, 
	SUM(CASE WHEN f.result = 'white_win' THEN 1 ELSE 0 END)AS white_wins,
	SUM(CASE WHEN f.result = 'black_win' THEN 1 ELSE 0 END) AS black_wins,
	SUM(CASE WHEN f.result = 'draw' THEN 1 ELSE 0 END) AS draws,
	COUNT(*) AS total_games
FROM fact_games f
JOIN dim_openings o ON f.opening_id = o.opening_id
GROUP BY o.opening_name
ORDER BY total_games DESC;


--Average move per time control
SELECT 
	t.category, 
	AVG(f.moves_count) AS avg_moves
FROM fact_games f
JOIN dim_time_controls t ON t.time_control_id = f.time_control_id
GROUP BY category
ORDER BY avg_moves DESC;

-- Top 10 players by total games played
SELECT 
    p.username,
    COUNT(*) AS total_games_played
FROM dim_players p
LEFT JOIN fact_games f 
    ON p.player_id = f.white_player_id
    OR p.player_id = f.black_player_id
GROUP BY p.username
ORDER BY total_games_played DESC
LIMIT 10;


-- White vs BLACK win rate
SELECT 
	SUM(CASE WHEN result = 'white_win' THEN 1 ELSE 0 END) AS white_win,
	SUM(CASE WHEN result = 'black_win' THEN 1 ELSE 0 END) AS black_win,
	SUM(CASE WHEN result = 'draw' THEN 1 ELSE 0 END) AS draws,
	COUNT(*) AS total_games
FROM fact_games;

-- Number of games played in each year
SELECT
	d.year, 
	COUNT(*) AS games_in_year
FROM fact_games f
JOIN dim_dates d ON f.date_id = d.date_id
GROUP BY d.year;

-- Average elo per time_control
SELECT
	t.category,
	AVG((f.white_elo + f.black_elo)/2.0) AS avg_elo
FROM fact_games f
JOIN dim_time_controls t ON f.time_control_id = t.time_control_id
GROUP BY t.category
ORDER BY avg_elo DESC;

-- Elo difference vs win rate
SELECT
	CASE 
		WHEN (white_elo - black_elo) >= 200 THEN 'White +200'
		WHEN (white_elo - black_elo) BETWEEN 50 AND 199 THEN 'White +50-199'
		WHEN (white_elo - black_elo) BETWEEN -49 AND 49 THEN 'Even'
		WHEN (white_elo - black_elo) BETWEEN -199 AND -50 THEN 'Black +50-199'
		ELSE 'Black +200'
	END AS rating_diff_bucket,
	SUM(CASE WHEN result = 'white_win' THEN 1 ELSE 0 END) AS white_wins,
	SUM(CASE WHEN result = 'black_win' THEN 1 ELSE 0 END) AS black_wins,
	SUM(CASE WHEN result = 'draw' THEN 1 ELSE 0 END) AS draws,
	COUNT(*) AS total_games
FROM fact_games
GROUP BY rating_diff_bucket
ORDER BY total_games DESC;