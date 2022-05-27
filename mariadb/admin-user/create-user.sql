-- The CREATE USER statement creates new MariaDB accounts.
-- For each account, CREATE USER creates a new row in mysql.user (until MariaDB 10.3 this is a table, from MariaDB 10.4 it's a view)

USE mysql;

-- The str user@host is unique

-- If any of the specified accounts, or any permissions for the specified accounts, already exist, then the server returns ERROR 1396 (HY000)
CREATE USER turing1@localhost IDENTIFIED BY 'password';


-- OR REPLACE is basically a shortcut for:
/*
    DROP USER IF EXISTS name;
    CREATE USER name ...;
*/
CREATE OR REPLACE USER turing1@localhost IDENTIFIED BY 'password';


-- When the IF NOT EXISTS clause is used, MariaDB will return a warning instead of an error if the specified user already exists.
CREATE USER IF NOT EXISTS turing1@localhost IDENTIFIED BY 'password';
CREATE USER 'turin4'@'%' IDENTIFIED BY 'password';
SHOW WARNINGS;
-- SELECT Password FROM user WHERE User='turing';
-- Hashed password have 41 bytes : *E2664F40B976A4F64DEB0307BE1D09AF94BAB01E


-- IDENTIFIED BY PASSWORD 'password_hash'
CREATE OR REPLACE USER turing2@localhost IDENTIFIED BY PASSWORD '*BC0B6115D63E06A6D74E044B4B42CC2086681468';


-- IDENTIFIED {VIA | WITH} authentication_plugin
-- LIST ALL PLUGING
SHOW PLUGING;

-- THERE EXISTS A LOT OF AUTHENTICATION PLUGINS, FOR EXAMPLE : PAO, PAM, mysql_old_password, mysql_native_password
-- ed25519, GSSAPI, Unix Socket, Named Pipe, SHA-256.

-- Although the plugin's shared library is distributed with MariaDB by default, the plugin is not actually installed by MariaDB by default.
-- INSTALL PLUGIN especified_name_plugin_user SONAME 'auth_pam' or INSTALL SONAME 'auth_pam'
INSTALL PLUGIN pam SONAME 'auth_pam';
-- UNINSTALL PLUGIN 'auth_pam';
-- PAM configuration usually : Authentication using passwords from /etc/shadow

CREATE USER turing3@localhost IDENTIFIED VIA pam USING 'password';


-- TLS Options
-- By default, MariaDB transmits data between the server and clients without encrypting it
-- This is generally acceptable when the server and client run on the same host or in networks where security is guaranteed through other means.
-- However, in cases where the server and client exist on separate networks or they are in a high-risk network.

-- To mitigate this concern, MariaDB allows you to encrypt data in transit between the server and clients using the Transport Layer Security (TLS) protocol
-- You can set certain TLS-related restrictions for specific user accounts.
-- REQUIRE NONE, REQUIRE SSL, REQUIRE X509, REQUIRE ISSUER 'issuer', REQUIRE SUBJECT 'subject' and REQUIRE CIPHER 'cipher'.
CREATE USER 'turing5'@'%'
    REQUIRE SUBJECT '/CN=turing/O=felipeturing.com, Inc./C=PE/ST=Lima/L=SJL'
    AND ISSUER '/C=FI/ST=Jicamarca/L=Lima/ O=Terexor/CN=ggm/emailAddress=ggm@terexor.com'
    AND CIPHER 'TLSv1.2';


-- Resource Limit Options
-- MAX_QUERIES_PER_HOUR, MAX_UPDATES_PER_HOUR, MAX_CONNECTIONS_PER_HOUR, MAX_USER_CONNECTIONS, MAX_STATEMENT_TIME
-- If any of these limits are set to 0, then there is no limit for that resource for that user.

CREATE USER 'turing6'@'localhost' WITH
    MAX_USER_CONNECTIONS 10 -- Number of simultaneous connections from the same account
    MAX_QUERIES_PER_HOUR 200;


-- HOST NAME COMPONENT : uses some wildcards % and _
CREATE USER 'turing10'@'247.150.130.0/255.255.255.0';
-- ip_addr & netmask = base_ip (247.150.130.0 to 247.150.130.255.)


-- Anonymous Accounts
CREATE USER ''@'localhost';
CREATE USER ''@'192.168.0.3';
-- On some systems, the mysql.db table has some entries for the ''@'%' anonymous account by default. It's neccesary delete
-- that account.
/*
CREATE USER ''@'%';
ERROR 1396 (HY000): Operation CREATE USER failed for ''@'%'
*/

DELETE FROM mysql.db WHERE User='' AND Host='%';
FLUSH PRIVILEGES; -- The FLUSH statement clears or reloads various internal caches used by MariaDB. To execute FLUSH ,
-- you must have the RELOAD privilege.
CREATE USER ''@'%';
-- Query OK, 0 rows affected (0.01 sec)


--Password Expiry and Account Locking
-- User password expiry was introduced in MariaDB 10.4.3.
-- My installed MariaDB server version is 10.3.31
CREATE USER felipeturing@localhost IDENTIFIED BY '12345turing12345' PASSWORD EXPIRE INTERVAL 120 DAY;
CREATE USER 'turing11'@'localhost' ACCOUNT LOCK;
