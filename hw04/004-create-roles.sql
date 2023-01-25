-- Создать роль аналитика только для чтения
CREATE ROLE analyst;
GRANT CONNECT ON DATABASE simple_shop TO analyst;
GRANT USAGE ON SCHEMA shop TO analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA shop TO analyst;
ALTER DEFAULT PRIVILEGES IN SCHEMA shop GRANT SELECT ON TABLES TO analyst;

-- Создать роль сервис-менеджера базы данных
CREATE ROLE service_manager;
GRANT CONNECT ON DATABASE simple_shop TO service_manager;
GRANT USAGE ON SCHEMA shop TO service_manager;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA shop TO service_manager;

-- Создать техническую роль для бэкенд-приложения для чтения и записи в таблицы бд
CREATE ROLE tech_role;
GRANT CONNECT ON DATABASE simple_shop TO tech_role;
GRANT USAGE ON SCHEMA shop TO tech_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA shop TO tech_role;
