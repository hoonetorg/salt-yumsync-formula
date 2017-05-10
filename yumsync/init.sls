# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - yumsync.install
  - yumsync.config
  #- yumsync.cron

extend:
  yumsync__file_confdir:
    file:
      - require:
        - pkg: yumsync_install__pkg
  #yumsync_cron__cron:
  #  cron:
  #    - watch:
  #      - file: yumsync_config__conffile
  #    - require:
  #      - pkg: yumsync_install__pkg

