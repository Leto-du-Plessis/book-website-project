from typing import Optional
from datetime import timedelta

from fastapi import FastAPI, HTTPException, Query, Depends
from fastapi.security import OAuth2PasswordRequestForm
from fastapi.middleware.cors import CORSMiddleware

import database as db
from auth import Authenticator
from user import User

app = FastAPI()
database = db.DatabaseManager()
authenticator = Authenticator(database)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.middleware("http")
async def add_csp_header(request, call_next):
    response = await call_next(request)
    response.headers["Content-Security-Policy"] = "default-src 'self'; connect-src 'self' http://127.0.0.1:8000;"
    return response

@app.post("/token")
def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    '''
    Authenticates a user and returns a JWT token if succesful.
    '''
    user = authenticator.authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect username or password")

    access_token_expires = timedelta(minutes=30)
    access_token = authenticator.create_access_token(data={"sub": form_data.username}, expires_delta=access_token_expires)

    return {"access_token": access_token, "token_type": "bearer"}

@app.get("/get_document/")
def get_document(
    name: Optional[str] = Query(None)
):
    if name:
        document = database.fetch_document_from_name(name)
    else:
        document = database.fetch_document_from_id(0)
    
    return document

@app.get("/get_user_information", response_model=User)
def get_user_information(
    name: str = Query(None)
):
    user_info = database.fetch_user_information(name)
    if user_info:
        try:
            return User(user_info["username"], user_info["image_bytes"])
        except ValueError as e:
            raise HTTPException(status_code=404, detail=str(e))
    raise HTTPException(status_code=404, detail="User could not be found.")
