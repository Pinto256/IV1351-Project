--Selects rows to be copied from the main database to the lesson_record entity in the historical database
SELECT date, level, type,
	CASE 
		WHEN type = 'individual' THEN 
			CASE
				WHEN level = 'beginner' THEN (SELECT individual_lesson_beginner FROM pricing_scheme WHERE pricing_scheme_id = 1)
				WHEN level = 'intermediate' THEN (SELECT individual_lesson_intermediate FROM pricing_scheme WHERE pricing_scheme_id = 1)
				WHEN level = 'advanced' THEN (SELECT individual_lesson_advanced FROM pricing_scheme WHERE pricing_scheme_id = 1)
			END
		WHEN type = 'group' THEN 
			CASE
				WHEN level = 'beginner' THEN (SELECT group_lesson_beginner FROM pricing_scheme WHERE pricing_scheme_id = 1)
				WHEN level = 'intermediate' THEN (SELECT group_lesson_intermediate FROM pricing_scheme WHERE pricing_scheme_id = 1)
				WHEN level = 'advanced' THEN (SELECT group_lesson_advanced FROM pricing_scheme WHERE pricing_scheme_id = 1)
			END
		WHEN type = 'ensemble' THEN (SELECT ensemble FROM pricing_scheme WHERE pricing_scheme_id = 1)
	END price 
FROM lesson_record, pricing_scheme;

--Selects rows to be copied from the main database to the student_lesson_record entity in the historical database
SELECT * FROM student_lesson_record;

--Selects rows to be copied from the main database to the student entity in the historical database
SELECT * FROM student;

--Selects rows to be copied from the main database to the discount entity in the historical database
SELECT * FROM discount;