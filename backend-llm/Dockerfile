FROM python:3.11.13-bullseye
# RUN apt update && apt upgrade -y && apt install curl -y
# RUN curl -sS https://ollama.ai/install.sh | bash
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY ./ .
EXPOSE 8000
# CMD [ "/bin/bash" ]
CMD [ "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload" ]