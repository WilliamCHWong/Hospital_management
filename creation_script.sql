-- Specialty Table
CREATE TABLE Specialty (
    SpecialtyID NUMERIC(2),
    Specialty VARCHAR(50) NOT NULL,
    PRIMARY KEY (SpecialtyID),
    CONSTRAINT ck_SpecialtyID CHECK (SpecialtyID BETWEEN 1 AND 99)
);

-- Doctor Table
CREATE TABLE Doctor (
    DoctorID NUMERIC(4),
    FirstName VARCHAR(25) NOT NULL,
    LastName VARCHAR(25) NOT NULL,
    SpecialtyID NUMERIC(2) NOT NULL,
    Rank NUMERIC(1) NOT NULL,
    Phone NUMERIC(10) NOT NULL,
    PRIMARY KEY (DoctorID),
    CONSTRAINT ck_DoctorID CHECK (DoctorID > 0),
    FOREIGN KEY (SpecialtyID) REFERENCES Specialty(SpecialtyID)
);

-- Patient Table
CREATE TABLE Patient (
    PatientID NUMERIC(6),
    FirstName VARCHAR(25) NOT NULL,
    LastName VARCHAR(25) NOT NULL,
    DOB DATE NOT NULL,
    Phone NUMERIC(10) NOT NULL,
    PRIMARY KEY (PatientID),
    CONSTRAINT ck_PatientID CHECK (PatientID > 0)
);

-- Room Table
CREATE TABLE Room (
    RoomNumber NUMERIC(3),
    RoomName VARCHAR(50) NOT NULL,
    RoomType VARCHAR(1) NOT NULL,
    RoomCapacity NUMERIC(2) NOT NULL,
    RoomStatus VARCHAR(10) NOT NULL,
    PRIMARY KEY (RoomNumber),
    CONSTRAINT ck_RoomNumber CHECK (RoomNumber > 0)
);

-- SurgeryType Table
CREATE TABLE SurgeryType (
    SurgeryTypeID NUMERIC(4),
    SurgeryType VARCHAR(50) NOT NULL,
    Description VARCHAR(255),
    EstimatedDuration NUMERIC(3,2) NOT NULL, 
    SpecialtyID NUMERIC(2) NOT NULL,
    DocRankRequired NUMERIC(1) NOT NULL,
    PRIMARY KEY (SurgeryTypeID),
    CONSTRAINT ck_SurgeryTypeID CHECK (SurgeryTypeID > 0),
    FOREIGN KEY (SpecialtyID) REFERENCES Specialty(SpecialtyID)
);

-- SurgeryRoom Table
CREATE TABLE SurgeryRoom (
    RoomNumber NUMERIC(3),
    SurgeryTypeID NUMERIC(4),
    PRIMARY KEY (RoomNumber, SurgeryTypeID),
    FOREIGN KEY (RoomNumber) REFERENCES Room(RoomNumber),
    FOREIGN KEY (SurgeryTypeID) REFERENCES SurgeryType(SurgeryTypeID)
);

-- Appointment Table
CREATE TABLE Appointment (
    AppointmentID NUMERIC(4),
    PatientID NUMERIC(6),
    DoctorID NUMERIC(4),
    AppointmentDate DATE NOT NULL,
    StartTime NUMERIC(4) NOT NULL, 
    EndTime NUMERIC(4) NOT NULL,
    RoomNumber NUMERIC(3),
    SurgeryTypeID NUMERIC(4),
    PRIMARY KEY (AppointmentID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (RoomNumber) REFERENCES Room(RoomNumber),
    FOREIGN KEY (SurgeryTypeID) REFERENCES SurgeryType(SurgeryTypeID),
    CONSTRAINT ck_AppointmentID CHECK (AppointmentID > 0),
    CONSTRAINT ck_StartTime_EndTime CHECK (StartTime < EndTime)
);

-- Medicines Table
CREATE TABLE Medicines (
    MedicineID NUMERIC(9),
    MedicineName VARCHAR(50) NOT NULL,
    Supplier VARCHAR(25) NOT NULL,
    MaxServingPerDose NUMERIC(6,2) NOT NULL,
    MinDoseInterval NUMERIC(4) NOT NULL,
    PRIMARY KEY (MedicineID),
    CONSTRAINT ck_MedicineID CHECK (MedicineID > 0)
);

-- Prescription table
CREATE TABLE Prescription (
    PrescriptionID NUMERIC(9),
    DoctorID NUMERIC(4),
    PatientID NUMERIC(6),
    MedicineID NUMERIC(9),
    ServingPerDose NUMERIC(6,2) NOT NULL,
    DoseInterval NUMERIC(4) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    PRIMARY KEY (PrescriptionID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID),
    CONSTRAINT ck_PrescriptionID CHECK (PrescriptionID > 0)
);


-- Allergy Table
CREATE TABLE Allergy (
    AllergyID NUMERIC(9),
    AllergyName VARCHAR(50) NOT NULL,
    PRIMARY KEY (AllergyID),
    CONSTRAINT ck_AllergyID CHECK (AllergyID > 0)
);

CREATE TABLE MedicineProhibition (
    AllergyID NUMERIC(9),
    MedicineID NUMERIC(9),
    PRIMARY KEY (AllergyID, MedicineID),
    FOREIGN KEY (AllergyID) REFERENCES Allergy(AllergyID),
    FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID)
);


-- PatientAllergy Table
CREATE TABLE PatientAllergy (
    AllergyID NUMERIC(9),
    PatientID NUMERIC(6),
    PRIMARY KEY (AllergyID, PatientID),
    FOREIGN KEY (AllergyID) REFERENCES Allergy(AllergyID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
