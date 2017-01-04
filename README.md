# Curator

This Dockerfile is based on Ubuntu 16.04
It installs curator from the debian 4.0 elastic search repo.

It runs curator as a hourly cron job at n:01

# The Theory:
It requires 5 environmental variables:
curator_hosts=<hostnames> e.g. elasticsearch
curator_port=<portname> e.g. 9200 (only used if hosts do not have a hostname:portname markup
curator_delete_unit=<unit of time> e.g. days
curator_delete_unit_count=<amount of unit of time> e.g. 14
curator_index_prefix=<nameof the index> #e.g. logstash-

# In practice:
Cron doesn't work well with ENV settings, so defining them in the docker/kubernetes settings doesn't work at the moment.
Easiest workaround is to fork your own version with the fixed settings.
A solution would be highly appreciated :D


It assumes a YYYY.MM.DD date format at the end of the index name.
