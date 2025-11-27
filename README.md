# Chess Data Warehouse

This project is a fully structured SQL-based data warehouse designed to analyze chess games using a star schema. It includes four dimension tables (Players, Openings, Dates, Time Controls) and one fact table (Games). All data is synthetic and was generated to learn SQL, dimensional modeling, and data warehousing concepts.

## 📁 Project Structure
- **schema.sql** — Creates all tables (dimensions + fact table)
- **insert_dimensions.sql** — Inserts data into all dimension tables
- **insert_fact.sql** — Inserts data into the fact_games table
- **/data** — Contains synthetic SQL data files for each table

## 🗄️ Database Schema
The data warehouse follows a star schema with the following tables:

- **dim_players** — Player information (username, country, preferred time control)
- **dim_openings** — Chess openings with ECO codes and move sequences
- **dim_dates** — Calendar table used for analysis over time
- **dim_time_controls** — Time format categories and increments
- **fact_games** — Central fact table storing game results, player links, openings, timestamps, and Elo ratings

The fact table references all dimensions via foreign keys, enabling analysis such as:
- Opening success rates  
- Player performance trends  
- Time control preferences  
- Game statistics over specific dates  

## 🚀 Purpose
This repository serves as a learning project for practicing:
- SQL  
- Data warehousing  
- Star schema design  
- ETL workflows  
- Analytical querying  

All data is entirely synthetic and intended solely for educational use.
