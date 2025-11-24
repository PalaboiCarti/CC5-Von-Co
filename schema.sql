DROP TABLE IF EXISTS Equipment_Statistics, Hero_Statistics;
DROP TABLE IF EXISTS Hero_Equipment_Build, Hero_Equipment_Usage, Hero_Build_Slots;
DROP TABLE IF EXISTS Hero_Skills_New, Hero_Skill_Slots;
DROP TABLE IF EXISTS Equipments, Heroes, Skills;
DROP TABLE IF EXISTS Factions, Equipment_Types, Skill_Types;

CREATE TABLE Factions (
    Faction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Faction_Name VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT
) ENGINE=InnoDB;

CREATE TABLE Equipment_Types (
    Type_ID INT PRIMARY KEY AUTO_INCREMENT,
    Type_Name VARCHAR(20) NOT NULL UNIQUE,
    Description TEXT
) ENGINE=InnoDB;

CREATE TABLE Skill_Types (
    Type_ID INT PRIMARY KEY AUTO_INCREMENT,
    Type_Name VARCHAR(20) NOT NULL UNIQUE,
    Description TEXT
) ENGINE=InnoDB;

CREATE TABLE Heroes (
    Hero_ID INT PRIMARY KEY AUTO_INCREMENT,
    Hero_Name VARCHAR(30) NOT NULL UNIQUE,
    Role VARCHAR(30) NOT NULL,
    Specialty VARCHAR(50) NOT NULL,
    Release_date DATE,
    Faction_ID INT,
    Difficulty VARCHAR(20),
    FOREIGN KEY (Faction_ID) REFERENCES Factions(Faction_ID) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE Equipments (
    Equipment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Equipment_Name VARCHAR(50) NOT NULL UNIQUE,
    Type_ID INT NOT NULL,
    Recipe TEXT,
    Passive TEXT,
    Price INT NOT NULL,
    FOREIGN KEY (Type_ID) REFERENCES Equipment_Types(Type_ID)
) ENGINE=InnoDB;

CREATE TABLE Skills (
    Skill_ID INT PRIMARY KEY AUTO_INCREMENT,
    Description TEXT NOT NULL,
    Type_ID INT,
    Cooldown DECIMAL(6,2),
    Mana_energy_cost INT,
    FOREIGN KEY (Type_ID) REFERENCES Skill_Types(Type_ID)
) ENGINE=InnoDB;

CREATE TABLE Hero_Statistics (
    Hero_ID INT PRIMARY KEY,
    HP INT NOT NULL,
    HP_Regen DECIMAL(6,2),
    Mana INT,
    Mana_Regen INT,
    Physical_Attack INT NOT NULL,
    Magic_Power INT NOT NULL,
    Physical_Defense INT NOT NULL,
    Magic_Defense INT NOT NULL,
    Attack_Speed DECIMAL(5,2),
    Movement_Speed INT NOT NULL,
    Basic_Attack_range INT NOT NULL,
    FOREIGN KEY (Hero_ID) REFERENCES Heroes(Hero_ID) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Equipment_Statistics (
    Equipment_ID INT PRIMARY KEY,
    PA INT,
    MA INT,
    Attack_Speed_Bonus INT,
    PP INT,
    MP INT,
    HP INT,
    HP_Regen INT,
    AD INT,
    MD INT,
    FOREIGN KEY (Equipment_ID) REFERENCES Equipments(Equipment_ID) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Hero_Build_Slots (
    Hero_ID INT,
    Slot_Number INT,
    PRIMARY KEY (Hero_ID, Slot_Number),
    FOREIGN KEY (Hero_ID) REFERENCES Heroes(Hero_ID) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Hero_Equipment_Usage (
    Hero_ID INT,
    Equipment_ID INT,
    Usage_Rate DECIMAL(5,2),
    PRIMARY KEY (Hero_ID, Equipment_ID),
    FOREIGN KEY (Hero_ID) REFERENCES Heroes(Hero_ID) ON DELETE CASCADE,
    FOREIGN KEY (Equipment_ID) REFERENCES Equipments(Equipment_ID) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Hero_Equipment_Build (
    Hero_Equipment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Hero_ID INT NOT NULL,
    Equipment_ID INT NOT NULL,
    Slot_Number INT NOT NULL,
    Is_Recommended BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (Hero_ID) REFERENCES Heroes(Hero_ID) ON DELETE CASCADE,
    FOREIGN KEY (Equipment_ID) REFERENCES Equipments(Equipment_ID) ON DELETE CASCADE,
    FOREIGN KEY (Hero_ID, Slot_Number) REFERENCES Hero_Build_Slots(Hero_ID, Slot_Number)
) ENGINE=InnoDB;

CREATE INDEX idx_heroes_name ON Heroes(Hero_Name);
CREATE INDEX idx_heroes_role ON Heroes(Role);
CREATE INDEX idx_heroes_faction ON Heroes(Faction_ID);
CREATE INDEX idx_heroes_difficulty ON Heroes(Difficulty);
CREATE INDEX idx_heroes_role_faction ON Heroes(Role, Faction_ID);

CREATE INDEX idx_equipments_name ON Equipments(Equipment_Name);
CREATE INDEX idx_equipments_type ON Equipments(Type_ID);
CREATE INDEX idx_equipments_price ON Equipments(Price);
CREATE INDEX idx_equip_type_price ON Equipments(Type_ID, Price);

CREATE INDEX idx_hero_stats_hp ON Hero_Statistics(HP);
CREATE INDEX idx_hero_stats_physical ON Hero_Statistics(Physical_Attack);
CREATE INDEX idx_hero_stats_magic ON Hero_Statistics(Magic_Power);
CREATE INDEX idx_hero_stats_movement ON Hero_Statistics(Movement_Speed);
CREATE INDEX idx_hero_stats_combat ON Hero_Statistics(Physical_Attack, Magic_Power, HP);

CREATE INDEX idx_equip_stats_pa ON Equipment_Statistics(PA);
CREATE INDEX idx_equip_stats_ma ON Equipment_Statistics(MA);
CREATE INDEX idx_equip_stats_hp ON Equipment_Statistics(HP);

CREATE INDEX idx_build_hero ON Hero_Equipment_Build(Hero_ID);
CREATE INDEX idx_build_equipment ON Hero_Equipment_Build(Equipment_ID);
CREATE INDEX idx_build_slot ON Hero_Equipment_Build(Slot_Number);
CREATE INDEX idx_build_recommended ON Hero_Equipment_Build(Is_Recommended);
CREATE INDEX idx_build_hero_recommended ON Hero_Equipment_Build(Hero_ID, Is_Recommended);

CREATE INDEX idx_usage_hero_equipment ON Hero_Equipment_Usage(Hero_ID, Equipment_ID);
CREATE INDEX idx_usage_rate ON Hero_Equipment_Usage(Usage_Rate);

CREATE INDEX idx_slots_hero ON Hero_Build_Slots(Hero_ID);

INSERT INTO Factions (Faction_ID, Faction_Name, Description) VALUES
(1, 'Moniyan', 'The Imperial Empire of Moniyan'),
(2, 'Abyssal', 'Demons from the Abyss'),
(3, 'Cadia Riverlands', 'Northern tribal factions'),
(4, 'Magic Academy', 'Magic users and scholars');

INSERT INTO Equipment_Types (Type_ID, Type_Name, Description) VALUES
(1, 'Physical', 'Increases physical attack and damage'),
(2, 'Magic', 'Increases magic power and effects'),
(3, 'Defense', 'Provides armor and health'),
(4, 'Movement', 'Improves mobility and speed'),
(5, 'Jungling', 'Enhances jungle monster damage');

INSERT INTO Skill_Types (Type_ID, Type_Name, Description) VALUES
(1, 'Damage', 'Deals damage to enemies'),
(2, 'CC', 'Crowd control effects'),
(3, 'Buff', 'Enhances allies'),
(4, 'Heal', 'Restores health'),
(5, 'Mobility', 'Movement abilities');

INSERT INTO Heroes (Hero_ID, Hero_Name, Role, Specialty, Faction_ID, Difficulty) VALUES
(101, 'Aamon', 'Assassin', 'Charge', 1, 'Moderate'),
(102, 'Alucard', 'Fighter', 'Chase', 1, 'Easy'),
(103, 'Miya', 'Marksman', 'Poke', 1, 'Easy'),
(104, 'Eudora', 'Mage', 'Burst', 4, 'Easy'),
(105, 'Tigreal', 'Tank', 'Initiate', 1, 'Moderate'),
(106, 'Lunox', 'Mage', 'Burst', 4, 'Hard'),
(107, 'Claude', 'Marksman', 'Poke', 1, 'Moderate'),
(108, 'Gatotkaca', 'Tank', 'Protect', 1, 'Easy');

INSERT INTO Equipments (Equipment_ID, Equipment_Name, Type_ID, Passive, Price) VALUES
(1, 'Bloodlust Axe', 1, 'Spell Vamp: 15%', 1950),
(2, 'Endless Battle', 1, 'True Damage', 2150),
(3, 'Blade of Despair', 1, 'Extra damage to impaired targets', 3010),
(4, 'Magic Shoes', 2, '10% Cooldown Reduction', 650),
(5, 'Windtalker', 4, 'Movement speed bonus', 1820),
(6, 'Immortality', 3, 'Revive after death', 2120),
(7, 'Athena''s Shield', 3, 'Magic defense boost', 2150),
(8, 'Divine Glaive', 2, 'Magic penetration', 1970),
(9, 'Sea Halberd', 1, 'Reduces enemy healing', 2180),
(10, 'Fleeting Time', 2, 'Cooldown reduction on kills', 1950);

INSERT INTO Hero_Statistics (Hero_ID, HP, HP_Regen, Mana, Physical_Attack, Magic_Power, Physical_Defense, Magic_Defense, Attack_Speed, Movement_Speed, Basic_Attack_range) VALUES
(101, 2520, 7.2, 480, 118, 0, 18, 12, 0.88, 255, 140),
(102, 2680, 8.5, 450, 125, 0, 25, 15, 0.95, 260, 150),
(103, 2250, 6.8, 420, 115, 0, 15, 10, 0.85, 240, 800),
(104, 2100, 5.5, 600, 0, 135, 12, 18, 0.75, 245, 550),
(105, 3200, 10.2, 400, 90, 0, 35, 25, 0.65, 250, 150),
(106, 1950, 4.8, 650, 0, 145, 10, 20, 0.70, 240, 600),
(107, 2300, 7.0, 450, 120, 0, 18, 14, 0.90, 245, 750),
(108, 3050, 9.5, 380, 95, 0, 32, 22, 0.68, 255, 160);

INSERT INTO Equipment_Statistics (Equipment_ID, PA, MA, HP, HP_Regen) VALUES
(1, 70, 0, 0, 0),
(2, 65, 0, 500, 0),
(3, 160, 0, 0, 0),
(4, 0, 0, 0, 0),
(5, 0, 0, 0, 0),
(6, 0, 0, 800, 0),
(7, 0, 0, 900, 0),
(8, 0, 65, 0, 0),
(9, 70, 0, 0, 0),
(10, 0, 65, 0, 0);

INSERT INTO Hero_Build_Slots (Hero_ID, Slot_Number) VALUES
(101, 1), (101, 2), (101, 3), (101, 4),
(102, 1), (102, 2), (102, 3), (102, 4),
(103, 1), (103, 2), (103, 3), (103, 4),
(104, 1), (104, 2), (104, 3), (104, 4),
(105, 1), (105, 2), (105, 3), (105, 4),
(106, 1), (106, 2), (106, 3), (106, 4),
(107, 1), (107, 2), (107, 3), (107, 4),
(108, 1), (108, 2), (108, 3), (108, 4);

INSERT INTO Hero_Equipment_Usage (Hero_ID, Equipment_ID, Usage_Rate) VALUES
(101, 1, 85.5), (101, 2, 78.2), (101, 6, 45.3),
(102, 1, 90.3), (102, 3, 82.7), (102, 6, 52.1),
(103, 5, 65.8), (103, 2, 72.1), (103, 9, 38.7),
(104, 4, 88.9), (104, 8, 76.4), (104, 10, 61.2),
(105, 6, 92.5), (105, 7, 85.7), (105, 1, 28.9),
(106, 4, 79.3), (106, 8, 83.6), (106, 10, 71.8),
(107, 5, 68.9), (107, 2, 74.5), (107, 9, 42.3),
(108, 6, 88.2), (108, 7, 81.9), (108, 1, 35.7);

INSERT INTO Hero_Equipment_Build (Hero_ID, Equipment_ID, Slot_Number, Is_Recommended) VALUES
(101, 1, 1, TRUE), (101, 2, 2, TRUE), (101, 6, 3, TRUE),
(102, 1, 1, TRUE), (102, 3, 2, TRUE), (102, 6, 3, TRUE),
(103, 5, 1, TRUE), (103, 2, 2, TRUE), (103, 9, 3, TRUE),
(104, 4, 1, TRUE), (104, 8, 2, TRUE), (104, 10, 3, TRUE),
(105, 6, 1, TRUE), (105, 7, 2, TRUE), (105, 1, 3, TRUE),
(106, 4, 1, TRUE), (106, 8, 2, TRUE), (106, 10, 3, TRUE),
(107, 5, 1, TRUE), (107, 2, 2, TRUE), (107, 9, 3, TRUE),
(108, 6, 1, TRUE), (108, 7, 2, TRUE), (108, 1, 3, TRUE);
