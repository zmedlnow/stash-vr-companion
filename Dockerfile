FROM python:3.10-bookworm
LABEL org.opencontainers.image.source="https://github.com/zmedlnow/stash-vr-companion"


RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

    
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV CACHE_DIR=/cache/
ENV HSP_DIR=/hsp/
COPY requirements.txt /
RUN pip3 install -r /requirements.txt

COPY . /app
WORKDIR /app

#CMD [ "flask","run","--host=0.0.0.0"]
CMD ["uwsgi","--http=:5000","--wsgi-file=app.py","--callable", "app","--enable-threads"]
