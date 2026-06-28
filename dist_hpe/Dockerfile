# Servidor web ligero con Nginx Alpine
FROM nginx:alpine

# Copiar el build estático pre-compilado de la PWA
COPY web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
