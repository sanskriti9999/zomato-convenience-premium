#ONLINE ORDERING VS POPULARITY-splits restaurants into online and offline and calculates the avg votes and no of restaurants for each group
SELECT online_order,ROUND(AVG(votes), 2) AS avg_votes,COUNT(*) AS total_restaurants
FROM restaurants
GROUP BY online_order;
#Offline restaurants actually get slightly more votes

#Which cuisine category is most popular?
SELECT cuisine_bucket,ROUND(AVG(votes), 2) AS avg_votes,ROUND(AVG(rate), 2) AS avg_rating,COUNT(*) AS total
FROM restaurants
GROUP BY cuisine_bucket
ORDER BY avg_votes DESC;
/*
Premium cuisines dominate votes by a massive margin — nearly 4x Fast food. 
But notice Premium also has the highest rating. So quality and popularity align here.
*/

#Does higher rating actually mean more votes?
SELECT 
    CASE 
        WHEN rate >= 4.5 THEN '4.5+'
        WHEN rate >= 4.0 THEN '4.0-4.4'
        WHEN rate >= 3.5 THEN '3.5-3.9'
        WHEN rate >= 3.0 THEN '3.0-3.4'
        ELSE 'Below 3.0'
    END AS rating_band,ROUND(AVG(votes), 2) AS avg_votes,COUNT(*) AS total
FROM restaurants
GROUP BY rating_band
ORDER BY avg_votes DESC;
#Votes increase exponentially with rating.Quality actually does predict popularity very strongly.

#Does convenience matter more in Metro vs Tier 2?
Select city_tier,online_order,ROUND(AVG(votes), 2) AS avg_votes,COUNT(*) AS total
FROM restaurants
GROUP BY city_tier, online_order
ORDER BY city_tier, avg_votes DESC;
/*
In Tier2 areas, online ordering helps.
In Metro areas, top restaurants are already popular without it. The effect of online ordering is location-dependent.
*/

#What do the most popular restaurants look like?
SELECT  name,MAX(votes) AS votes,MAX(rate) AS rate,online_order,cuisine_bucket,city_tier
FROM restaurants
GROUP BY name, online_order, cuisine_bucket, city_tier    #preventing duplicates
ORDER BY votes DESC
LIMIT 20;
