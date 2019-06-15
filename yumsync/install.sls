# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}

yumsync_install__pkg:
  pkg.installed:
    - pkgs: {{ yumsync.pkgs | tojson }}
