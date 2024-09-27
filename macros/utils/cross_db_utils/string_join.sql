{% macro string_join() %}
  {% do return(adapter.dispatch("string_join", "elementary")()) %}
{% endmacro %}

{%- macro default__string_join() -%}
  ||
{%- endmacro -%}

{%- macro sqlserver__string_join() -%}
  +
{%- endmacro -%}