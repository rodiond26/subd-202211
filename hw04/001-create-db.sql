-- Создать пользователей в кластере БД
CREATE ROLE super_admin
  WITH SUPERUSER;

CREATE ROLE service_admin
  WITH CREATEDB CREATEROLE;

-- Создать таблиное пространство
CREATE TABLESPACE fast_space
  LOCATION '/ssd1/postgresql/data'; -- должен быть абсолютный путь
SET default_tablespace = fast_space;

-- Создать базу данных
CREATE DATABASE simple_shop
  WITH OWNER = super_admin
       ENCODING = 'UTF8'
       TABLESPACE = fast_space;

-- Создать схему в базе данных simple_shop
CREATE SCHEMA shop;
