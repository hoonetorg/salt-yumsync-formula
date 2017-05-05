# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}

yumsync_config__conffile:
  file.managed:
    - name: {{ yumsync.reposdir }}/{{ yumsync.conffile }}
{% if salt['pillar.get']('yumsync:repos')|default(False) %}
    - contents_pillar: yumsync:repos
{% endif %}
    - makedirs: True
    - mode: 644
    - user: root
    - group: root
