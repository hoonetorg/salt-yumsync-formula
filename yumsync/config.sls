# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}

yumsync_config__conffile:
  file.managed:
    - name: {{ yumsync.conffile }}
    - source: salt://yumsync/files/configtempl.jinja
    - template: jinja
    - context:
      confdict: {{yumsync|json}}
    - mode: 644
    - user: root
    - group: root
