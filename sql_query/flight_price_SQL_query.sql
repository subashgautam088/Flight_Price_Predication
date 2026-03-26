CREATE DATABASE project_p1;
CREATE TABLE flights (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Airline VARCHAR(50),
    Date_of_Journey DATE,
    Source VARCHAR(50),
    Destination VARCHAR(50),
    Route VARCHAR(100),
    Dep_Time TIME,
    Arrival_Time VARCHAR(50),
    Duration VARCHAR(20),
    Total_Stops INT,
    Additional_Info VARCHAR(100),
    Price INT,
    Duration_hours INT,
    Duration_minutes INT,
    Duration_total_mins INT
);

-- Flight Dataset Analysis**
# 1.Total Number of flights
SELECT COUNT(Airline) FROM flights;
SELECT COUNT(DISTINCT(Airline)) AS diff_flight FROM flights;
SELECT Airline,COUNT(Airline) AS flight_num FROM flights GROUP BY 1;

# Average ticket price
SELECT Airline,AVG(Price) FROM flights GROUP BY Airline;
SELECT AVG(Price) FROM flights;

# 3.Maximum price ticket
SELECT Airline,Price FROM flights ORDER BY Price DESC ;
SELECT Airline,MAX(Price) FROm flights GROUP BY Airline;
SELECT Airline,Price FROM flights WHERE Price = (SELECT MAX(Price) FROm flights);

# 4.Minimum price ticket
SELECT Airline,MIN(Price) FROM flights GROUP BY Airline;
SELECT Airline,Price FROM flights ORDER BY Price;
SELECT Airline,Price FROm flights WHERE Price = (SELECT MIN(Price) FROM flights);

# 5.Flights from Delhi
SELECT * FROm flights WHERE Source='Delhi';

# Flights to Bangalore
SELECT * FROM flights WHERE Destination='Bangalore';

# 7.Flights with more than 1 stop
SELECT * FROm flights WHERE Total_Stops > 1;

# 8.Count flights per airline
SELECT Airline,COUNT(*) FROM flights GROUP BY Airline;

# 9.Show top 10 most expensive tickets
SELECT * FROM flights ORDER BY Price DESC LIMIT 10;
SELECT *,Price FROm flights ORDER BY Price DESC;

# 10.Flights with duration > 5 hours
SELECT * FROM flights WHERE Duration > '5h' ORDER BY Duration DESC;
SELECT * FROM flights WHERE Duration > '5h';
SELECT * FROm flights WHERE Duration_hours > 5 ORDER BY Duration_hours DESC;

# 11.Average price per airline
SELECT Airline,AVG(Price) FROm flights GROUP BY Airline;

# 12.Total flights per source city
SELECT Source,COUNT(*) AS num_flights FROM flights GROUP BY Source;

# 13.Total flights per destination
SELECT Destination,COUNT(*) AS num_flight FROM flights GROUP BY Destination;

# 14.Average duration per airline
SELECT Airline,ROUND(AVG(Duration),2) AS avg_dur FROm flights GROUP BY Airline;

# 15.Total revenue(Price) per airline
SELECT Airline,SUm(Price) AS tot_rev FROm flights GROUP BY Airline ORDER BY tot_rev DESC;

# 16.Most expensive airline (avg Price)
SELECT Airline,ROUND(AVG(Price),2) AS avg_price FROm flights GROUP BY Airline ORDER BY avg_price DESC;

# 17.Count flights by total stops
SELECT Total_Stops,COUNT(Airline) FROM flights GROUP BY Total_Stops;

# 18.Route wise average price
SELECT Route,ROUND(AVG(Price),2) AS avg_price FROm flights GROUP BY Route ORDER BY avg_price;

# 19. Source-->Destination total flights
SELECT Source,Destination,COUNT(Airline) AS total_flights FROm flights GROUP BY SOurce, Destination;

# 20.Airline wise max and min price
SELECT AIrline,MAX(price),MIN(Price) FROM flights GROUP BY Airline;

# 21.Flights per journey date
 SELECT Date_of_Journey,COUNT(Airline) FROm flights GROUP BY Date_of_Journey ORDER BY Date_of_Journey;
 
 # 22.Average Price per day
SELECT DAYNAME(Date_of_Journey),ROUND(AVG(Price),2) FROM flights GROUP BY 1;

# 23.Peak travel day(max flights)
SELECT DAYNAME(Date_of_Journey),COUNT(Airline) AS num_flight FROm flights GROUP BY 1 ORDER BY 2 DESC;

# 24.Flights per month
SELECT MONTHNAME(Date_of_Journey),COUNT(Airline) AS num_flight FROm flights GROUP BY 1 ORDER BY 2 DESC;
SELECT MONTH(Date_of_Journey),COUNT(Airline) AS num_flight FROm flights GROUP BY 1 ORDER BY 2 DESC;

# 25.Average duration per month
SELECT MONTHNAME(Date_of_Journey),ROUND(AVG(Duration),2) AS avg_dur FROm flights GROUP BY 1 ORDER BY 2;

# 26.Departure hour wise flight count.
SELECT HOUR(Dep_Time) AS hour_wise ,COUNT(*) AS flight_count FROM flights GROUP BY 1;
SELECT HOUR(Dep_Time) AS hour_wise,Source,COUNT(*) AS flight_count FROM flights WHERE Source = 'Delhi' GROUP BY 1;

# 27.Most common departure time
SELECT Dep_Time,COUNT(*) FROm flights GROUP BY 1 ORDER BY 2 DESC LIMIT 1;

# 28.Flights per weekday
SELECT WEEKDAY(Date_of_Journey), COUNT(*) FROM flights GROUP BY 1 ORDER BY 2 DESC;

# 29.Cheapest day to  travel
SELECT DAYNAME(Date_of_Journey), Price FROM flights ORDER BY 2;

# 30.Most expensive day
-- SELECT DAYNAME(Date_of_Journey),Price FROm flights ORDER BY Price DESC; 
SELECT DAYNAME(Date_of_Journey),ROUND(AVG(Price),2) FROm flights GROUP BY 1 ORDER BY 2 DESC;

# 31.Row number for each airline
SELECT *,ROW_NUMBER() OVER(PARTITION BY Airline ORDER BY Airline) AS row_num FROM flights;

# 32.Rank flights by price
SELECT *,RANK() OVER(PARTITION BY Airline ORDER BY Price DESC) AS rnk FROM flights;

# 33.Rank flights within each airline
SELECT *,RANK() OVER(PARTITION BY Airline ORDER BY Dep_Time) AS rnk FROm flights;

# 34.Running average price by date
SELECT Date_of_Journey,AVG(Price),AVG(Price) OVER(PARTITION BY Date_of_Journey ORDER BY DATE_of_Journey) 
	AS avg_price FROM flights GROUP BY 1;

# 32.Rank flights by price
SELECT Airline,
       SUM(Price) AS total_price,
       RANK() OVER(ORDER BY SUM(Price) DESC) AS rnk
FROM flights
GROUP BY Airline;

# 33.Rank flights within each airline
SELECT Airline,
	RANK() OVER(PARTITION BY Airline ORDER BY Airline) AS rnk 
    FROM flights;
    
# 34.Running average price by date
SELECT 
    Airline,
    Date_Of_Journey,
    Price,
    AVG(Price) OVER (
        PARTITION BY Date_Of_Journey 
        ORDER BY Price
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_avg_price
FROM flights;

# 35.Running total revenue
SELECT Airline,Date_of_Journey,Price,SUM(Price) OVER(PARTITION BY Airline
		ORDER BY Date_of_Journey
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_revenue
    FROM flights;

# 36.Previous flight price(LAG)
SELECT *,LAG(Price) OVER(PARTITION BY Airline 
				ORDER BY Date_of_Journey) AS prev_price FROm flights;

# 37.Next flight price(LEAD)
SELECT *,Price,LEAD(Price) OVER(PARTITION BY Airline 
		ORDER BY Date_of_Journey) AS next_price FROM flights;
        
# 38. Price difference prom previous flight
SELECT *,
		LAG(Price) OVER(PARTITION BY AIrline ORDER BY Date_of_Journey) AS
		prev_price
,Price - LAG(Price) OVER(PARTITION BY AIrline ORDER BY Date_of_Journey) AS
		diff_pric_prev_price FROM flights;
        
# 39.Top 3 expensive flights per airline
SELECT *,DENSE_RANK() OVER(PARTITION BY Airline ORDER BY Price DESC) AS rnk
	FROM flights;
SELECT * FROM(SELECT Airline,Price,DENSE_RANK() 
		OVER(PARTITION BY Airline ORDER BY Price DESC) AS rnk
		FROM flights) t 
        WHERE rnk <=3;       
SELECT Airline, AVG(Price) AS avg_top3_price
FROM (
    SELECT *,
           DENSE_RANK() OVER(PARTITION BY Airline ORDER BY Price DESC) AS rnk
    FROM flights
) t
	WHERE rnk <= 3
	GROUP BY Airline
	ORDER BY avg_top3_price DESC;

# 40.Cheapest flight per route
SELECT * FROM(
	SELECT Airline,Route,Price,DENSE_RANK()
    OVER(PARTITION BY Route ORDER BY Price) AS rnk
    FROM flights) t WHERE rnk =1;

# 41.Price contribution % of each flight
SELECT Airline,ROUND((SUM(Price) / (SELECT SUM(Price) FROM flights) * 100),2) 
	AS contri FROM flights GROUP BY Airline;
    
# 42.Flights with price above airline average
SELECT Airline,Price,AVG(Price) OVER(PARTITION BY Airline) As avg_price, 
	CASE
		WHEN Price > AVG(Price) OVER(PARTITION BY Airline) THEN 'Above_avg'
        WHEN Price < AVG(Price) OVER(PARTITION BY Airline) THEN 'Below_avg'
        END AS compare
    FROM flights;
-- CTE USE
WITH AirlineAvg AS (
    SELECT 
    Airline, Price, AVG(Price) OVER (PARTITION BY Airline) AS avg_price
    FROM flights
    )
	SELECT 
		Airline, Price, avg_price,
		CASE
			WHEN Price > avg_price THEN 'Above_avg'
			WHEN Price < avg_price THEN 'Below_avg'
			ELSE 'Equal'  -- Optional: In case Price equals avg_price
		END AS compare
	FROM AirlineAvg;
    
# 43.Find cheapest flight per source
SELECT * FROM(
		SELECT Airline,Price,Source,DENSE_RANK() 
		OVER(PARTITION BY Source ORDER BY Price) AS rnk FROm flights) t
        WHERE rnk =1; 
SELECT * FROM(
		SELECT Airline,Price,Source,DENSE_RANK() 
		OVER(PARTITION BY Source ORDER BY AVG(Price)) AS rnk FROm flights) t
        WHERE rnk =1;

# 44.Find most expensive route
SELECT * FROM(SELECT Route,Price,DENSE_RANK() OVER(PARTITION BY Route ORDER BY Price DESC) AS exp_route
	FROM flights) t WHERE exp_route = 1;
    
# 45.Airline performance (avg price + avg duration)
SELECT Airline,AVG(Price) AS avg_price,AVG(Duration) AS avg_dur FROM flights GROUP BY 1;

# 46.Compare direct vs connecting flights
SELECT Total_Stops,COUNT(*), AVG(Price) FROM flights GROUP BY Total_Stops;
SELECT Total_Stops,COUNT(*) FROM flights GROUP BY Total_Stops;

# 47.Find routes with highest delays(Based on duration)
SELECT Route,Duration FROM flights ORDER BY Duration DESC;
SELECT Route, Duration 
		FROM flights 
		ORDER BY Duration DESC
		LIMIT 10;

# 48.Find busiest route
SELECT Route,COUNT(*) FROM flights GROUP BY Route ORDER BY 2 DESC;

# 49.Top 10% expensive flights
SELECT *
		FROM (
			SELECT *, PERCENT_RANK() OVER (ORDER BY Price DESC) AS pr
			FROM flights
		) t
		WHERE pr <= 0.10;
SELECT *
		FROM (
			SELECT *, NTILE(10) OVER (ORDER BY Price DESC) AS bucket
			FROM flights
		) t
		WHERE bucket = 1; 
-- Bucket 1= top 10% 

# 50.Detect price spike between consecutive flights
SELECT 
		id,
		Route,
		Price,
		LAG(Price) OVER (PARTITION BY Route ORDER BY Date_of_Journey) AS Prev_Price,
		Price - LAG(Price) OVER (PARTITION BY Route ORDER BY Date_of_Journey) AS Price_Diff
	FROM flights;
    
# 51.Build report Airline,Total flights,Avg price,Rank airline by revenue
SELECT Airline,COUNT(*),AVG(Price) AS avg_price,
		SUM(price) AS revenue,
        RANK() OVER(ORDER BY SUM(Price) DESC) AS rnk_revenue
        FROM flights
        GROUP BY Airline;

# 52.Route analysis:Source,  Destination, Total flights, Avg price,Cheapest flight
SELECT 
		Source,Destination, COUNT(*) AS total_flights,
		ROUND(AVG(Price),2) AS avg_price, MIN(Price) AS cheapest_flight,
		CASE
			WHEN AVG(Price) < (SELECT AVG(Price) FROM flights) THEN 'Cheap'
			ELSE 'Expensive'
		END AS route_category
	FROM flights
	GROUP BY Source, Destination;
    
# 53.Time Analysis dashboard: Departure hour,flight count, Avg Price
SELECT Dep_Time,COUNT(*) AS flight_count,
	ROUND(AVG(Price),2) AS avg_price
    FROM flights
    GROUP BY Dep_Time;

# 54.Stops Analysis: Total_Stops,Avg price,AVG duration
SELECT Total_Stops,ROUND(AVG(Price),2) AS avg_price,
		 ROUND(AVG(Duration),2) AS avg_duration
         FROM flights
         GROUP BY Total_Stops;

# 55.Final Project Query:Airline,Source,Destination,Price,Rank price within airline,
# Previous flight price, Price difference
WITH cte AS (
    SELECT Airline,Source,Destination,Price,
        RANK() OVER (PARTITION BY Airline ORDER BY Price DESC) AS rnk,
        LAG(Price) OVER (PARTITION BY Airline ORDER BY Price DESC) AS prev_price
    FROM flights
)
SELECT Airline,Source,Destination,Price,rnk,
	prev_price,
    Price - prev_price AS diff_price
FROM cte;


SELECT * FROM flights; 
SELECT COUNT(*) FROm flights;
USE project_p1;
SELECT DISTINCT(Airline) FROM flights;
# How many different flights are?
SELECT COUNT(DISTINCT(Airline)) FROM flights;