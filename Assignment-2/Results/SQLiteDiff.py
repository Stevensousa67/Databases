
import sqlite3
import csv
from os import path


"""
Performs a SQLite diff on an included database
between a provided solution and a query via supplied SQL
"""
DB_PATH = path.join(path.dirname(__file__), 'Chinook_Sqlite_AutoIncrementPKs.sqlite')

def check_columns(cursor, expected):
    """
    Compares number, name, and order of columns against a supplied reference list
    :param cursor: sqlite3 cursor object
    :param expected: expected column names, in order
    :return: error message, or None if identical
    """
    col_count = len(cursor.description)

    if col_count != len(expected):
        return f"Column count incorrect: expected={len(expected)}, actual={col_count}\n"

    for i, col in enumerate(cursor.description):
        if col[0] != expected[i]:
            return f'Column label #{i + 1} incorrect: expected="{expected[i]}", actual="{col[0]}"\n'

    return None

def check_row(cursor, expected):
    """
    Compares row values against a reference list
    :param cursor: sqlite3 cursor object
    :param expected: expected row values, in order
    :return: error message, or None if identical
    """
    row = cursor.fetchone()
    if row is None:
        return "No row available"

    for i, value in enumerate(expected):
        val = str(row[i])
        if val != value:
            return f'Value for <{cursor.description[i][0]}> incorrect: expected="{value}", actual="{val}"\n'

    return None

def main(answer_file, query_file, debug_info=False):
    """
    Run the diff
    :param answer_file: path to the answer CSV file
    :param query_file: path to the SQL query file
    :param debug_info: if True, prints debug information
    """
    print(f'Trying to produce <{answer_file}> with <{query_file}>\n')
    print(f'Using database... \n{DB_PATH}\n')

    # Parse the query file
    try:
        with open(query_file, 'r', encoding='utf-8') as q_file:
            sql = ' '.join(line.strip() for line in q_file if line.strip())
    except Exception as e:
        print(f"Query file exception: {e}")
        return

    print(f"Using query...\n{sql}\n")

    # Parse the answer CSV
    cols = None
    rows = []
    try:
        with open(answer_file, 'r', encoding='utf-8') as a_file:
            reader = csv.reader(a_file)
            for row in reader:
                if cols is None:
                    cols = row
                else:
                    rows.append(row)
    except Exception as e:
        print(f"Answer file exception: {e}")
        return
    connection=None
    # Perform diff
    try:
        connection = sqlite3.connect( DB_PATH)
        cursor = connection.cursor()

        if debug_info:
            print("== Debug Info ==")
            print(f"SQLite version: {sqlite3.sqlite_version}")
            print("\n")

        print("== Result ==")

        cursor.execute(sql)

        print("Checking columns... ", end="")
        output =  check_columns(cursor, cols)
        if output is None:
            print("same")
        else:
            print(output)
            return

        for i, row in enumerate(rows):
            print(f"Checking row #{i + 1}... ", end="")
            output =  check_row(cursor, row)
            if output is None:
                print("same")
            else:
                print(output)
                return

        print("\nQuery correctly reproduces answer file.\n")

    except sqlite3.Error as e:
        print(f"SQLite error: {e}")
    finally:
        if connection:
            connection.close()

if __name__ == '__main__':
    import sys

    if len(sys.argv) not in (3, 4):
        print(f"Usage: python {sys.argv[0]} <answer file> <query file> [anything for debug info]")
    else:
        answer = sys.argv[1]
        query = sys.argv[2]
        debug = len(sys.argv) == 4
        main(answer, query, debug)
