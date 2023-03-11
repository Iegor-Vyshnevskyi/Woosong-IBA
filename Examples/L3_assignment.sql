--6
SELECT count(DISTINCT name)
FROM cities;

--7
SELECT *
FROM cities 
WHERE metroarea_pop >= 2000000 
	AND metroarea_pop <= 10000000
ORDER BY urbanarea_pop desc;


--8
SELECT country_code  , max(city_proper_pop)
FROM cities 
GROUP BY country_code;

--9
SELECT region, sum(surface_area) AS total_surface_area 
FROM countries
WHERE (continent = 'Asia' OR continent = 'Europe')
AND (indep_year >= 1945)
GROUP BY region
ORDER BY total_surface_area DESC ;

--10
SELECT *
FROM cities c 
LEFT JOIN countries c2 
ON c.country_code  = c2.code
WHERE metroarea_pop IS NOT NULL
AND indep_year >= 1945;


SELECT * FROM cities;
SELECT * FROM countries;

