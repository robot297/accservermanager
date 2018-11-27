FROM ubuntu:latest

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wine-development python3-pip && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install django django-material random-word

RUN useradd -ms /bin/bash someuser
USER someuser

ENV WINEARCH=win64 \
    WINEDEBUG=-all
RUN wineboot --init

VOLUME /server
ADD . /accservermanager
WORKDIR /accservermanager

EXPOSE 9231 9232 8000
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
