# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}

yumsync__file_confdir:
  file.recurse:
    - name: {{yumsync.confdir}}
    #- exclude_pat: E@hosts/.*/install/.*conf
    - clean: True
    - include_empty: True
    - force_symlinks: True
    - keep_symlinks: True
    - user: root
    - group: root
    - dir_mode: '0775'
    - file_mode: '0644'
    - template: jinja
    - source: salt://yumsync/files/config
