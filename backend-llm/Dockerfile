FROM pytorch/pytorch
# RUN apt update && apt upgrade -y
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY ./ .
EXPOSE 8000
CMD [ "/bin/bash" ]
#CMD [ "uvicorn", "app.main:app", "--reload", "--host", "0.0.0.0", "--port", "8000" ]