FROM debian:latest

COPY backend/ /var/www/html/backend
COPY frontend/ /var/www/html/frontend
COPY .htaccess /var/www/html/.htaccess
COPY logo.png /var/www/html/logo.png