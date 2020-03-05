FROM nginx
LABEL ca.rullmann.author="Ernst Rullmann" \
      ca.rullmann.email="e.rullmann@gmail.com" \
      ca.rullmann.version="1.0"


RUN apt update
RUN apt install certbot -y

COPY . /etc/nginx/
RUN rm -rf /etc/nginx/conf.d

CMD [ "nginx", "-g", "daemon off;" ]
