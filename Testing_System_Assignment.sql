-- create database
DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

-- create table 1: Department
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	DepartmentID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName 			NVARCHAR(30) NOT NULL UNIQUE KEY
);

-- create table 2: Posittion
DROP TABLE IF EXISTS Position;
CREATE TABLE `Position` (
	PositionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName			ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
);

-- create table 3: Account
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email					VARCHAR(50) NOT NULL UNIQUE KEY,
    Username				VARCHAR(50) NOT NULL UNIQUE KEY,
    FullName				NVARCHAR(50) NOT NULL,
    DepartmentID 			TINYINT UNSIGNED NOT NULL,
    PositionID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

-- create table 4: Group
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName				NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW()
);

-- create table 5: GroupAccount
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	GroupID					TINYINT UNSIGNED NOT NULL,
    AccountID				TINYINT UNSIGNED NOT NULL,
    JoinDate				DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID,AccountID)
);

-- create table 6: TypeQuestion
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
    TypeID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName 		ENUM('Esay','Multiple-Choice') NOT NULL UNIQUE KEY
);

-- create table 7: CategoryQuestion
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
    CategoryID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName			NVARCHAR(50) NOT NULL UNIQUE KEY
);

-- create table 8: Question
DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
    QuestionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    TypeID					TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL UNIQUE KEY,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) 	REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) 		REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY(CreatorID) 		REFERENCES `Account`(AccountId)
);

-- create table 9: Answer
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
    Answers					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    QuestionID				TINYINT UNSIGNED NOT NULL,
    isCorrect				BIT DEFAULT 1,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

-- create table 10: Exam
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
    ExamID					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`					CHAR(10) NOT NULL,
    Title					NVARCHAR(50) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    Duration				TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId)
);

-- create table 11: ExamQuestion
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
    ExamID				TINYINT UNSIGNED NOT NULL,
	QuestionID			TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID),
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID),
    PRIMARY KEY (ExamID,QuestionID)
);
/*===========================================================INSERT DATABASE============================================================*/
/*======================================================================================================================================*/
-- Add data Department
INSERT INTO Department(DepartmentName) 
		VALUES 			(N'Marketing'	),
						(N'Sale'		),
						(N'B???o v???'		),
						(N'Nh??n s???'		),
						(N'K??? thu???t'	),
						(N'T??i ch??nh'	),
						(N'Ph?? gi??m ?????c'),
						(N'Gi??m ?????c'	),
						(N'Th?? k??'		),
						(N'B??n h??ng'	);
                        
-- Add data position
INSERT INTO Position	(PositionName	) 
VALUES 					('Dev'			),
						('Test'			),
						('Scrum Master'	),
						('PM'			); 
                        
-- Add data Account
INSERT INTO `Account`(Email								, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUES 				('nhungnguyen50200@gmail.com'		, 'nhungnguyen'		,'Nguy???n Th??? Nhung'		,   '1'			,   '1'		,'2021-03-01'),
					('hoanganh123@gmail.com'			, 'hoanganh'		,'D????ng Ho??ng Anh'		,   '2'			,   '2'		,'2021-01-02'),
                    ('huuchien123@gmail.com'			, 'huuchien'		,'Nguy???n H???u Chi???n'		,   '3'			,   '3'		,'2021-02-03'),
                    ('congduc456@gmail.com'				, 'congduc'			,'D????ng C??ng ?????c'		,   '4'			,   '4'		,'2021-03-04'),
                    ('thuylinh987@gmail.com'			, 'thuylinh'		,'Ng?? Tr???n Thu??? Linh'	,   '5'			,   '4'		,'2021-03-05'),
                    ('vancong23@gmail.com'				, 'congdeptrai'		,'Nguy???n V??n C??ng'		,   '6'			,   '3'		,'2021-04-06'),
                    ('thuhien756@gmail.com'				, 'hienbaby'		,'Ng?? Th??? Thu Hi???n'		,   '7'			,   '2'		, NULL		),
                    ('sontungmtp@gmail.com'				, 'tungnui'			,'Nguy???n Thanh T??ng'	,   '8'			,   '1'		,'2021-04-07'),
                    ('kilinguyen@gmail.com'				, 'nguyenly'		,'Nguy???n Th??? Ly'		,   '9'			,   '2'		,'2021-04-08'),
                    ('ngoclan452@gmail.com'				, 'ngoclan'			,'Ninh Lan D????ng Ng???c'	,   '10'		,   '1'		,'2021-04-09');
                    
-- Add data Group
INSERT INTO `Group`	(  GroupName			, CreatorID		, CreateDate)
VALUES 				(N'Testing System'		,   5			,'2020-03-05'),
					(N'Development'			,   1			,'2021-03-07'),
                    (N'VTI Sale 01'			,   2			,'2020-03-09'),
                    (N'VTI Sale 02'			,   3			,'2021-03-10'),
                    (N'VTI Sale 03'			,   4			,'2021-03-28'),
                    (N'VTI SA'				,   6			,'2021-04-06'),
                    (N'VTI Marketing 01'	,   7			,'2020-04-07'),
                    (N'Management'			,   8			,'2021-04-08'),
                    (N'Accounting'			,   9			,'2020-04-09'),
                    (N'Customer Offcicer'	,   10			,'2020-04-10');
				
-- Add data GroupAccount
INSERT INTO `GroupAccount`	(  GroupID	, AccountID	, JoinDate	 )
VALUES 						(	1		,    1		,'2020-03-05'),
							(	1		,    2		,'2021-03-07'),
							(	3		,    3		,'2020-03-09'),
							(	3		,    4		,'2020-03-10'),
							(	5		,    5		,'2021-03-28'),
							(	1		,    3		,'2021-04-06'),
							(	1		,    7		,'2021-04-07'),
							(	8		,    3		,'2020-04-08'),
							(	1		,    9		,'2020-04-09'),
							(	10		,    10		,'2020-04-10');
                            
-- Add data TypeQuestion
INSERT INTO TypeQuestion	(TypeName			) 
VALUES 						('Essay'			), 
							('Multiple-Choice'	); 

-- Add data CategoryQuestion
INSERT INTO CategoryQuestion		(CategoryName	)
VALUES 								('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('Postman'		),
									('Ruby'			),
									('Python'		),
									('C++'			),
									('C Sharp'		),
									('PHP'			);

-- Add data Question
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 					(N'C??u h???i v??? Java'	,	1		,   '1'			,   '2'		,'2021-04-05'),
						(N'C??u H???i v??? PHP'	,	10		,   '2'			,   '2'		,'2021-04-06'),
						(N'H???i v??? C#'		,	9		,   '2'			,   '3'		,'2020-08-06'),
						(N'H???i v??? Ruby'		,	6		,   '1'			,   '4'		,'2020-03-08'),
						(N'H???i v??? Postman'	,	5		,   '1'			,   '5'		,'2021-03-09'),
						(N'H???i v??? ADO.NET'	,	3		,   '2'			,   '6'		,'2020-02-09'),
						(N'H???i v??? ASP.NET'	,	2		,   '1'			,   '7'		,'2021-03-08'),
						(N'H???i v??? C++'		,	8		,   '1'			,   '8'		,'2020-05-07'),
						(N'H???i v??? SQL'		,	4		,   '2'			,   '9'		,'2021-04-07'),
						(N'H???i v??? Python'	,	7		,   '1'			,   '10'	,'2021-04-09');
                        
-- Add data Answers
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Tr??? l???i 01'	,   1			,	0		),
					(N'Tr??? l???i 02'	,   1			,	1		),
                    (N'Tr??? l???i 03'	,   1			,	0		),
                    (N'Tr??? l???i 04'	,   1			,	1		),
                    (N'Tr??? l???i 05'	,   2			,	1		),
                    (N'Tr??? l???i 06'	,   3			,	1		),
                    (N'Tr??? l???i 07'	,   4			,	0		),
                    (N'Tr??? l???i 08'	,   8			,	0		),
                    (N'Tr??? l???i 09'	,   9			,	1		),
                    (N'Tr??? l???i 10'	,   10			,	1		);
                    
-- Add data Exam
INSERT INTO Exam	(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('DNUQ001'		, N'????? thi C#'			,	1			,	60		,   '5'			,'2020-04-05'),
					('DNUQ002'		, N'????? thi PHP'			,	10			,	60		,   '2'			,'2020-01-05'),
                    ('VTIQ003'		, N'????? thi C++'			,	9			,	120		,   '2'			,'2020-01-07'),
                    ('VTIQ004'		, N'????? thi Java'		,	6			,	60		,   '3'			,'2021-04-08'),
                    ('DNUQ005'		, N'????? thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
                    ('DNUQ006'		, N'????? thi Postman'		,	3			,	60		,   '6'			,'2021-03-05'),
                    ('DNUQ007'		, N'????? thi SQL'			,	2			,	60		,   '7'			,'2021-03-05'),
                    ('VTIQ008'		, N'????? thi Python'		,	8			,	60		,   '8'			,'2021-02-07'),
                    ('VTIQ009'		, N'????? thi ADO.NET'		,	4			,	90		,   '9'			,'2020-03-07'),
                    ('VTIQ010'		, N'????? thi ASP.NET'		,	7			,	90		,   '10'		,'2020-02-08');
                    
-- Add data ExamQuestion
INSERT INTO ExamQuestion(ExamID	, QuestionID	) 
VALUES 					(	1	,		5		),
						(	2	,		10		), 
						(	3	,		4		), 
						(	4	,		3		), 
						(	5	,		7		), 
						(	6	,		10		), 
						(	7	,		2		), 
						(	8	,		10		), 
						(	9	,		9		), 
						(	10	,		8		); 