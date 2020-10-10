USE JobApplicationDB;


Go
SELECT * FROM Certificate;
SELECT * FROM Institute;
SELECT * FROM Education;
SELECT * FROM Companies;
SELECT * FROM Post;
SELECT * FROM Reference;
SELECT * FROM EmploymentHistory;
SELECT * FROM Applicants;

GO

------------ Alter Table Reference--------------------------------------------

ALTER TABLE Reference  ADD  Email	VARCHAR;

GO

------------- Delect column from table-----------------------------------------------

ALTER TABLE Reference  DROP COLUMN  Email;

------------- Update ROW-----------------------------------------------------------------

UPDATE Post SET PostTitle = 'Sales Executive' WHERE PostID = 6;

GO
------------- DELETE ROW-------------------------------------------------------------------
DELETE FROM Applicants WHERE ApplicantID = 24;


-------------------Justify Index--(IX_Post)------------------------------------------------------
EXEC sp_helpIndex Post; 


------------------Justify Index--(IX_Certificate)-----------------------------------------------
EXEC Sp_helpindex Certificate;


------------------Justify Index--(IX_AppicantsCopy_ApplicantID)---------------------------------
EXEC Sp_helpindex AppicantsCopy;

GO
-----------------Justify Index--(Sp_All_Index_Information)----------------------------------------
EXEC sp_All_Index_Information;


GO
-------------------A view that find out Applicants Highest Education---------------------------------------------------
SELECT * FROM vw_HighestEducation;


GO
-------------------A Select Statement------------------------------------------------------------------------------------
SELECT ReferenceID, Name, Company, Phone FROM Reference ORDER BY Name;

GO
-------------------A Select statemant that concatenate data---------------------------------------------------------------
SELECT ApplicantID, FirstName+ ' '+ LastName as [Full Name] FROM Applicants;


GO
------------------A Select statemant that Eliminates duplicate rows-------------------------------------------------------
SELECT DISTINCT ApplicantID  FROM Education;


GO
-----------------A Select statemant that Use IN Phrase--------------------------------------
SELECT * FROM Applicants WHERE ApplicantID IN (1,2,3,5,8,10, 20, 22);

SELECT * FROM Applicants WHERE ApplicantID NOT IN (1,2,3,5,8,10, 20, 22);


GO
----------------A Select statemant that Use BETWEEN Phrase------------------------------------------------------------------
SELECT * FROM Applicants WHERE ApplyDate BETWEEN '2019-06-02' AND '2019-06-10';

SELECT * FROM Applicants WHERE ApplyDate NOT BETWEEN '2019-06-02' AND '2019-06-10';



GO
---------------- A Join Query that show all the information about Applicants---------------------------------------------------------------------------
SELECT Applicants.ApplicantID, FirstName+ ' '+ LastName as [Full Name], Applicants.Address, Applicants.Contact, CertificateName, 
		InstituteName, Education.Year, Applicants.CurrentJobStatus, Applicants.ApplyDate, Post.PostTitle, Applicants.ExpectedSalary,
		Reference.Name AS Reference, Reference.Position AS [Reference Position], Reference.Company, Reference.Phone, Companies.CompanyName,
		 Companies.Address, Companies.Phone, Post.PostTitle, EmploymentHistory.JobStarttDate, EmploymentHistory.JobEndDate 
FROM Applicants 
JOIN Reference			ON Applicants.ReferenceID = Reference.ReferenceID
join Education			ON Applicants.ApplicantID = Education.ApplicantID
JOIN Certificate		ON Education.CertificateID = Certificate.CertificateID
JOIN Institute			ON Education.InstituteID = Institute.InstituteID
JOIN EmploymentHistory	ON Applicants.ApplicantID = EmploymentHistory.ApplicantID
JOIN POST				ON EmploymentHistory.PostID = Post.PostID
JOIN Companies			ON	EmploymentHistory.CompanyID = Companies.CompanyID;

GO


-----------------A Implicit Join query --------------------------------------------------------------------------
SELECT FirstName + ' '+ LastName as [Full Name], Certificate.CertificateName, Institute.InstituteName, YEAR

FROM Applicants, Education, Certificate, Institute	
WHERE	 Applicants.ApplicantID = Education.ApplicantID
AND		 Education.CertificateID = Certificate.CertificateID
AND		 Education.InstituteID = Institute.InstituteID;



GO
-------------A Left Outer Join query -------------------------------------------------------------
SELECT Applicants.ApplicantID, Applicants.FirstName+' '+ Applicants.LastName AS [Applicant's Name], Reference.Name AS [Reference Name]
FROM Applicants LEFT JOIN Reference  ON Applicants.ReferenceID = Reference.ReferenceID;

GO
-------------Summary----------------------------------------------------------------------------

SELECT COUNT(ApplicantID) AS [Total Applicants] FROM Applicants;

SELECT (Applicants.FirstName + ' ' + Applicants.LastName) AS ApplicantName, COUNT (Applicants.PostID) AS TotalPost, PostTitle 
FROM Applicants JOIN Post ON Applicants.PostId = Post.PostId
GROUP BY  (Applicants.FirstName + ' ' + Applicants.LastName) , PostTitle
HAVING COUNT (Applicants.PostID) < 2;


--------------Sub-Query---------------------------------------------------------------------------------------------------------------

SELECT ApplicantID, CompanyId FROM EmploymentHistory WHERE PostID IN (SELECT PostID FROM EmploymentHistory WHERE PostID IN (1, 2, 3));


---------------CTE------------------
WITH CTE1 AS
	( SELECT FirstName, LastName, Address, CurrentJobStatus, COUNT (DISTINCT Applicants.PostId) AS TotalPost, PostTitle 
	 FROM Applicants JOIN Post ON Applicants.PostId = Post.PostId 
	 GROUP BY FirstName, LastName, Address, CurrentJobStatus,PostTitle)
	 SELECT FirstName, LastName, Address, CurrentJobStatus, TotalPost, PostTitle FROM CTE1 WHERE LastName = 'Ala Zafar';


GO

----------------------Execute Stored Procedure---------------------------------------------------------
EXEC sp_UpdateApplicants 1, Abdul, Jalil;



--------------------------------Transaction------------------------------------------------------

GO
IF OBJECT_ID ('tempdb..#InstituteCopy') IS NOT NULL
	DROP TABLE tempdb.. #InstituteCopy;

SELECT InstituteID, InstituteName, City INTO #InstituteCopy FROM Institute WHERE InstituteID <= 5;

BEGIN TRAN;
	DELETE #InstituteCopy WHERE InstituteID = 1;
	SAVE TRAN Institute1;

	DELETE #InstituteCopy WHERE InstituteID = 2;
	SAVE TRAN Institute2;
	SELECT * FROM #InstituteCopy;


	ROLLBACK TRAN Institute2;
	SELECT * FROM #InstituteCopy;

	ROLLBACK TRAN Institute1;
	SELECT * FROM #InstituteCopy;
COMMIT TRAN;
SELECT * FROM #InstituteCopy;


