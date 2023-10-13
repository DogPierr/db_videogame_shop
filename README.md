### Проект "Онлайн магазин видеоигр"

---
В данноей базе данных будут хранится данные по продажам и ассортимент в онлайн магазине по продажам видеоигр.
В данной базе данных будут хранится данные по продажам и ассортимент в онлайн магазине по продажам видеоигр.

---

### Описание таблиц

---

- Таблица `gsh.clients` содержит информацию о клиенте: ФИО, почта, пароль, номер карты.
- Таблица `gsh.games` содержит информацию о играх, которые находятся в каталоге.
- Таблица `gsh.shopping_carts` содержит информацию об играх, которые содержатся в корзине каждого клиента.
- Таблица `gsh.discounts` содержит информацию о скидках на игры.
- Таблица `gsh.orders` содержит информцацию об совершенных сделках.
- Таблица `gsh.clients_history` содержит информацию о предыдущих данных, указанных клиентом, но по каким-то причинам
  данные были изменены.

---

### Описание запросов из `selects.sql`

---

1. Таблица с ценой наиболее дорогой игры в каждом из жанров.

```postgresql
select genre,
       max(price) as max_price
from gsh.games
group by genre
having max(price) > 1000
order by genre;
```

2. Количество заказов, котоыре совершил каждый из клиентов.

```postgresql
select concat(cli.surname, ' ', cli.firstname) as name,
       count(ord.customer_id)                  as orders
from gsh.orders as ord
         join gsh.clients as cli on ord.customer_id = cli.customer_id
group by name
order by name;
```

3. Цена всех игр в корзине для каждого челвоека, отсортированнах по цене.

```postgresql
select concat(cli.surname, ' ', cli.firstname) as name,
       sum(game.price)                         as total_spent
from gsh.clients as cli
         join gsh.shopping_carts as cart on cli.customer_id = cart.customer_id
         join gsh.games as game on cart.game_id = game.game_id
group by 1
order by total_spent;
```

4. Ранжирование каждого заказа по его дате.

```postgresql
select rank() over (order by ord.date desc)    as rank,
       concat(cli.surname, ' ', cli.firstname) as name,
       ord.date                                as date
from gsh.clients as cli
         join gsh.orders as ord on cli.customer_id = ord.customer_id;
```

5. Таблица с играми, соответствующими разработчиками и средней ценой для каждого разработчика.

```postgresql
select developer,
       name,
       avg(price) over (partition by developer) as avg_price
from gsh.games;
```

6. Дата заказа каждого покупателя и дата его заказа до этого.

```postgresql
select concat(cli.surname, ' ', cli.firstname)                         as name,
       ord.date                                                        as date,
       lag(ord.date) over (partition by ord.customer_id order by date) as prev_date
from gsh.orders as ord
         join gsh.clients as cli on ord.customer_id = cli.customer_id
order by name;
```

---

### Описание тестов

---

Все тесты занумерованны последовательно, соответствуют запросам из файла `scripts/selects.sql`.

Каждый из тестов проверяет размер таблицы, названия колонок, значения в случайных ячейках.

---

### Обоснование выбранных полей для индексирования

---

1. Для таблицы `gsh.clients` создается индекс по полю номер карты `card_number`, так как это поле уникально для каждого
   клиента и часто используется для идентификации клиента при выполнении операций в системе.
2. Для таблицы `gsh.games` создается индекс по полю id игры `game_id`, так как это поле часто используется для поиска
   игр в каталоге.
3. Для таблицы `gsh.shopping_carts` создается индекс по полю id клиента `customer_id`, так как это поле используется для
   связи с таблицей `gsh.clients` и позволяет быстро получить информацию о корзине конкретного клиента.

---

