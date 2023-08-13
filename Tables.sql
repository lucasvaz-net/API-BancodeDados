-- categories definition
CREATE TABLE [categories] (
    [id] INT IDENTITY(1,1) PRIMARY KEY,
    [name] NVARCHAR(MAX) NOT NULL
);

-- foods definition
CREATE TABLE [foods] (
    [id] INT IDENTITY(1,1) PRIMARY KEY,
    [name] NVARCHAR(MAX) NOT NULL,
    [categoryId] INT NOT NULL,
    FOREIGN KEY ([categoryId]) REFERENCES [categories]([id]) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- nutrients definition
CREATE TABLE [nutrients] (
    [id] INT IDENTITY(1,1) PRIMARY KEY,
    [foodId] INT NOT NULL UNIQUE,
    [moisture] REAL,
    [kcal] REAL,
    [kJ] REAL,
    [protein] REAL,
    [lipids] REAL,
    [cholesterol] REAL,
    [carbohydrates] REAL,
    [dietaryFiber] REAL,
    [ash] REAL,
    [calcium] REAL,
    [magnesium] REAL,
    [manganese] REAL,
    [phosphorus] REAL,
    [iron] REAL,
    [sodium] REAL,
    [potassium] REAL,
    [copper] REAL,
    [zinc] REAL,
    [retinol] REAL,
    [re] REAL,
    [rae] REAL,
    [thiamin] REAL,
    [riboflavin] REAL,
    [pyridoxine] REAL,
    [niacin] REAL,
    [vitaminC] REAL,
    FOREIGN KEY ([foodId]) REFERENCES [foods]([id]) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- units definition
CREATE TABLE [units] (
    [id] INT IDENTITY(1,1) PRIMARY KEY,
    [fieldName] NVARCHAR(MAX) NOT NULL,
    [unit] NVARCHAR(MAX) NOT NULL,
    [labelPt] NVARCHAR(MAX) NOT NULL,
    [infoodsTagname] NVARCHAR(MAX),
    [systematicName] NVARCHAR(MAX),
    [commonName] NVARCHAR(MAX)
);

-- User definition
CREATE TABLE [users] (
    [id] INT IDENTITY(1,1) PRIMARY KEY,
    [username] NVARCHAR(255) NOT NULL UNIQUE,
    [email] NVARCHAR(255) NOT NULL UNIQUE,
    [hashedPassword] NVARCHAR(255) NOT NULL,
    [dateOfBirth] DATE,
    [weight] REAL,
    [goalWeight] REAL,
    [activityLevel] NVARCHAR(255),
    [dateJoined] DATE DEFAULT GETDATE(),
    [lastLogin] DATETIME
);

-- FoodDiary definition
CREATE TABLE [foodDiary] (
    [id] INT IDENTITY(1,1) PRIMARY KEY,
    [userId] INT NOT NULL,
    [foodId] INT NOT NULL,
    [date] DATE DEFAULT GETDATE(),
    [servingSize] REAL NOT NULL,
    FOREIGN KEY ([userId]) REFERENCES [users]([id]) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ([foodId]) REFERENCES [foods]([id]) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- UserGoals definition
CREATE TABLE [userGoals] (
    [id] INT IDENTITY(1,1) PRIMARY KEY,
    [userId] INT NOT NULL,
    [dailyCalories] REAL,
    [proteinGoal] REAL,
    [carbsGoal] REAL,
    [fatGoal] REAL,
    FOREIGN KEY ([userId]) REFERENCES [users]([id]) ON DELETE CASCADE ON UPDATE CASCADE
);

-- PremiumSubscription (optional) definition
CREATE TABLE [premiumSubscription] (
    [id] INT IDENTITY(1,1) PRIMARY KEY,
    [userId] INT NOT NULL UNIQUE,
    [startDate] DATE,
    [endDate] DATE,
    [paymentDetails] NVARCHAR(255),
    FOREIGN KEY ([userId]) REFERENCES [users]([id]) ON DELETE CASCADE ON UPDATE CASCADE
);

-- LOG for users
CREATE TABLE [LOG_users] (
    [id] INT,
    [username] NVARCHAR(255),
    [email] NVARCHAR(255),
    [hashedPassword] NVARCHAR(255),
    [dateOfBirth] DATE,
    [weight] REAL,
    [goalWeight] REAL,
    [activityLevel] NVARCHAR(255),
    [dateJoined] DATE,
    [lastLogin] DATETIME,
    [userId] INT,
    [operation] CHAR(1),
    [actionDate] DATETIME DEFAULT GETDATE(),
    FOREIGN KEY ([userId]) REFERENCES [users]([id]),
    PRIMARY KEY ([id], [actionDate])
);

-- LOG for foodDiary
CREATE TABLE [LOG_foodDiary] (
    [id] INT,
    [userId] INT,
    [foodId] INT,
    [date] DATE,
    [servingSize] REAL,
    [logUserId] INT,
    [operation] CHAR(1),
    [actionDate] DATETIME DEFAULT GETDATE(),
    FOREIGN KEY ([logUserId]) REFERENCES [users]([id]),
    PRIMARY KEY ([id], [actionDate])
);

-- LOG for userGoals
CREATE TABLE [LOG_userGoals] (
    [id] INT,
    [userId] INT,
    [dailyCalories] REAL,
    [proteinGoal] REAL,
    [carbsGoal] REAL,
    [fatGoal] REAL,
    [logUserId] INT,
    [operation] CHAR(1),
    [actionDate] DATETIME DEFAULT GETDATE(),
    FOREIGN KEY ([logUserId]) REFERENCES [users]([id]),
    PRIMARY KEY ([id], [actionDate])
);

-- LOG for premiumSubscription
CREATE TABLE [LOG_premiumSubscription] (
    [id] INT,
    [userId] INT,
    [startDate] DATE,
    [endDate] DATE,
    [paymentDetails] NVARCHAR(255),
    [logUserId] INT,
    [operation] CHAR(1),
    [actionDate] DATETIME DEFAULT GETDATE(),
    FOREIGN KEY ([logUserId]) REFERENCES [users]([id]),
    PRIMARY KEY ([id], [actionDate])
);

-- LOG for nutrients (completo)
CREATE TABLE [LOG_nutrients] (
    [id] INT,
    [foodId] INT,
    [moisture] REAL,
    [kcal] REAL,
    [kJ] REAL,
    [protein] REAL,
    [lipids] REAL,
    [cholesterol] REAL,
    [carbohydrates] REAL,
    [dietaryFiber] REAL,
    [ash] REAL,
    [calcium] REAL,
    [magnesium] REAL,
    [manganese] REAL,
    [phosphorus] REAL,
    [iron] REAL,
    [sodium] REAL,
    [potassium] REAL,
    [copper] REAL,
    [zinc] REAL,
    [retinol] REAL,
    [re] REAL,
    [rae] REAL,
    [thiamin] REAL,
    [riboflavin] REAL,
    [pyridoxine] REAL,
    [niacin] REAL,
    [vitaminC] REAL,
    [logUserId] INT,
    [operation] CHAR(1),
    [actionDate] DATETIME DEFAULT GETDATE(),
    FOREIGN KEY ([logUserId]) REFERENCES [users]([id]),
    PRIMARY KEY ([id], [actionDate])
);
-- LOG for categories
CREATE TABLE [LOG_categories] (
    [id] INT,
    [name] NVARCHAR(MAX),
    [userAction] NVARCHAR(255),
    [operation] CHAR(1),
    [actionDate] DATETIME DEFAULT GETDATE(),
    PRIMARY KEY ([id], [actionDate])
);

-- LOG for foods
CREATE TABLE [LOG_foods] (
    [id] INT,
    [name] NVARCHAR(MAX),
    [categoryId] INT,
    [userAction] NVARCHAR(255),
    [operation] CHAR(1),
    [actionDate] DATETIME DEFAULT GETDATE(),
    PRIMARY KEY ([id], [actionDate])
);

-- LOG for nutrients
CREATE TABLE [LOG_nutrients] (
    [id] INT,
    [foodId] INT,
    [moisture] REAL,
    -- ... (todos os outros campos da tabela nutrients)
    [vitaminC] REAL,
    [userAction] NVARCHAR(255),
    [operation] CHAR(1),
    [actionDate] DATETIME DEFAULT GETDATE(),
    PRIMARY KEY ([id], [actionDate])
);

-- LOG for units
CREATE TABLE [LOG_units] (
    [id] INT,
    [fieldName] NVARCHAR(MAX),
    [unit] NVARCHAR(MAX),
    [labelPt] NVARCHAR(MAX),
    [infoodsTagname] NVARCHAR(MAX),
    [systematicName] NVARCHAR(MAX),
    [commonName] NVARCHAR(MAX),
    [userAction] NVARCHAR(255),
    [operation] CHAR(1),
    [actionDate] DATETIME DEFAULT GETDATE(),
    PRIMARY KEY ([id], [actionDate])
);
