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