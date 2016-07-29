echo "Starting nginx..."

uwsgi uwsgi.ini 
exec /usr/sbin/nginx -g 'daemon off;'
