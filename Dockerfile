FROM nginx:1.11.1-alpine

ENV FLASK_HOME /usr/share/flask

ENV NGINX_HOME /usr/share/nginx/html
ENV NGINX_CONF /etc/nginx
ENV UWSGI_CONF /etc/uwsgi

WORKDIR $NGINX_HOME

RUN mkdir assets
RUN mkdir $NGINX_CONF/logs
RUN mkdir -p $UWSGI_CONF

COPY nginx/nginx.conf $NGINX_CONF
ADD nginx/certs $NGINX_CONF

ADD demo $NGINX_HOME
COPY index.html $NGINX_HOME

RUN mkdir $FLASK_HOME
ADD flask $FLASK_HOME

WORKDIR $FLASK_HOME

#COPY requirements.txt $FLASK_HOME

RUN apk add --no-cache python3-dev g++ libffi-dev sqlite linux-headers
RUN python3 -m ensurepip
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt


COPY entrypoint.sh /

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
