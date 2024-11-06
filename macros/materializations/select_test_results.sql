{%- macro select_test_results(sql, sample_limit) -%}
    {{ return(adapter.dispatch('select_test_results', 'elementary')(sql, sample_limit)) }}
{%- endmacro -%}

{%- macro default__select_test_results(sql, sample_limit) -%}
    with test_results as (
      {{ sql }}
    )

    select * from test_results {% if sample_limit is not none %} limit {{ sample_limit }} {% endif %}
{%- endmacro -%}

{%- macro sqlserver__select_test_results(sql, sample_limit) -%}
    {# We do not support nested CTEs #}
    {% set test_sql = elementary.escape_special_chars(sql) %}
    {% set unique_key = local_md5(model.name) %}
    {% set test_view %}[{{ target.schema }}.testview_{{ unique_key }}_{{ range(1300, 19000) | random }}]{% endset %}
    EXEC('create view {{ test_view }} as {{ test_sql }};');

    select {% if sample_limit is not none %} top {{ sample_limit }} {% endif %} * from {{ test_view }};

    EXEC('drop view {{ test_view }};');
{%- endmacro -%}