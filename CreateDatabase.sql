CREATE TABLE instructor (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_number VARCHAR(256) NOT NULL,
 name VARCHAR(256) NOT NULL,
 age INT NOT NULL,
 email VARCHAR(256) NOT NULL,
 phone_number VARCHAR(15) NOT NULL,
 city VARCHAR(256) NOT NULL,
 zip VARCHAR(256) NOT NULL,
 street VARCHAR(256) NOT NULL,
 street_number INT NOT NULL,
 apartment_number INT
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instrument (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 type VARCHAR(256) NOT NULL,
 brand VARCHAR(256),
 price INT,
 is_being_rented INT NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE parent (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 email VARCHAR(256) NOT NULL,
 phone_number VARCHAR(15) NOT NULL
);

ALTER TABLE parent ADD CONSTRAINT PK_parent PRIMARY KEY (id);


CREATE TABLE pricing_scheme (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 individual_lesson_beginner FLOAT(53) NOT NULL,
 individual_lesson_intermediate FLOAT(53) NOT NULL,
 individual_lesson_advanced FLOAT(53) NOT NULL,
 group_lesson_beginner FLOAT(53) NOT NULL,
 group_lesson_intermediate FLOAT(53) NOT NULL,
 group_lesson_advanced FLOAT(53) NOT NULL,
 ensemble FLOAT(53) NOT NULL
);

ALTER TABLE pricing_scheme ADD CONSTRAINT PK_pricing_scheme PRIMARY KEY (id);


CREATE TABLE student (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_number VARCHAR(256) NOT NULL,
 name VARCHAR(256) NOT NULL,
 age INT NOT NULL,
 instrument_quota INT NOT NULL,
 family_id INT NOT NULL,
 email VARCHAR(256) NOT NULL,
 phone_number VARCHAR(15) NOT NULL,
 city VARCHAR(256) NOT NULL,
 zip VARCHAR(256) NOT NULL,
 street VARCHAR(256) NOT NULL,
 street_number INT NOT NULL,
 apartment_number INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE student_can_play_instrument (
 student_id INT NOT NULL,
 instrumant_id INT NOT NULL,
 skill VARCHAR(256) NOT NULL
);

ALTER TABLE student_can_play_instrument ADD CONSTRAINT PK_student_can_play_instrument PRIMARY KEY (student_id,instrumant_id);


CREATE TABLE student_parent (
 student_id INT NOT NULL,
 parent_id INT NOT NULL
);

ALTER TABLE student_parent ADD CONSTRAINT PK_student_parent PRIMARY KEY (student_id,parent_id);


CREATE TABLE time_slot (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 time TIME(6) NOT NULL
);

ALTER TABLE time_slot ADD CONSTRAINT PK_time_slot PRIMARY KEY (id);


CREATE TABLE discount (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 percent_discount FLOAT(53) NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE discount ADD CONSTRAINT PK_discount PRIMARY KEY (id);


CREATE TABLE ensemble (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 maximum_number_of_students INT NOT NULL,
 minimum_number_of_students INT NOT NULL,
 genre VARCHAR(256),
 instructor_id INT NOT NULL,
 date DATE NOT NULL,
 time TIME(6) NOT NULL
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (id);


CREATE TABLE group_lesson (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 number_of_places INT NOT NULL,
 number_of_students_enrolled INT,
 minimum_number_of_students INT NOT NULL,
 instructor_id INT NOT NULL,
 date DATE NOT NULL,
 time TIME(6) NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (id);


CREATE TABLE individual_lesson (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument VARCHAR(256),
 instructor_id INT NOT NULL,
 student_id INT NOT NULL,
 date DATE NOT NULL,
 time TIME(6) NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (id);


CREATE TABLE instructor_can_teach_instrument (
 instructor_id INT NOT NULL,
 instrumant_id INT NOT NULL
);

ALTER TABLE instructor_can_teach_instrument ADD CONSTRAINT PK_instructor_can_teach_instrument PRIMARY KEY (instructor_id,instrumant_id);


CREATE TABLE instructor_time_slot (
 instructor_id INT NOT NULL,
 time_slot_id INT NOT NULL
);

ALTER TABLE instructor_time_slot ADD CONSTRAINT PK_instructor_time_slot PRIMARY KEY (instructor_id,time_slot_id);


CREATE TABLE lesson_record (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 date DATE NOT NULL,
 level VARCHAR(256),
 type VARCHAR(256) NOT NULL,
 instructor_id INT NOT NULL,
 pricing_scheme_id INT NOT NULL
);

ALTER TABLE lesson_record ADD CONSTRAINT PK_lesson_record PRIMARY KEY (id);


CREATE TABLE renting_instruments (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 student_id INT NOT NULL,
 start_date DATE NOT NULL,
 termination_date DATE,
 instrument_id INT NOT NULL
);

ALTER TABLE renting_instruments ADD CONSTRAINT PK_renting_instruments PRIMARY KEY (id);


CREATE TABLE student_ensemble (
 student_id INT NOT NULL,
 ensemble_id INT NOT NULL
);

ALTER TABLE student_ensemble ADD CONSTRAINT PK_student_ensemble PRIMARY KEY (student_id,ensemble_id);


CREATE TABLE student_group_lesson (
 student_id INT NOT NULL,
 group_lesson_id INT NOT NULL
);

ALTER TABLE student_group_lesson ADD CONSTRAINT PK_student_group_lesson PRIMARY KEY (student_id,group_lesson_id);


CREATE TABLE student_lesson_record (
 student_id INT NOT NULL,
 lesson_record_id INT NOT NULL
);

ALTER TABLE student_lesson_record ADD CONSTRAINT PK_student_lesson_record PRIMARY KEY (student_id,lesson_record_id);


CREATE TABLE student_time_slot (
 time_slot_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_time_slot ADD CONSTRAINT PK_student_time_slot PRIMARY KEY (time_slot_id,student_id);


ALTER TABLE student_can_play_instrument ADD CONSTRAINT FK_student_can_play_instrument_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE student_can_play_instrument ADD CONSTRAINT FK_student_can_play_instrument_1 FOREIGN KEY (instrumant_id) REFERENCES instrument (id);


ALTER TABLE student_parent ADD CONSTRAINT FK_student_parent_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE student_parent ADD CONSTRAINT FK_student_parent_1 FOREIGN KEY (parent_id) REFERENCES parent (id);


ALTER TABLE discount ADD CONSTRAINT FK_discount_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE instructor_can_teach_instrument ADD CONSTRAINT FK_instructor_can_teach_instrument_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE instructor_can_teach_instrument ADD CONSTRAINT FK_instructor_can_teach_instrument_1 FOREIGN KEY (instrumant_id) REFERENCES instrument (id);


ALTER TABLE instructor_time_slot ADD CONSTRAINT FK_instructor_time_slot_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE instructor_time_slot ADD CONSTRAINT FK_instructor_time_slot_1 FOREIGN KEY (time_slot_id) REFERENCES time_slot (id);


ALTER TABLE lesson_record ADD CONSTRAINT FK_lesson_record_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);
ALTER TABLE lesson_record ADD CONSTRAINT FK_lesson_record_1 FOREIGN KEY (pricing_scheme_id) REFERENCES pricing_scheme (id);


ALTER TABLE renting_instruments ADD CONSTRAINT FK_renting_instruments_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE renting_instruments ADD CONSTRAINT FK_renting_instruments_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE student_ensemble ADD CONSTRAINT FK_student_ensemble_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE student_ensemble ADD CONSTRAINT FK_student_ensemble_1 FOREIGN KEY (ensemble_id) REFERENCES ensemble (id);


ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE student_group_lesson ADD CONSTRAINT FK_student_group_lesson_1 FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (id);


ALTER TABLE student_lesson_record ADD CONSTRAINT FK_student_lesson_record_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE student_lesson_record ADD CONSTRAINT FK_student_lesson_record_1 FOREIGN KEY (lesson_record_id) REFERENCES lesson_record (id);


ALTER TABLE student_time_slot ADD CONSTRAINT FK_student_time_slot_0 FOREIGN KEY (time_slot_id) REFERENCES time_slot (id);
ALTER TABLE student_time_slot ADD CONSTRAINT FK_student_time_slot_1 FOREIGN KEY (student_id) REFERENCES student (id);


