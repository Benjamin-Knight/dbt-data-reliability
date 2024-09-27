{% macro dbt_model_run_result_description() %}
    'The model ' {{ elementary.string_join() }} name {{ elementary.string_join() }} ' returned ' {{ elementary.string_join() }} status {{ elementary.string_join() }} ' at ' {{ elementary.string_join() }} generated_at {{ elementary.string_join() }} ' on run ' {{ elementary.string_join() }} invocation_id
{% endmacro %}