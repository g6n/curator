# Curator

This Dockerfile is based on Ubuntu 16.04
It installs the latest available curator package from the debian 4.0 elastic search repo.

It runs curator as a hourly cron job at n:01

Curator requires two files to run.
action.yaml and config.yaml
both these files are included in this repo, but are rather specific.

When using Kubernetes, substitute these files with a configmap that while set the appropiate settings for your indexes
and overwirte the files included in the build.

The default build has the following settings:
  action.yaml
    action 1 looks for indexes named filebeat-*
    that are older than 14 days
    and will delete these

    action2 looks for indexes named lpt-*
    that are older then 90 days
    and will delete these

  config.yaml
   sets the elasticsearch host to elas
   sets the elasticsearch host port to 9200
   uses no authentication or transport security
   logs INFO messages to the default output (defined in the Dockerfile)


