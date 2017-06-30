{% from "kapacitor/map.jinja" import kapacitor with context %}

kapacitor-service:
  service.{{ "running" if kapacitor.enabled else "dead" }}:
    - name: kapacitor
    - enable: {{ kapacitor.enabled }}
    - watch:
      - sls: kapacitor.install
      - sls: kapacitor.config
    - require:
      - sls: kapacitor.install
      - sls: kapacitor.config
