from pathlib import Path
import sqlite3 as sql
from passlib.context import CryptContext

class DatabaseManager:

    def __init__(self, path = None):

        if path:
            self.path = path
        else: 
            self.path = self._test_database_path()
        self.pwd_context = CryptContext(schemes=["bcrypt"])

    # Initialization methods
    # ----------------------------------------------------
    
    def initialize_test_books(self):
        '''
        Creates a table in the database to store books if it does not already exist.
        '''
        conn = sql.connect(self.path)
        cursor = conn.cursor()

        # need to extend to also store file paths for book front cover images.
        cursor.execute('''
                    CREATE TABLE IF NOT EXISTS test_database (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT,
                    body TEXT
                    )
                    ''')

        conn.commit()
        conn.close()

    def initialize_books(self):
        '''
        Creates a table in the database to store books if it does not already exist.
        '''
        conn = sql.connect(self.path)
        cursor = conn.cursor()

        cursor.execute('''
                       CREATE TABLE IF NOT EXISTS books_database (
                       id INTEGER PRIMARY KEY AUTOINCREMENT,
                       name TEXT,
                       author TEXT,
                       body TEXT
                       )
                       ''')
        
    def initialize_genres(self):
        '''
        Creates a table in the database to store genres if it does not already exist.
        '''
        conn = sql.connect(self.path)
        cursor = conn.cursor()

        cursor.execute('''
                       CREATE TABLE IF NOT EXISTS genres_database (
                       id INTEGER PRIMARY KEY AUTOINCREMENT,
                       name TEXT UNIQUE
                       )
                       ''')
        
    def initialize_book_genres(self):
        '''
        Creates a table in the database to store genres per book if it does not already exist.
        '''
        conn = sql.connect(self.path)
        cursor = conn.cursor()

        cursor.execute('''
                       CREATE TABLE IF NOT EXISTS book_genres_database (
                       book_id INTEGER,
                       genre_id INTEGER,
                       FOREIGN KEY(book_id) REFERENCES books_database(id),
                       FOREIGN KEY(genre_id) REFERENCES genres_database(id),
                       PRIMARY KEY(book_id, genre_id)
                       )
                       ''')

    def initialize_users(self):
        '''
        Creates a table in the database to store users if it does not already exist
        '''
        conn = sql.connect(self.path)
        cursor = conn.cursor()

        # need to change to reflect the fact that the profile_image will in fact be a file path pointing to the image.
        cursor.execute('''
                    CREATE TABLE IF NOT EXISTS user_database (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    username TEXT,
                    hashed_password TEXT,
                    profile_image TEXT 
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
    
    def hash_password(self, password: str) -> str:
        return self.pwd_context.hash(password)
    
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

    def insert_user(self, username: str, password: str):
        conn = sql.connect(self.path)
        cursor = conn.cursor()

        try:
            cursor.execute("""
                INSERT INTO user_database (username, hashed_password)
                VALUES (?, ?)
            """, (username, self.hash_password(password)))

            conn.commit()
        except sql.IntegrityError:
            raise ValueError("Username already exists")
        finally:
            conn.close()

    # Retrieve methods
    # ----------------------------------------------------

    def fetch_user(self, username: str):
        conn = sql.connect(self.path)
        cursor = conn.cursor() 

        cursor.execute("SELECT * FROM user_database WHERE username = ?", (username,))
        user = cursor.fetchone()

        conn.close()

        if user:
            return {"id": user[0], "username": user[1], "hashed_password": user[2]}
        return None
    
    def fetch_user_information(self, username: str):
        conn = sql.connect(self.path)
        cursor = conn.cursor()

        cursor.execute("SELECT * FROM user_database WHERE username = ?", (username,))
        user = cursor.fetchone()

        conn.close()

        if user:
            return {"username": user[1], "image_bytes": user[3]}
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

