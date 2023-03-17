### HW08

---

### Физическая репликация

#### 1. Скачать образ Ubuntu
```shell 
docker run -it ubuntu:22.10
```

#### 2. Обновить пакеты
```shell
apt-get update -y && apt-get install -y
```

#### 3. Установить postgresql
* Geographic area: 8. Europe
* Time zone: 34. Moscow
```shell
apt install postgresql -y 
```

#### 4. Просмотреть кластеры
```shell
pg_lsclusters
```

#### 5. Запустить первый кластер
```shell
pg_ctlcluster 14 main start
```

#### 6. Создать кластер


