# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}

yumsync_cron__cronscript:
  file.managed:
    - name: {{yumsync.cronscriptdir}}/{{yumsync.cronscript}}
    - source: salt://yumsync/files/yumsyncscript.jinja2
    - user: root
    - group: root
    - mode: '0755'
    - template: jinja
    - makedirs: True

yumsync_cron__cron_sync:
  cron.present:
    - identifier: cron_yumsync_sync
    - name: {{yumsync.cronscriptdir}}/{{yumsync.cronscript}} --sync; rm -Rf /var/tmp/yum-root-*
    - minute: 7
    - hour: 2
    - require:
      - file: yumsync_cron__cronscript

yumsync_cron__cron_set_stable:
  cron.present:
    - identifier: cron_yumsync_set_stable
    - name: {{yumsync.cronscriptdir}}/{{yumsync.cronscript}}; rm -Rf /var/tmp/yum-root-*
    - minute: 7
    - hour: 6
    - require:
      - file: yumsync_cron__cronscript
