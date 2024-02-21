FROM nginx
RUN apt-get update && apt-get upgrade && apt-get -y install cron

COPY static-html /usr/share/nginx/html


RUN curl -i -o /usr/share/nginx/html/discovery.meethue.txt https://discovery.meethue.com


# https://stackoverflow.com/questions/37458287/how-to-run-a-cron-job-inside-a-docker-container

COPY get-meethue-info /etc/cron.d/get-meethue-info
RUN chmod 0644 /etc/cron.d/get-meethue-info
RUN crontab /etc/cron.d/get-meethue-info
RUN touch /var/log/cron.log
CMD curl -i -o /usr/share/nginx/html/discovery.meethue.txt https://discovery.meethue.com && cron && tail -f /var/log/cron.log
