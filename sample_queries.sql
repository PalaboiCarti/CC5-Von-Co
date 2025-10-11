-- Insert Sample Data
INSERT INTO HERO VALUES
(1, 'Alucard', 'Fighter', 'Chase/Burst', '2016-08-10', 'Moniyan Empire', 2689, 42.5, 0, 0, 123, 0, 25, 15, 0.95, 1.00, 2.00, 260, 150, 'Moderate'),
(2, 'Eudora', 'Mage', 'Burst/Poke', '2016-06-08', 'Magical City', 2521, 36.2, 500, 12, 115, 135, 18, 22, 0.85, 1.00, 2.00, 240, 450, 'Low'),
(3, 'Miya', 'Marksman', 'DPS/Push', '2016-01-01', 'Moniyan Empire', 2550, 38.7, 420, 15, 130, 0, 17, 10, 1.10, 1.00, 2.00, 245, 700, 'Low');

INSERT INTO SKILL VALUES
(101, 'Slashes forward dealing physical damage', 'Damage/Blink', 250, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 'Single', 8, 0),
(102, 'Ultimate: Enters frenzy state', 'Buff/Damage', 350, 0, 0, 0, 50, 30, 30, 0, 0, 150, 0, 0, 0, 0, 0, 0, 'Self', 45, 0),
(103, 'Passive: Lifesteal on skills', 'Passive', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 'Self', 0, 0),
(201, 'Forked Lightning strikes enemy', 'Damage/Stun', 300, 0, 0, 1, 0, 0, 0, 0, 0, 0, 120, 0, 0, 0, 0, 0, 'Single', 6, 90),
(202, 'Ultimate: Lightning strikes multiple times', 'Damage/CC', 400, 0, 0, 2, 0, 0, 0, 0, 0, 0, 180, 0, 0, 0, 0, 0, 'Area', 40, 150),
(203, 'Passive: Extra magic damage after skills', 'Passive', 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, 0, 'Single', 3, 0),
(301, 'Fires an arrow dealing physical damage', 'Damage', 200, 0, 0, 0, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 'Single', 5, 60),
(302, 'Ultimate: Rain of arrows in area', 'Damage/Slow', 350, 0, 0, 1, 0, 0, 0, 0, 0, 120, 0, 0, 0, 0, 0, 0, 'Area', 30, 120),
(303, 'Passive: Attack speed stacks', 'Passive', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Self', 0, 0);

INSERT INTO EQUIPMENT VALUES
(1001, 'Blade of Despair', '2x Sword + 1300 Gold', 'Attack', 'Deals +25% damage to enemies under 50% HP', 160, 0, 0, 0, 0, 0, 0, 0, 0, 3010),
(1002, 'Endless Battle', 'Sword + Magic Necklace + 980 Gold', 'Hybrid', 'Next basic attack deals 70% extra true damage after using skill', 65, 15, 0, 0, 0, 250, 0, 0, 0, 2470),
(1003, 'Bloodlust Axe', 'Sword + Vitality Crystal + 900 Gold', 'Attack', 'Spell Vamp +20%', 70, 0, 0, 0, 0, 550, 0, 0, 0, 2250),
(1004, 'Lightning Truncheon', 'Book + Magic Necklace + 1100 Gold', 'Magic', 'Every 6 seconds, next skill deals 20% max mana as magic damage', 0, 75, 0, 0, 300, 250, 0, 0, 0, 2300),
(1005, 'Windtalker', 'Dagger + Necklace + 950 Gold', 'Attack', 'Every 4-6 basic attacks, release chain lightning', 0, 0, 20, 0, 0, 0, 0, 0, 0, 1820),
(1006, 'Berserker''s Fury', 'Gloves + Sword + 1200 Gold', 'Attack', '+40% Critical Damage, +5% Critical Chance', 65, 0, 0, 25, 0, 0, 0, 0, 0, 2250);

INSERT INTO CREEP VALUES
(5001, 'Buff Creep', 30, 'Red Buff/Blue Buff', 'Common', 1500),
(5002, 'Lord', 120, 'Lord Buff', 'Epic', 15000),
(5003, 'Turtle', 120, 'Gold & EXP', 'Rare', 8000),
(5004, 'Crab', 60, 'Gold & EXP', 'Common', 2000);

INSERT INTO HERO_SKILL VALUES
-- Alucard Skills
(1, 101, 1), (1, 102, 4), (1, 103, 0),
-- Eudora Skills
(2, 201, 1), (2, 202, 4), (2, 203, 0),
-- Miya Skills
(3, 301, 1), (3, 302, 4), (3, 303, 0);

INSERT INTO HERO_EQUIPMENT VALUES
-- Alucard Equipment
(1, 1001, 1, TRUE, 85.5), (1, 1002, 2, TRUE, 78.2), (1, 1003, 3, TRUE, 92.1),
-- Eudora Equipment
(2, 1004, 1, TRUE, 88.7), (2, 1002, 2, FALSE, 45.3),
-- Miya Equipment
(3, 1005, 1, TRUE, 91.2), (3, 1006, 2, TRUE, 86.4), (3, 1001, 3, TRUE, 79.8);

INSERT INTO HERO_CREEP_INTERACTION VALUES
-- Alucard vs Creeps
(1, 5001, 80, 100, 'Red Buff', 90, 30),
(1, 5002, 150, 300, 'Lord Buff', 180, 120),
-- Eudora vs Creeps
(2, 5001, 80, 100, 'Blue Buff', 90, 30),
(2, 5003, 120, 200, 'None', 0, 120),
-- Miya vs Creeps
(3, 5004, 60, 80, 'None', 0, 60),
(3, 5002, 150, 300, 'Lord Buff', 180, 120);

-- Demonstration Queries
-- 1. Show all heroes with their skills
SELECT h.Hero_Name, h.Role, s.Description, s.Type, hs.Skill_Slot
FROM HERO h
JOIN HERO_SKILL hs ON h.Hero_ID = hs.Hero_ID
JOIN SKILL s ON hs.Skill_ID = s.Skill_ID
ORDER BY h.Hero_Name, hs.Skill_Slot;

-- 2. Show recommended equipment for each hero
SELECT h.Hero_Name, e.Equipment_Name, e.Type, e.Passive, he.Slot_Number, he.Usage_Rate
FROM HERO h
JOIN HERO_EQUIPMENT he ON h.Hero_ID = he.Hero_ID
JOIN EQUIPMENT e ON he.Equipment_ID = e.Equipment_ID
WHERE he.Is_Recommended = TRUE
ORDER BY h.Hero_Name, he.Slot_Number;

-- 3. Show creep interactions for fighters
SELECT h.Hero_Name, c.Creep_Name, hci.Gold_Reward, hci.Experience_Reward, hci.Buff_Type
FROM HERO h
JOIN HERO_CREEP_INTERACTION hci ON h.Hero_ID = hci.Hero_ID
JOIN CREEP c ON hci.Creep_ID = c.Creep_ID
WHERE h.Role = 'Fighter'
ORDER BY h.Hero_Name, c.Creep_Name;

-- 4. Show hero statistics with their primary equipment
SELECT h.Hero_Name, h.Role, h.Specialty, h.Physical_Attack, h.Magic_Power,
       e.Equipment_Name, e.PA, e.MA
FROM HERO h
JOIN HERO_EQUIPMENT he ON h.Hero_ID = he.Hero_ID
JOIN EQUIPMENT e ON he.Equipment_ID = e.Equipment_ID
WHERE he.Slot_Number = 1 AND he.Is_Recommended = TRUE;

-- 5. Show skill details for mage heroes
SELECT h.Hero_Name, s.Description, s.Type, s.Base_Damage, s.CC_Duration, s.Cooldown
FROM HERO h
JOIN HERO_SKILL hs ON h.Hero_ID = hs.Hero_ID
JOIN SKILL s ON hs.Skill_ID = s.Skill_ID
WHERE h.Role = 'Mage' AND hs.Skill_Slot != 0
ORDER BY h.Hero_Name, hs.Skill_Slot;
