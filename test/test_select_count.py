import os

import pandas as pd
import pytest
from . import execute_sql_to_df
from . import read_sql

PATH = ["scripts/selects.sql"]


@pytest.fixture()
def select_script():
    path = PATH[0]
    return read_sql(path)


@pytest.fixture()
def select_df(select_script, sqlalchemy_conn):
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select_script
    )


def test1(select_df):
    assert list(select_df.columns) == ['genre', 'max_price']
    assert select_df.shape[0] == 4
    assert select_df.iloc[2]['genre'] == 'RPG'
    assert select_df.iloc[7]['max_price'] == 2000


def test2(select_df):
    assert list(select_df.columns) == ['name', 'orders']
    assert select_df.shape[0] == 9
    assert select_df.iloc[4]['name'] == 'Николаева Анна'
    assert select_df.iloc[7]['orders'] == 2


def test3(select_df):
    assert list(select_df.columns) == ['name', 'total_spent']
    assert select_df.shape[0] == 5
    assert select_df.iloc[2]['name'] == 'Федоров Иван'
    assert select_df.iloc[4]['total_spent'] == 2500


def test4(select_df):
    assert list(select_df.columns) == ['rank', 'name', 'date']
    assert select_df.shape[0] == 10
    assert select_df.iloc[5]['rank'] == 6
    assert select_df.iloc[6]['name'] == 'Соколов Максим'
    assert select_df.iloc[4]['date'] == '2021-10-02 16:45:00.000000'


def test5(select_df):
    assert list(select_df.columns) == ['developer', 'name', 'avg_price']
    assert select_df.shape[0] == 8
    assert select_df.iloc[5]['developer'] == 'Larian Studios'
    assert select_df.iloc[6]['name'] == 'The Legend of Zelda: Breath of the Wild'
    assert select_df.iloc[7]['date'] == 999


def test6(select_df):
    assert list(select_df.columns) == ['name', 'date', 'prev_date']
    assert select_df.shape[0] == 10
    assert select_df.iloc[5]['name'] == 'Петрова Екатерина'
    assert select_df.iloc[6]['date'] == '2021-10-03 09:15:00.000000'
    assert select_df.iloc[8]['prev_date'] == '2021-10-04 11:30:00.000000'
