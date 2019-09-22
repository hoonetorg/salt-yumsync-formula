# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - yumsync.install
  - yumsync.config
  - yumsync.cron
  - yumsync.bootimagesync

extend:
  yumsync_config__confdir:
    file:
      - require:
        - pkg: yumsync_install__pkg
  yumsync_cron__cron_sync_script:
    file:
      - require:
        - pkg: yumsync_install__pkg
        - file: yumsync_config__confdir

