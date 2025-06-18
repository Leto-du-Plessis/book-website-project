from typing import Optional

from fastapi import FastAPI, Query

import database as db

app = FastAPI()
database = db.DatabaseManager()

@app.get("/get_document/")
def get_document(
    name: Optional[str] = Query(None)
):
    if name:
        document = database.fetch_document_from_name(name)
    else:
        document = database.fetch_document_from_id(0)
    
    return document
