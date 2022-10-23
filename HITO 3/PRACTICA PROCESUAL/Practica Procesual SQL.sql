
/** 5 **/
CREATE FUNCTION sumadosvariables(a INT, b INT)
RETURNS int
begin
declare numero INTEGER default 0;
Set numero =a+b;
Return numero;
end;

CREATE OR REPLACE FUNCTION sumadosvariables(a INT, b INT)
RETURNS int
begin
declare numero INTEGER default 0;
Set numero =a+b;
Return numero;
end;

DROP FUNCTION sumadosvariables;

/** 6 **/
create or replace function concat_cadenas(a varchar(50), b varchar(50),c varchar(50))
returns varchar(50)
begin
declare CADENA varchar(50) default '';
set CADENA= CONCAT(a,' ',b,' ',c);
return CADENA;
end;

select concat_cadenas('demonios','gump','eres realmente un genio');

/** 7 **/
create or replace function substring_cadena(nombre varchar(50), posicion varchar(50),longitud varchar(50))
returns varchar(50)
begin
declare cadena varchar(50) default '';
set cadena= substring(nombre,posicion,longitud);
return cadena;
end;

select concat_cadenas();

/** 8 **/
create or replace function comparar_cadenas (a varchar(50), b varchar(50),c varchar(50))
returns varchar(50)
begin
declare respuesta varchar(50) default '';
if strcmp (a,b)=0 then set respuesta ='dos cadenas son iguales';
elseif strcmp(a,c)=0 then set respuesta ='dos cadenas son iguales';
elseif strcmp(b,c)=0 then set respuesta ='dos cadenas son iguales';
else
set respuesta= 'ninguna es igual';
end if ;
return respuesta;
end;

select comparar_cadenas('salar de uyuni','litio para elon musk','salar de uyuni');

/** 9 **/
create or replace function Clength_cadena(a varchar(50))
RETURNS integer
begin
declare respuesta varchar (50) default '';
Set respuesta=char_length(a);
Return respuesta;
end;

select Clength_cadena('Maravilloso');


create or replace function locate_cadenas(lcatecadena varchar(50), cadena varchar(50))
returns integer
begin
declare resp varchar(50) default '';
set resp= locate(cadena,lcatecadena);
return resp;
end;

select locate_cadenas('darksiders','siders');



CREATE DATABASE DEFENSA_HITO3 ;
USE DEFENSA_HITO3;

create table estudiantes
(
    id_est    int auto_increment primary key not null,
    nombres   varchar(50),
    apellidos varchar(50),
    edad      int(11),
    gestion   int(11),
    fono      int(11),
    email     varchar(100),
    direccion varchar(100),
    sexo      varchar(10)
);
create table materias
(
    id_mat     int auto_increment primary key not null,
    nombre_mat varchar(100),
    cod_mat    varchar(100)
);

create table inscripcion
(
    id_ins   int auto_increment primary key not null,
    semestre varchar(20),
    gestion  int(11),

    id_est   int                            not null,
    id_mat   int                            not null,

    foreign key (id_est) references estudiantes (id_est),
    foreign key (id_mat) references materias (id_mat)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
VALUES ('Miguel', 'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
       ('Sandra', 'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino'),
       ('Joel', 'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
       ('Andrea', 'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
       ('Santos', 'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura', 'ARQ-101'),
       ('Urbanismo y Diseno', 'ARQ-102'),
       ('Dibujo y Pintura Arquitectonico', 'ARQ-103'),
       ('Matematica discreta', 'ARQ-104'),
       ('Fisica Basica', 'ARQ-105');

INSERT INTO inscripcion (semestre, gestion, id_est, id_mat)
values ('1er Semestre', 2018, 1, 1),
       ('2do Semestre', 2018, 1, 2),
       ('1er Semestre', 2019, 2, 4),
       ('2do Semestre', 2019, 2, 3),
       ('2do Semestre', 2020, 3, 3),
       ('3er Semestre', 2020, 3, 1),
       ('4to Semestre', 2021, 4, 4),
       ('5to Semestre', 2021, 5, 5);

/*12.Crear una función que genere la serie Fibonacci.
 La función recibe un límite(number)
 La función debe de retornar una cadena.
 Ejemplo para n=7. OUTPUT: 0, 1, 1, 2, 3, 5, 8,
 Adjuntar el código SQL generado y una imagen de su correcto funcionamiento.*/

CREATE OR REPLACE FUNCTION fibonacci(limite INT)
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE fibo1 INT DEFAULT 0;
    DECLARE fibo2 INT DEFAULT 1;
    DECLARE fibo3 INT DEFAULT 0;
    DECLARE str VARCHAR(255) DEFAULT '0,1,';

    IF limite = 1 THEN
        RETURN fibo1;
    ELSEIF limite = 2 THEN
        RETURN CONCAT(fibo1, fibo2);
    ELSE
        WHILE limite > 2 DO
            SET fibo3 = fibo1 + fibo2;
            SET fibo1 = fibo2;
            SET fibo2 = fibo3;
            SET limite = limite - 1;
            SET str = CONCAT(str, fibo3,',');
        END WHILE;
        RETURN str;
    END IF;
END;

select fibonacci(7);

/*13.Crear una variable global a nivel BASE DE DATOS.
 Crear una función cualquiera.
 La función debe retornar la variable global.
 Adjuntar el código SQL generado y una imagen de su correcto funcionamiento.*/

set @limit=7;
CREATE OR REPLACE FUNCTION fibonacci1()
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE fib1 INT DEFAULT 0;
    DECLARE fib2 INT DEFAULT 1;
    DECLARE fib3 INT DEFAULT 0;
    DECLARE str VARCHAR(255) DEFAULT '0,1,';

    IF @limit = 1 THEN
        RETURN fib1;
    ELSEIF @limit = 2 THEN
        RETURN CONCAT(fib1, fib2);
    ELSE
        WHILE @limit > 2 DO
            SET fib3 = fib1 + fib2;
            SET fib1 = fib2;
            SET fib2 = fib3;
            SET @limit = @limit - 1;
            SET str = CONCAT(str, fib3,',');
        END WHILE;
        RETURN str;
    END IF;
END;

select fibonacci1();

/* 14.Crear una función no recibe parámetros (Utilizar WHILE, REPEAT o LOOP).
 Previamente deberá de crear una función que obtenga la edad mínima de los estudiantes
 la función no recibe ningún parámetro.
 La función debe de retornar un número.(LA EDAD MÍNIMA)
 Si la edad mínima es PAR mostrar todos los pares empezando desde 0 a este
 ese valor de la edad mínima.
 Si la edad mínima es IMPAR mostrar descendentemente todos los impares
 hasta el valor 0.*/

create or replace function edadMinima2()
returns text
begin
    declare respuesta text default '';
    declare limite int;
    declare x int default 1;
    select min(est.edad) into limite
    from estudiantes as est;

   if limite %2=0
       then
       set x=2;
    end if;
    while x<=limite do
           set respuesta= concat(respuesta,x,',');
           set x=x+2;
       end while;
    return respuesta;
   END;

select edadMinima2();


/* 15.Crear una función que determina cuantas veces se repite las vocales.
 La función recibe una cadena y retorna un TEXT.
 Retornar todas las vocales ordenadas e indicando la cantidad de veces que
 se repite en la cadena. */

create or replace function vowel_count111(str varchar(1024))
returns text
begin
    return  concat(
       concat (' a: ', (LENGTH(str) - LENGTH(REPLACE(str, 'a', '')))/LENGTH('a')),
       concat (' e: ', (LENGTH(str) - LENGTH(REPLACE(str, 'e', '')))/LENGTH('e')),
       concat (' i: ', (LENGTH(str) - LENGTH(REPLACE(str, 'i', '')))/LENGTH('i')),
       concat (' o: ', (LENGTH(str) - LENGTH(REPLACE(str, 'o', '')))/LENGTH('o')),
       concat (' u: ', (LENGTH(str) - LENGTH(REPLACE(str, 'u', '')))/LENGTH('u'))
     );
end;

select vowel_count111('trivialidades');

/*16.Crear una función que recibe un parámetro INTEGER.
○ La función debe de retornar un texto(TEXT) como respuesta.
○ El parámetro es un valor numérico credit_number.
○ Si es mayor a 50000 es PLATINIUM.
○ Si es mayor igual a 10000 y menor igual a 50000 es GOLD.
○ Si es menor a 10000 es SILVER
○ La función debe retornar indicando si ese cliente es PLATINUM, GOLD o
SILVER en base al valor del credit_number.
*/

create or replace function funcion_credito( CREDIT_NUMBER INTEGER)
returns text
begin
declare RESPUESTA text default '';
case
when CREDIT_NUMBER>=50000 then set RESPUESTA='PLATINUM';
when CREDIT_NUMBER>=10000 and CREDIT_NUMBER<50000 then set RESPUESTA='GOLD';
when CREDIT_NUMBER<10000 then set RESPUESTA ='SILVER';
else set RESPUESTA='NO PERTENCE A NINGUNA CLASE';
end case ;
return RESPUESTA;
end;

select funcion_credito(10500);

/* 17.Crear una función que reciba un parámetro TEXT
 En donde este parámetro deberá de recibir una cadena cualquiera y retorna
 un TEXT de respuesta.
 Concatenar N veces la misma cadena reduciendo en uno en cada iteración
 hasta llegar a una sola letra.
 Utilizar REPEAT y retornar la nueva cadena concatenada.*/

create or replace function disminuir_Cadena (CADENA TEXT)
returns text
begin
declare RESPUESTA text default '';
declare CONTADOR integer default CHAR_LENGTH(CADENA);
declare dis_cad integer default 1;
declare dis_cad2 integer default CHAR_LENGTH(CADENA);
repeat
set RESPUESTA= CONCAT(RESPUESTA,',',SUBSTRING(CADENA,dis_cad,dis_cad2));
set CONTADOR=CONTADOR-1;
set dis_cad=dis_cad+1;
until CONTADOR <=0 end repeat;
return RESPUESTA;
end;

select disminuir_Cadena('DBAII');


