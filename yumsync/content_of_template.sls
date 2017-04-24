# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}

/tmp/yumsync.yaml:
  file.managed:
    - contents: |
        {{yumsync|yaml(False)|indent(8)}}
