--View 1: confirmAppt
--Check with the patient to confirm the appointment
--This view offers insights into appointments, featuring AppointmentID, PatientID, phone, PatientFullName, DoctorID, DoctorFullName, AppointmentDate, StartTime and EndTime.
--It's designed to assist in confirming appointments with patients, enhancing communication, and reducing no-show occurrences.
--Columns are arranged in a sequence most convenient to make the phone call, starting from the phone number to the timeslot.

CREATE VIEW confirmAppt AS
SELECT
    a.AppointmentID,
    a.PatientID,
    p.phone AS PatientPhone,
    p.FirstName || ' ' || p.LastName AS PatientFullName,
    a.DoctorID,
    d.FirstName || ' ' || d.LastName AS DoctorFullName,
    a.AppointmentDate,
    a.StartTime,
    a.EndTime
FROM
    Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Doctor d ON a.DoctorID = d.DoctorID
WHERE 
   a.AppointmentDate > CURRENT_DATE;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View 2: historyAppts
--This view provides a historical overview of patient appointments, showcasing details like AppointmentID, PatientID, PatientFullName, 
--DoctorID, DoctorFullName, AppointmentDate, StartTime, and EndTime. It aids in analyzing past appointment data, tracking patient attendance, and assessing scheduling efficiency.

CREATE VIEW historyAppts AS
SELECT
    a.AppointmentID,
    a.PatientID,
    p.FirstName || ' ' || p.LastName AS patientFullName,
    a.DoctorID,
    d.FirstName || ' ' || d.LastName AS doctorFullName,
    a.AppointmentDate,
    a.StartTime,
    a.EndTime
FROM
    Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Doctor d ON a.DoctorID = d.DoctorID
WHERE
    a.AppointmentDate < CURRENT_DATE
ORDER BY a.AppointmentDate;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View 3: Contaminated_medicine
--This view provides a list of patients prescribed a particular medicine. 
--If a medicine is reported as contaminated, this view aids in quickly identifying which patients may have been exposed to contaminated medicines 
--and their exposure period so that medical staff can arrange testing and treatment. 
--In this example, we assume medicine 235823457 Cephalexin is contaminated.

CREATE VIEW Contaminated_medicine AS
SELECT
    m.MedicineName AS "Medicine Name",
    p.PatientID AS "Patient ID",
    p.FirstName || ' ' || p.LastName AS "Patient Full Name",
    pr.StartDate AS "Start Date",
    pr.EndDate AS "End Date"
FROM
    Medicines m
JOIN Prescription pr ON m.MedicineID = pr.MedicineID
JOIN Patient p ON pr.PatientID = p.PatientID
WHERE m.MedicineID = 235823457
ORDER BY "Start Date";

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View 4: Allergy_audit
--This view provides a list of prescriptions that may cause allergies to patients.
--It ensures patient safety by identifying potential allergic reactions to prescribed medicines and eliminating manual errors in decision-making. 
--This is an audit step before officially issuing a prescription, thus the end date is not required. 
--In this example, four prescriptions are made to patients with allergies to medicine. Two of them are safely prescribed 
--and another two are prescribed antibiotics which are dangerous to them.

CREATE VIEW Allergy_audit AS
SELECT
pr.PrescriptionID AS "Prescription ID",
pr.StartDate AS "Prescription Start Date",
p.PatientID AS "Patient ID",
p.FirstName || ' ' || p.LastName AS "Patient Full Name",
m.MedicineName AS "Medicine Name",
a.AllergyName AS "Allergy Name"
FROM
    Patient p
JOIN PatientAllergy pa ON p.patientid = pa.patientid
JOIN Allergy a ON pa.allergyid = a.allergyid
JOIN MedicineProhibition mp ON a.allergyid = mp.allergyid
JOIN Prescription pr ON p.patientid = pr.patientid
JOIN Medicines m ON pr.medicineid = m.medicineid
WHERE mp.medicineid = m.medicineid;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View 5: checkAvailabiity
--Check which types of surgery can be started immediately based on the availability of surgery rooms. 
--This will give a clear understanding of which rooms are not occupied and may start surgery immediately. 

CREATE VIEW checkAvailability AS
SELECT
   r.roomNumber AS "Surgery Room Number",
   t.surgeryType AS "Surgery Type",
   r.roomStatus AS "Room Status"
FROM
   room r
JOIN
   surgeryRoom sr ON r.roomNumber = sr.roomNumber
JOIN
   surgeryType t ON sr.surgeryTypeID = t.surgeryTypeID
WHERE roomStatus = 'INACTIVE';
   
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View 6: Prescription_Abuse
--This view provides information on suspicious prescriptions. It shows prescriptions which patients and doctors did not have prior appointment before. 
--These irregularities require further investigation because some medicines are addictive. 
--In this example, morphine and cough syrup can be abused or sold in black market.

CREATE VIEW Prescription_Abuse AS
SELECT
    pr.prescriptionid AS "Suspicious prescription",
    d.FirstName || ' ' || d.LastName AS "Suspicious doctor",
    pr.doctorid AS "Doctor ID",
    p.FirstName || ' ' || p.LastName AS "Suspicious patient",
    pr.patientid AS "Patient ID",
    m.medicinename AS "Abused medicine",
    pr.startdate AS "Prescribed date"
FROM
    Prescription pr
INNER JOIN Patient p ON pr.patientid = p.patientid
INNER JOIN Doctor d ON pr.doctorid = d.doctorid
INNER JOIN Medicines m ON pr.medicineid = m.medicineid
LEFT JOIN Appointment a ON pr.patientid = a.patientid AND pr.startdate = a.appointmentdate AND pr.doctorid = a.doctorid
WHERE pr.prescriptionid IS NOT NULL AND a.appointmentid IS NULL
ORDER BY pr.patientid;
