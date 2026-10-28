# Лабораторная работа №1 — вариант 30

**Тема:** Создание таблиц в PostgreSQL  
**Вариант:** 30 — Трамваи и депо  
**СУБД:** PostgreSQL (15 или новее)  
**Среда:** pgAdmin 4

## Цель работы
Создать базу данных, выбрать типы данных, обеспечить первичные и внешние ключи, заполнить таблицы и изучить импорт/экспорт CSV.

## 1. Создание базы
В pgAdmin создайте базу `lab1_variant30` (Databases → Create → Database). Затем откройте для неё Query Tool.

## 2. Таблицы
Выполните `create_tables.sql`.

### `depots` — Депо
- `depot_id` — номер депо, INTEGER, PRIMARY KEY, автоинкремент
- `depot_name` — название, VARCHAR(120), NOT NULL
- `parking_spaces` — количество парковочных мест, INTEGER, CHECK >= 0
- `repair_spaces` — количество ремонтных мест, INTEGER, CHECK >= 0
- `address` — адрес, TEXT, NOT NULL
- `contact_phone` — контактный телефон, VARCHAR(30), NOT NULL

### `trams` — Трамваи
- `tram_id` — номер трамвая, INTEGER, PRIMARY KEY
- `depot_id` — номер депо, INTEGER, FOREIGN KEY на `depots.depot_id`
- `model` — модель, VARCHAR(100)
- `production_year` — год постройки, INTEGER
- `overhaul_date` — дата капитального ремонта, DATE, допускает NULL
- `total_capacity` — количество мест (общая вместимость), INTEGER
- `seat_count` — количество сидячих мест, INTEGER, не более общей вместимости
- `length_m` — длина в метрах, NUMERIC(6,2)
- `bogie_count` — количество тележек, INTEGER
- `section_count` — количество секций в составе поезда, INTEGER

Поля проверяются с помощью `NOT NULL` и `CHECK`. Отсутствие капитального ремонта обозначено `NULL`.

## 3. Связь между таблицами
Один объект `depots` может содержать множество записей `trams`. Поле `trams.depot_id` — внешний ключ. Обновление номера депо каскадное, а удаление депо с привязанными трамваями запрещено. Схема: `erd.svg`, `ERD.png`, исходник `erd.dot`.

![ERD](ERD.png)

## 4. Заполнение данными
Выполните `insert_data.sql`. Добавлено **10 депо и 10 трамваев**. Номера трамваев уникальны, номера депо существуют во внешней таблице. Содержимое приведено также в `depots.csv` и `trams.csv` (UTF-8 с BOM для удобного открытия в Excel).

Имена, адреса, телефоны и технические характеристики — **учебные примеры**, а не подтверждённые сведения о московских предприятиях.

## 5. Проверка
```sql
SELECT * FROM depots ORDER BY depot_id;
SELECT * FROM trams ORDER BY tram_id;
SELECT d.depot_name, t.tram_id, t.model
FROM trams AS t JOIN depots AS d ON t.depot_id = d.depot_id;
```

## 6. Скриншоты для сдачи
Откройте pgAdmin и сделайте собственные скриншоты: база и таблицы в Object Explorer; конструктор/Columns и Constraints для обеих таблиц; ERD в pgAdmin; результаты `SELECT *` по обеим таблицам. В ZIP этих скриншотов нет, потому что SQL не запускался в вашем локальном pgAdmin.

## 7. Вывод
Созданы две связанные таблицы с ограничениями целостности, подготовлены запросы на создание и заполнение, CSV-файлы и ERD-схема. Практический запуск на локальном сервере требуется подтвердить в pgAdmin.
