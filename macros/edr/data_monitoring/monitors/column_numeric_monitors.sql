{% macro standard_deviation(column_name) %}
  {% do return(adapter.dispatch("standard_deviation", "elementary")(column_name)) %}
{% endmacro %}

{% macro variance(column_name) %}
  {% do return(adapter.dispatch("variance", "elementary")(column_name)) %}
{% endmacro %}

{% macro max(column_name) -%}
    max(cast({{ column_name }} as {{ elementary.edr_type_float() }}))
{%- endmacro %}

{% macro min(column_name) -%}
    min(cast({{ column_name }} as {{ elementary.edr_type_float() }}))
{%- endmacro %}

{% macro average(column_name) -%}
    avg(cast({{ column_name }} as {{ elementary.edr_type_float() }}))
{%- endmacro %}

{% macro zero_count(column_name) %}
    coalesce(sum(case when {{ column_name }} is null then 1 when cast({{ column_name }} as {{ elementary.edr_type_float() }}) = 0 then 1 else 0 end), 0)
{% endmacro %}

{% macro zero_percent(column_name) %}
    {{ elementary.edr_percent(elementary.zero_count(column_name), elementary.row_count()) }}
{% endmacro %}

{% macro not_zero_percent(column_name) %}
    {{ elementary.edr_not_percent(elementary.zero_count(column_name), elementary.row_count()) }}
{% endmacro %}

{% macro default__standard_deviation(column_name) -%}
    stddev(cast({{ column_name }} as {{ elementary.edr_type_float() }}))
{%- endmacro %}

{% macro sqlserver__standard_deviation(column_name) -%}
    stdev(cast({{ column_name }} as {{ elementary.edr_type_float() }}))
{%- endmacro %}

{% macro default__variance(column_name) -%}
    variance(cast({{ column_name }} as {{ elementary.edr_type_float() }}))
{%- endmacro %}

{% macro sqlserver__variance(column_name) -%}
    var(cast({{ column_name }} as {{ elementary.edr_type_float() }}))
{%- endmacro %}

{% macro sum(column_name) -%}
    sum(cast({{ column_name }} as {{ elementary.edr_type_float() }}))
{%- endmacro %}
