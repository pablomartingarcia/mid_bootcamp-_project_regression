use house_price_regression;

SELECT * FROM house_price_regression.house_price_data  -- Select all the data from the table to verify if the command worked. Limit your returned results to 10.
LIMIT 10;

SELECT COUNT(*) AS total_rows -- Query to find how many rows of data you have.
FROM house_price_regression.house_price_data;

-- Now we will try to find the unique values in some of the categorical columns
SELECT DISTINCT bedrooms FROM house_price_regression.house_price_data;
SELECT DISTINCT bathrooms FROM house_price_regression.house_price_data;
SELECT DISTINCT floors FROM house_price_regression.house_price_data;
SELECT DISTINCT `condition` FROM house_price_regression.house_price_data;
SELECT DISTINCT grade FROM house_price_regression.house_price_data;

SELECT id -- Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
FROM house_price_regression.house_price_data
ORDER BY price DESC
LIMIT 10;

SELECT AVG(price) AS average_price -- What is the average price of all the properties in your data?
FROM house_price_regression.house_price_data;

SELECT bedrooms, AVG(price) AS average_price_bedrooms
FROM house_price_regression.house_price_data
GROUP BY bedrooms;

SELECT bedrooms, AVG(sqft_living) AS average_sqft_living
FROM house_price_regression.house_price_data
GROUP BY bedrooms;

SELECT waterfront, AVG(price) AS average_price_waterfront
FROM house_price_regression.house_price_data
GROUP BY waterfront;

select distinct waterfront from house_price_regression.house_price_data;

SELECT `condition`, AVG(grade) AS avg_grade_condition
FROM house_price_regression.house_price_data
GROUP BY `condition`;

SELECT -- Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
    AVG((`condition` - avg_condition) * (grade - avg_grade)) / (STDDEV_POP(`condition`) * STDDEV_POP(grade)) AS correlation
FROM (
    SELECT
        `condition`,
        AVG(`condition`) OVER () AS avg_condition,
        grade,
        AVG(grade) OVER () AS avg_grade
    FROM
        house_price_regression.house_price_data
) subquery;

SELECT * -- One of the customers is only interested in the following houses:
FROM house_price_regression.house_price_data
WHERE bedrooms IN (3, 4)
  AND bathrooms > 3
  -- AND floors = 1
  -- AND waterfront = 0
  -- AND `condition` >= 3
  -- AND grade >= 5
  AND price < 300000;
  
SELECT *  -- Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. Write a query to show them the list of such properties. 
FROM house_price_regression.house_price_data
WHERE price > 2 * (SELECT AVG(price) FROM house_price_regression.house_price_data);

CREATE VIEW double_avg_price_properties AS  -- Since this is something that the senior management is regularly interested in, create a view of the same query.
SELECT *
FROM house_price_regression.house_price_data
WHERE price > 2 * (SELECT AVG(price) FROM house_price_regression.house_price_data);

SELECT *  -- view double_avg_price_properties created
FROM double_avg_price_properties;

SELECT bedrooms, AVG(price) AS average_price   -- Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?
FROM house_price_regression.house_price_data
WHERE bedrooms IN (3, 4)
GROUP BY bedrooms;

SELECT DISTINCT zipcode  -- What are the different locations where properties are available in your database? (distinct zip codes)
FROM house_price_regression.house_price_data;

SELECT COUNT(DISTINCT zipcode) AS count_zipcodes   -- counting the number of zipcodes
FROM house_price_regression.house_price_data;

SELECT * -- Show the list of all the properties that were renovated.
FROM house_price_regression.house_price_data
WHERE yr_renovated = 2015;

SELECT * -- Provide the details of the property that is the 11th most expensive property in your database.
FROM house_price_regression.house_price_data
ORDER BY price DESC
LIMIT 1 OFFSET 10;


  



