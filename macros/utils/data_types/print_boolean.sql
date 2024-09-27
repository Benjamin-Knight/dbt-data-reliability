{%- macro print_boolean(value) -%}
    {{ return(adapter.dispatch('print_boolean', 'elementary')(value)) }}
{%- endmacro -%}

{% macro default__print_boolean(value) -%}
    {{ value }}
{%- endmacro %}

{% macro sqlserver__print_boolean(value) -%}
    {{ elementary.edr_cast_as_bool(elementary.edr_quote(value)) }}
{%- endmacro %}