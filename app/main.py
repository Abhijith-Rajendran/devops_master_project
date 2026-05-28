from fastapi import FastAPI
import os

app = FastAPI()

@app.get("/")
def read_root():
    return {
        "status": "Healthy",
        "environment": os.getenv("ENV", "Development"),
        "message": "DevOps Pipeline is running!"
    }