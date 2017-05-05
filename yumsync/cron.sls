# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}

yumsync_cron__cron:
  cron.{{ yumsync.cron.state }}:
    - name: {{ yumsync.cron.name }}
{% if yumsync.cron.state in [ 'running', 'dead' ] %}
    - enable: {{ yumsync.cron.enable }}
{% endif %}

