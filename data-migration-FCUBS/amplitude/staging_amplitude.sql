-- tablespace for amplitude
CREATE TABLESPACE DATADBS DATAFILE 
'/oradata/STAGE/stage01' SIZE 31G,
'/oradata/STAGE/stage02' SIZE 31G,
'/oradata/STAGE/stage03' SIZE 31G,
'/oradata/STAGE/stage04' SIZE 31G,
'/oradata/STAGE/stage04' SIZE 31G
logging online permanent blocksize 8192 extent management local autoallocate default nocompress segment space management auto;





-- schema for amplitude
CREATE USER stage IDENTIFIED BY stage default tablespace "DATADBS" temporary tablespace TEMP;

grant CONNECT to stage;

grant RESOURCE to stage;



