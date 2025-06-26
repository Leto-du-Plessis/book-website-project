from pathlib import Path
import sqlite3 as sql

class DatabaseManager:

    def __init__(self, path = None):

        if path:
            self.path = path
        else: 
            self.path = self._test_database_path()

    # Initialization methods
    # ----------------------------------------------------
    
    def initialize_books(self):
        '''
        Creates a table in the database to store books if it does not already exist.
        '''
        conn = sql.connect(self.path)
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

    def initialize_users(self):
        '''
        Creates a table in the database to store users if it does not already exist
        '''
        conn = sql.connect(self.path)
        cursor = conn.cursor()

        cursor.execute('''
                    CREATE TABLE IF NOT EXISTS user_database (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    username TEXT,
                    hashed_password TEXT,
                    profile_image TEXT, 
                    )
                    ''')

        conn.commit()
        conn.close()

    # Helper methods
    # ----------------------------------------------------

    def _test_database_path(self) -> str:
        '''
        Returns the directory path of the test database.
        '''
        script_dir = Path(__file__).resolve().parent
        db_path = script_dir.parent / 'database' / 'test_database.db'
        return db_path
    
    # Insert methods
    # ----------------------------------------------------

    def insert_into_database(self, name: str, body: str):
        '''
        Inserts the provided document into the database with the name provided.
        '''
        conn = sql.connect(self.path)
        cursor = conn.cursor()

        cursor.execute('''
                       INSERT INTO test_database (name, body) VALUES (?, ?)
                       ''', (name, body))
        
        conn.commit()
        conn.close()

    # Retrieve methods
    # ----------------------------------------------------

    def get_user(self, username: str):
        conn = sql.connect(self.path)
        cursor = conn.cursor() 

        cursor.execute("SELECT * FROM users WHERE username = ?", (username,))
        user = cursor.fetchone()

        conn.close()

        if user:
            return {"id": user[0], "username": user[1], "hashed_password": user[2]}
        return None

    def fetch_document_from_name(self, name: str):
        '''
        Fetch a document given the provided name.
        '''
        conn = sql.connect(self.path)
        cursor = conn.cursor()

        cursor.execute('''
                       SELECT body FROM test_database WHERE name = ?
                       ''', (name,))
        row = cursor.fetchone()
        conn.close()

        return row[0]
    
    def fetch_document_from_id(self, id: int):
        '''
        Fetch a document with the provided id.
        '''
        conn = sql.connect(self.path)
        cursor = conn.cursor()

        cursor.execute('''
                       SELECT body FROM test_database WHERE id = ?
                       ''', (id, ))
        row = cursor.fetchone()
        conn.close()

        return row[0]

