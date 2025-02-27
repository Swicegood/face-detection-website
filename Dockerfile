# Dockerfile

# FROM directive instructing base image to build upon
FROM python:3.7-buster
RUN apt-get update && apt-get install nginx vim cron default-libmysqlclient-dev -y --no-install-recommends
COPY nginx.default /etc/nginx/sites-available/default
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
RUN mkdir -p /opt/app
RUN mkdir -p /opt/app/pip_cache
RUN mkdir -p /opt/app/face_website
COPY requirements.txt start-server.sh crontab /opt/app/
RUN crontab /opt/app/crontab
COPY .pip_cache /opt/app/pip_cache/
ADD  face_website /opt/app/face_website/
WORKDIR /opt/app
RUN pip install -r requirements.txt --cache-dir /opt/app/pip_cache
RUN chown -R www-data:www-data /opt/app
RUN pip3 uninstall mysqlclient -y; pip3 install mysqlclient
EXPOSE 8020
STOPSIGNAL SIGTERM
CMD ["/opt/app/start-server.sh"]
