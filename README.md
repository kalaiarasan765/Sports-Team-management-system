# Sports-Team-management-system
# Sports Team Management System

## Overview
The Sports Team Management System is a comprehensive application designed to manage sports teams, players, matches, scores, and leagues. It utilizes MySQL for the database and provides various features to track and manage sports-related data.

## Features
- Manage teams and players.
- Record match details and scores.
- Track team standings and player statistics.
- Organize matches within different leagues.
- Perform CRUD (Create, Read, Update, Delete) operations on the database.

## Database Schema
The system uses the following tables:
1. `Teams`: Stores team information.
2. `Players`: Stores player information.
3. `Matches`: Stores match information.
4. `Scores`: Stores scores for each match.
5. `Leagues`: Stores league information.

## Installation

### Prerequisites
- MySQL
- A MySQL client (e.g., MySQL Workbench)
- Java (for backend logic if needed)
- Maven (for dependency management if using Java)

### Setting Up the Database
1. **Create the Database**:
    ```sql
    CREATE DATABASE sports_management;
    USE sports_management;
    ```

2. **Create Tables**:
    ```sql
    CREATE TABLE Teams (
        team_id INT AUTO_INCREMENT PRIMARY KEY,
        team_name VARCHAR(100) NOT NULL,
        coach_name VARCHAR(100),
        home_stadium VARCHAR(100)
    );

    CREATE TABLE Players (
        player_id INT AUTO_INCREMENT PRIMARY KEY,
        first_name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL,
        position VARCHAR(50),
        age INT,
        team_id INT,
        FOREIGN KEY (team_id) REFERENCES Teams(team_id)
    );

    CREATE TABLE Matches (
        match_id INT AUTO_INCREMENT PRIMARY KEY,
        team1_id INT,
        team2_id INT,
        match_date DATE,
        venue VARCHAR(100),
        league_id INT,
        FOREIGN KEY (team1_id) REFERENCES Teams(team_id),
        FOREIGN KEY (team2_id) REFERENCES Teams(team_id),
        FOREIGN KEY (league_id) REFERENCES Leagues(league_id)
    );

    CREATE TABLE Scores (
        score_id INT AUTO_INCREMENT PRIMARY KEY,
        match_id INT,
        team_id INT,
        goals INT,
        FOREIGN KEY (match_id) REFERENCES Matches(match_id),
        FOREIGN KEY (team_id) REFERENCES Teams(team_id)
    );

    CREATE TABLE Leagues (
        league_id INT AUTO_INCREMENT PRIMARY KEY,
        league_name VARCHAR(100) NOT NULL,
        season_year INT
    );
    ```

3. **Insert Sample Data**:
    ```sql
    INSERT INTO Teams (team_name, coach_name, home_stadium) VALUES
    ('Team A', 'Coach A', 'Stadium A'),
    ('Team B', 'Coach B', 'Stadium B');

    INSERT INTO Players (first_name, last_name, position, age, team_id) VALUES
    ('John', 'Doe', 'Forward', 25, 1),
    ('Jane', 'Smith', 'Midfielder', 23, 1),
    ('Mike', 'Johnson', 'Defender', 28, 2);

    INSERT INTO Leagues (league_name, season_year) VALUES
    ('Premier League', 2024),
    ('Champions League', 2024);

    INSERT INTO Matches (team1_id, team2_id, match_date, venue, league_id) VALUES
    (1, 2, '2024-12-25', 'Stadium A', 1),
    (1, 2, '2024-12-30', 'Stadium B', 2);

    INSERT INTO Scores (match_id, team_id, goals) VALUES
    (1, 1, 2),
    (1, 2, 1),
    (2, 1, 3),
    (2, 2, 2);
    ```

## Usage

### Common Queries
#### Get All Teams
```sql
SELECT * FROM Teams;
