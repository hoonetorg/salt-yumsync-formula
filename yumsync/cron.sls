# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "yumsync/map.jinja" import yumsync with context %}

yumsync_cron__cron_sync_script:
  file.managed:
    - name: {{yumsync.cron.scriptdir}}/{{yumsync.cron.sync.script}}
    - source: salt://yumsync/files/yumsyncscript.jinja2
    - user: root
    - group: root
    - mode: '0755'
    - template: jinja
    - makedirs: True

yumsync_cron__cron_sync:
  cron.present:
    - identifier: cron_yumsync_sync
    - name: {{yumsync.cron.scriptdir}}/{{yumsync.cron.sync.script}} --sync; rm -Rf /var/tmp/yum-root-*
    - minute: '{{ yumsync.cron.sync.minute }}'
    - hour: '{{ yumsync.cron.sync.hour }}'
    - daymonth: '{{ yumsync.cron.sync.daymonth }}'
    - month: '{{ yumsync.cron.sync.month }}'
    - dayweek: '{{ yumsync.cron.sync.dayweek }}'
    - require:
      - file: yumsync_cron__cron_sync_script

yumsync_cron__cron_set_stable:
  cron.present:
    - identifier: cron_yumsync_set_stable
    - name: {{yumsync.cron.scriptdir}}/{{yumsync.cron.sync.script}}; rm -Rf /var/tmp/yum-root-*
    - minute: '{{ yumsync.cron.set_stable.minute }}'
    - hour: '{{ yumsync.cron.set_stable.hour }}'
    - daymonth: '{{ yumsync.cron.set_stable.daymonth }}'
    - month: '{{ yumsync.cron.set_stable.month }}'
    - dayweek: '{{ yumsync.cron.set_stable.dayweek }}'
    - require:
      - file: yumsync_cron__cron_sync_script

{% if yumsync.get('clean_before', {}).get('year', False) and yumsync.get('clean_before', {}).get('month', False) and yumsync.get('clean_before', {}).get('day', False) %}
yumsync_cron__cron_clean_script:
  file.managed:
    - name: {{yumsync.cron.scriptdir}}/{{yumsync.cron.clean.script}}
    - source: salt://yumsync/files/yumsyncclean.jinja2
    - user: root
    - group: root
    - mode: '0755'
    - template: jinja
    - makedirs: True

yumsync_cron__cron_clean:
  cron.present:
    - identifier: cron_yumsync_clean
    - name: {{yumsync.cron.scriptdir}}/{{yumsync.cron.clean.script}}
    - minute: '{{ yumsync.cron.clean.minute }}'
    - hour: '{{ yumsync.cron.clean.hour }}'
    - daymonth: '{{ yumsync.cron.clean.daymonth }}'
    - month: '{{ yumsync.cron.clean.month }}'
    - dayweek: '{{ yumsync.cron.clean.dayweek }}'
    - require:
      - file: yumsync_cron__cron_clean_script

{% else %}
yumsync_cron__cron_clean_script:
  file.absent:
    - name: {{yumsync.cron.scriptdir}}/{{yumsync.cron.clean.script}}

yumsync_cron__cron_clean:
  cron.absent:
    - identifier: cron_yumsync_clean

{% endif %}
