# App de Teoría Musical - Plataforma Interactiva

Una aplicación moderna y premium para el aprendizaje y práctica de lectura musical, diseñada bajo una arquitectura modular, escalable y visualmente atractiva.

## Características principales
- **Identificación de Notas**: Práctica interactiva en tiempo real en Clave de Sol y Clave de Fa.
- **Renderizado Fiel al Píxel**: Construido utilizando la fuente estándar de la industria `Bravura` y los codepoints SMuFL para una alineación perfecta de las claves y las notas en el pentagrama.
- **Diseño Visual Estilo 2026**: Fondo radial oscuro premium, botones con gradientes modernos, sombras con glow dinámico y micro-escalado al tacto.

## Arquitectura de Despliegue
La aplicación está construida sobre **Flutter Web** y se sirve en producción a través de un servidor **Nginx Alpine**. 
La dockerización utiliza una estrategia de compilación multi-etapa (multi-stage build):
1. **Build Stage**: Entorno basado en Debian donde se instala git, se descarga el SDK de Flutter estable y se ejecuta `flutter build web --release` para obtener el código estático compilado.
2. **Production Stage**: Entorno Nginx ultra-ligero que monta el build final estático, sirviendo la aplicación de forma rápida y optimizada en el puerto `80`.

---

## Cómo Empezar

### Requisitos Previos
- Tener instalado [Docker](https://www.docker.com/) y [Docker Compose](https://docs.docker.com/compose/).
- Tener instalado [Git](https://git-scm.com/).

### 1. Clonar el repositorio
Abre una terminal en tu máquina local y ejecuta:
```bash
git clone <URL_DE_TU_REPOSITORIO_EN_GITHUB>
cd music_theory_project
```

### 2. Levantar la aplicación con Docker Compose
Para compilar la imagen y levantar el contenedor web en segundo plano, ejecuta:
```bash
docker-compose up -d --build
```
Una vez terminado el proceso de construcción, abre tu navegador y entra a:
👉 **[http://localhost:8080](http://localhost:8080)**

Para detener la aplicación:
```bash
docker-compose down
```

---

## Desarrollo Local sin Docker
Si deseas realizar cambios locales utilizando el entorno aislado integrado en el proyecto (PowerShell en Windows):
- Ejecuta `.\run_flutter.ps1 run -d chrome` desde el directorio raíz.
