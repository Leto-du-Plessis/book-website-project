from datetime import datetime, timedelta
from typing import Optional

from fastapi import Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
from passlib.context import CryptContext

from database import DatabaseManager

class Authenticator:

    _SECRET_KEY = "key1"
    _ALGORITHM = "HS256"
    _ACCESS_TOKEN_EXPIRES_MINUTES = 30
    _pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

    def __init__(self, database: DatabaseManager):
        self.database = database

    def verify_password(self, plain_password, hashed_password):
        return self._pwd_context.verify(plain_password, hashed_password)

    def get_password_hash(self, password):
        return self._pwd_context.hash(password)

    def authenticate_user(self, username: str, password: str):
        user = self.database.get_user(username) 
        if not user or not self.verify_password(password, user["hashed_password"]):
            return None
        return user 

    def create_access_token(self, data: dict, expires_delta: Optional[timedelta] = None):
        to_encode = data.copy() 
        expire = datetime.utcnow() + (expires_delta or timedelta(minutes=15)) # deprecated but alternative offered doesn't work ??? 
        to_encode.update({"exp": expire})
        return jwt.encode(to_encode, self._SECRET_KEY, algorithm=self._ALGORITHM)

    def get_current_user(self, token: str = Depends(OAuth2PasswordBearer(tokenUrl="token"))):
        try:
            payload = jwt.decode(token, self._SECRET_KEY, algorithms=[self._ALGORITHM])
            username: str = payload.get("sub")
            if username is None:
                raise HTTPException(status_code=401, detail="Invalid authentication credentials")
        except JWTError:
            raise HTTPException(status_code=401, detail="Invalid token")
        
        user = self.database.get_user(username)
        if user is None:
            raise HTTPException(status_code=401, detail="User not found")
        
        return user["username"]
    
    def get_current_user_id(self, token: str = Depends(OAuth2PasswordBearer(tokenUrl="token"))):
        try:
            payload = jwt.decode(token, self._SECRET_KEY, algorithms=[self._ALGORITHM])
            username: str = payload.get("sub")
            if username is None:
                raise HTTPException(status_code=401, detail="Invalid authentication credentials")
        except JWTError:
            raise HTTPException(status_code=401, detail="Invalid token")
        
        user = self.database.get_user(username)
        if user is None:
            raise HTTPException(status_code=401, detail="User not found")
        
        return user["id"]
    
    def get_user_or_null(self):
        try:
            return self.get_current_user()
        except HTTPException:
            return None