### HW06

---

Запуск контейнера

`docker-compose up otusdb`

Подключение к БД в контейнере

`docker-compose exec otusdb mysql -u root -p12345 otus`

Для использования в клиентских приложениях можно использовать команду:

`mysql -u root -p12345 --port=3309 --protocol=tcp otus`

Для подключения к MySQL внутри контейнера:

`docker exec -it db_mysql mysql --user=root -p12345`

Показать базы данных в контейнере:

`show databases;`

Использовать базу данных otus:

`use otus;`

Посмотреть таблицу students:

`select * from students;`
