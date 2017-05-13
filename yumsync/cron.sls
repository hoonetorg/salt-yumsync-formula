# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}
#FIXME: for repo in /etc/yumsync/*.yml; do yumsync --stable -c $repo -o /srv/export/repo/ ; done
yumsync_cron__cron:
  cron.{{ yumsync.cron.state }}:
    - name: {{ yumsync.cron.name }}
{% if yumsync.cron.state in [ 'running', 'dead' ] %}
    - enable: {{ yumsync.cron.enable }}
{% endif %}

