FROM ubuntu:16.04
MAINTAINER : g6n
RUN apt-get update && \
    apt-get install -y wget vim cron && \
    wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo deb http://packages.elastic.co/curator/4/debian stable main > /etc/apt/sources.list.d/curator.list && \
    apt-get update && \
    apt-get install -y python-elasticsearch-curator && \
    echo "actions: \n  1: \n    action: delete_indices \n    description: \"Delete selected indices\" \n    options: \n      timeout_override: \n      continue_if_exception: False \n      disable_action: False \n    filters: \n     - filtertype: pattern \n       kind: prefix \n       value: \filebeat- \n       exclude: \n     - filtertype: age \n       source: name \n       direction: older \n       timestring: '%Y.%m.%d' \n       unit: \days \n       unit_count: \31 \n       field: \n       stats_result: \n       epoch: \n       exclude: False \n" > /tmp/action.yaml && \
    echo "client: \n  hosts: \n    - \elas.elk.k8ss.otas.nv \n  port: \9200 \n  url_prefix: \n  use_ssl: False \n  certificate: \n  client_cert: \n  client_key: \n  ssl_no_validate: False \n  http_auth: \n  timeout: 30  \n  master_only: False \n  \nlogging: \n  loglevel: INFO \n  logfile: \n  logformat: default \n  blacklist: ['elasticsearch', 'urllib3'] \n" > /tmp/config.yaml && \
    echo "* * * * * /usr/bin/curator --config /tmp/config.yaml /tmp/action.yaml >> /var/log/cron.log \n" >> /var/curator.cron && \ 
    crontab /var/curator.cron && \
    touch /var/log/cron.log

    
CMD tail -f /var/log/cron.log
