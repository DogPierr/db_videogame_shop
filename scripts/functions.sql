create or replace procedure gsh.change_client(
    id INTEGER,
    surname_ VARCHAR(255),
    firstname_ VARCHAR(255),
    email_ VARCHAR(255),
    password_ VARCHAR(255),
    card_number_ INTEGER
)
    language plpgsql as
$$
begin
    insert into gsh.clients_history
    select cli.customer_id,
           cli.email,
           cli.password,
           cli.card_number,
           current_date as change_date
    from gsh.clients as cli
    where cli.customer_id = id;

    update gsh.clients
    set surname     = surname_,
        firstname   = firstname_,
        email       = email_,
        password    = password_,
        card_number = card_number_
    where customer_id = id;
end;
$$;

create or replace function gsh.get_client_orders(client_id INTEGER)
    returns table
            (
                name        TEXT,
                orders      BIGINT,
                total_spent DOUBLE PRECISION
            )
    language plpgsql
as
$$
begin
    return query
        select distinct concat(cli.surname, ' ', cli.firstname),
               count(ord.customer_id) over (partition by cli.customer_id),
               sum(game.price) over (partition by cli.customer_id)
        from gsh.orders as ord
                 join gsh.clients as cli on ord.customer_id = cli.customer_id
                 join gsh.games as game on ord.game_id = game.game_id
        where cli.customer_id = client_id
        order by 1;
end ;
$$;