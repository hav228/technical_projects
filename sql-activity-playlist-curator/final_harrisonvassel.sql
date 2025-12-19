DROP DATABASE IF EXISTS activity_playlist_db;
CREATE DATABASE activity_playlist_db;
USE activity_playlist_db;

-- drops tables if theya already exist so we dont have duplicates.
DROP TABLE IF EXISTS Activity_Songs;
DROP TABLE IF EXISTS Songs;
DROP TABLE IF EXISTS Activities;
DROP TABLE IF EXISTS Artists;

-- creates the artist table, PK ArtistID
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    ArtistName VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),
    Country VARCHAR(50)
);

-- creates the songs table, PK SongID, FK ArtistID
CREATE TABLE Songs (
    SongID INT PRIMARY KEY,
    SongName VARCHAR(150) NOT NULL,
    ArtistID INT NOT NULL,
    Genre VARCHAR(50),
    BPM INT,
    EnergyLevel VARCHAR(20),
    Valence DECIMAL(3,2),
    DurationSeconds INT,
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

-- creates activities table, PK ActivityID,
CREATE TABLE Activities (
    ActivityID INT PRIMARY KEY,
    ActivityName VARCHAR(100) NOT NULL,
    Description VARCHAR(200),
    MinBPM INT,
    MaxBPM INT,
    TargetEnergy VARCHAR(20)
);

-- creates Activity_Songs table, PKs ActivityID and SongID,
CREATE TABLE Activity_Songs (
    ActivityID INT,
    SongID INT,
    RecommendationScore DECIMAL(3,2),
    PRIMARY KEY (ActivityID, SongID),
    FOREIGN KEY (ActivityID) REFERENCES Activities(ActivityID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

-- fills the Artists table with the specified data.
INSERT INTO Artists (ArtistID, ArtistName, Genre, Country) VALUES
(1, 'Drake', 'Hip Hop', 'Canada'),
(2, 'Taylor Swift', 'Pop', 'USA'),
(3, 'Kendrick Lamar', 'Hip Hop', 'USA'),
(4, 'Billie Eilish', 'Alternative', 'USA'),
(5, 'The Weeknd', 'R&B', 'Canada');

-- fills the songs table with the specified data.
INSERT INTO Songs (SongID, SongName, ArtistID, Genre, BPM, EnergyLevel, Valence, DurationSeconds) VALUES
(1, 'God''s Plan', 1, 'Hip Hop', 77, 'Medium', 0.36, 199),
(2, 'One Dance', 1, 'Hip Hop', 104, 'Medium', 0.59, 173),
(3, 'Shake It Off', 2, 'Pop', 160, 'High', 0.87, 219),
(4, 'Blank Space', 2, 'Pop', 96, 'Medium', 0.59, 231),
(5, 'Anti-Hero', 2, 'Pop', 97, 'Medium', 0.48, 200),
(6, 'HUMBLE.', 3, 'Hip Hop', 150, 'High', 0.42, 177),
(7, 'DNA.', 3, 'Hip Hop', 185, 'High', 0.40, 185),
(8, 'bad guy', 4, 'Alternative', 135, 'Medium', 0.56, 194),
(9, 'when the party''s over', 4, 'Alternative', 80, 'Low', 0.13, 196),
(10, 'Blinding Lights', 5, 'R&B', 171, 'High', 0.71, 200),
(11, 'Starboy', 5, 'R&B', 186, 'High', 0.49, 230),
(12, 'Save Your Tears', 5, 'R&B', 118, 'Medium', 0.48, 215),
(13, 'LOYALTY.', 3, 'Hip Hop', 138, 'Medium', 0.57, 227),
(14, 'Lover', 2, 'Pop', 69, 'Low', 0.74, 221),
(15, 'everything i wanted', 4, 'Alternative', 61, 'Low', 0.15, 245);

-- adding duplicate songs for my correlated query to catch later.
INSERT INTO Songs (SongID, SongName, ArtistID, Genre, BPM, EnergyLevel, Valence, DurationSeconds) VALUES
(16, 'God''s Plan', 1, 'Hip Hop', 78, 'Medium', 0.37, 201),
(17, 'Shake It Off', 2, 'Pop', 161, 'High', 0.88, 220);

-- adding songs that dont fit criteria for any activity for my creative query to catch later.
INSERT INTO Songs (SongID, SongName, ArtistID, Genre, BPM, EnergyLevel, Valence, DurationSeconds) VALUES
(18, 'Passionfruit', 1, 'Hip Hop', 112, 'Low', 0.52, 298),        
(19, 'Cruel Summer', 2, 'Pop', 170, 'Medium', 0.56, 178),         
(20, 'bury a friend', 4, 'Alternative', 120, 'Low', 0.23, 193); 
  
-- fills the activities table with specified data.
INSERT INTO Activities (ActivityID, ActivityName, Description, MinBPM, MaxBPM, TargetEnergy) VALUES
(1, 'Running', 'High intensity cardio workout', 150, 180, 'High'),
(2, 'Studying', 'Focus and concentration', 60, 100, 'Low'),
(3, 'Gym Workout', 'Weight lifting and strength training', 120, 160, 'High'),
(4, 'Commuting', 'Driving or public transit', 80, 130, 'Medium'),
(5, 'Relaxing', 'Unwinding after a long day', 50, 90, 'Low'),
(6, 'Pre-Game Hype', 'Getting pumped for lacrosse game', 140, 190, 'High'),
(7, 'Cleaning', 'Household chores', 100, 140, 'Medium'),
(8, 'Cooking', 'Preparing meals', 80, 120, 'Medium'),
(9, 'Walking', 'Light cardio or casual stroll', 90, 130, 'Low'),
(10, 'Party/Social', 'Hanging out with friends', 110, 150, 'High');

-- fills the Activity_Songs table with song recommmendations based on the activity.
INSERT INTO Activity_Songs (ActivityID, SongID, RecommendationScore) VALUES
(1, 3, 1.00), (1, 6, 1.00), (1, 7, 1.00), (1, 10, 1.00), (1, 11, 1.00),
(2, 1, 0.90), (2, 9, 1.00), (2, 14, 1.00), (2, 15, 1.00),
(3, 3, 0.95), (3, 6, 0.95), (3, 8, 0.85), (3, 13, 0.90),
(4, 2, 1.00), (4, 4, 1.00), (4, 5, 1.00), (4, 12, 0.90),
(5, 9, 1.00), (5, 14, 1.00), (5, 15, 1.00),
(6, 6, 1.00), (6, 7, 1.00), (6, 10, 1.00), (6, 11, 1.00),
(7, 2, 0.95), (7, 8, 0.95), (7, 12, 0.90), (7, 13, 0.95);

-- use a correlated subquery to find duplicate songs.
-- the inner query references the outer query.
SELECT s1.SongID, s1.SongName, s1.ArtistID, a.ArtistName
FROM Songs AS s1
JOIN Artists AS a ON s1.ArtistID = a.ArtistID
WHERE s1.SongName IN
    (SELECT s2.SongName
     FROM Songs AS s2
     WHERE s1.ArtistID = s2.ArtistID
       AND s1.SongName = s2.SongName        
       AND s1.SongID <> s2.SongID);         

-- creating a view  that combines songs and artists tables into a virtual table.
CREATE VIEW vw_SongDetails AS
  SELECT s.SongID,s.SongName,a.ArtistID,a.ArtistName,a.Country AS ArtistCountry,s.Genre,s.BPM,s.EnergyLevel,s.Valence,s.DurationSeconds,ROUND(s.DurationSeconds / 60.0, 2) AS DurationMinutes
  FROM Songs AS s
  JOIN Artists AS a ON s.ArtistID = a.ArtistID;


-- QUERIES
-- first query lists all artists from the database
SELECT * FROM Artists
ORDER BY ArtistName;

-- second query will find all songs with a BPM greater than 120.
SELECT SongName, BPM, EnergyLevel, Genre
FROM Songs
WHERE BPM > 120
ORDER BY BPM DESC;

-- the third query will list all songs which should be played while running.
-- the songs are sorted by SongName and all have high energy and high bpm and strong recommendation scores.
SELECT a.ActivityName, s.SongName, s.BPM, s.EnergyLevel, asongs.RecommendationScore
FROM Activities a
JOIN Activity_Songs asongs ON a.ActivityID = asongs.ActivityID
JOIN Songs s ON asongs.SongID = s.SongID
WHERE a.ActivityName = 'Running'
ORDER BY s.SongName ASC;


-- the fourth query finds all the songs in the hip hop genre.
SELECT s.SongName, a.ArtistName, s.BPM, s.EnergyLevel
FROM Songs s
JOIN Artists a ON s.ArtistID = a.ArtistID
WHERE s.Genre = 'Hip Hop'
ORDER BY s.BPM DESC;


-- the fifth query will count how many songs are in each genre and then calculate each genres average bpm.
SELECT Genre, COUNT(*) AS SongCount, ROUND(AVG(BPM), 1) AS AvgBPM, MIN(BPM) AS MinBPM, MAX(BPM) AS MaxBPM
FROM Songs
GROUP BY Genre
HAVING COUNT(*) >= 2
ORDER BY AvgBPM DESC;


-- the sixth query will find all songs with an above average bpm
SELECT s.SongName, a.ArtistName, s.BPM, s.Genre
FROM Songs s
JOIN Artists a ON s.ArtistID = a.ArtistID
WHERE s.BPM > (SELECT AVG(BPM) FROM Songs)
ORDER BY s.BPM DESC;


-- the seventh query joins the artists and songs table using the foreign key relationship.
-- it displays the songs with their artists information sorted alphabetically
SELECT a.ArtistName, a.Country, s.SongName, s.BPM, s.EnergyLevel, ROUND(s.DurationSeconds / 60.0, 2) AS DurationMinutes
FROM Artists a
JOIN Songs s ON a.ArtistID = s.ArtistID
ORDER BY a.ArtistName, s.SongName;


-- creative queries uniqie to the activity playlist
-- activity playlist is a playlist made for specific activities.


-- the first creative query finds songs to add to the Gym Workout playlist based on their BPM and energy
SELECT act.ActivityName, s.SongName, a.ArtistName, s.BPM, act.MinBPM, act.MaxBPM, s.EnergyLevel
FROM Activities act
CROSS JOIN Songs s
JOIN Artists a ON s.ArtistID = a.ArtistID
WHERE s.BPM BETWEEN act.MinBPM AND act.MaxBPM
    AND s.EnergyLevel = act.TargetEnergy
    AND act.ActivityName = 'Gym Workout'
ORDER BY s.BPM DESC;


-- the second query identifies versatile songs that can be listended to during several activities.
-- in this case, it identifies songs useful for 2 or more activities.
SELECT s.SongName, a.ArtistName, s.BPM, s.EnergyLevel, COUNT(asongs.ActivityID) AS ActivityCount
FROM Songs s
JOIN Artists a ON s.ArtistID = a.ArtistID
JOIN Activity_Songs asongs ON s.SongID = asongs.SongID
GROUP BY s.SongID, s.SongName, a.ArtistName, s.BPM, s.EnergyLevel
HAVING COUNT(asongs.ActivityID) >= 2
ORDER BY ActivityCount DESC, s.SongName;


-- the third and final query finds songs that dont meet the requirements for any activity.
-- possible next steps for this query could be the user can manually add these songs to a playlist if it fits for them.
SELECT s.SongName, a.ArtistName, s.Genre, s.BPM, s.EnergyLevel
FROM Songs s
JOIN Artists a ON s.ArtistID = a.ArtistID
WHERE s.SongID NOT IN (SELECT SongID FROM Activity_Songs)
ORDER BY s.BPM DESC;
