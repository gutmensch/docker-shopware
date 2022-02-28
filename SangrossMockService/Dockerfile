FROM python:3.7-alpine

WORKDIR /code

RUN apk add --no-cache curl gcc musl-dev libxml2-dev libxslt-dev linux-headers

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

EXPOSE 8000

COPY code/ /code/

CMD ["python", "server.py"]
