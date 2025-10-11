-- Hero Table
CREATE TABLE HERO (
    Hero_ID INT PRIMARY KEY,
    Hero_Name VARCHAR(30) NOT NULL,
    Role VARCHAR(30) NOT NULL,
    Specialty VARCHAR(50) NOT NULL,
    Release_date DATE,
    Faction VARCHAR(50),
    HP INT,
    HP_Regen DECIMAL(6,2),
    Mana INT,
    Mana_Regen INT,
    Physical_Attack INT,
    Magic_Power INT,
    Physical_Defense INT,
    Magic_Defense INT,
    Attack_Speed DECIMAL(5,2),
    Attack_Speed_Ratio DECIMAL(5,2),
    Critical_Damage DECIMAL(5,2),
    Movement_Speed INT,
    Basic_Attack_range INT,
    Difficulty VARCHAR(20)
);

-- Skill Table
CREATE TABLE SKILL (
    Skill_ID INT PRIMARY KEY,
    Description TEXT,
    Type TEXT,
    Base_Damage INT,
    Base_Shield INT,
    Base_Healing INT,
    CC_Duration INT,
    Base_MS INT,
    Base_PD INT,
    Base_MD INT,
    Base_PP INT,
    Base_MP INT,
    PA_Scaling INT,
    MA_Scaling INT,
    PD_Scaling INT,
    MD_Scaling INT,
    HP_Scaling INT,
    Max_HP_Damage INT,
    Spell_Vamp_Ratio INT,
    Target TEXT,
    Cooldown INT,
    Mana_energy_cost INT
);

-- Equipment Table
CREATE TABLE EQUIPMENT (
    Equipment_ID INT PRIMARY KEY,
    Equipment_Name VARCHAR(50) NOT NULL,
    Recipe TEXT,
    Type TEXT,
    Passive TEXT,
    PA INT,
    MA INT,
    `AS` INT,
    PP INT,
    MP INT,
    HP INT,
    HP_Regen INT,
    AD INT,
    MD INT,
    Price INT
);

-- Creep Table
CREATE TABLE CREEP (
    Creep_ID INT PRIMARY KEY,
    Creep_Name VARCHAR(20) NOT NULL,
    First_appearance INT,
    Loots TEXT,
    Rarity TEXT,
    Creeps_statistics INT
);

-- INTERSECTION TABLES
CREATE TABLE HERO_EQUIPMENT (
    Hero_ID INT,
    Equipment_ID INT,
    Slot_Number INT,
    Is_Recommended BOOLEAN DEFAULT FALSE,
    Usage_Rate DECIMAL(5,2),
    PRIMARY KEY (Hero_ID, Equipment_ID),
    FOREIGN KEY (Hero_ID) REFERENCES HERO(Hero_ID) ON DELETE CASCADE,
    FOREIGN KEY (Equipment_ID) REFERENCES EQUIPMENT(Equipment_ID) ON DELETE CASCADE
);

CREATE TABLE HERO_CREEP_INTERACTION (
    Hero_ID INT,
    Creep_ID INT,
    Gold_Reward INT NOT NULL,
    Experience_Reward INT NOT NULL,
    Buff_Type VARCHAR(50),
    Buff_Duration INT,
    Spawn_Time INT,
    PRIMARY KEY (Hero_ID, Creep_ID),
    FOREIGN KEY (Hero_ID) REFERENCES HERO(Hero_ID) ON DELETE CASCADE,
    FOREIGN KEY (Creep_ID) REFERENCES CREEP(Creep_ID) ON DELETE CASCADE
);

CREATE TABLE HERO_SKILL (
    Hero_ID INT,
    Skill_ID INT,
    Skill_Slot INT,
    PRIMARY KEY (Hero_ID, Skill_ID),
    FOREIGN KEY (Hero_ID) REFERENCES HERO(Hero_ID) ON DELETE CASCADE,
    FOREIGN KEY (Skill_ID) REFERENCES SKILL(Skill_ID) ON DELETE CASCADE
);
