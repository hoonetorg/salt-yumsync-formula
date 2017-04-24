# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - yumsync.install
  - yumsync.config
  - yumsync.service

extend:
  yumsync_config__conffile:
    file:
      - require:
        - pkg: yumsync_install__pkg
  yumsync_service__service:
    service:
      - watch:
        - file: yumsync_config__conffile
      - require:
        - pkg: yumsync_install__pkg

