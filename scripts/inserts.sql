insert into gsh.games (game_id, name, price, genre, developer, description)
values (0, 'Elden Ring', 2000, 'RPG', 'FromSoftware', '10/10'),
       (1, 'The Legend of Zelda: Breath of the Wild', 2500, 'Action-adventure', 'Nintendo',
        'Breath of the Wild — action-adventure с открытым миром'),
       (2, 'World of Warcraft', 549, 'MMORPG', 'Blizzard Entertainment',
        'World of Warcraft представляет собой массовую многопользовательскую ролевую онлайн-игру'),
       (3, 'Resident Evil 4', 4000, 'survival-horror', 'Capcom',
        'Как и в оригинальной игре геймплей шутера от третьего лица «через плечо»'),
       (4, 'The Witcher 3: Wild Hunt', 1999, 'ARPG', 'CD Project RED',
        '«Ведьмак 3: Дикая Охота» — компьютерная игра от третьего лица в жанре action/RPG'),
       (5, 'Dark Souls 3', 1499, 'ARPG', 'FromSoftware',
        'Действие игры происходит в Лотрике, на стыке владений повелителей пепла.'),
       (6, 'Divinity: Original Sin 2', 899, 'RPG', 'Larian Studios',
        'В начале игры для своего персонажа нужно выбрать одну из 5 рас (человек, эльф, нежить, ящер, гном)'),
       (7, 'Kingdom Come: Deliverance', 999, 'ARPG', 'Warhorse Studios',
        'Kingdom Come: Deliverance представляет собой игру в жанре action/RPG с открытым миром');

insert into gsh.clients (customer_id, surname, firstname, email, password, card_number)
values (0, 'Кузнецов', 'Александр', 'aleksandr.kuznetsov@mail.com', 'aKuz5678', 1234),
       (1, 'Иванова', 'Ольга', 'olga.ivanova@mail.com', 'oIva9012', 2345),
       (2, 'Смирнов', 'Дмитрий', 'dmitriy.smirnov@mail.com', 'dSmir7890', 3456),
       (3, 'Петрова', 'Екатерина', 'ekaterina.petrova@mail.com', 'ePet1234', 4567),
       (4, 'Федоров', 'Иван', 'ivan.fedorov@mail.com', 'iFed7890', 5678),
       (5, 'Николаева', 'Анна', 'anna.nikolaeva@mail.com', 'aNik2345', 6789),
       (6, 'Морозов', 'Сергей', 'sergey.morozov@mail.com', 'sMor4567', 7890),
       (7, 'Лебедева', 'Юлия', 'yuliya.lebedeva@mail.com', 'yLeb5678', 8901),
       (8, 'Козлова', 'Александра', 'alexandra.kozlova@mail.com', 'aKoz1234', 9012),
       (9, 'Соколов', 'Максим', 'maxim.sokolov@mail.com', 'mSok7890', 2109);

insert into gsh.orders (order_id, customer_id, game_id, date)
values (1, 3, 5, '2021-10-01 14:30:00'),
       (2, 7, 2, '2021-10-02 16:45:00'),
       (3, 2, 2, '2021-10-03 09:15:00'),
       (4, 9, 4, '2021-10-04 11:30:00'),
       (5, 1, 1, '2021-10-05 13:00:00'),
       (6, 5, 0, '2021-10-06 18:00:00'),
       (7, 8, 6, '2021-10-07 15:20:00'),
       (8, 4, 3, '2021-10-08 12:45:00'),
       (9, 6, 7, '2021-10-09 10:00:00'),
       (10, 9, 1, '2021-10-10 17:30:00');

insert into gsh.clients_history (customer_id, email, password, card_number, change_date)
values (1, 'john.doe@example.com', 'password123', 1234, '2021-10-01 14:30:00'),
       (2, 'jane.doe@example.com', 'password456', 2345, '2021-10-02 16:45:00'),
       (3, 'bob.smith@example.com', 'password789', 3456, '2021-10-03 09:15:00'),
       (4, 'susan.johnson@example.com', 'passwordabc', 4567, '2021-10-04 11:30:00'),
       (5, 'mike.brown@example.com', 'passworddef', 5678, '2021-10-05 13:00:00'),
       (6, 'amy.wilson@example.com', 'passwordghi', 6789, '2021-10-06 18:00:00');

insert into gsh.shopping_carts (customer_id, game_id, adding_date)
values (1, 3, '2021-10-01 14:30:00'),
       (3, 2, '2021-10-03 08:15:00'),
       (4, 4, '2021-10-04 10:30:00'),
       (5, 1, '2021-10-05 12:00:00'),
       (6, 0, '2021-10-06 17:00:00'),
       (7, 6, '2021-10-07 14:20:00');

insert into gsh.discounts (game_id, discount, start_date, end_date)
values (1, 0.5, '2023-01-15 14:30:00', '2023-01-20 14:30:00'),
       (2, 0.25, '2023-02-15 14:30:00', '2023-02-20 14:30:00'),
       (3, 0.1, '2022-02-15 14:30:00', '2022-02-20 14:30:00'),
       (7, 0.15, '2022-02-15 14:30:00', '2022-02-20 14:30:00');

insert into gsh.reviews (game_id, customer_id, rating, description)
values (0, 2, 5, 'masterpiece'),
       (1, 1, 5, 'very good gameplay'),
       (2, 5, 3, 'it was better before...'),
       (3, 9, 1, 'cant play it now'),
       (4, 7, 4, 'my childhood');
