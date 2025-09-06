# Ollama Setup
import requests
import os
from time import sleep
CHECK_FILE = "./check.txt"

ollama_url = "http://127.0.0.1:11434"
def connectingWithOllama():
	while True:
		try:
			res = requests.get(ollama_url)
			print("Connected with Ollama server!")
			break
		except Exception as e:
			print("Connecting with Ollama server...")
			sleep(1) # Sleep for 3 seconds as server may take around this much time.
   
def OllamaSetup():
	os.system("apt update && apt upgrade -y && apt install curl -y")
	os.system("curl -sS https://ollama.ai/install.sh | bash")
	os.system("nohup ollama serve &")
	connectingWithOllama()
	os.system("ollama pull phi3")
	os.system("echo \"1\" > check.txt")

# Check if ollama services is not available or shut down! And, make it up and running.
def runOllama():
	os.system(f"ollama 2> {CHECK_FILE}")
	with open(CHECK_FILE, "r") as file:
		line = file.readlines()[0]
		if "not found" in line:
			OllamaSetup()
		else:
			try:
				res = requests.get(ollama_url)
			except Exception as e:
				# logging.debug("Ollama server is not running!")
				print("Ollama server is not running!")
				# logging.debug(f"Staring ollama server at {ollama_url}")
				print(f"Staring ollama server at {ollama_url}")
				os.system("nohup ollama serve &")
				connectingWithOllama()
runOllama()

from langchain_community.llms import Ollama


# Load your local LLaMA model
llm = Ollama(model="phi3")

# System rules (JSON-only, schema, table info)
system_prompt = """You are a SQL query generator. 
Output ONLY valid JSON. Do not write anything before or after the JSON.
The JSON must follow exactly this schema:

{
  "query": null OR "query": "SELECT ...;"
}

Rules:
- Do not output explanations, comments, or multiple JSON objects.
- If the user request cannot be converted to a SQL SELECT query, return exactly:
  {
    "query": null
  }
- The table name is always `Items`.
- The available fields are: id, name, price, category, last_added, qty, isdeadstock, recommendation.
"""

import json
def sql_generator(user_prompt: str):
    
    # User input
    # user_prompt = "Show me the names and prices of all items added in the last 7 days. Return only JSON. Do not include null before JSON."
    user_prompt += "Return only JSON. Do not include null before JSON."

    # Combine system + user into a single request
    full_prompt = f"{system_prompt}\n\nUser request: {user_prompt}"

    # Generate output
    response = llm(full_prompt)
    
    start = response.index("{")
    end = response.index("}") + 1
    
    print("response is: ", response[start:end])

    return json.loads(response[start:end])