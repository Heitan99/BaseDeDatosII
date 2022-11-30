create database defenzahito4;
use defenzahito4;

create table departamento(
    id_dep int primary key,
    nombre varchar(50)
);
create table provincia(
    id_prov int primary key,
    nombre varchar(50) not null ,
    id_dep int,
    foreign key (id_dep) references departamento(id_dep)
);
create table detalle_proyecto(
    id_dp int primary key,
    id_per int,
    id_proy int,
    foreign key (id_proy) references proyecto(id_proy),
    foreign key (id_per) references persona(id_per)
);
create table proyecto(
    id_proy int primary key,
    nombreproy varchar(100),
    tipoproy varchar(30)
);
create table persona(
    id_per int primary key,
    nombre varchar(20),
    apellidos varchar(50),
    fecha_nac date,
    edad int(11),
    email varchar(50),
    id_dep int,
    id_prov int,
    sexo char(1),
    foreign key (id_dep) references departamento(id_dep),
    foreign key (id_prov) references provincia(id_prov)
);

insert into departamento(id_dep,nombre)
values (1,'El Alto'),(2,'Tarija');

insert into provincia(id_prov, nombre, id_dep)
values (1,'ingavi',1),(2,'viacha',2);

insert into proyecto(id_proy, nombreproy, tipoproy)
values (1,1,'proyecto 1'),(2,2,'proyecto 2');

insert into persona(id_per, nombre, apellidos, fecha_nac, edad, email, id_dep, id_prov, sexo)
values (1,'Luis','Gomez',1990-10-09,30,'luis@gmail.com',1,1,'M'),(2,'Maria','angeles',2000-05-02,50,'maria@gmail.com',25,2,'F');

insert into detalle_proyecto(id_dp, id_per, id_proy)
values (1,1,1),(2,2,2);

create table audit_proyectos(
    nombre_proy_anterior varchar(30),
    nombre_proy_posterior varchar(30),
    tipo_proy_anterior varchar(30),
    tipo_proy_posterior varchar(30),
    operation varchar(30),
    userl varchar(30),
    hostname varchar(30)
);

create trigger cambio
    before  update on proyecto
    for each row
    begin
        insert into audit_proyectos values (old.nombreproy,new.nombreproy,old.tipoproy,new.tipoproy,'update',@@hostname,'localhost');
    end;
