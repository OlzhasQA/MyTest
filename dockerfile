FROM python:3.12-slim

# Установка системных зависимостей (вместо твоих apk и wget)
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Используем версию 21, так как 17-я удалена из репозиториев Trixie
    openjdk-21-jre-headless \
    chromium \
    # В новых версиях Debian драйвер часто идет в пакете chromium-driver или просто chromedriver
    chromium-driver || apt-get install -y chromedriver \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Установка Allure (обновил версию для тебя)
RUN curl -o allure-2.24.0.tgz -Ls https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/2.24.0/allure-commandline-2.24.0.tgz && \
    tar -zxvf allure-2.24.0.tgz -C /opt/ && \
    ln -s /opt/allure-2.24.0/bin/allure /usr/bin/allure && \
    rm allure-2.24.0.tgz

WORKDIR /usr/workspace

# Установка зависимостей Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копирование всего проекта
COPY . .

# Команда запуска
CMD ["python3", "-m", "pytest", "--alluredir=report"]