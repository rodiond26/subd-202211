### HW03
База данных интернет-магазина

Запуск
```shell
docker compose up -d
```

Останов
```shell
docker compose down
```

### pgAdmin Login
- Email Address/Username: admin@linuxhint.com
- Password: secret
- Browser: http://localhost:8800/

### Register Server
- Name: hw03
- Host name/address: host.docker.internal
- Port: 5432
- Maintenance database: postgres
- Username: postgres
- Password: secret

### Подключение к базе в контейнере с помощью psql
```shell
docker exec -it pg14 psql -U postgres -W postgres
```
- Password: secret

Список баз данных
```
\l
```
Подключение к базе postgres
```
\c postgres
```
Список таблиц
```
\dt
```
Запрос в таблицу products
```sql
select * from products;
```
