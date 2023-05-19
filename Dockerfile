# Utiliza la imagen base de Apache
FROM httpd:2.4

# Copia los archivos de la aplicación web al directorio de documentos de Apache
COPY ./build/web/ /usr/local/apache2/htdocs/

# Exponer el puerto 80 para el tráfico HTTP
EXPOSE 4200