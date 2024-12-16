
-- PART 1 --

-- CREATE DATABASE --

CREATE DATABASE FoodServiceDB

USE FoodServiceDB

-- CHECK ALL THE .CSV FILES ARE IMPORTED--

SELECT * FROM Restaurants;
SELECT * FROM Consumers;
SELECT * FROM Ratings;
SELECT * FROM Restaurant_Cuisines;

-- ADD CONSTRAINTS PRIMARY AND FOREIGN KEY --

ALTER TABLE Restaurants
ADD CONSTRAINT PK_Restaurants PRIMARY KEY (Restaurant_ID);

-- Assuming Consumer_id is the primary key for Consumers table
ALTER TABLE Consumers
ADD CONSTRAINT PK_Consumers PRIMARY KEY (Consumer_ID);

-- Assuming (Consumer_ID, Restaurant_ID) is the composite primary key for Ratings table
ALTER TABLE Ratings
ADD CONSTRAINT PK_Ratings PRIMARY KEY (Consumer_ID, Restaurant_ID);

-- Assuming (Consumer_id, Restaurant_id) is the foreign key in Ratings referencing (Restaurants,Consumers) tables
ALTER TABLE Ratings
ADD CONSTRAINT FK_Ratings_Restaurant_ID FOREIGN KEY (Restaurant_ID) REFERENCES Restaurants (Restaurant_ID);
ALTER TABLE Ratings
ADD CONSTRAINT FK_Ratings_Consumer_ID FOREIGN KEY (Consumer_ID) REFERENCES Consumers (Consumer_ID);

-- Assuming Restaurant_id is the foreign key in Restaurant_Cuisines referencing Restaurant table

ALTER TABLE Restaurant_Cuisines
ADD CONSTRAINT FK_Restaurant_Cuisines_Restaurant_ID FOREIGN KEY (Restaurant_ID) REFERENCES Restaurants(Restaurant_ID);

-- PART 2 --

-- Query 1: List all restaurants with a Medium range price, open area, serving Mexican food

SELECT R.*
FROM Restaurants R
JOIN Restaurant_Cuisines RC ON R.Restaurant_id = RC.Restaurant_id
WHERE R.Price = 'Medium' AND R.Area = 'Open' AND RC.Cuisine = 'Mexican';

-- Query 2: Total number of restaurants with overall rating as 1 serving Mexican food

SELECT COUNT(DISTINCT R.Restaurant_id)
FROM Restaurants R
JOIN Ratings Ra ON R.Restaurant_id = Ra.Restaurant_id
JOIN Restaurant_Cuisines RC ON R.Restaurant_id = RC.Restaurant_id
WHERE Ra.Overall_Rating = 1
AND RC.Cuisine = 'Mexican';

-- Total number of restaurants with overall rating as 1 serving Italian food

SELECT COUNT(DISTINCT R.Restaurant_id)
FROM Restaurants R
JOIN Ratings Ra ON R.Restaurant_id = Ra.Restaurant_id
WHERE Ra.Overall_Rating = 1
AND EXISTS (
    SELECT 1
    FROM Restaurant_Cuisines RC
    WHERE R.Restaurant_id = RC.Restaurant_id AND RC.Cuisine = 'Italian'
);

-- Explanation: We're using EXISTS to check if there are any restaurants serving Mexican/Italian food with an overall rating of 1.

-- Query 3: Average age of consumers who rated 'Service_rating' as 0

SELECT ROUND(AVG(C.Age), 0) AS Average_Age
FROM Consumers C
JOIN Ratings R ON C.Consumer_id = R.Consumer_id
WHERE R.Service_Rating = 0;

-- Query 4: Restaurants ranked by the youngest consumer with their food rating (sorted by food rating)

SELECT R.Name, Ra.Food_Rating
FROM Restaurants R
JOIN Ratings Ra ON R.Restaurant_id = Ra.Restaurant_id
JOIN Consumers C ON Ra.Consumer_id = C.Consumer_id
WHERE C.Age = (SELECT MIN(Age) FROM Consumers)
ORDER BY Ra.Food_Rating DESC;

-- Query 5: Stored procedure for updating Service_rating of restaurants with available parking

CREATE PROCEDURE Update_ServiceRatingWithParking
AS
BEGIN
    UPDATE Ratings
    SET Service_Rating = 2
    WHERE Restaurant_id IN (
        SELECT R.Restaurant_id
        FROM Restaurants R
        WHERE R.Parking IN ('yes', 'public')
    );
END;
-- To call the Procedure --
EXEC Update_ServiceRatingWithParking;
SELECT * FROM Ratings;

--6 -- Custom Query

--(1) Nested Queries - EXISTS --

SELECT *
FROM Consumers c
WHERE EXISTS (
    SELECT 1
    FROM Ratings ra
    WHERE ra.Consumer_id = c.Consumer_id
    AND ra.Overall_Rating = 1
);

--

SELECT AVG(Age) AS Avg_Age
FROM Consumers C
WHERE EXISTS (
    SELECT 1
    FROM Ratings R
    WHERE R.Consumer_id = C.Consumer_id AND R.Overall_Rating = 5
);

-- (2) Nested Queries - IN --

SELECT *
FROM Consumers
WHERE Consumer_id IN (
    SELECT Consumer_id
    FROM Ratings
    WHERE Overall_Rating = 1
);

--
SELECT Name, City, State, Country
FROM Restaurants
WHERE State IN (
    SELECT DISTINCT State
    FROM Restaurants
)
ORDER BY Name;


-- System Functions Clauses --

-- (3) GROUPBY AND HAVING --

--
SELECT Cuisine, COUNT(*) AS Restaurant_Count
FROM Restaurant_Cuisines
GROUP BY Cuisine
HAVING COUNT(*) > 5
ORDER BY Restaurant_Count DESC;

--
SELECT City, COUNT(*) AS NumConsumers
FROM Consumers
GROUP BY City
HAVING COUNT(*) > 5;

-- HAVING --

SELECT R.Restaurant_id, R.Name, COUNT(*) AS Rating_Count
FROM Restaurants R
JOIN Ratings Ra ON R.Restaurant_id = Ra.Restaurant_id
GROUP BY R.Restaurant_id, R.Name
HAVING COUNT(*) = (
    SELECT MAX(Rating_Count)
    FROM (
        SELECT COUNT(*) AS Rating_Count
        FROM Ratings
        GROUP BY Restaurant_id
    ) AS Max_Rating
)


-- (4) ORDERBY --

SELECT *
FROM Restaurants
ORDER BY Latitude DESC;

--
SELECT Consumer_id, Occupation, Age, Budget
FROM Consumers
WHERE Age > (SELECT AVG(Age) FROM Consumers)
ORDER BY Age DESC;

--
SELECT R.Restaurant_id, R.Name, AVG(Ra.Overall_Rating) AS Avg_Rating
FROM Restaurants R
JOIN Ratings Ra ON R.Restaurant_id = Ra.Restaurant_id
WHERE EXISTS (
    SELECT 1
    FROM Restaurant_Cuisines
    WHERE Restaurant_id = R.Restaurant_id
    AND Cuisine = 'Italian'
)
GROUP BY R.Restaurant_id, R.Name
ORDER BY Avg_Rating DESC;

-- TO PERFORM FULL DATABASE BACKUP--

BACKUP DATABASE FoodServiceDB TO DISK = 'E:\00755216backup\00755216_task2.bak'
WITH CHECKSUM;

-- TO RESTORE DATABASE FROM BACKUP --

RESTORE VERIFYONLY FROM DISK = 'E:\00755216backup\00755216_task2.bak';








    
