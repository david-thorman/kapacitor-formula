{% from "kapacitor/map.jinja" import kapacitor with context %}

{%- for conf in kapacitor.config %}
{%- if conf.table_name in ['replay', 'task'] %}
kapacitor-config-{{ conf.table_name }}:
  file.directory:
    - name: {{ conf.dir }}
    - user: kapacitor
    - group: kapacitor
    - makedirs: true
    - recurse:
      - user
      - group
{%- endif %}
{%- if conf.table_name == 'storage' %}
kapacitory-config-{{ conf.table_name }}:
  file.managed:
    - name: {{ conf.boltdb }}
    - mode: 644
    - user: kapacitor
    - group: kapacitor
    - makedirs: true
    - replace: false
{%- endif %}
{%- endfor %}

kapacitor-config:
  file.managed:
    - name: /etc/kapacitor/kapacitor.conf
    - source: salt://kapacitor/files/kapacitor.conf
    - user: kapacitor
    - group: kapacitor
    - mode: 644
    - context:
        kapacitor: {{ kapacitor }}
    - template: jinja
    - require:
      - sls: kapacitor.install
