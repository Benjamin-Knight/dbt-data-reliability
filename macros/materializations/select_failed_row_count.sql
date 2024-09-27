{%- macro select_failed_row_count(sql, failed_row_count_calc) -%}
    {{ return(adapter.dispatch('select_failed_row_count', 'elementary')(sql, failed_row_count_calc)) }}
{%- endmacro -%}

{%- macro default__select_failed_row_count(sql, failed_row_count_calc) -%}
    with results as (
        {{ sql }}
    )
    select {{ failed_row_count_calc }} as count from results
{%- endmacro -%}

{%- macro sqlserver__select_failed_row_count(sql, failed_row_count_calc) -%}
    {# We do not support nested CTEs #}
    {% set test_sql = elementary.escape_special_chars(sql) %}
    {% set test_view %}
        [{{ target.schema }}.failed_count_{{ local_md5(test_sql) }}]
    {% endset %}
    EXEC('create view {{test_view}} as {{ test_sql }};');

    select {{ failed_row_count_calc }} as count from {{ test_view }};

    EXEC('drop view {{test_view}};');
{%- endmacro -%}