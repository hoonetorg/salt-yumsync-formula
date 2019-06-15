# vim: sts=2 ts=2 sw=2 et ai
{% from "yumsync/map.jinja" import yumsync with context %}

yumsync_bootimagesync__pkgbootimagesync:
  pkg.installed:
    - pkgs: {{yumsync.pkgsbootimagesync | tojson}}

yumsync_bootimagesync__confdirbootimagesync:
  file.recurse:
    - name: {{yumsync.confdirbootimagesync}}
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
      - pkg: yumsync_bootimagesync__pkgbootimagesync

yumsync_bootimagesync__cronbootimagesynclinks:
  cron.present:
    - identifier: cron_cronbootimagesynclinks
    - name: /bin/bootimagesync-links -v
    - minute: 7
    - hour: 7
    - require:
      - pkg: yumsync_bootimagesync__pkgbootimagesync
      - file: yumsync_bootimagesync__confdirbootimagesync
