-- наиболее дорогая игра по жанрам
select genre,
       max(price) as max_price
from gsh.games
group by genre
having max(price) > 1000
order by genre;

-- количество заказов по клиентам
select concat(cli.surname, ' ', cli.firstname) as name,
       count(ord.customer_id)                  as orders
from gsh.orders as ord
         join gsh.clients as cli on ord.customer_id = cli.customer_id
group by name
order by name;

-- цена корзины человека
select concat(cli.surname, ' ', cli.firstname) as name,
       sum(game.price)                         as total_spent
from gsh.clients as cli
         join gsh.shopping_carts as cart on cli.customer_id = cart.customer_id
         join gsh.games as game on cart.game_id = game.game_id
group by 1
order by total_spent;

-- топ самых ранних заказов
select rank() over (order by ord.date desc)    as rank,
       concat(cli.surname, ' ', cli.firstname) as name,
       ord.date                                as date
from gsh.clients as cli
         join gsh.orders as ord on cli.customer_id = ord.customer_id;

-- игры, разработчики и средняя цена по разработчику
select developer,
       name,
       avg(price) over (partition by developer) as avg_price
from gsh.games;

-- даты заказов каждого человека вместе с датой предыдущего
select concat(cli.surname, ' ', cli.firstname)                         as name,
       ord.date                                                        as date,
       lag(ord.date) over (partition by ord.customer_id order by date) as prev_date
from gsh.orders as ord
         join gsh.clients as cli on ord.customer_id = cli.customer_id
order by name;