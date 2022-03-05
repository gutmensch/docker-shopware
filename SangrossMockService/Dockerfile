FROM python:3.8-alpine

WORKDIR /code

COPY requirements.txt requirements.txt
COPY code/ /code/

RUN apk add --no-cache curl gcc musl-dev \
  && pip install -r requirements.txt \
  && apk del gcc musl-dev

# mimicks actual environment
ENV SCRIPT_NAME="/csp/kpsdat/nw.nwAPI.cls" SERVER_PORT=57773

EXPOSE $SERVER_PORT

CMD ["python", "server.py"]
