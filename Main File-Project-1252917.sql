/*************************************Job Application System Project****************************************/
USE master;
GO
If DB_ID('JobApplicationDB') IS NOT NULL
	DROP DATABASE JobApplicationDB;
GO
--USE JobApplicationDB;
CREATE DATABASE JobApplicationDB
ON(
		NAME		= JobApplicationDB_data,
		FILENAME	='C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\JobApplicationDB_data.mdf',
		SIZE		= 10MB,
		MAXSIZE		= 50MB,
		FILEGROWTH	= 5MB
)
LOG ON (
		NAME		= JobApplicationDB_log,
		FILENAME	='C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\JobApplicationDB_log.ldf',
		SIZE		= 5MB,
		MAXSIZE		= 25MB,
		FILEGROWTH	= 2MB
);
GO
USE JobApplicationDB;
GO

----1.Table Certificate 

CREATE TABLE Certificate (
						CertificateID INT IDENTITY PRIMARY KEY NOT NULL,
						CertificateName VARCHAR(30)
						);

Go
--2.Table  Institute

CREATE TABLE Institute (
						InstituteID INT IDENTITY PRIMARY KEY NOT NULL,
						InstituteName VARCHAR(30),
						Address VARCHAR(50),
						City VARCHAR(20)
						);

GO
---3.TABLE Companies

CREATE TABLE Companies(
						CompanyID INT IDENTITY PRIMARY KEY NOT NULL,
						CompanyName VARCHAR(30),
						Address VARCHAR(50),
						Phone VARCHAR(15));

GO

---4. TABLE Post

CREATE TABLE Post(
						PostID INT IDENTITY PRIMARY KEY NOT NULL,
						PostTitle VARCHAR(30)
						);

GO
--5 Table Reference

CREATE TABLE Reference (
						ReferenceID			INT IDENTITY PRIMARY KEY ,
						Name				VARCHAR(100),
						Position			VARCHAR(20),
						Company				VARCHAR(20),
						Phone				VARCHAR(15)
						);

---6.Table Applicants

CREATE TABLE Applicants(
						ApplicantID INT IDENTITY PRIMARY KEY NOT NULL,
						FirstName VARCHAR(20),
						LastName VARCHAR(20),
						Address VARCHAR(50),
						Contact VARCHAR(15),
						CurrentJobStatus VARCHAR(20),
						ApplyDate  DATE,
						PostID		INT		REFERENCES Post (PostID),
						ExpectedSalary  INT,
						ReferenceID		INT  REFERENCES Reference (ReferenceID)
						);

--DROP TABLE Applicants;

Go

---7.TABLE Education

CREATE TABLE Education(
						ApplicantID INT REFERENCES Applicants(ApplicantID),
						CertificateID INT REFERENCES Certificate(CertificateID),
						InstituteID INT REFERENCES Institute(InstituteID),
						Year		INT,
						PRIMARY KEY(ApplicantID, CertificateID, InstituteID)
						);
--DROP TABLE  Education;
GO

---8.TABLE EmploymentHistory;

CREATE TABLE EmploymentHistory(
						ApplicantID INT REFERENCES Applicants(ApplicantID),
						CompanyID INT REFERENCES Companies(CompanyID),
						PostID INT REFERENCES Post(PostID),
						JobStarttDate DATE,
						JobEndDate	VARCHAR(10),
						PRIMARY KEY (ApplicantID, CompanyID, PostID)); 


GO

INSERT INTO Certificate values ('SSC'), ('HSC'), ('Honours');

GO

INSERT INTO Institute VALUES ('Khilkhet Model High School', 'Khilkhet', 'Dhaka'), ('Kurmitula Model High School', 'Airport', 'Dhaka'), 
							 ('Tongi Govt. Model High School', 'Tongi', 'Gazipur'), ('Govt boys High School', 'Adamjee', 'Narayanganj'), 
							 ('Uttara Model College', 'Uttara', 'Dhaka'), ('Dhaka College', 'New Market', 'Dhaka'), 
							 ('Govt Bangla College', 'Mirpur', 'Dhaka'), ('Govt Tularam College', 'Chasara', 'Narayanganj'), 
							 ('Tongi Govt. College', 'Tongi', 'Gazipur'), ('Dhaka University', 'Shahbag', 'Dhaka'), 
							 ('Jagannath University', 'Sadarghat', 'Dhaka');

GO

INSERT INTO Companies VALUES ('Pran Group ', 'Shahzadpur,Dhaka', '9874567'),
							('Akij Group', 'Sector-4, Uttara,Dhaka', '9789477'),
							('Sajeb Group', 'Binnati,Dhaka', '94789147'),
							 ('Aman Group', 'Sector-6, Uttara,Dhaka', '87943747'),
							 ('Pocha-Alam Group', 'Khilkhet,Dhaka', '947648717'),
							 ('Babylon Group', 'mirpur,Dhaka', '949788147'),
							 ('Matrix Group', 'Banani,Dhaka', '941567447'),
							 ('Aj Group', 'Nilkhet,Dhaka', '9471478947'),
							 ('Sarah Group', 'Azimpur,Dhaka', '94718497'),
							('Santa-Mariam Group', 'Kurmitula,Dhaka', '947874877'),
							 ('Milon Group', 'Azampur,Dhaka', '941748747'),
							('Brtx Group', 'Agargoan,Dhaka', '94789478947');

GO

INSERT INTO Post VALUES  ('Auditor'), ('Marketing Officer'),('Senior officer'), ('Officer'), ('Junior Officer'),
						('Senior Sales Executive'), ('Junior Sales Executive') ;
GO

INSERT INTO Reference VALUES	('Md. Kamrul Hasan', 'MD', 'Aman Group', '459876485'), 
								('Md. Nazmul Hasan', 'Manager', 'Milon Group', '455896789'),
								('Md. Badrul Ahmed', 'Assist. Teacher', 'Dhaka College', '97845769'), 
								('Md. Rehan Uddin', 'Manager', 'Sajeb Group', '874987648'),
								('Md. Fakhrul Hasan', 'Marketing Officer', 'Pran Group', '86749874'), 
								('Md. Habibur Rahman', 'Professor', 'Govt Bangla College', '97468751');

INSERT INTO Reference (Name) VALUES ('Without Reference');

GO

INSERT INTO Applicants 
				VALUES ('Md.', 'Alauddin', 'Saignboard, Narayanganj', '01725-874598', 'Job Holder', '2019-06-02', 1 , 20000, 2),
					   ('Md.', 'Mohibullah', 'Mirpur, Dhaka', '01758-874598', 'Unemployed', '2019-06-02', 3, 20000, 4),
					   ('Md.', 'Imran Hossen', 'Demra, Dhaka', '01725-875988', 'New Appicant', '2019-06-03', 2, 25000, 3),
					   ('Md.', 'Zulhas Uddin', 'Ghatarchar, Mohammadpur', '01725-846978', 'Job Holder', '2019-06-03', 1, 15000, 1),
					   ('Md.', 'Robiul Hossain', 'Farmgate, Dhaka', '01725-876488', 'New Appicant', '2019-06-04', 2, 18000, 7),
					   ('Md.', 'Kawser Ahmed', 'Badda, Dhaka', '01725-976598', 'Job Holder', '2019-06-04', 1, 16000, 5),
					   ('Mrs.', 'Sharmin Akter', 'Adomzi, Narayanganj', '01725-897488', 'Unemployed', '2019-06-06', 2, 22000 , 6),
					   ('Md.', 'Ala Zafar', 'Sadarghaat, Dhaka', '01725-858176', 'Job Holder', '2019-06-06', 3, 25000 , 7),
					   ('Mrs.', 'Rokeya Akter', 'Saignboard, Narayanganj', '01725-887952','New Appicant', '2019-06-07', 1,25000, 3),
					   ('Mrs.', 'Benojir Khanam', 'Chasara, Narayanganj', '01758-223498', 'Unemployed', '2019-06-10', 2,22000, 1),
					   ('Md.', 'Mushfiqur', 'Uttara, Dhaka', '01758-810408', 'Job Holder', '2019-06-10', 1, 22000, 4),
					   ('Md.', 'Asif Mahmud', 'niketon, Dhaka', '01758-764138','New Appicant', '2019-06-15', 2, 20000, 7),
					   ('Md.', 'Niloy Ahmed', 'Pikepara, Dhaka', '01758-897488', 'Job Holder', '2019-06-15', 2, 22000, 6),
					   ('Md.', 'Nijhum Ahmed', 'Mirpur10, Dhaka', '01758-843958', 'Unemployed', '2019-06-16',3, 20000, 2),
					   ('Md.', 'Onik Asif', 'Mirpur2, Dhaka', '01758-874598', 'Job Holder', '2019-06-16', 1, 19000, 1 ),
					   ('Md.', 'Saiful Islam', 'Mirpur14, Dhaka', '01758-800248', 'Unemployed', '2019-06-16', 2, 16000, 7),
					   ('Md.', 'Sakil Ahmed', 'Shewrapara, Dhaka', '01758-876768', 'New Appicant', '2019-06-17', 1, 27000, 7),
					   ('Md.', 'Ripon Mahmud', 'Vairab, kishoreganj', '01758-889748', 'Job Holder', '2019-06-17', 3, 16000, 2),
					   ('Md.', 'Shihab Sarkar', 'sararchar, kishoreganj', '01758-874598', 'Job Holder', '2019-06-18', 3, 15000, 3),
					   ('Md.', 'Ontu Sarkar', 'Malibag, Dhaka', '01758-446898', 'Job Holder', '2019-06-18', 2, 22000, 4),
					   ('Md.', 'Mamun Mondol', 'kotiadi, Rangpur', '01758-874878', 'Unemployed', '2019-06-18', 2, 30000,  4),
					   ('Md.', 'Shafic Ahmed', 'Demra, Dhaka', '01758-871398', 'New Appicant', '2019-06-18', 1, 22000, 7),
					   ('Md.', 'Mazhar Hossain', 'Paltan, Dhaka', '01758-814288', 'Unemployed', '2019-06-19', 2, 15000, 6),
					   ('Md.', 'Himel Ahmed', 'Shahbag, Dhaka', '01758-874598', 'Job Holder', '2019-06-19', 3, 20000, 5);
								

GO

INSERT INTO Education VALUES    (1, 1, 4, 2008), (1, 2, 8, 2010), (1, 3, 8, 2015),
								(2, 1, 1, 2007), (2, 2, 7, 2009), (2, 3, 7, 2013),
								(3, 1, 4, 2006), (3, 2, 5, 2008), (3, 3, 10, 2012),
								(4, 1, 2, 2011), (4, 2, 9, 2013), (4, 3, 11, 2017),
								(5, 1, 3, 2010), (5, 2, 7, 2012), (5, 3, 10, 2017),
								(6, 1, 1, 2009), (6, 2, 6, 2012), (6, 3, 8, 2016),
								(7, 1, 1, 2006), (7, 2, 6, 2008), (7, 3, 6, 2014),
								(8, 1, 2, 2011), (8, 2, 8, 2013), (8, 3, 8, 2019),
								(9, 1, 4, 2008), (9, 2, 9, 2010), (9, 3, 10, 2015),
								(10, 1, 3, 2011), (10, 2, 9, 2013), (10, 3, 11, 2017),
								(11, 1, 1, 2003), (11, 2, 6, 2005), (11, 3, 8, 2009),
								(12, 1, 2, 2004), (12, 2, 7, 2006), (12, 3, 6, 2010),
								(13, 1, 4, 2005), (13, 2, 9, 2007), (13, 3, 10, 2011),
								(14, 1, 3, 2007), (14, 2, 5, 2009), (14, 3, 11, 2013),
								(15, 1, 1, 2008), (15, 2, 8, 2010), (15, 3, 10, 2014),
								(16, 1, 4, 2002), (16, 2, 5, 2004), (16, 3, 8, 2008),
								(17, 1, 2, 2011), (17, 2, 8, 2013), (17, 3, 7, 2017),
								(18, 1, 4, 2008), (18, 2, 6, 2010), (18, 3, 11, 2015),
								(19, 1, 4, 2001), (19, 2, 8, 2003), (19, 3, 8, 2007),
								(20, 1, 3, 2008), (20, 2, 9, 2010), (20, 3, 11, 2014),
								(21, 1, 2, 2004), (21, 2, 6, 2006), (21, 3, 10, 2010),
								(22, 1, 1, 2002), (22, 2, 7, 2004), (22, 3, 11, 2008),
								(23, 1, 4, 2003), (23, 2, 8, 2005), (23, 3, 10, 2009),
								(24, 1, 2, 2007), (24, 2, 7, 2009), (24, 3, 11, 2013);
								
								

GO 

INSERT INTO EmploymentHistory VALUES	(1, 1, 4, '2018-01-01', 'Running'),			(2, 1, 4, '2018-01-01', '2019-02-15'),
										(4, 4, 3, '2018-02-10', 'Running'),			(6, 8, 5, '2019-01-01', 'Running'),
										(7, 3, 7, '2015-05-27', '2018-06-30'),		(8, 7, 5, '2016-01-01', 'Running'),
										(10, 9, 5, '2019-01-01', '2019-06-30'), 	(11, 5, 3, '2015-12-20', 'Running'),		
										(13, 8, 2, '2018-01-01', 'Running'),		(14, 2, 2, '2018-01-01', '2018-11-30'),
										(15, 4, 4, '2018-01-01', 'Running'),		(16, 8, 4, '2018-11-01', '2019-04-30'),
										(18, 11, 5, '2018-01-01', 'Running'),		(19, 7, 7, '2018-01-01', 'Running'),
										(20, 2, 5, '2018-01-01', 'Running'),		(21, 10, 6, '2018-05-10', '2018-07-05'),			
										(23, 10, 4, '2017-03-01', '2018-10-10'),	(24, 12, 4, '2018-01-01', 'Running');
							



----------------------------------  Create a Non Clustred INDEX --------------------------------------------
GO
CREATE INDEX IX_Post ON Post(PostTitle);
CREATE INDEX IX_Certificate ON Certificate(CertificateName);

--------------------------------Create Clustered Index---------------------------------------------------------------

GO
SELECT * INTO AppicantsCopy FROM Applicants;
CREATE CLUSTERED INDEX IX_AppicantsCopy_ApplicantID ON AppicantsCopy(ApplicantID ASC);


GO
------------------------------ Create Procedure that show the all information about Index-----------------------------
CREATE PROC Sp_All_Index_Information
AS
SELECT 
     TableName	=	t.name,
     IndexName	=	ind.name,
     IndexId	=	ind.index_id,
     ColumnId	=	ic.index_column_id,
     ColumnName =	col.name,
     ind.*,
     ic.*,
     col.* 
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
	 t.is_ms_shipped = 0 
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id;



GO
--------------------  Create a view  WITH ENCRYPTION, WITH SCHEMABINDING AND WITH CHECK OPTION ---------------------

CREATE VIEW vw_HighestEducation WITH ENCRYPTION AS
	SELECT	Applicants.FirstName+' '+ Applicants.LastName AS [Applicant's Name], 
			CertificateName AS [Highest Qualification], YEAR 
	FROM Certificate join Education	
		ON Certificate.CertificateID = Education.CertificateID
	JOIN Applicants 
		ON Applicants.ApplicantID = Education.ApplicantID
	WHERE CertificateName = 'Honours'
	WITH CHECK OPTION;


GO  
-------------------------Create Store Procedure------------------------------------------------------------------

CREATE PROC sp_UpdateApplicants
@ID INT ,
@Fname VARCHAR(50),
@Lname VARCHAR(50)
AS
UPDATE Applicants 
SET
		FirstName = @Fname, 
		LastName = @Lname 
WHERE ApplicantID = @ID ;
SELECT * FROM Applicants WHERE ApplicantID = @ID ;



GO
-----------------------------------Create Scalar-valued Function----------------------------------------------
CREATE FUNCTION Fn_TotalApplicant()
RETURNS INT
BEGIN
	RETURN (SELECT COUNT(*) FROM Applicants);
END;


GO
--------------------------Create Simple Table-valued Function-------------------------------------------------
CREATE FUNCTION Fn_EmploymentHistory()
RETURNS TABLE
AS
RETURN
		(SELECT Applicants.ApplicantID, (FirstName + ' ' + LastName) AS Name, Contact, CompanyID, EmploymentHistory.PostID, JobStarttDate, JobEndDate
		FROM Applicants JOIN EmploymentHistory ON Applicants.ApplicantID = EmploymentHistory.ApplicantID);



GO
---------------------Create Trigger Statemant----After Trigger Deleted------------------------------------------------------------
SELECT	* FROM AppicantsCopy;

CREATE TABLE AppicantArchive (
							ApplicantID		INT,
							FirstName		VARCHAR(30),
							LastName		VARCHAR(30),
							Address			VARCHAR(50),
							Contact			VARCHAR(20),
							CurrentJobStatus	varchar(20),
							ApplyDate		date,
							PostID			int,
							ExpectedSalary	money, 
							ReferenceID			int);
GO

CREATE TRIGGER Tr_AppicantDetails
ON AppicantsCopy
AFTER DELETE 
AS 
INSERT INTO AppicantArchive (ApplicantID, FirstName, LastName, Address, Contact, CurrentJobStatus, ApplyDate, PostID, ExpectedSalary, ReferenceID)
SELECT	ApplicantID, FirstName, LastName, Address, Contact, CurrentJobStatus, ApplyDate, PostID, ExpectedSalary, ReferenceID FROM deleted;


GO

