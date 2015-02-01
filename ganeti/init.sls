{% from "ganeti/map.jinja" import ganeti with context %}

{% set cfg_ganeti = pillar.get('ganeti', {}) -%}
{%- macro get_config(configname, default_value) -%}
{%- if configname in cfg_ganeti -%}
{{ cfg_ganeti[configname] }}
{%- else -%}
{{ default_value }}
{%- endif -%}
{%- endmacro -%}

ganeti-deps:
  pkg.installed:
    - pkgs: {{ ganeti['pkgs_deps']|json }}
