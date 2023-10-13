create schema gsh;

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

CREATE TABLE gsh.games
(
    game_id     INTEGER                NOT NULL,
    name        CHARACTER VARYING(200) NOT NULL,
    price       FLOAT                  NOT NULL,
    genre       CHARACTER VARYING(200),
    developer   CHARACTER VARYING(200),
    description CHARACTER VARYING(200),

    CONSTRAINT game_pk PRIMARY KEY (game_id)
);

CREATE TABLE gsh.discounts
(
    game_id    INTEGER   NOT NULL,
    discount   FLOAT     NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date   TIMESTAMP NOT NULL,

    CONSTRAINT discounts_game_fk FOREIGN KEY (game_id) REFERENCES gsh.games(game_id)
);

CREATE TABLE gsh.reviews
(
    game_id     INTEGER      NOT NULL,
    customer_id INTEGER      NOT NULL,
    rating     FLOAT        NOT NULL,
    description VARCHAR(200) NOT NULL,

    CONSTRAINT reviews_game_fk FOREIGN KEY (game_id) REFERENCES gsh.games (game_id),
    CONSTRAINT reviews_customer_fk FOREIGN KEY (customer_id) REFERENCES gsh.clients (customer_id)

);

CREATE TABLE gsh.shopping_carts
(
    customer_id INTEGER      NOT NULL,
    game_id     INTEGER      NOT NULL,
    adding_date TIMESTAMP NOT NULL,

    CONSTRAINT shopping_carts_customer_fk FOREIGN KEY (customer_id) REFERENCES gsh.clients(customer_id),
    CONSTRAINT shopping_carts_game_fk FOREIGN KEY (game_id) REFERENCES gsh.games (game_id)
);

CREATE TABLE gsh.orders
(
    order_id    INTEGER   NOT NULL,
    customer_id INTEGER   NOT NULL,
    game_id     INTEGER   NOT NULL,
    date        TIMESTAMP NOT NULL,

    CONSTRAINT orders_customer_fk FOREIGN KEY (customer_id) REFERENCES gsh.clients (customer_id),
    CONSTRAINT orders_game_fk FOREIGN KEY (game_id) REFERENCES gsh.games (game_id)
);

CREATE TABLE gsh.clients_history
(
    customer_id INTEGER                NOT NULL,
    email       CHARACTER VARYING(200) NOT NULL,
    password    CHARACTER VARYING(200) NOT NULL,
    card_number INTEGER                NOT NULL,
    change_date TIMESTAMP              NOT NULL,

    CONSTRAINT history_customer_fk FOREIGN KEY (customer_id) REFERENCES gsh.clients (customer_id)
);