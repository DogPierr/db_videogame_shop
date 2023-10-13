# Физическя модель

---

Таблица `gsh.clients`:

| Название      | Описание              | Тип данных     | Ограничение   |
|---------------|-----------------------|----------------|---------------|
| `customer_id` | Идентификатор клиента | `INTEGER`      | `PRIMARY KEY` |
| `surname`     | Фамилия клиента       | `VARCHAR(200)` | `NOT NULL`    |
| `firstname`   | Имя клиента           | `VARCHAR(200)` | `NOT NULL`    |
| `email`       | Почта клиента         | `VARCHAR(200)` | `NOT NULL`    |
| `password`    | Пароль клиента        | `VARCHAR(200)` | `NOT NULL`    |
| `card_number` | Номер карты           | `INT`          | `NOT NULL`    |

Таблица `gsh.games`:

| Название      | Описание           | Тип данных     | Ограничение   |
|---------------|--------------------|----------------|---------------|
| `game_id`     | Идентификатор игры | `INTEGER`      | `PRIMARY KEY` |
| `name`        | Название игры      | `VARCHAR(200)` | `NOT NULL`    |
| `price`       | Цена               | `FLOAT`        | `NOT NULL`    |
| `genre`       | Жанр               | `VARCHAR(200)` | `-`           |
| `developer`   | Разработчик        | `VARCHAR(200)` | `-`           |
| `description` | Описание           | `VARCHAR(200)` | `-`           |

Таблица `gsh.discounts`:

| Название      | Описание               | Тип данных     | Ограничение   |
|---------------|------------------------|----------------|---------------|
| `game_id`     | Идентификатор игры     | `INTEGER`      | `FOREIGN KEY` |
| `discount`    | Скидка в долях         | `FLOAT`        | `NOT NULL`    |
| `start_date`  | Начало действия скидки | `TIMESTAMP`    | `NOT NULL`    |
| `end_date`    | Конец действия скидки  | `TIMESTAMP`    | `NOT NULL`    |


Таблица `gsh.reviews`:

| Название      | Описание               | Тип данных     | Ограничение   |
|---------------|------------------------|----------------|---------------|
| `game_id`     | Идентификатор игры     | `INTEGER`      | `FOREIGN KEY` |
| `customer_id` | Идентификатор клиента  | `INTEGER`      | `FOREIGN KEY` |
| `raiting`     | Оценка по пятибалльной | `FLOAT`        | `NOT NULL`    |
| `description` | Рецензия               | `VARCHAR(200)` | `-`           |

Таблица `gsh.shopping_carts`:

| Название      | Описание              | Тип данных     | Ограничение   |
|---------------|-----------------------|----------------|---------------|
| `customer_id` | Идентификатор клиента | `INTEGER`      | `FOREIGN KEY` |
| `game_id`     | Идентификатор игры    | `INTEGER`      | `FOREIGN KEY` |
| `adding_date` | Дата добавления       | `TIMESTAMP`    | `NOT NULL`    |

Таблица `gsh.orders`:

| Название      | Описание               | Тип данных  | Ограничение   |
|---------------|------------------------|-------------|---------------|
| `order_id`    | Номер заказа           | `INTEGER`   | `PRIMARY KEY` |
| `customer_id` | Идентификатор клиента  | `INTEGER`   | `FOREIGN KEY` |
| `game_id`     | Идентификатор игры     | `INTEGER`   | `FOREIGN KEY` |
| `date`        | Дата совершения заказа | `TIMESTAMP` | `NOT NULL`    |

Таблица `gsh.clients_history`:

| Название      | Описание              | Тип данных     | Ограничение   |
|---------------|-----------------------|----------------|---------------|
| `customer_id` | Идентификатор клиента | `INTEGER`      | `FOREIGN KEY` |
| `email`       | Почта клиента         | `VARCHAR(200)` | `NOT NULL`    |
| `password`    | Пароль клиента        | `VARCHAR(200)` | `NOT NULL`    |
| `card_number` | Номер карты           | `INT`          | `NOT NULL`    |
| `change_date` | Дата изменения данных | `TIMESTAMP`    | `NOT NULL`    |

---
Таблица `gsh.clients`:
```postgresql
CREATE TABLE gsh.clients
(
    customer_id INTEGER                NOT NULL,
    surname     CHARACTER VARYING(200) NOT NULL,
    firstname   CHARACTER VARYING(200) NOT NULL,
    email       CHARACTER VARYING(200) NOT NULL,
    password    CHARACTER VARYING(200) NOT NULL,
    card_number INTEGER                NOT NULL,

    CONSTRAINT clients_pk PRIMARY KEY (customer_id)
);
```
Таблица `gsh.games`:
```postgresql
CREATE TABLE gsh.games
(
    game_id     INTEGER                NOT NULL,
    name        CHARACTER VARYING(200) NOT NULL,
    price       FLOAT                  NOT NULL,
    genre       CHARACTER VARYING(200),
    developer   CHARACTER VARYING(200),
    description INTEGER,

    CONSTRAINT game_pk PRIMARY KEY (game_id)
);
```
Таблица `gsh.discounts`:
```postgresql
CREATE TABLE gsh.discounts
(
    game_id    INTEGER   NOT NULL,
    discount   FLOAT     NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date   TIMESTAMP NOT NULL,

    CONSTRAINT discounts_game_fk FOREIGN KEY (game_id) REFERENCES gsh.games(game_id)
);
```

Таблица `gsh.reviews`:
```postgresql
CREATE TABLE gsh.reviews
(
    game_id     INTEGER      NOT NULL,
    customer_id INTEGER      NOT NULL,
    raiting     FLOAT        NOT NULL,
    description VARCHAR(200) NOT NULL,

    CONSTRAINT reviews_game_fk FOREIGN KEY (game_id) REFERENCES gsh.games (game_id),
    CONSTRAINT reviews_customer_fk FOREIGN KEY (customer_id) REFERENCES gsh.clients (customer_id)

);
```
Таблица `gsh.shopping_carts`:
```postgresql
CREATE TABLE gsh.shopping_carts
(
    customer_id INTEGER      NOT NULL,
    game_id     INTEGER      NOT NULL,
    adding_date TIMESTAMP NOT NULL,

    CONSTRAINT shopping_carts_customer_fk FOREIGN KEY (customer_id) REFERENCES gsh.clients(customer_id),
    CONSTRAINT shopping_carts_game_fk FOREIGN KEY (game_id) REFERENCES gsh.games (game_id)
);
```
Таблица `gsh.orders`:
```postgresql
CREATE TABLE gsh.orders
(
    order_id    INTEGER   NOT NULL,
    customer_id INTEGER   NOT NULL,
    game_id     INTEGER   NOT NULL,
    date        TIMESTAMP NOT NULL,

    CONSTRAINT orders_customer_fk FOREIGN KEY (customer_id) REFERENCES gsh.clients (customer_id),
    CONSTRAINT orders_game_fk FOREIGN KEY (game_id) REFERENCES gsh.games (game_id)
);
```
Таблица `gsh.clients_history`:
```postgresql
CREATE TABLE gsh.clients_history
(
    customer_id INTEGER                NOT NULL,
    email       CHARACTER VARYING(200) NOT NULL,
    password    CHARACTER VARYING(200) NOT NULL,
    card_number INTEGER                NOT NULL,
    change_date TIMESTAMP              NOT NULL,

    CONSTRAINT history_customer_fk FOREIGN KEY (customer_id) REFERENCES gsh.clients (customer_id)
);
```




