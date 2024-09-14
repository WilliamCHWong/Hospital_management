# Hospital Management System - SQL Database

## Project Summary

The **Hospital Management System** is an SQL-based database system designed to improve the efficiency of hospital operations by managing various essential components, including:
- Patient information
- Appointments
- Prescriptions
- Doctor information
- Room availability

This database system helps minimize errors and delays, ensuring the hospital runs smoothly and provides faster, more professional services. By utilizing the data stored in the database, the system generates useful insights for decision-making and monitoring, leading to an improved overall hospital experience.

## Business Rules

### Appointments & Doctors
- Each appointment is scheduled with **one doctor** (1:1).
- A doctor can have **multiple appointments** (1:M).

### Doctors & Prescriptions
- A doctor can create **multiple prescriptions** (1:M).
- Each prescription is created by **one doctor** (1:1).

### Prescriptions & Medicine
- Each prescription includes **one medicine** (1:1).
- A medicine can be included in **multiple prescriptions** (1:M).

### Prescriptions & Patients
- Each prescription is assigned to **one patient** (1:1).
- A patient can have **multiple prescriptions** (1:M).

### Medicine & Allergies
- Each medicine can cause **multiple allergies** (1:M) *(Bridge Table Required)*.
- Each allergy may be caused by **multiple medicines** (1:M) *(Bridge Table Required)*.

### Allergies & Patients
- Each allergy can affect **many patients** (1:M) *(Bridge Table Required)*.
- A patient can have **multiple allergies** (1:M) *(Bridge Table Required)*.

### Appointments & Patients
- Each appointment is for **one patient** (1:1).
- A patient can have **multiple appointments** (1:M).

### Appointments & Rooms
- Each appointment is assigned to **one room** (1:1).
- A room can host **multiple appointments** (1:M).

### Rooms & Surgery Types
- Each room can host **multiple surgery types** (1:M) *(Bridge Table Required)*.
- Each surgery type can take place in **multiple rooms** (1:M) *(Bridge Table Required)*.

### Surgery Types & Appointments
- Each appointment is scheduled for a **specific surgery type** (1:1).
- A surgery type can be scheduled for **multiple appointments** (1:M).

## Key Features

The Hospital Management System includes the following core functionalities:
1. **Patient Management**: Store and manage patient records, including personal information, prescriptions, allergies, and appointment history.
2. **Doctor Management**: Track doctors’ availability, appointments, and the prescriptions they provide.
3. **Appointment Scheduling**: Manage patient appointments, assign rooms, and track schedules with integrated surgery types.
4. **Prescription Management**: Facilitate doctor-generated prescriptions and track prescribed medicines.
5. **Room & Surgery Management**: Assign rooms to surgeries, and keep track of available surgery types in each room.

## Conclusion

This SQL-based hospital management system enhances healthcare operations by streamlining patient, doctor, and room management. It reduces errors and delays in handling vital data, ultimately improving the efficiency and quality of services provided throughout the hospital.
