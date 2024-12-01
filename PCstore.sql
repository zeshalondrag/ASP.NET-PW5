CREATE DATABASE PCstore;

USE PCstore;

CREATE TABLE Users (
    ID_User INT PRIMARY KEY IDENTITY(1,1),
	UserSurname VARCHAR(50) NOT NULL,
	UserName VARCHAR(50) NOT NULL,
	UserMiddleName VARCHAR(50) NOT NULL,
	Phone VARCHAR(12) NOT NULL UNIQUE,
	Logins VARCHAR(100) NOT NULL UNIQUE,
	Passwords VARCHAR(255) NOT NULL
);
GO

INSERT INTO Users (UserSurname, UserName, UserMiddleName, Phone, Logins, Passwords)
VALUES
	('Сизова','Варвара','Робертовна','+79585954810','sizova@gmail.com','sizova123'),
	('Симонов','Михаил','Дмитриевич','+79370883342','simonov@gmail.com','simonov123'),
	('Новиков','Сергей','Михайлович','+79955248160','novikov@gmail.com','novikov123')
	
SELECT * FROM Users;

CREATE TABLE Categorys (
    ID_Category INT PRIMARY KEY IDENTITY(1,1),
    Names VARCHAR(100) NOT NULL
);
GO

INSERT INTO Categorys(Names)
VALUES
	('Игровые компьютеры'),
	('Рабочие станции'),
	('Серверы')

CREATE TABLE Catalogs (
    ID_Catalog INT PRIMARY KEY IDENTITY(1,1),
    Names VARCHAR(100) NOT NULL,
	Descriptions TEXT,
    Price DECIMAL(10, 2) NOT NULL,
	Quantity INT NOT NULL,
	Category_ID INT FOREIGN KEY REFERENCES Categorys(ID_Category),
    Image_url TEXT
);
GO

INSERT INTO Catalogs(Names, Descriptions, Price, Quantity, Category_ID, Image_url)
VALUES
	('HYPERPC FURY', 'Геймерская система на базе Intel® Core™ i5-12400F и видеокарты MSI GeForce RTX 4060 VENTUS 2X [8GB, 3072 CUDA].', 118100.0, 10, 1, 'https://hyperpc.ru/cache/hp_position_hyperpc_fury_4355/hyperpc-fury-black-v3-upd-450x450.jpg'),
	('HYPERPC WARRIOR', 'Производительный компьютер для игр и работы на базе Intel® Core™ i5-13400F и видеокарты MSI GeForce RTX 4060 Ti [8GB, 4352 CUDA].', 158700.0, 4, 1, 'https://hyperpc.ru/cache/hp_position_hyperpc_warrior_4626/hyperpc-warrior-white-alt-450x450.jpg'),
	('HYPERPC CHAMPION', 'Мощная система на базе Intel® Core™ i5-14400F и видеокарты Palit GeForce RTX 4070 JetStream [12GB, 5888 CUDA].', 204800.0, 1, 1, 'https://hyperpc.ru/cache/hp_position_hyperpc_champion_4356/hyperpc-champion-d41-screen-450x450.jpg'),
	('HYPERPC G5 PRO', 'Мощная рабочая станция для работы с видеокартой MSI GeForce RTX 4090 [24GB, 16384 CUDA] и процессором Intel® Core™ i9-14900K [до 6.0GHz, 24 ядер].', 578800.0, 2, 2, 'https://hyperpc.ru/cache/hp_position_hyperpc_g5_pro_4564/hyperpc-g5-pro-alt-450x450.jpg'),
	('HYPERPC G6 PRO', 'Мощная рабочая станция для задач любой сложности. В основе: NVIDIA RTX A6000 [48GB, 10752 CUDA] и процессор Intel® Core™ i9-14900K [до 6.0GHz, 24 ядер].', 1074400.0, 8, 2, 'https://hyperpc.ru/cache/hp_position_hyperpc_g6_pro_4565/hyperpc-g6-black-alt-upd-450x450.jpg'),
	('HYPERPC G7 PRO', 'Высокопроизводительная станция для создания и обработки 3D-графики с видеокартой NVIDIA RTX 6000 Ada Generation [48GB, 18176 CUDA] и процессором AMD Ryzen Threadripper PRO 7956WX [до 5.3GHz, 24 ядер].', 2297900.0, 6, 2, 'https://hyperpc.ru/cache/hp_position_hyperpc_g7_pro_4566/hyperpc-g7-pro-upd-450x450.jpg'),
	('FORCE CORE', 'Серверы для основных IT-задач, таких как управление веб-сервисами, базами данных и файловыми хранилищами. FORCE CORE обеспечивает стабильную и надежную работу для малых и средних бизнесов с возможностью масштабирования по мере роста. До 2x процессоров, до 256 ядер (Intel Xeon 2nd-4th Gen, AMD EPYC) До 4TB памяти DDR4/DDR5 ECC Контроллеры до 16 жестких дисков (SAS, NVMe)', 0.0, 1, 3, 'https://hyperpc.ru/images/product/servers/main/force/hyperpc-force-1-unit-blk.jpg?1'),
	('FORCE POWER', 'Мощные серверы, предназначенные для более сложных задач, таких как виртуализация, аналитика и работа с большими массивами данных. FORCE POWER предлагает идеальное сочетание производительности и гибкости для построения надежной инфраструктуры.  До 4x процессоров, до 256 ядер (Intel Xeon 2nd-5th Gen, AMD EPYC) До 8TB памяти DDR4/DDR5 ECC Контроллеры до 24 жестких дисков (SAS, NVMe)', 0.0, 1, 3, 'https://hyperpc.ru/images/product/servers/main/force/hyperpc-force-2-unit-blk.jpg?1'),
	('FORCE ULTRA', 'Сервера премиум-класса для критически важных бизнес-систем. FORCE ULTRA предлагает максимальную производительность, надежность системы и масштабируемость, что делает их идеальным выбором для организаций с высокими требованиями к надежности и безопасности. До 8x процессоров, до 256 ядер (Intel Xeon 2nd-5th Gen, AMD EPYC) До 16TB памяти DDR4/DDR5 ECC Контроллеры до 48 жестких дисков (SAS, NVMe)', 0.0, 2, 3, 'https://hyperpc.ru/images/product/servers/main/force/hyperpc-force-4-unit-blk.jpg?1')

SELECT * FROM Catalogs;
GO

CREATE TABLE Statuss (
    ID_Status INT PRIMARY KEY IDENTITY(1,1),
    StatusName VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Orders (
    ID_Order INT PRIMARY KEY IDENTITY(1,1),
    Users_ID INT FOREIGN KEY REFERENCES Users(ID_User),
    Dates VARCHAR(10),
    TotalSum DECIMAL(10, 2),
	Status_ID INT FOREIGN KEY REFERENCES Statuss(ID_Status)
);
GO

CREATE TABLE PosOrders (
    ID_PosOrder INT PRIMARY KEY IDENTITY(1,1),
	Orders_ID INT FOREIGN KEY REFERENCES Orders(ID_Order),
	Catalogs_ID INT FOREIGN KEY REFERENCES Catalogs(ID_Catalog),
    Counts INT,
    Price DECIMAL(10, 2)
);
GO

CREATE TABLE Cart (
	ID_Cart INT PRIMARY KEY IDENTITY(1,1),
	Catalog_ID INT FOREIGN KEY REFERENCES Catalogs(ID_Catalog),
	Users_ID INT FOREIGN KEY REFERENCES Users(ID_User),
	Quantity INT NOT NULL,
	Price DECIMAL(10,2) NOT NULL
);
GO
