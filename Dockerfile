FROM ubuntu:16.04
MAINTAINER : g6nuk
RUN apt-get update && \
    apt-get install -y wget cron && \
    wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo deb http://packages.elastic.co/curator/4/debian stable main > /etc/apt/sources.list.d/curator.list && \
    apt-get update && \
    apt-get install -y elasticsearch-curator && \
    apt-get clean && \ 
    echo "* * * * * LC_ALL=C.UTF-8 /usr/bin/curator --config /tmp/config.yaml /tmp/action.yaml &> /var/log/cron.log \n " >> /var/curator.cron && \ 
    crontab /var/curator.cron && \
    echo "cron.log entry \n" >> /var/log/cron.log

ADD config.yaml /tmp/config.yaml
ADD action.yaml /tmp/action.yaml
CMD service cron start && tail -f /var/log/cron.log
