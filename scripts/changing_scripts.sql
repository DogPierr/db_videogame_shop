-- inserts
insert into gsh.games (game_id, name, price, genre, developer, description)
values (8, 'Terraria', 399, 'sandbox', 'Re-Logic',
        'В игровом процессе Terraria уделяется внимание исследованию мира, поиску сокровищ и сражениям');

insert into gsh.discounts (game_id, discount, start_date, end_date)
values (8, 1, '2023-04-16 00:00:00', '2023-04-16 00:10:00');

-- select
select name
from gsh.games
where genre = 'ARPG';

select name
from gsh.games
where price < 1000;

select description
from gsh.reviews
where rating >= 3;

-- update
update gsh.games
set price = price + 100
where price < 1000;

update gsh.reviews
set description = 'not bad'
where rating > 3;

-- delete
delete
from gsh.reviews
where rating < 2;

delete
from gsh.clients_history
where change_date < '2021-10-04';

delete
from gsh.shopping_carts
where customer_id = 1;