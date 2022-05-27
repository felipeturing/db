
-- Consulta básica para crear una base de datos
create database botaren;
create database if not exists botaren;
CREATE DATABASE IF NOT EXISTS test;

-- Eliminar la base de datos
drop database botaren; 
drop database if exists botaren; 


USE test;

/*
    Creación de tablas
    CREATE TABLE table_name (<column_definitions>);

    La <column-definitions> tiene la siguiente sintaxis básica:
	    <column_name> <data_type>
		[not null | null]
		[default <default_value>]
		[auto_increment]
		[unique [key] | [primary] key]
		[comment '<string>']
*/

create table if not exists nombretabla(
    id int not null auto_increment primary key,
    nombre varchar(200) not null default 'nombre-default' unique comment 'algún comentario relevante',
    precio decimal(8,2) not null default 0.00 comment 'redondeado a dos decimales', 
    cumple date null comment 'la fecha de cumpleaños' default "1892-12-23"
)

create table if not exists tablagresiva(
    id int not null auto_increment primary key,
    sex enum('M', 'F', 'X') default 'X' comment 'somos inclusivos mi amigo xd'
)



-- Mostrar el comando usado para crear la tabla
show create table nombretabla;
describe <table_name> <column_name>;

/*
    Modificación de la configuración de una tabla
	ALTER TABLE table_name <alter_definition> [, alter_definition] ...;
	
    <alter_definition> puede ser ADD, MODIFY, DROP, entre otras cosas.
    Multiples alteraciones en una sola tabla son separadas por comas. 

    - Add column
	<alter_definition> : ADD <column_name> <column_definition> [FIRST | AFTER <column_name>]
    - Modify column
	<alter_definition> : MODIFY <column_name> <column_definition>
    - Drop a column
	<alter_definition> : DROP <column>

    Si queremos eliminar la tabla

	DROP TABLE <table_name>
	DROP TABLE IF EXISTS <table_name>

*/


