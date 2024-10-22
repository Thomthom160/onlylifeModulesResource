INSERT INTO
    `jobs` (name, label)
VALUES
    ('cdj', "Cartel de Tijuana");

INSERT INTO
    `job_grades` (job_name, grade, name, label, salary)
VALUES
    ('cdj', 0, '0', 'Pequeno', 0),
    ('cdj', 1, '1', 'Soldado', 0),
    ('cdj', 2, '2', 'Capo', 0),
    ('cdj', 3, '3', 'Commandante', 0),
    ('cdj', 4, 'boss', 'Segundo', 0),
    ('cdj', 5, 'boss', 'Don', 0)
;

INSERT INTO `buisness` (`job`) VALUES ('cdj');
select * from `job_grades` where `job_name` = 'cdj';

