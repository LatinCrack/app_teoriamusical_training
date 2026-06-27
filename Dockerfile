# Etapa 1: Compilar la aplicación Flutter Web
FROM debian:bookworm-slim AS build-env

# Instalar dependencias requeridas para compilar Flutter
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Descargar y configurar el SDK de Flutter (versión estable)
RUN git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Validar instalación de Flutter
RUN flutter doctor -v

# Copiar el código del proyecto
WORKDIR /app
COPY music_theory_app /app/music_theory_app

# Obtener dependencias y compilar para Web
WORKDIR /app/music_theory_app
RUN flutter pub get
RUN flutter build web --release

# Etapa 2: Servir usando Nginx Alpine
FROM nginx:alpine

# Copiar los archivos compilados en la etapa 1 al directorio de Nginx
COPY --from=build-env /app/music_theory_app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
