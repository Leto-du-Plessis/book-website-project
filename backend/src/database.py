from pathlib import Path
import sqlite3 as sql

class DatabaseManager:

    def __init__(self, path = None):

        if path:
            self.path = path
        else: 
            self.path = self._test_database_path()

    def _test_database_path() -> str:
        '''
        Returns the directory path of the test database.
        '''
        script_dir = Path(__file__).resolve().parent
        db_path = script_dir.parent / 'database' / 'test_database.db'
        return db_path
    
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

