{% from "logentries_agent/map.jinja" import logentries_agent_settings with context %}

{% if grains.os_family == 'Debian' %}
logentries-repo:
    pkgrepo.managed:
        - humanname: Logentries
        - name: deb http://rep.logentries.com/ {{ grains.oscodename }} main
        - keyid: C43C79AD
        - keyserver: pgp.mit.edu
        - require_in:
            - logentries-daemon
{% endif %}

logentries-deps:
    pkg.installed:
        - pkgs: {{ logentries_agent_settings.deps|json }}

{{ logentries_agent_settings.logentries }}:
    pkg.installed:
        - pkgs:
            - {{ logentries_agent_settings.logentries }}
    file.managed:
        - source: salt://logentries_agent/files/config
        - name: /etc/le/config
        - template: jinja

{{ logentries_agent_settings.logentries_daemon }}:
    pkg.installed:
        - require:
            - pkg: logentries-deps
            - pkg: {{ logentries_agent_settings.logentries }}
    service.running:
        - enable: True
        - name: {{ logentries_agent_settings.service }}
        - watch:
            - file: /etc/le/config
