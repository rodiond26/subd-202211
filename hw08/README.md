### HW08

---

### Физическая репликация

#### 1.1 Скачать образ Ubuntu

```shell 
docker run --name hw08 -it ubuntu:22.10
```

#### 1.2 Обновить пакеты

```shell
apt-get update -y && apt-get install -y
```

#### 1.3 Установить пароль для root

```shell
passwd 
```

#### 1.4 Установить sudo

```shell
apt install sudo
```

#### 1.5 Установить nano

```shell
apt-get install nano
```

#### 2.1 Установить postgresql

* Geographic area: 8. Europe
* Time zone: 34. Moscow

```shell
apt install postgresql -y 
```

#### 2.2 Просмотреть кластеры

```shell
pg_lsclusters
```

#### 2.3 Запустить первый кластер

```shell
pg_ctlcluster 14 main start
```

#### 2.4 Зайти в psql под пользователем postgres

```shell
sudo -u postgres psql
```

#### 2.5 Создать таблицу students

```sql
CREATE DATABASE university;

\c university;

CREATE TABLE student AS
SELECT generate_series(1,20)         AS id,
       md5(random()::text)::char(20) AS fio;
       
SELECT * FROM student;

SHOW wal_level;
```

#### 3.1 Отредактировать файлы первого кластера

- `nano /etc/postgresql/14/main/pg_hba.conf`

`host	replication		all        ::1/128		   md5`

- `nano /etc/postgresql/14/main/postgresql.conf`

`listen_addresses = 'localhost'`

#### 3.2 Создать второй кластер

```shell
sudo pg_createcluster -d /var/lib/postgresql/14/main2 14 replica
```

#### 3.3 Отредактировать файлы второго кластера

- `nano /etc/postgresql/14/replica/pg_hba.conf`

`host	replication		all        ::1/128		   md5`

- `nano /etc/postgresql/14/replica/postgresql.conf`

`listen_addresses = 'localhost'`

#### 3.4 Удалить все файлы с реплики

```shell
sudo rm -rf /var/lib/postgresql/14/main2
```

#### 3.5 Создать бэкап БД. Ключ -R создаст заготовку управляющего файла recovery.conf.

```shell
sudo -u postgres pg_basebackup -p 5433 -R -D /var/lib/postgresql/14/main2
```

#### 7. Запустить второй кластер

```shell
pg_ctlcluster 14 replica start
```

Проверить состояние репликации на мастере:

```shell
sudo -u postgres psql -p 5432

SELECT * FROM pg_stat_replication \gx
```

#### 4.1 Создать на мастере репликационный слот и проверить

```
SELECT pg_create_physical_replication_slot('standby_slot');

SELECT * FROM pg_replication_slots; 
```

#### Найти файл конфигурации мастера

```shell
su - postgres -c "psql -c 'SHOW config_file;'"
```

Подключиться к работающему контейнеру

docker exec -it CONTAINER_ID sh
docker exec -it a2af97ae9aee sh