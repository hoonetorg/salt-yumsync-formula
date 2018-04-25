# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}

yumsync_cron__cronscriptsync:
  file.managed:
    - name: {{yumsync.cronscriptdir}}/{{yumsync.cronscriptsync}}
    - source: salt://yumsync/files/yumsyncscript.jinja2
    - user: root
    - group: root
    - mode: '0755'
    - template: jinja
    - makedirs: True

yumsync_cron__cron_sync:
  cron.present:
    - identifier: cron_yumsync_sync
    - name: {{yumsync.cronscriptdir}}/{{yumsync.cronscriptsync}} --sync; rm -Rf /var/tmp/yum-root-*
    - minute: 7
    - hour: 2
    - require:
      - file: yumsync_cron__cronscriptsync

yumsync_cron__cron_set_stable:
  cron.present:
    - identifier: cron_yumsync_set_stable
    - name: {{yumsync.cronscriptdir}}/{{yumsync.cronscriptsync}}; rm -Rf /var/tmp/yum-root-*
    - minute: 7
    - hour: 6
    - require:
      - file: yumsync_cron__cronscriptsync

{% if yumsync.get('clean_before', {}).get('year', False) and yumsync.get('clean_before', {}).get('month', False) and yumsync.get('clean_before', {}).get('day', False) %}
yumsync_cron__cronscriptclean:
  file.managed:
    - name: {{yumsync.cronscriptdir}}/{{yumsync.cronscriptclean}}
    - source: salt://yumsync/files/yumsyncclean.jinja2
    - user: root
    - group: root
    - mode: '0755'
    - template: jinja
    - makedirs: True

yumsync_cron__cron_clean:
  cron.present:
    - identifier: cron_yumsync_clean
    - name: {{yumsync.cronscriptdir}}/{{yumsync.cronscriptclean}}
    - minute: 7
    - hour: 2
    - require:
      - file: yumsync_cron__cronscriptclean

{% else %}
yumsync_cron__cronscriptclean:
  file.absent:
    - name: {{yumsync.cronscriptdir}}/{{yumsync.cronscriptclean}}

yumsync_cron__cron_clean:
  cron.absent:
    - identifier: cron_yumsync_clean

{% endif %}
