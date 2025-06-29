import json
import sys
from pathlib import Path

import database as db

script_dir = Path(__file__).resolve().parent
data_path = script_dir.parent / 'test_data' / 'Monsters_Test.json'
db_path = script_dir.parent / 'database' / 'test_database.db'

database = db.DatabaseManager() 
database.initialize_books()
database.initialize_genres()
database.initialize_book_genres()

# with open(data_path, 'r', encoding='utf-8') as f:
#     json_obj = json.load(f)

# json_string = json.dumps(json_obj)

# database = db.DatabaseManager()
# database.insert_into_database('Monsters Test Data', json_string)


