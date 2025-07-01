from pydantic import BaseModel

class BookSummary(BaseModel): 

    id: int
    title: str 
    tagline: str | None
    summary: str | None
    imageId: str | None
