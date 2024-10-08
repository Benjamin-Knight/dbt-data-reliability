{# Same as date trunc, but casts the time/date expression to timestamp #}
{% macro edr_time_trunc(date_part, date_expression) -%}
    {{ return(adapter.dispatch('edr_time_trunc', 'elementary') (date_part, date_expression)) }}
{%- endmacro %}

{% macro default__edr_time_trunc(date_part, date_expression) %}
    date_trunc('{{date_part}}', cast({{ date_expression }} as {{ elementary.edr_type_timestamp() }}))
{% endmacro %}

{% macro bigquery__edr_time_trunc(date_part, date_expression) %}
    timestamp_trunc(cast({{ date_expression }} as timestamp), {{ date_part }})
{% endmacro %}

{% macro sqlserver__edr_time_trunc(date_part, date_expression) %}
    {% if date_part == 'day' %}
        cast(cast({{ date_expression }} as date) AS {{ elementary.edr_type_timestamp() }})
    {% elif date_part == 'month' %}
        cast(dateadd(day, 1, eomonth({{ date_expression }}, -1)) AS {{ elementary.edr_type_timestamp() }})
    {% endif %}
{% endmacro %}