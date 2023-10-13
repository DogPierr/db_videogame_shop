create or replace view gsh.v_clients as
select customer_id,
       surname,
       firstname,
       email,
       concat(substr(password, 1), '*******')             as password,
       concat(substr(cast(card_number as varchar), 1, 1), '**',
              substr(cast(card_number as varchar), 4, 4)) as card_number
from gsh.clients;

create or replace view gsh.v_clients_history as
select customer_id,
       email,
       concat(substr(password, 1), '*******')             as password,
       concat(substr(cast(card_number as varchar), 1, 1), '**',
              substr(cast(card_number as varchar), 4, 4)) as card_number,
       change_date
from gsh.clients_history;

create or replace view gsh.v_orders as
select order_id,
       cli.customer_id,
       cli.email,
       concat(substr(cast(card_number as varchar), 1, 1), '**',
              substr(cast(card_number as varchar), 4, 4)) as card_number,
       game_id,
       date
from gsh.orders as ord
         join gsh.clients as cli on cli.customer_id = ord.customer_id;

create or replace view gsh.clients_stats as
select concat(cli.surname, ' ', cli.firstname) as name,
       count(ord.customer_id)                  as orders,
       sum(game.price)                         as total_spent
from gsh.orders as ord
         join gsh.clients as cli on ord.customer_id = cli.customer_id
         join gsh.shopping_carts as cart on cli.customer_id = cart.customer_id
         join gsh.games as game on cart.game_id = game.game_id
group by 1
order by 1;

create or replace view gsh.v_games as
select game.game_id,
       name,
       price * coalesce(d.discount, 1) as price,
       genre,
       max(price) over (partition by developer) as max_price,
       avg(price) over (partition by developer) as avg_price
from gsh.games as game
left join gsh.discounts as d on game.game_id = d.game_id
order by name;

create or replace view gsh.v_client_last_game as
with max_date as (
    select customer_id,
           game_id,
           max(date) over(partition by customer_id) max
    from gsh.orders
)
select cli.customer_id,
       concat(surname, ' ', firstname) as name,
       game.game_id as game_id,
       game.name as game_name
from gsh.clients as cli
join max_date as ord on cli.customer_id = ord.customer_id
join gsh.games as game on game.game_id = ord.game_id
order by customer_id;