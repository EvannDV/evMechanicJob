INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mechanic', 'mechanic', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mechanic', 'mechanic', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_mechanic', 'mechanic', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mechanic', 'mechanic')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mechanic',0,'recrue','Recrue',12,'{}','{}'),
	('mechanic',1,'medium',"Medium",24,'{}','{}'),
	('mechanic',2,'ce','chef Equipe',36,'{}','{}'),
	('mechanic',3,'boss',"Patron",48,'{}','{}')
;

INSERT INTO `items` (name, label) VALUES 
    ('carokit', 'Kit carosserie'),
	('fixkit', 'Kit réparation')
;