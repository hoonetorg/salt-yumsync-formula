# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}

yumsync_service__service:
  service.{{ yumsync.service.state }}:
    - name: {{ yumsync.service.name }}
{% if yumsync.service.state in [ 'running', 'dead' ] %}
    - enable: {{ yumsync.service.enable }}
{% endif %}

