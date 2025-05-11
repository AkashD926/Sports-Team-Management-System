#Create Database 
Create database SportTeamManagement;
use SportTeamManagement;

#Create League
 Create Table League ( 
  LeagueID int primary key, 
 LeagueName Varchar(70),
 States Varchar(75)
 );
 Desc League;

#Create team table
create table Team (
TeamID int primary key,
TeamName varchar(10) not null,
LeagueID int,
CoachName Varchar(50),
City varchar(55), 
foreign key (LeagueID) references League (LeagueID)
);
Desc Team;
Alter table team modify TeamName varchar(80) ;

#Create Players table
Create table players (
PlayerID INT PRIMARY KEY,
PlayerName VARCHAR(50),
TeamID INT,
FieldPosition VARCHAR(50),
Age INT,
RunSaved INT,
FOREIGN KEY (TeamID) REFERENCES Team (TeamID)
);
Desc Players;


#Create Matches table
 Create table Matches(
MatchID int primary key,
Date date,
Home_TeamID Int,
Away_TeamID int,
LeagueID int,
Location Varchar(95),
FOREIGN KEY (Home_TeamID) REFERENCES Team (TeamID),
FOREIGN KEY (Away_TeamID) REFERENCES Team (TeamID),
Foreign key (LeagueID) references League (LeagueID) 
 );
 Desc Matches;

#Create Scores table
 Create table Scores(
 ScoreID int Primary key,
 MatchID int,
 PlayerID int,
 TeamID int,
 Run int,
 FOREIGN KEY (MatchID) REFERENCES Matches (MatchID),
 FOREIGN KEY (PlayerID) REFERENCES Players (PlayerID),
 FOREIGN KEY (TeamID) REFERENCES Team (TeamID)
 );
 Desc Scores;
 
 #use Database
 Use SportTeamManagement;
 
#Insert Leagues
INSERT INTO League VALUES (1, 'Indian Premier League', 'Indian');
INSERT INTO League VALUES (2, 'Champions League', 'Dubai');
Select* from league;

#Teams
INSERT INTO Team VALUES (1, 'CSK', 1, 'Michael', 'Chennai');
INSERT INTO Team VALUES (2, 'MI', 1, 'Bravo', 'Mumbai');
INSERT INTO Team VALUES (3, 'RCB', 2, 'Dinesh', 'Bangalore');
Select* from team;

-- Players
INSERT INTO Players VALUES (1, 'Dhoni', 1, 'WicketKeeper', 25,  5);
INSERT INTO Players VALUES (2, 'Bravo', 1, 'Midoff', 27,  8);
INSERT INTO Players VALUES (3, 'Gale', 2, 'Longon', 24,  3);
INSERT INTO Players VALUES (4, 'David Miller', 3, 'Wicketkeeper', 29,1);
Select* from players;

-- Matches
INSERT INTO Matches VALUES (1, '2024-04-01', 1, 2, 1, 'Red Soil');
INSERT INTO Matches VALUES (2, '2024-04-08', 2, 3, 2, 'Green Field');
Select* from Matches;

-- Scores
INSERT INTO Scores VALUES (1, 1, 1, 1, 81);
INSERT INTO Scores VALUES (2, 1, 2, 1, 12);
INSERT INTO Scores VALUES (3, 2, 3, 2, 099);
INSERT INTO Scores VALUES (4, 2, 4, 3, 023);
Select* from scores;
 

 #Use dataset
 use SportTeamManagement;
 
 #Query join two table
 Select T.TeamName, T.CoachName,L.LeagueID from Team T Inner join League L on T.LeagueID = L.LeagueID where L.LeagueID = 1;
 
 Select T.TeamName,M.Date,P.PlayerName from Scores S left join Team T on S.TeamID = T.TeamID Right join matches M on S.MatchID = M.MatchID inner join Players P on S.PlayerID = P.PlayerID;
 
#View: Teams in a Specific League
Create view printTeam as 
Select T.TeamName, T.CoachName,L.LeagueID 
from Team T 
Inner join League L 
on T.LeagueID = L.LeagueID 
where L.LeagueID = 1;
Select * from printTeam;

#View: Home Matches for a Specific Team
CREATE VIEW printMatch AS
SELECT M.Date AS matchday
FROM Team T
INNER JOIN Matches M ON M.Home_TeamID = T.TeamID
WHERE T.TeamID = 1;
Select * from printMatch;

#Scalar subquery: Display the teams with the maximum and minimum total runs scored
Select TeamID,Run,(Select max(run) from scores) as Max,(Select min(run) from scores)as Min from scores;
#Subquery: Display the team with the maximum number of away matches
Select * from matches where away_TeamID=(Select max(Away_TeamID) from matches);

#StoreProcedure : Retrieve Player Details for a Specific Team
Delimiter $$
Create Procedure allrows()
Begin
Select P.PlayerName,P.FieldPosition,P.runsaved from Players P inner join Team T on T.TeamID = P.TeamID where T.TeamID = 1;
End $$
Delimiter ;
Call allrows();