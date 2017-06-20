# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}

yumsync_config__confdir:
  file.recurse:
    - name: {{yumsync.confdir}}
    - clean: True
    - include_empty: True
    - force_symlinks: True
    - keep_symlinks: True
    - exclude_pat: .gitkeep
    - user: root
    - group: root
    - dir_mode: '0775'
    - file_mode: '0644'
    - template: jinja
    - source: salt://yumsync/files/config
