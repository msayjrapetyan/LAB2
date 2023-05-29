implement main
    open core, file, stdio

domains
    name = string
    date = string
    time = string
    diagnosis = string

predicates
    patient(name, date, diagnosis)
    doctor(name, date, time)
    appointment(doctor_name, patient_name, date, time)

clauses
    % Каких врачей прошёл пациент за указанный день?
    patient_visits_doctors(PatientName, Date, DoctorNames) :-
    findall(DoctorName, appointment(DoctorName, PatientName, Date, _), DoctorNames).

    % Диагнозы пациента за все время
    patient_diagnoses(PatientName, Diagnoses) :-
    findall(Diagnosis, patient(PatientName, _, Diagnosis), Diagnoses).

    % Количество записей на приемы за месяц
    appointments_count_month(DoctorName, Month, Count) :-
    findall(Date, (appointment(DoctorName, _, Date, _), substring(Date, 4, 2, M), int::fromString(M, Month)), Dates),
    length(Dates, Count).

    % Среднее количество пациентов на прием за день
    appointments_average_day(DoctorName, Average) :-
    findall(Date, appointment(DoctorName, _, Date, _), Dates),
    list_to_set(Dates, UniqueDates),
    length(UniqueDates, DatesCount),
    appointments_count_month(DoctorName, Month, Count),
    Average is Count / DatesCount.

end implement main

goal
    onsole::run(main::run).
