from fastapi import FastAPI, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from pydantic import BaseModel



# For User Login Schema
class Query(BaseModel):
    query: str
    
    
    class Config:
        orm_mode = True
        
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root():
	return {"message":"Hello, World!"}


from .DeadStockAI import sql_generator
@app.post("/query")
async def user_query(query: Query):
    try:
        get_sql = sql_generator(query.query)
        return JSONResponse(content={"message":get_sql}, status_code=status.HTTP_200_OK)
    except Exception as e:
        print("Exception: ", e)
        return JSONResponse(content={"message":e}, status_code=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
