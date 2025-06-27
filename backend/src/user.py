from pydantic import BaseModel

class User(BaseModel):
    username: str
    image_bytes: str