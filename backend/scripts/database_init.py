from pathlib import Path
import sqlite3 as sql

# Run script to generate a test data

script_dir = Path(__file__).resolve().parent
db_path = script_dir.parent / 'database' / 'test_database.db'

conn = sql.connect(db_path)
cursor = conn.cursor()

cursor.execute('''
               CREATE TABLE IF NOT EXISTS test_database (
               id INTEGER PRIMARY KEY AUTOINCREMENT,
               name TEXT,
               body TEXT
               )
               ''')

conn.commit()
conn.close()