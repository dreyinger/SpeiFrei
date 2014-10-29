INSERT INTO USER (Email, Firstname, Surname, RegistrationDate, Gender)
VALUES ('vitzthum_m@gmx.at', 'Michael', 'Vitzthum', CURRENT_TIMESTAMP, 'm');
INSERT INTO USER (Email, Firstname, Surname, RegistrationDate, Birthday, Gender)
VALUES ('max_mustermann@web.de', 'Max', 'Mustermann', TO_TIMESTAMP('2014-07-02 06:14:00', 'YYYY-MM-DD HH24:MI:SS'), CURRENT_TIME, 'm');

INSERT INTO STUDIO (StudioID, Name, Headquarter)
VALUES (0, 'MaxStudio', 'MusterStadt');
INSERT INTO STUDIO (StudioID, Name, Headquarter)
VALUES (1, 'Universal', 'Los Angeles');

INSERT INTO DIRECTOR (PersID, Firstname, Surname, PlaceOfBirth, Birthdate, Gender)
VALUES (0, 'Michael', 'Bay', 'Los Angeles', CURRENT_DATE, 'm');


