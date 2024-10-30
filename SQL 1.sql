
-- TASK 1 --
-- PART 1 --
-- BUILD A DATABASE DESIGN --

CREATE DATABASE Hospital_Task_1

USE Hospital_Task_1


--[1] --TABLE FOR PATIENT RECORDS--

CREATE TABLE PatientRecords(
    PatientID int IDENTITY(1,1) PRIMARY KEY ,
	FirstName NVARCHAR(80) NOT NULL,
	MiddleName NVARCHAR(80) NULL,
    LastName NVARCHAR(80) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender NVARCHAR(15) NOT NULL,
	NHSNumber NVARCHAR(30) NOT NULL,
    Address NVARCHAR(120) NOT NULL,
    City NVARCHAR(80) NOT NULL,
    State NVARCHAR(80) NOT NULL,
    PostCode NVARCHAR(25) NOT NULL,
    TelephoneNumber NVARCHAR(25) ,
    Email NVARCHAR(150) ,
    Username NVARCHAR(60) NOT NULL UNIQUE,
    Password NVARCHAR(60) NOT NULL,
	DateofPatientleft NVARCHAR(30) 
	);

INSERT INTO PatientRecords ( FirstName,MiddleName,LastName, DateOfBirth,Gender,NHSNumber, Address,City,State, PostCode, 
TelephoneNumber, Email, Username, Password,DateofPatientleft)
VALUES 
( 'Ava','Hannah','Grace','06-08-2005','Female','148 776 5119','72',' Butterworth Lane', 'Chadderton Oldham', 
'OL9 8DX','0373 887 1234','avahannahgrace@gmail.com','Hannah123','Grace@456','NULL'),
('Amelia','Natalie','Williams','01-02-2004','Female','143 476 5219','61-63',' Queens Road','Oldham',
' OL8 2BA','0814 175 4569','amelianataliewilliams@gmail.com','Natalie789','Williams@753','NULL'),
('Bella','NULL','Parker','03-04-2003','Female','183 472 5319','Worthington Lake', 'Chorley Road', 'Worthington Standish Wigan',
' WN1 2XN','0315 258 7895','bellaparker@gmail.com','Bella741','Parker@789','NULL'),
( 'Blake','Ethan','Parker','05-06-1980','Female','193 475 5417','Huddersfield Road', 'Waterhead', 'Oldham',
' OL4 3NN','0616 331 7423','blakeethanparker@gmail.com','Blake456','Ethan@852','NULL'),
('Chole','NULL','Gabriel','08-08-2008','Female','173 578 5519','Oakwood House', 'Bury Road', 'Rochdale',
' OL11 5EU','0917 492 1596','cholegabriel@gmail.com','Chole951','Gabriel963','2020-05-19'),
( 'Daniel','NULL','Isaac','09-06-1983' ,'Male','163 479 5615','205/207 ','Grimshaw Lane','Middleton Manchester',
' M24 2BW','0418 553 7845','danielisaac@gmail.com','Daniel358','Isaac852','NULL'),
('David','NULL','Jacob','03-04-1999','Male','133 376 5719','Wood Street', 'Langley Middleton', 'Manchester',
' M24 5QH','0821 627 1278','davidjacob@gmail.com','David741','Jacob896','NULL'),
('Henry','NULL','Kevin','07-09-1992','Male','113 473 5813','400',' Huddersfield Road', 'Millbrook Stalybridge',
' SK15 3ET','0531 706 9874','henrykevin@gmail.com','Henry963','Kevin896','2023-06-17 '),
('Jennifer','NULL','Williams','09-10-1995','Female','228 485 9637','39','Partington', 'Greater Manchester', 
'M31 4ND','0147 852 3697','jenniferwilliams@gmail.com','Jennifer@963','Williams@852','NULL'),
('Paul','NULL','Lawrence','06-04-2001','Male','789 632 1456','59c','Altrincham', 'Greater Manchester',
'WA15 7JW','0963 456 7539','paullawrence@gmail.com','Paul@123','Lawrence@831','NULL');


--TABLE FOR DEPARTMENT RECORDS--

CREATE TABLE DepartmentRecords (
    DepartmentID INT PRIMARY KEY,
    Department VARCHAR(100) NOT NULL
);

INSERT INTO DepartmentRecords (DepartmentID,Department)
VALUES
('11','Gastroenterologists'),
('21','Cancer'),
('31','Hypertension'),
('41','Diabetes'),
('51','Arthritis'),
('61','Osteoarthritis'),
('71','Asthma'),
('81','Coronary Artery Disease'),
('91','Migraine Headaches'),
('22','Major Depressive Disorder');

--TABLE FOR DOCTOR RECORDS--

	CREATE TABLE DoctorRecords (
    DoctorID int  PRIMARY KEY,
    Name VARCHAR(180) NOT NULL,
    DepartmentID INT ,
    Specialty VARCHAR(120) NOT NULL,
	CONSTRAINT fK_DepartmentID FOREIGN KEY (DepartmentID) REFERENCES DepartmentRecords(DepartmentID)
	);

	INSERT INTO DoctorRecords( DoctorID,Name,DepartmentID,Specialty)
	VALUES
	('801','Diana','11','Gastroenterologists'),
	('802','Devin','21','Cancer'),
	('803','Harper','31','Hypertension'),
	('804','Hope','41','Diabetes'),
	('805','Sebastian','51','Arthritis'),
	('806','Samuel','11','Gastroenterologists'),
	('807','Silas','31','Hypertension'),
	('808','Steven','21','Cancer'),
	('809','Julia','41','Diabetes'),
	('810','Neil','21','Cancer');

--TABLE FOR MEDICAL RECORDS--
	
    CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY,
    PatientID INT ,
    DoctorID INT  ,
    SpecialtyofDoctor VARCHAR(120) NOT NULL,
    Diagnosis VARCHAR(300)  NULL,
    MedicinePrescribed VARCHAR(150)  NULL,
    MedicinePrescribedDate DATE NULL,
    Allergies VARCHAR(300) NULL,
    Appointment DATETIME NULL,
    AppointmentStatus VARCHAR(30) NOT NULL,
    Review VARCHAR(MAX) ,
	CONSTRAINT fK_PatientID FOREIGN KEY (PatientID) REFERENCES PatientRecords(PatientID),
    CONSTRAINT fK_DoctorID FOREIGN KEY (DoctorID) REFERENCES DoctorRecords(DoctorID)
	);

INSERT INTO MedicalRecords(RecordID, PatientID, DoctorID, SpecialtyofDoctor, Diagnosis, MedicinePrescribed, MedicinePrescribedDate, Allergies, Appointment, AppointmentStatus, Review)
VALUES 
('901','1', '801', 'Gastroenterologists', 'Gastroenterologists', 'Omeprazole', '2021-04-08', 'None', '2021-04-08 09:10:00', 'Completed', 'Dr. Diana was incredibly knowledgeable and attentive during my appointment. Her thorough explanation of my condition put me at ease, and I left feeling confident in my treatment plan'),
('902', '4', '802', 'Cancer', 'Cancer', 'Chemotherapy', '2020-04-12', 'None', '2020-04-12 11:30:00', 'Completed', 'I highly recommend Dr. Devin for her exceptional care and expertise. She took the time to listen to my concerns and provided compassionate support throughout my treatment journey'),
('903', '3', '807', 'Hypertension', NULL, NULL, NULL, NULL, '2022-04-14 13:50:00', 'Cancelled', NULL),
('904', '9', '809', 'Diabetes', 'Diabetes', 'Insulin', '2021-04-16', 'Sugar', '2021-04-16 15:20:00', 'Completed', 'I cannot speak highly enough of Dr. Julia. Her compassionate approach and genuine concern for my well-being made me feel valued as a patient. I trust her completely with my healthcare'),
('905', '8', '805', 'Arthritis', NULL, NULL, NULL, NULL, '2021-04-18 17:40:00', 'Cancelled', NULL),
('906', '2', '801', 'Gastroenterologists', 'Gastroenterologists', 'Omeprazole', '2021-04-11', 'None', '2021-04-11 10:20:00', 'Completed', 'Dr. Diana is an exceptional doctor who goes the extra mile for her patients. She took the time to explore all possible treatment options with me and made me feel empowered in my healthcare decisions. Thank you for your dedication, Dr. Diana'),
('907', '6', '802', 'Cancer', 'Cancer', 'Chemotherapy', '2007-04-13', 'None', '2007-04-13 12:40:00', 'Completed', 'I have had the pleasure of being under Dr. Devin care for several years now, and I could not be happier with the level of care I have received. Her compassion and expertise make her an outstanding physician. I highly recommend her to anyone seeking top-notch medical care'),
('908', '8', '807', 'Hypertension', 'Hypertension', 'Amlodipine', '2022-04-15', 'None', '2022-04-15 14:10:00', 'Completed', 'Dr. Silas has been instrumental in managing my chronic condition. His comprehensive approach to treatment has significantly improved my quality of life. I am grateful for his expertise and compassionate care'),
('909', '10', '809', 'Diabetes', 'Diabetes', 'Metformin', '2020-04-17', 'Gluten', '2020-04-17 16:30:00', 'Completed', 'Dr. Julia is an excellent communicator who takes the time to listen to her patients concerns. She explains complex medical concepts in a way that is easy to understand and involves me in decision-making regarding my treatment. Highly recommend'),
('910', '5', '805', 'Arthritis', 'Arthritis', 'Naproxen', '2019-04-19', 'None', '2019-04-19 18:50:00', 'Completed', 'I can thank Dr. Sebastian enough for the exceptional care he provided during my recent hospitalization. He expertise, dedication, and kindness made a difficult time much more manageable. I am forever grateful for his support');

--TABLE FOR  PATIENT APPOINTMENTS --

CREATE TABLE PatientAppointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Department VARCHAR(100) NOT NULL,
    Status VARCHAR(20)  NOT NULL,
    CONSTRAINT FK_PatientIDA FOREIGN KEY (PatientID) REFERENCES PatientRecords(PatientID),
    CONSTRAINT FK_DoctorIDA FOREIGN KEY (DoctorID) REFERENCES DoctorRecords(DoctorID)
	
	);

	INSERT INTO PatientAppointments(AppointmentID,PatientID,DoctorID,Department,AppointmentDate,AppointmentTime,Status)
VALUES
('501',' 1', '801', 'Gastroenterologists', '2024-08-10' ,  '09:10:00','Pending'),
('502', '2', '801', 'Gastroenterologists',  '2024-08-11',  '10:20:00','Pending'),
('503', '4', '802', 'Cancer',  '2024-08-12', ' 11:30:00','Pending' ),
('504', '6', '802', 'Cancer',  '2024-08-13', ' 12:40:00','Pending'),
('505', '3', '807', 'Hypertension', '2024-09-14 ', ' 13:50:00','Pending'),
('506', '3', '807', 'Hypertension',  '2024-07-17', '16:30:00','Pending'),
('507', '9', '809', 'Diabetes',  '2024-09-16', ' 15:20:00','Pending'),
('508', '10', '809', 'Diabetes', '2024-09-17', ' 16:30:00','Pending'),
('509', '3', '805', 'Hypertension', '2025-06-18', ' 17:40:00','Pending'),
('510', '3', '805',  'Hypertension',  '2025-07-19', '18:50:00','Pending');


-- TABLE FOR DOCTOR APPOINTMENTS --

CREATE TABLE DoctorAppointments(
    AppointmentID INT ,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
	DoctorSpecialty VARCHAR(30) ,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
	Department VARCHAR(100) NOT NULL,
    Status VARCHAR(20),
	Review VARCHAR(MAX),
	CONSTRAINT FK_DoctorIDC FOREIGN KEY (DoctorID) REFERENCES DoctorRecords(DoctorID),
	);

	INSERT INTO DoctorAppointments(AppointmentID,PatientID,DoctorID,DoctorSpecialty, AppointmentDate ,AppointmentTime ,
	Department,Status,Review)
VALUES
('501',' 1', '801', 'Gastroenterologists', '2024-08-10' ,  '09:10:00', 'Gastroenterologists','Pending','NULL'),
('502', '2', '806', 'Gastroenterologists',  '2024-08-11',  '10:20:00','Gastroenterologists','Pending','NULL'),
('503', '4', '802', 'Cancer',  '2024-08-12', ' 11:30:00','Cancer','Pending' ,'NULL'),
('504', '6', '808', 'Cancer',  '2024-08-13', ' 12:40:00','Cancer', 'Pending','NULL'),
('505', '3', '807', 'Hypertension', '2024-09-14 ', ' 13:50:00','Hypertension','Pending','NULL'),
('506', '3', '803', 'Hypertension',  '2024-07-17', '16:30:00','Hypertension','Pending','NULL'),
('507', '9', '809', 'Diabetes',  '2024-09-16', ' 15:20:00', 'Diabetes', 'Pending','NULL'),
('508', '10', '804', 'Diabetes', '2024-09-17', ' 16:30:00','Diabetes','Pending','NULL'),
('509', '3', '805', 'Arthritis', '2025-06-18', ' 17:40:00','Arthritis','Pending','NULL'),
('510', '3', '810',  'Cancer',  '2025-07-19', '18:50:00','Cancer', 'Pending','NULL'),
('511','1', '801', 'Gastroenterologists', '2021-04-08', '09:10:00', 'Gastroenterologists','Completed', 'Dr. Diana was incredibly knowledgeable and attentive during my appointment. Her thorough explanation of my condition put me at ease, and I left feeling confident in my treatment plan'),
('512', '4', '802', 'Cancer',  '2020-04-12',' 11:30:00','Cancer',   'Completed', 'I highly recommend Dr. Devin for her exceptional care and expertise. She took the time to listen to my concerns and provided compassionate support throughout my treatment journey'),
('513', '3', '807', 'Hypertension', '2022-04-14',' 13:50:00', 'Hypertension','Cancelled', 'NULL'),
('514', '9', '809', 'Diabetes',  '2021-04-16',' 15:20:00','Diabetes',   'Completed', 'I cannot speak highly enough of Dr. Julia. Her compassionate approach and genuine concern for my well-being made me feel valued as a patient. I trust her completely with my healthcare'),
('515', '8', '805', 'Arthritis',  '2021-04-18',' 17:40:00', 'Arthritis','Cancelled', 'NULL'),
('516', '2', '801', 'Gastroenterologists', '2021-04-11',' 10:20:00','Gastroenterologists', 'Completed', 'Dr. Diana is an exceptional doctor who goes the extra mile for her patients. She took the time to explore all possible treatment options with me and made me feel empowered in my healthcare decisions. Thank you for your dedication, Dr. Diana'),
('517', '6', '802', 'Cancer','2007-04-13',' 12:40:00', 'Cancer','Completed', 'I have had the pleasure of being under Dr. Devin care for several years now, and I could not be happier with the level of care I have received. Her compassion and expertise make her an outstanding physician. I highly recommend her to anyone seeking top-notch medical care'),
('518', '8', '807', 'Hypertension',  '2022-04-15',' 14:10:00','Hypertension', 'Completed', 'Dr. Silas has been instrumental in managing my chronic condition. His comprehensive approach to treatment has significantly improved my quality of life. I am grateful for his expertise and compassionate care'),
('519', '10', '809', 'Diabetes', '2020-04-17',' 16:30:00', 'Diabetes','Completed', 'Dr. Julia is an excellent communicator who takes the time to listen to her patients concerns. She explains complex medical concepts in a way that is easy to understand and involves me in decision-making regarding my treatment. Highly recommend'),
('520', '5', '805', 'Arthritis',  '2019-04-19',' 18:50:00','Arthritis', 'Completed', 'I can thank Dr. Sebastian enough for the exceptional care he provided during my recent hospitalization. He expertise, dedication, and kindness made a difficult time much more manageable. I am forever grateful for his support');


-- CREATE TABLE PATIENT REVIEWS --

CREATE TABLE PatientReviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
	PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    Review VARCHAR(MAX) NOT NULL,
    CONSTRAINT FK_DoctorIDD FOREIGN KEY (DoctorID) REFERENCES DoctorRecords(DoctorID),
);

INSERT INTO PatientReviews ( PatientID, DoctorID, Review)
VALUES
( '1', '801', 'Dr. Diana was incredibly knowledgeable and attentive during my appointment. Her thorough explanation of my condition put me at ease, and I left feeling confident in my treatment plan'),
( '4', '802', 'I highly recommend Dr. Devin for her exceptional care and expertise. She took the time to listen to my concerns and provided compassionate support throughout my treatment journey'),
( '9', '809', 'I cannot speak highly enough of Dr. Julia. Her compassionate approach and genuine concern for my well-being made me feel valued as a patient. I trust her completely with my healthcare'),
( '2', '801', 'Dr. Diana is an exceptional doctor who goes the extra mile for her patients. She took the time to explore all possible treatment options with me and made me feel empowered in my healthcare decisions. Thank you for your dedication, Dr. Diana'),
( '6', '802', 'I have had the pleasure of being under Dr. Devin''s care for several years now, and I could not be happier with the level of care I have received. Her compassion and expertise make her an outstanding physician. I highly recommend her to anyone seeking top-notch medical care'),
( '8', '807', 'Dr. Silas has been instrumental in managing my chronic condition. His comprehensive approach to treatment has significantly improved my quality of life. I am grateful for his expertise and compassionate care'),
( '10', '809', 'Dr. Julia is an excellent communicator who takes the time to listen to her patients'' concerns. She explains complex medical concepts in a way that is easy to understand and involves me in decision-making regarding my treatment. Highly recommend'),
( '5', '805', 'I can''t thank Dr. Sebastian enough for the exceptional care he provided during my recent hospitalization. His expertise, dedication, and kindness made a difficult time much more manageable. I am forever grateful for his support');

-- CLIENT REQUIREMENTS --

-- CREATE PROCEDURE FOR PATIENT REGISTRATION --

CREATE PROCEDURE RegistrationofPatient
    @FirstName NVARCHAR(80),
    @MiddleName NVARCHAR(80) = NULL,
    @LastName NVARCHAR(80),
    @DateOfBirth DATE,
    @Gender NVARCHAR(15),
    @NHSNumber NVARCHAR(30),
    @Address NVARCHAR(120),
    @City NVARCHAR(80),
    @State NVARCHAR(80),
    @PostCode NVARCHAR(25),
    @TelephoneNumber NVARCHAR(25) = NULL,
    @Email NVARCHAR(150) = NULL,
    @Username NVARCHAR(60),
    @Password NVARCHAR(60)
AS
BEGIN
    SET NOCOUNT ON;
  -- Check if the username already exists --
    IF EXISTS (SELECT 1 FROM PatientRecords WHERE Username = @Username)
    BEGIN
        SELECT 'Username already exists' AS [Message];
        RETURN;
    END
    INSERT INTO PatientRecords (FirstName, MiddleName, LastName, DateOfBirth, Gender, NHSNumber, Address, City, State, PostCode, TelephoneNumber, Email, Username, Password)
    VALUES (@FirstName, @MiddleName, @LastName, @DateOfBirth, @Gender, @NHSNumber, @Address, @City, @State, @PostCode, @TelephoneNumber, @Email, @Username, HASHBYTES('SHA2_512', @Password));
    SELECT 'Patient record inserted successfully' AS [Message];
END

-- TO CALL THE PROCEDURE --

EXEC RegistrationofPatient
    @FirstName = 'John',
    @MiddleName = 'David',
    @LastName = 'Doe',
    @DateOfBirth = '1990-05-15',
    @Gender = 'Male',
    @NHSNumber = '1234567890',
    @Address = '123 Main St',
    @City = 'New York',
    @State = 'New York',
    @PostCode = '10001',
    @TelephoneNumber = '1234567890',
    @Email = 'johndoe@gmail.com',
    @Username = 'Johndoe896',
    @Password = 'Johndoe@356';
  SELECT * FROM PatientRecords;


-- CREATE PROCEDURE TO BOOK/REBOOK APPOINTMENT --

CREATE PROCEDURE Book_Appointment
    @PatientID INT,
    @DoctorID INT,
    @AppointmentDate DATE,
    @AppointmentTime TIME,
    @Department VARCHAR(100)
AS
BEGIN
    -- Get the current date
    DECLARE @CurrentDate DATE = GETDATE();
  -- Check if the patient exists
    IF EXISTS (SELECT 1 FROM PatientRecords WHERE PatientID = @PatientID)
    BEGIN
        
		-- Check if the appointment date is present and future
        IF @AppointmentDate >= @CurrentDate
        BEGIN
            
			-- Check doctor's availability
            IF NOT EXISTS (SELECT 1 FROM PatientAppointments WHERE DoctorID = @DoctorID AND AppointmentDate = @AppointmentDate AND AppointmentTime = @AppointmentTime AND Status = 'Pending')
            BEGIN
                
				-- Get the next available AppointmentID
                DECLARE @NextAppointmentID INT;
                SELECT @NextAppointmentID = ISNULL(MAX(AppointmentID), 0) + 1 FROM PatientAppointments;
               
			   -- Insert appointment into PatientAppointments table
                INSERT INTO PatientAppointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime, Department, Status)
                VALUES (@NextAppointmentID, @PatientID, @DoctorID, @AppointmentDate, @AppointmentTime, @Department, 'Pending');
               PRINT 'Appointment booked successfully with AppointmentID: ' + CAST(@NextAppointmentID AS VARCHAR(10));
            END
            ELSE
            BEGIN
                PRINT 'Doctor is not available at the specified time.';
            END
        END
        ELSE
        BEGIN
            PRINT 'Appointment date must be present or future.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Invalid patient ID.';
    END
END;
GO

-- TO CALL THE PROCEDURE --

EXEC Book_Appointment @PatientID = 1, @DoctorID = 801, @AppointmentDate = '2024-08-20', @AppointmentTime = '10:00', @Department = 'Gastroenterologists';

SELECT * FROM PatientAppointments WHERE PatientID = '1';

-- CREATE PROCEDURE TO REVIEW PATIENT RECORD --

CREATE PROCEDURE View_Patient_MedicalRecord
    @PatientID INT
AS
BEGIN
    -- Retrieve medical records linked to the patient
    SELECT 
        mr.Diagnosis,
        mr.MedicinePrescribed,
        mr.MedicinePrescribedDate,
        mr.Allergies,
        dr.Name AS DoctorName,
        mr.Appointment AS AppointmentDate,
        mr.AppointmentStatus
    FROM MedicalRecords mr
    JOIN DoctorRecords dr ON mr.DoctorID = dr.DoctorID
    WHERE mr.PatientID = @PatientID;
-- Retrieve upcoming and past appointments
    SELECT 
        pa.AppointmentDate,pa.AppointmentTime,
        pa.Department,pa.Status,d.Name AS DoctorName
    FROM PatientAppointments pa
    JOIN DoctorRecords d ON pa.DoctorID = d.DoctorID
    WHERE pa.PatientID = @PatientID
    ORDER BY pa.AppointmentDate DESC;
-- Retrieve any reviews left by the patient
    SELECT 
        pr.Review,pr.PatientID,
        d.Name AS DoctorName
        FROM PatientReviews pr
    JOIN DoctorRecords d ON pr.DoctorID = d.DoctorID
    WHERE pr.PatientID = @PatientID;
END;

-- TO CALL THIS PROCEDURE --

EXEC View_Patient_MedicalRecord @PatientID = 2; 


-- CREATE PROCEDURE TO UPDATE MEDICAL RECORD --

CREATE PROCEDURE Update_Medical_Record 
    @PatientID INT,
    @Diagnosis VARCHAR(300),
    @MedicinePrescribed VARCHAR(150),
    @MedicinePrescribedDate DATE,
    @Allergies VARCHAR(300),
    @Review VARCHAR(MAX)
AS
BEGIN
    UPDATE MedicalRecords
    SET Diagnosis = @Diagnosis,
        MedicinePrescribed = @MedicinePrescribed,
        MedicinePrescribedDate = @MedicinePrescribedDate,
        Allergies = @Allergies,
        Review = @Review
    WHERE PatientID = @PatientID;
END;
GO

-- TO CALL THE PROCEDURE --

EXEC Update_Medical_Record 1, 'flu', 'Temiflu', '2024-04-14', 'Allergies', 'The doctor was very professional and attentive.';

SELECT * FROM MedicalRecords WHERE PatientID = '1'; 

-- CREATE PROCEDURE TO COMPLETE APPOINTMENT --

CREATE PROCEDURE Complete_Appointment 
    @PatientID INT
AS
BEGIN
    UPDATE PatientAppointments
    SET Status = 'Completed'
    WHERE PatientID = @PatientID;
END;
GO

-- TO CALL THE PROCEDURE --

EXEC Complete_Appointment 9;

SELECT * FROM PatientAppointments WHERE PatientID = '9';

-- CREATE PROCEDURE TO WRITE REVIEW/FEEDBACK FOR DOCTOR --

CREATE PROCEDURE Write_Review_or_Feedback 
    @PatientID INT,
    @DoctorID INT,
    @Review VARCHAR(MAX)
AS
BEGIN
    
    INSERT INTO PatientReviews (PatientID, DoctorID, Review)
    VALUES (@PatientID, @DoctorID, @Review);
END;
GO

-- TO CALL THE PROCEDURE --

EXEC Write_Review_or_Feedback 2, 805, 'The doctor was very professional and attentive.';
SELECT * FROM PatientReviews WHERE PatientID = '2';

-- CREATE PROCEDURE TO CANCEL APPOINTMENT --

CREATE PROCEDURE Cancel_Appointment
    @AppointmentID INT
AS
BEGIN
    -- Update the appointment status to 'Cancelled'
    UPDATE PatientAppointments
    SET Status = 'Cancelled'
    WHERE AppointmentID = @AppointmentID;

    -- Confirm cancellation
    SELECT 'Appointment cancelled. Please rebook your appointment.' AS Message;
END;

-- TO CALL THE PROCEDURE --

EXEC Cancel_Appointment @AppointmentID = 509; 
SELECT * FROM PatientAppointments WHERE AppointmentID = '509';

-- CREATE PROCEDURE TO KEEP RECORD OF THE DATE THE PATIENT LEFT --

CREATE PROCEDURE Record_Patient_Exit
    @PatientID INT,
    @ExitDate NVARCHAR(30)
AS
BEGIN
    -- Record the date the patient left
    UPDATE PatientRecords
    SET DateofPatientleft = @ExitDate
    WHERE PatientID = @PatientID;

    -- Confirm record update
    SELECT 'Exit date recorded for patient.' AS Message;
END;

-- TO CALL THE PROCEDURE --

EXEC Record_Patient_Exit @PatientID = 6, @ExitDate = '2024-04-15'; 

SELECT PatientID,DateofPatientleft FROM PatientRecords WHERE PatientID = '6';

-- PART 2 --

--[2] --

-- CONSTRAINT TO CHECK APPOINTMENT IS NOT IN THE PAST--

ALTER TABLE PatientAppointments	
ADD CONSTRAINT CheckAppointmentDate CHECK (AppointmentDate >= GETDATE());

--[3] --TO LIST ALL PATIENTS OLDER THAN 40 AND HAVE CANCER DIAGNOSIS--

-- SELECT QUERIES WHICH MAKE USE OF JOINS AND SUB-QUERIES --

-- USING A JOIN --

SELECT *
FROM PatientRecords p
JOIN MedicalRecords mr ON p.PatientID = mr.PatientID
WHERE DATEDIFF(YEAR, p.DateOfBirth, GETDATE()) > 40
AND mr.Diagnosis = 'Cancer';

-- USING A SUB-QUERY--

SELECT FirstName, LastName, Gender
FROM PatientRecords
WHERE PatientID IN (SELECT PatientID FROM MedicalRecords WHERE Diagnosis = 'Cancer');

-- SYSTEM FUNCTIONS AND USER DEFINED FUNCTIONS --

CREATE FUNCTION Patient_Age
(
    @DateOfBirth DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @Age INT;
    SET @Age = DATEDIFF(YEAR, @DateOfBirth, GETDATE());
    RETURN @Age;
END;

-- TO CALL THE USER DEFINED FUNCTION --

SELECT
    PatientID,
	FirstName,
    DateOfBirth,
    dbo.Patient_Age(DateOfBirth) AS Age
FROM
    PatientRecords;


--[4] --

--STORED PROCEDURES --

--(A) SEARCH STRINGS BY NAME OF MEDICINE--

CREATE PROCEDURE Search_Medicine_By_Name
    @MedicinePrescribed VARCHAR(150)
AS
BEGIN
    SELECT *
    FROM MedicalRecords
    WHERE MedicinePrescribed LIKE '%' + @MedicinePrescribed + '%'
    ORDER BY MedicinePrescribedDate DESC;
END;

--TO CALL THE STORED PROCEDURE--

EXEC Search_Medicine_By_Name @MedicinePrescribed = 'Omeprazole';

--(B) RETURN FULL LIST OF DIAGNOSIS AND ALLERGIES OF PATIENT WHO AS APPOINTMENT TODAY--

CREATE PROCEDURE GetDiagnosis_And_AllergiesFor_PatientToday
    @PatientID INT
AS
BEGIN
    DECLARE @today DATE = GETDATE();

    SELECT mr.Diagnosis, mr.Allergies
    FROM MedicalRecords mr
    INNER JOIN PatientAppointments a ON mr.PatientID = a.PatientID
    WHERE a.PatientID = @PatientID
    AND a.AppointmentDate = @today;
	END
    BEGIN
        -- No appointment for today--
        SELECT 'No appointment for today' AS message;
    END ;

	-- TO CALL THE PROCEDURE --

	EXEC GetDiagnosis_And_AllergiesFor_PatientToday @PatientID = 1;

--SELECT USING APPOINTMENT DATE--

	SELECT mr.Diagnosis, mr.Allergies, a.AppointmentDate
    FROM MedicalRecords mr
    INNER JOIN PatientAppointments a ON mr.PatientID = a.PatientID
    WHERE a.AppointmentDate = '2024-04-16';


--(C) UPDATE DETAILS OF DOCTOR--

CREATE PROCEDURE Update_Doctor_Details
    @DoctorID INT,
    @Specialty VARCHAR(120)
AS	
BEGIN
    UPDATE DoctorRecords
SET Specialty = @Specialty
    WHERE DoctorID = @DoctorID;
END;

--TO CALL THE STORED PROCEDURE--

EXEC Update_Doctor_Details @DoctorID='805', @Specialty ='Nephrologists';
SELECT * FROM DoctorRecords WHERE DoctorID='805';
SELECT * FROM DoctorRecords ;

--(D) DELETE APPOINTMENT WHO STATUS IS COMPLETED--

CREATE PROCEDURE Delete_Completed_Appointments
AS
BEGIN
    DELETE FROM DoctorAppointments
    WHERE Status = 'Completed';
END;	

--TO CALL THE STORED PROCEDURE--

EXEC Delete_Completed_Appointments;
SELECT * FROM DoctorAppointments;

--[5]-- VIEWS --

-- TO CREATE VIEW FOR APPOINTMENT DETAILS OF DOCTORS --

CREATE VIEW Appointment_Details_Doctors 
AS
SELECT 
    A.AppointmentDate,
    A.AppointmentTime,
    A.Department,
    A.DoctorSpecialty,
    DR.Name,
    A.DoctorID,
	A.Status,
    A.Review
FROM 
    DoctorAppointments A
INNER JOIN 
    DoctorRecords DR ON A.DoctorID = DR.DoctorID;

	--TO CALL THE STORED PROCEDURE--

SELECT * FROM Appointment_Details_Doctors;

-- [6] TRIGGERS --

-- TO CREATE TRIGGER TO CHANGE TO AVAILABLE WHEN STATUS IS CANCELLED--

CREATE TRIGGER Update_Appointment_Status
ON PatientAppointments
AFTER UPDATE
AS
BEGIN
    IF UPDATE(Status) AND (SELECT Status FROM INSERTED) = 'Cancelled'
    BEGIN
        UPDATE PatientAppointments
        SET Status = 'Available'
        WHERE Status = 'Cancelled';
    END;
END;

-- TO CHECK THE TRIGGER FUNCTION--

UPDATE PatientAppointments
SET Status = 'Cancelled'
WHERE AppointmentID = 510;

SELECT * FROM PatientAppointments;

--[7] -- SELECT QUERY TO COUNT COMPLETED APPOINTMENTS WITH SPECIALTY OF GASTROENTEROLOGISTS--

SELECT COUNT (*)
FROM MedicalRecords MR
JOIN DoctorRecords DR ON MR.DoctorID = DR.DoctorID
WHERE MR.AppointmentStatus = 'Completed' AND MR.SpecialtyofDoctor = 'Gastroenterologists';

--[8]--

--[1]-- DATA INTEGRITY AND CONCURRENCY--

-- USING CONSTRAINTS --

ALTER TABLE PatientRecords
ADD CONSTRAINT CK_Gender CHECK (Gender IN ('Male', 'Female', 'Other'));

-- USING TRANSACTIONS --

BEGIN TRANSACTION;
UPDATE PatientRecords SET FirstName = 'Jennifer' WHERE PatientID = 1;
UPDATE MedicalRecords SET Diagnosis = 'Flu' WHERE PatientID = 1;
ROLLBACK TRANSACTION;
SELECT * FROM PatientRecords WHERE PatientID = 1;
SELECT * FROM MedicalRecords WHERE PatientID = 1;

BEGIN TRANSACTION;
UPDATE PatientRecords SET FirstName = 'Jennifer' WHERE PatientID = 1;
UPDATE MedicalRecords SET Diagnosis = 'Flu' WHERE PatientID = 1;
COMMIT TRANSACTION;
SELECT * FROM PatientRecords WHERE PatientID = 1;
SELECT * FROM MedicalRecords WHERE PatientID = 1;


--[2]-- DATABASE SECURITY --

-- CREATE NEW USER ACCOUNT --

CREATE LOGIN Julia WITH PASSWORD = 'Salford123';
CREATE USER Julia FOR LOGIN Julia;
CREATE ROLE HospitalAdministrator;

ALTER ROLE HospitalAdministrator ADD MEMBER Julia;
GRANT SELECT,INSERT,UPDATE ON  MedicalRecords TO Julia WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE ON  MedicalRecords TO HospitalAdministrator WITH GRANT OPTION;
REVOKE DELETE ON MedicalRecords FROM Julia;
REVOKE DELETE ON MedicalRecords FROM HospitalAdministrator;
REVOKE DELETE ON MedicalRecords FROM PUBLIC;


--[3]-- DATABASE BACKUP AND RECOVERY --

-- TO PERFORM FULL DATABASE BACKUP--

BACKUP DATABASE Hospital_8_Task1 TO DISK = 'E:\00755216backup\00755216_task1.bak'
WITH CHECKSUM;

-- TO RESTORE DATABASE FROM BACKUP --

RESTORE VERIFYONLY FROM DISK = 'E:\00755216backup\00755216_task1.bak';


