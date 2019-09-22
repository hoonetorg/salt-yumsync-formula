# vim: sts=2 ts=2 sw=2 et ai
{% from "yumsync/map.jinja" import yumsync with context %}

yumsync_bootimagesync__bootimagesync_pkgs:
  pkg.installed:
    - pkgs: {{yumsync.bootimagesync.pkgs | tojson}}

yumsync_bootimagesync__bootimagesync_confdir:
  file.recurse:
    - name: {{yumsync.bootimagesync.confdir}}
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
    - source: salt://yumsync/files/configbootimagesync
    - require:
      - pkg: yumsync_bootimagesync__bootimagesync_pkgs

yumsync_bootimagesync__cronbootimagesynclinks:
  cron.present:
    - identifier: cron_cronbootimagesynclinks
    - name: /bin/bootimagesync-links -v
    - minute: '{{ yumsync.bootimagesync.cron.minute }}'
    - hour: '{{ yumsync.bootimagesync.cron.hour }}'
    - daymonth: '{{ yumsync.bootimagesync.cron.daymonth }}'
    - month: '{{ yumsync.bootimagesync.cron.month }}'
    - dayweek: '{{ yumsync.bootimagesync.cron.dayweek }}'
    - require:
      - pkg: yumsync_bootimagesync__bootimagesync_pkgs
      - file: yumsync_bootimagesync__bootimagesync_confdir
