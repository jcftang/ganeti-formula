{% from "ganeti/map.jinja" import ganeti with context %}

{% set cfg_ganeti = pillar.get('ganeti', {}) -%}
{%- macro get_config(configname, default_value) -%}
{%- if configname in cfg_ganeti -%}
{{ cfg_ganeti[configname] }}
{%- else -%}
{{ default_value }}
{%- endif -%}
{%- endmacro -%}


{% if grains['os'] == 'Ubuntu' %}
ganeti-repo:
  pkgrepo.managed:
    - ppa: pkg-ganeti-devel/lts
    - require_in:
      - pkg: ganeti
{% endif %}


ganeti-deps:
  pkg.installed:
    - pkgs: {{ ganeti['pkgs_deps']|json }}

ganeti:
  pkg.installed:
    - require:
      - pkg: ganeti-deps

/etc/modprobe.d/drbd.conf:
  file.append:
    - text: options drbd minor_count=128 usermode_helper=/bin/true
    - require:
      - pkg: ganeti-deps

/etc/modules:
  file.append:
    - text: drbd
    - require:
      - pkg: ganeti-deps
