create database hito4;
use hito4;

create table users(
id_user int auto_increment primary key not null,
fullname varchar(50) not null,
lastname varchar(50) not null,
age int not null,
email varchar(100) not null
);

insert into users(fullname,lastname,age,email)
values  ('user1','UserLastName1',20,'user1@gmail.com'),
        ('user2','UserLastName2',30,'user2@gmail.com'),
        ('user3','UserLastName3',40,'user3@gmail.com'),
        ('user4','UserLastName4',50,'user4@gmail.com'),
        ('user5','UserLastName5',60,'user5@gmail.com');

insert into users(fullname, lastname, age, email) values ('user6','UserLastName6',70,'user6@gmail.com');
insert into users(fullname, lastname, age, email) values ('user7','UserLastName7',70,'user7@gmail.com');

#cuantos son mayores a 40 años
select count(*)
from users as us
where us.age>40;

#mostrar los usuarios mayores a 40 años
select us.*
from users as us
where us.age>40;

#trigger
#un trigger se ejecuta de manera automatica
#cuando ocurre los seguientes eventos:
#INSERT, UPDATE, DELETE
#es decir cada vez que inserto o modifico o elimino el registro de una tabla
#ub trigger puede acceder a los datos de la tabla
#y lo hace atravez de los objetos NEW y OLD
#NEW: INSERT        representa los datos que se van a insertar o modificar
#OLD: DELETE        representa los datos que se van a eliminar
#NEW Y OLD =UPDATE

#cada que se inserte un registro en la tabla usuarios debe tener una contraseña por defecto "pass-123";

alter table users add password varchar(50);

create trigger genera_password
before insert on users
for each row                            #es estructura del codigo
begin
    set new.password= 'pass-123';
end;

insert into users(fullname, lastname, age, email) values ('user9','UserLastName8',80,'user9@gmail.com');
select * from users;

#crear un trigger que cada vez que se inserte un registro en la tabla usuarios este debe
#tener una contraseña por defecto de las dos palabras del nombre, apellido, edad
create or replace trigger genera_password2
before insert on users
for each row                    #es estructura del codigo
begin
    set new.password= concat(substring(new.fullname,1,2), substring(new.lastname,1,2), substring(new.age,1,2));
end;

insert into users(fullname, lastname, age, email) values ('user10','UserLastName8',80,'user9@gmail.com');

create table numeros(
    numero bigint primary key not null,     #primary key
    cuadrado bigint,
    cubo bigint,
    raiz_cuadrada real
);

#crear un trigger que cada vez que se inserte un registro en la tabla numeros
#este debe tener el cuadrado, cubo y raiz cuadrada del numero
create or replace trigger calcular
before insert on numeros
for each row
begin
    set new.cuadrado=new.numero*new.numero;
    set new.cubo=pow(new.numero,3);
    set new.raiz_cuadrada=sqrt(new.numero);
end;

insert into numeros(numero) values (2);

select * from numeros;
