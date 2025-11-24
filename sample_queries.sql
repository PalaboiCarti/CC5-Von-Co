SELECT 
    h.Hero_Name,
    h.Role,
    h.Difficulty,
    f.Faction_Name,
    e.Equipment_Name,
    et.Type_Name AS Equipment_Type,
    heb.Slot_Number,
    heu.Usage_Rate,
    (hs.Physical_Attack + COALESCE(es.PA, 0)) AS Total_Physical_Attack,
    (hs.HP + COALESCE(es.HP, 0)) AS Total_Health
FROM Heroes h
JOIN Factions f ON h.Faction_ID = f.Faction_ID
JOIN Hero_Statistics hs ON h.Hero_ID = hs.Hero_ID
JOIN Hero_Equipment_Build heb ON h.Hero_ID = heb.Hero_ID
JOIN Equipments e ON heb.Equipment_ID = e.Equipment_ID
JOIN Equipment_Types et ON e.Type_ID = et.Type_ID
LEFT JOIN Equipment_Statistics es ON e.Equipment_ID = es.Equipment_ID
LEFT JOIN Hero_Equipment_Usage heu ON h.Hero_ID = heu.Hero_ID AND e.Equipment_ID = heu.Equipment_ID
WHERE heb.Is_Recommended = TRUE
  AND h.Role IN ('Assassin', 'Fighter', 'Marksman')
  AND heu.Usage_Rate > 60
ORDER BY h.Hero_Name, heb.Slot_Number
LIMIT 50;

SELECT 
    e.Equipment_Name,
    et.Type_Name,
    e.Price,
    COUNT(DISTINCT heb.Hero_ID) AS Recommended_By_Heroes,
    COUNT(DISTINCT heu.Hero_ID) AS Total_Users,
    ROUND(AVG(heu.Usage_Rate), 1) AS Avg_Usage_Rate,
    ROUND((COUNT(DISTINCT heb.Hero_ID) * 100.0 / COUNT(DISTINCT heu.Hero_ID)), 1) AS Recommendation_Rate
FROM Equipments e
JOIN Equipment_Types et ON e.Type_ID = et.Type_ID
LEFT JOIN Hero_Equipment_Build heb ON e.Equipment_ID = heb.Equipment_ID AND heb.Is_Recommended = TRUE
LEFT JOIN Hero_Equipment_Usage heu ON e.Equipment_ID = heu.Equipment_ID
WHERE e.Price BETWEEN 1500 AND 3000
GROUP BY e.Equipment_ID, e.Equipment_Name, et.Type_Name, e.Price
HAVING COUNT(DISTINCT heu.Hero_ID) > 0
   AND AVG(heu.Usage_Rate) > 50
ORDER BY Avg_Usage_Rate DESC, Total_Users DESC
LIMIT 25;

EXPLAIN FORMAT=JSON
SELECT 
    h.Hero_Name,
    h.Role,
    COUNT(heb.Equipment_ID) AS Equipment_Count,
    AVG(heu.Usage_Rate) AS Avg_Usage
FROM Heroes h
JOIN Hero_Equipment_Build heb ON h.Hero_ID = heb.Hero_ID
LEFT JOIN Hero_Equipment_Usage heu ON h.Hero_ID = heu.Hero_ID AND heb.Equipment_ID = heu.Equipment_ID
WHERE h.Role = 'Mage'
  AND heb.Is_Recommended = TRUE
GROUP BY h.Hero_ID, h.Hero_Name, h.Role
HAVING AVG(heu.Usage_Rate) > 70;

SELECT 
    f.Faction_Name,
    h.Role,
    COUNT(DISTINCT h.Hero_ID) AS Hero_Count,
    COUNT(DISTINCT heb.Equipment_ID) AS Unique_Equipment_Count,
    ROUND(AVG(heu.Usage_Rate), 1) AS Avg_Usage_Rate,
    ROUND(AVG(e.Price), 0) AS Avg_Equipment_Price,
    MAX(heu.Usage_Rate) AS Highest_Usage_Rate
FROM Factions f
JOIN Heroes h ON f.Faction_ID = h.Faction_ID
JOIN Hero_Equipment_Build heb ON h.Hero_ID = heb.Hero_ID AND heb.Is_Recommended = TRUE
JOIN Equipments e ON heb.Equipment_ID = e.Equipment_ID
LEFT JOIN Hero_Equipment_Usage heu ON h.Hero_ID = heu.Hero_ID AND e.Equipment_ID = heu.Equipment_ID
WHERE heu.Usage_Rate IS NOT NULL
GROUP BY f.Faction_ID, f.Faction_Name, h.Role
HAVING COUNT(DISTINCT h.Hero_ID) >= 1
   AND AVG(heu.Usage_Rate) > 60
ORDER BY f.Faction_Name, h.Role, Avg_Usage_Rate DESC;
