DROP TABLE IF EXISTS dbo.PlayerRegistration;
DROP TABLE IF EXISTS dbo.TeamEntry;
DROP TABLE IF EXISTS dbo.Club;
DROP TABLE IF EXISTS dbo.Season;
DROP TABLE IF EXISTS dbo.Player;

CREATE TABLE Player
(
    PlayerID INT PRIMARY KEY,
    FName VARCHAR(100) NOT NULL,
    LName VARCHAR(100) NOT NULL,
    Phone NVARCHAR(50) NULL,
)

CREATE TABLE Season
(
    Year INT,
    SeasonName VARCHAR(6) ,
    PRIMARY KEY (Year,SeasonName),
    CONSTRAINT Check_SeasonName
    CHECK (SeasonName IN ('Winter', 'Summer'))
);

CREATE TABLE Club
(
    ClubName VARCHAR(100) PRIMARY KEY,
    ContactName VARCHAR(100) NULL
)

CREATE TABLE TeamEntry
(
    AgeGroup VARCHAR(3),
    TeamNumber INT,
    ClubName VARCHAR(100),
    Year INT,
    SeasonName VARCHAR(6),
    PRIMARY KEY(AgeGroup,TeamNumber,ClubName,Year,SeasonName),
    FOREIGN KEY (ClubName) REFERENCES Club,
    FOREIGN KEY (Year,SeasonName) REFERENCES Season
)

CREATE TABLE PlayerRegistration
(
    DateRegistered DATE,
    PlayerID INT,
    ClubName VARCHAR(100),
    Year INT,
    SeasonName VARCHAR(6),
    AgeGroup VARCHAR(3),
    TeamNumber INT,
    PRIMARY KEY(PlayerID,ClubName,Year,SeasonName,AgeGroup,TeamNumber),
    FOREIGN KEY (PlayerID) REFERENCES Player,
    FOREIGN KEY (AgeGroup,TeamNumber,ClubName,Year,SeasonName) REFERENCES TeamEntry
)



INSERT INTO Player (PlayerID,FName,LName,Phone) VALUES
(10002,'John','Howard','5552345'),
(10003,'Julia','Gillard','5553456'),
(10004,'Tim','Burwood','5554567'),
(10005,'Tess','Spotswood','5555678');

INSERT INTO Season (Year,SeasonName) VALUES
(2018,'Winter'),
(2018,'Summer'),
(2019,'Winter'),
(2019,'Summer');

INSERT INTO Club (ClubName,ContactName) VALUES
('Mt Martha Basketball Club', 'Bob Jane'),
('SwinTeam Basketball Club','June Crow'),
('Monash Basketball Club','George Wood'),
('VicUni Basketball Club','James Mars');

INSERT INTO TeamEntry (ClubName,Year,SeasonName,AgeGroup,TeamNumber) VALUES
('Mt Martha Basketball Club',2018,'Summer','U14',1),
('Mt Martha Basketball Club',2018,'Summer','U14',2),
('SwinTeam Basketball Club',2018,'Winter','U16',6),
('SwinTeam Basketball Club',2019,'Winter','U14',2),
('SwinTeam Basketball Club',2019,'Winter','U16',3),
('VicUni Basketball Club',2019,'Winter','U16',4);

INSERT INTO PlayerRegistration (DateRegistered,PlayerID,ClubName,Year,SeasonName,AgeGroup,TeamNumber) VALUES
('2018-01-22',10003,'Mt Martha Basketball Club',2018,'Summer','U14',2),
('2018-06-11',10002,'Mt Martha Basketball Club',2018,'Summer','U14',1),
('2019-06-12',10004,'VicUni Basketball Club',2019,'Winter','U16',4),
('2019-06-14',10005,'SwinTeam Basketball Club',2019,'Winter','U16',3);

Select r.PlayerID, p.FName, p.LName, r.ClubName, c.ContactName, r.Year, r.SeasonName, r.AgeGroup, r.TeamNumber
FROM ((PlayerRegistration r
INNER JOIN Player p
ON r.PlayerID = p.PlayerID)
INNER JOIN Club c
ON r.ClubName = c.ClubName)
Order By PlayerID asc;

Select t.Year, t.AgeGroup, count(p.PlayerID) as "Number of Player"
FROM (TeamEntry t
INNER JOIN PlayerRegistration p
ON t.Year = p.Year)
GROUP BY t.Year, t.AgeGroup
ORDER BY t.Year, t.AgeGroup;


Select PlayerID, FName as "First Name", LName as "Last Name"
FROM Player
Where FName IN ( Select FName
                FROM Player
                WHERE Fname LIKE 'J%')
