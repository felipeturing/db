/*
    GRANT <privileges> ON <database> TO <user>

    We customize the <privileges> , <database> , and <user> parts as needed. The
<user> section should match the 'username'@'host' part of the CREATE statement.
Otherwise, we'll be creating a new user. We can also add an IDENTIFIED BY
'password' section to the end of the GRANT statement if we want to change the
password of the user (or add a password to a user that doesn't have one).

-- Es una buen hábito primero crear el usuario con una contraseña y luego concederle los mínimos permisos que necesitan
*/

grant all *.* to 'root'@'localhost' with grant option; -- todos los permisos al servidor completo. 
grant select on test.* to 'felipeturing'@'localhost';
grant all on botare.* to felipeturing@localhost with MAX_QUERIES_PER_HOUR 100;

/*
    REVOKE <priviligies> ON <databases> FROM <user>; 

*/

revoke select on botaren.* from felipeturing@localhost;
revoke all, grant option from 'felipeturing'@'locahost'; -- Remover todos los priviligeos del usuario felipeturing, pero es preferible usar DROP USER en lugar de quitar todos los privilegios. 
-- Así el usuario no tengo el privilegio GRANT OPTION es necesario colocarlo, sino la consulta no se ejecutará. 

/*

    SHOW GRANTS FOR <user>;

*/

show grants for felipeturing@localhost; 

/*
    Setting and changing passwords
    SET PASSWORD FOR <user> = PASSWORD('<password>');
*/

set password for felipeturing@localhost = password('turing');


/*
    Removing users
    DROP USER <user>;
*/

drop user felipeturing@localhost;

