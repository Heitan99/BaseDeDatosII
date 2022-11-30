create database tareaHito4;
use tareaHito4;

create table departamento
(
    id_dep    int auto_increment primary key not null ,
    nombres   varchar(50)
);

create table provincia
(
    id_prov   int auto_increment primary key,
    nombres   varchar(50),
    id_dep    int not null,
    foreign key (id_dep) references departamento (id_dep)
);

create table persona(

    id_per int auto_increment primary key not null,
    id_dep int not null,
    id_prov int not null,
    nombres varchar(50),
    apellidos varchar(50),
    fecha_nac date,
    edad int,
    genero varchar(50),
    email varchar(50),
    foreign key (id_dep) references provincia (id_dep),
    foreign key (id_prov) references provincia (id_prov)
);

create table proyecto(

    id_proy   int auto_increment primary key not null,
    nombreProy varchar(100),
    tipoProy varchar(50)
);

create table detalle_proyecto
(
    id_detProy   int auto_increment primary key not null,
    id_per int not null,
    id_proy int not null,
    foreign key (id_per) references persona (id_per),
    foreign key (id_proy) references proyecto (id_proy)
);


INSERT INTO departamento (nombres)
VALUES  ('La Paz'),
        ('El Alto'),
        ('Santa Cruz'),
        ('Cochabamba');


INSERT INTO provincia (nombres, id_dep)
VALUES  ('Inquisivi',1),
        ('Laja',2),
        ('Caranavi',3),
        ('Ingavi',4);

INSERT INTO persona (id_dep, id_prov, nombres, apellidos, fecha_nac, edad, genero, email)
VALUES  (1, 1, 'Juan', 'Perez ', '1990-01-01', 30, 'Masculino', 'juan@gmail.com'),
        (2, 2, 'Maria', 'Ramirez ', '2000-10-10', 30, 'Femenino', 'maria@gmail.com'),
        (2, 2, 'Maria', 'Luz ', '1990-01-01', 30, 'Femenino', 'maria@gmail.com'),
        (3, 3, 'Pedro', 'Gomez ', '1990-01-01', 30, 'Masculino', 'pedro@gmail.com');



INSERT INTO proyecto (nombreProy, tipoProy)
VALUES ('Proyecto 1', 'Tipo 1'),
        ('Proyecto 2', 'Tipo 2'),
        ('Proyecto 3', 'Tipo 3'),
        ('Proyecto 4', 'Tipo 4');


INSERT INTO detalle_proyecto (id_per, id_proy)
VALUES  (1, 1),
        (2, 2),
        (3, 3),
        (4, 4);


#10.Crear una función que sume los valores de la serie Fibonacci.
#○ El objetivo es sumar todos los números de la serie fibonacci desde una
#cadena.
#○ Es decir usted tendrá solo la cadena generada con los primeros N números
#de la serie fibonacci y a partir de ellos deberá sumar los números de esa
#serie.
#○ Ejemplo: suma_serie_fibonacci(mi_metodo_que_retorna_la_serie(10))
#■ Note que previamente deberá crear una función que retorne una
#cadena con la serie fibonacci hasta un cierto valor.
#1. Ejemplo: 0,1,1,2,3,5,8,.......
#■ Luego esta función se deberá pasar como parámetro a la función que
#suma todos los valores de esa serie generada.

CREATE OR REPLACE FUNCTION serie_Fibonacci (n INT)
RETURNS VARCHAR(255)
BEGIN
DECLARE serie VARCHAR(255);
DECLARE n1 INT;
DECLARE n2 INT;
DECLARE n3 INT;

SET n1 = 0;
SET n2 = 1;
SET serie = CONCAT(n1, ',', n2);

WHILE n > 2 DO
  SET n3 = n1 + n2;
  SET serie = CONCAT(serie, ',', n3);
  SET n1 = n2;
  SET n2 = n3;
  SET n = n - 1;
END WHILE;

RETURN serie;
END;

select serie_Fibonacci(10);


#Funcion que suma los valores de la serie fibonacci

CREATE OR REPLACE FUNCTION suma_serie_fibonacci (serie VARCHAR(255))
RETURNS INT
BEGIN
DECLARE total INT DEFAULT 0;
DECLARE n INT DEFAULT 0;

WHILE LENGTH(serie) > 0 DO
  SET n = SUBSTRING_INDEX(serie, ',', 1);
  SET serie = SUBSTRING(serie, LENGTH(n) + 2);
  SET total = total + n;
END WHILE;

RETURN total;
END;

SELECT  suma_serie_fibonacci(serie_fibonacci(10));

#11.Manejo de vistas.
#○ Crear una consulta SQL para lo siguiente.
#■ La consulta de la vista debe reflejar como campos:
#1. nombres y apellidos concatenados
#2. la edad
#3. fecha de nacimiento.
#4. Nombre del proyecto
#○ Obtener todas las personas del sexo femenino que hayan nacido en el
#departamento de El Alto en donde la fecha de nacimiento sea:
#1. fecha_nac = '2000-10-10


CREATE OR REPLACE VIEW persona_view AS
SELECT CONCAT(p.nombres, ' ', p.apellidos) AS nombres, p.edad, p.fecha_nac, pr.nombreProy
FROM persona p
INNER JOIN detalle_proyecto dp ON p.id_per = dp.id_per
INNER JOIN proyecto pr ON dp.id_proy = pr.id_proy
WHERE p.genero = 'Femenino' AND p.id_dep = 2 AND p.fecha_nac = '2000-10-10';

SELECT * FROM persona_view;

#12.Manejo de TRIGGERS I.
#○ Crear TRIGGERS Before or After para INSERT y UPDATE aplicado a la tabla
#PROYECTO
#■ Debera de crear 2 triggers minimamente.
#○ Agregar un nuevo campo a la tabla PROYECTO.
#■ El campo debe llamarse ESTADO
#6
#○ Actualmente solo se tiene habilitados ciertos tipos de proyectos.
#■ EDUCACION, FORESTACION y CULTURA
#○ Si al hacer insert o update en el campo tipoProy llega los valores
#EDUCACION, FORESTACIÓN o CULTURA, en el campo ESTADO colocar el valor
#ACTIVO. Sin embargo se llegat un tipo de proyecto distinto colocar
#INACTIVO

ALTER TABLE proyecto ADD (ESTADO VARCHAR(30));

INSERT INTO proyecto(nombreProy, tipoProy)
VALUES ('Proyecto 5', 'EDUCACION'),
        ('Proyecto 6', 'FORESTACION'),
        ('Proyecto 7', 'CULTURA');


CREATE OR REPLACE TRIGGER update_proyecto
BEFORE UPDATE ON proyecto
FOR EACH ROW
    BEGIN
        IF  NEW.tipoProy='EDUCACION'OR  NEW.tipoProy ='FORESTACION' OR  NEW.tipoProy= 'CULTURA'
            THEN SET NEW.ESTADO='ACTIVO';
        ELSE
            SET NEW.ESTADO='INACTIVO';
        END IF;
    END;

CREATE OR REPLACE TRIGGER insert_proyecto
BEFORE  INSERT ON proyecto
FOR EACH ROW
    BEGIN
        IF  NEW.tipoProy='EDUCACION'OR  NEW.tipoProy ='FORESTACION' OR  NEW.tipoProy= 'CULTURA'
            THEN SET NEW.ESTADO='ACTIVO';
        ELSE
            SET NEW.ESTADO='INACTIVO';
        END IF;
    end;

INSERT INTO proyecto(nombreProy, tipoProy)
VALUES ('Proyecto 8','EDUCACION');
SELECT * FROM proyecto;


#13.Manejo de Triggers II.
#○ El trigger debe de llamarse calculaEdad.
#○ El evento debe de ejecutarse en un BEFORE INSERT.
#○ Cada vez que se inserta un registro en la tabla PERSONA, el trigger debe de
#calcular la edad en función a la fecha de nacimiento.
#○ Adjuntar el código SQL generado y una imagen de su correcto
#funcionamiento.

CREATE OR REPLACE TRIGGER calculaEdad
BEFORE INSERT ON persona
FOR EACH ROW
BEGIN
    SET NEW.edad = YEAR(CURDATE()) - YEAR(NEW.fecha_nac); #CURDATE() devuelve la fecha actual
END;

INSERT INTO persona(id_dep,id_prov,nombres, apellidos,fecha_nac,genero,email)
VALUES (1,1,'Roberto', 'Aguirrez', '1990-10-10','Masculino','roberto@gmail.com');

SELECT * FROM persona;

#14.Manejo de TRIGGERS III.
#○ Crear otra tabla con los mismos campos de la tabla persona(Excepto el
#primary key id_per).
#■ No es necesario que tenga PRIMARY KEY.
#○ Cada vez que se haga un INSERT a la tabla persona estos mismos valores
#deben insertarse a la tabla copia.
#○ Para resolver esto deberá de crear un trigger before insert para la tabla
#PERSONA.
#○ Adjuntar el código SQL generado y una imagen de su correcto
#funcionamiento.

CREATE TABLE persona_dos(

    id_dep INT,
    id_prov INT,
    nombres VARCHAR(30),
    apellidos VARCHAR(30),
    fecha_nac DATE,
    edad INT,
    genero VARCHAR(30),
    email VARCHAR(30),
    foreign key (id_dep) references departamento(id_dep),
    foreign key (id_prov) references provincia(id_prov)
);

CREATE OR REPLACE TRIGGER insert_persona_dos
BEFORE INSERT ON persona
FOR EACH ROW
BEGIN
    INSERT INTO persona_dos(id_dep,id_prov,nombres,apellidos,fecha_nac,edad,genero,email)
    VALUES (NEW.id_dep,NEW.id_prov,NEW.nombres,NEW.apellidos,NEW.fecha_nac,NEW.edad,NEW.genero,NEW.email); # NEW. es para acceder a los valores de la tabla persona
END;

INSERT INTO persona(id_dep,id_prov,nombres, apellidos,fecha_nac,edad,genero,email)
VALUES (1,1,'Tania', 'jimenez', '1995-02-11',20,'Femenino','tania@gmail.com');

SELECT * FROM persona_dos;


#15.Crear una consulta SQL que haga uso de todas las tablas
#○ La consulta generada convertirlo a VISTA

CREATE VIEW todas_las_tablas AS
SELECT CONCAT(
    persona.nombres, ' ', persona.apellidos) AS nombre_completo, #CONCAT() concatena los valores de las columnas
    persona.edad AS edad,
    dep.nombres AS departamento,
    prov.nombres AS provincia,
    CONCAT(proyecto.nombreProy, ' ', proyecto.tipoProy) AS proyecto

FROM persona
INNER JOIN departamento dep ON persona.id_dep = dep.id_dep
INNER JOIN provincia prov ON persona.id_prov = prov.id_prov
INNER JOIN detalle_proyecto ON persona.id_per = detalle_proyecto.id_proy
INNER JOIN proyecto ON detalle_proyecto.id_proy = proyecto.id_proy;

SELECT * FROM todas_las_tablas;

















