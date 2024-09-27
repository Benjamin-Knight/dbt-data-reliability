{%- macro select_test_results(sample_limit) -%}
    {{ return(adapter.dispatch('select_test_results', 'elementary')(sample_limit)) }}
{%- endmacro -%}

{%- macro default__select_test_results(sample_limit) -%}
    select * from test_results {% if sample_limit is not none %} limit {{ sample_limit }} {% endif %}
{%- endmacro -%}

{%- macro sqlserver__select_test_results(sample_limit) -%}
    select {% if sample_limit is not none %} top {{ sample_limit }} {% endif %} * from test_results
{%- endmacro -%}