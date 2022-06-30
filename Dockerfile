FROM python:3.9.13-slim-bullseye

RUN apt-get update \
        && apt-get install unixodbc -y \
        && apt-get install unixodbc-dev -y \
        && apt-get install freetds-dev -y \
        && apt-get install freetds-bin -y \
        && apt-get install tdsodbc -y \
        && apt-get install --reinstall build-essential -y

RUN echo "[FreeTDS]\n\
Description = FreeTDS Driver\n\
Driver = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so\n\
Setup = /usr/lib/x86_64-linux-gnu/odbc/libtdsS.so" >> /etc/odbcinst.ini

COPY requirements.txt /tmp/requirements.txt

RUN pip install -r /tmp/requirements.txt --no-cache-dir

COPY ./app /app

WORKDIR /app

CMD ["python", "./app.py"]