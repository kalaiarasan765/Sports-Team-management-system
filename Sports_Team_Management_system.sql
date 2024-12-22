#creating database

create database sport_team_management_system;
use sport_team_management_system;
show tables;

#Teams table creation
create table Teams(
team_id int auto_increment primary key,
team_name varchar(100) not null,
coach_name varchar(100),
home_stadium varchar(100)
);

#players table creation
create table  players(
player_id int auto_increment primary key,
first_name varchar(100) not null,
last_name varchar(100) not null,
position varchar(50),
age int,
team_id int,
foreign key(team_id)references Teams(team_id)
);
#leagues table creation

create table leagues(
league_id int auto_increment primary key,
league_name varchar(100),
season_year int

);

#matches table creation
create table matches(
match_id int auto_increment primary key,
team1_id int,
team2_id int,
match_date date,
venue varchar(100),
league_id int,
foreign key(team1_id)references teams(team_id),
foreign key(team2_id) references teams(team_id),
foreign key (league_id) references leagues(league_id)

);

#scores table creation
create table scores(
score_id int auto_increment primary key,
match_id int,
team_id int,
goals int,
foreign key(match_id) references matches(match_id),
foreign key(team_id) references teams(team_id)
);

# insert data in to teams table
insert into teams(team_name,coach_name,home_stadium) values
('Team A','Coach A','Stadium A'),
('Team B','Coach B','Stadium B');

#insert data into players table
insert into players(first_name,last_name,position,age,team_id) values
('Cristiano','Ronaldo','Forwaed',36,1),
('Lionel','messi','Midfielder',35,2),
('Neymar','Jr','Defender',33,1);

#insert data into leagues table
insert into leagues(league_name,season_year) values
('Premier League',2024),
('Champion League',2024);

#insert data into matches table 
insert into matches(team1_id,team2_id,match_date,venue,league_id) values
(1,2,'2024-12-25','Stadium A',1),
(1,2,'2024-12-30','Stadium B',2);

#insert data into scores table
insert into scores(match_id,team_id,goals) values
(1,1,2),
(1,2,1),
(2,1,3),
(2,2,2);

#Writing Query
#1.Get all tables in database
show tables;

#2.Get All Teams
SELECT * FROM Teams;

#3.Get All Players
SELECT * FROM Players;

#4.Get All Matches
select * from matches;

#5.Get All Scores
select * from scores;

#6.Get All Leagues
select * from leagues;

#7.Get Players in a Specific Team
select p.first_name,p.last_name from players p where team_id=1;

#8.Get Matches for a Specific League
SELECT * FROM Matches WHERE league_id = 1; 

#9.Get Scores for a Specific Match
SELECT T.team_name, S.goals
FROM Scores S
 JOIN Teams T ON S.team_id = T.team_id
WHERE S.match_id = 2;

#10. Get Team Standing in a League
SELECT T.team_name, SUM(S.goals) AS total_goals
FROM Scores S
JOIN Teams T ON S.team_id = T.team_id
JOIN Matches M ON S.match_id = M.match_id
WHERE M.league_id = 1 
GROUP BY S.team_id
ORDER BY total_goals DESC;

#11.Get Teams with More Than One Player
SELECT team_name
FROM Teams
WHERE team_id IN (
    SELECT team_id
    FROM Players
    GROUP BY team_id
    HAVING COUNT(player_id) > 1
);
#12.Get Players Not Assigned to Any Team
SELECT first_name, last_name
FROM Players
WHERE team_id IS NULL

#13.Create a Stored Procedure to Insert a New Player

DELIMITER $$
CREATE PROCEDURE AddPlayer()
BEGIN
    INSERT INTO Players (first_name, last_name, position, age, team_id)
    VALUES (first_name, last_name, position, age, team_id);
END $$
DELIMITER ;
call AddPlayer('Kylian', 'Mbappe', 'Defender', 22, 1);
select * from players;
drop procedure AddPlayer;

#14.Create a Stored Procedure to Update Match Score
DELIMITER $$

CREATE PROCEDURE UpdateMatchScore(
    IN match_id INT,
    IN team_id INT,
    IN new_goals INT
)
BEGIN
    UPDATE Scores
    SET goals = new_goals
    WHERE match_id = match_id AND team_id = team_id;
END $$

DELIMITER ;
CALL UpdateMatchScore(1, 1, 12);
select * from scores;










