# Используем базовый образ Ubuntu 18.04
FROM ubuntu:18.04

# Устанавливаем временную зону и отключаем интерактивный ввод
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow

# Устанавливаем Python и необходимые зависимости
RUN apt update && apt install -qqy \
    python-all \
    python-pip \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Копируем файл requirements.txt в контейнер
COPY app/requirements.txt /tmp/

# Устанавливаем зависимости из requirements.txt
RUN pip install -qr /tmp/requirements.txt

# Указываем рабочую директорию
WORKDIR /opt/webapp

# Копируем приложение в контейнер
COPY ./app/app.py /opt/webapp

# Указываем порт, на котором работает приложение
EXPOSE 5000

# Точка входа: запуск приложения через app.py
ENTRYPOINT ["python", "app.py"]
