{% macro anomaly_detection_description() %}
    case
        when dimension is not null and column_name is null then {{ elementary.dimension_metric_description() }}
        when dimension is not null and column_name is not null then {{ elementary.column_dimension_metric_description() }}
        when metric_name = 'freshness' then {{ elementary.freshness_description() }}
        when column_name is null then {{ elementary.table_metric_description() }}
        when column_name is not null then {{ elementary.column_metric_description() }}
        else null
    end as anomaly_description
{% endmacro %}

{% macro freshness_description() %}
    'Last update was at ' {{ elementary.string_join() }} anomalous_value {{ elementary.string_join() }} ', ' {{ elementary.string_join() }} {{ elementary.edr_cast_as_string('abs(round(' ~ elementary.edr_cast_as_numeric('metric_value/3600') ~ ', 2))') }} {{ elementary.string_join() }} ' hours ago. Usually the table is updated within ' {{ elementary.string_join() }} {{ elementary.edr_cast_as_string('abs(round(' ~ elementary.edr_cast_as_numeric('training_avg/3600') ~ ', 2))') }} {{ elementary.string_join() }} ' hours.'
{% endmacro %}

{% macro table_metric_description() %}
    'The last ' {{ elementary.string_join() }} metric_name {{ elementary.string_join() }} ' value is ' {{ elementary.string_join() }} {{ elementary.edr_cast_as_string('round(' ~ elementary.edr_cast_as_numeric('metric_value') ~ ', 3)') }} {{ elementary.string_join() }}
    '. The average for this metric is ' {{ elementary.string_join() }} {{ elementary.edr_cast_as_string('round(' ~ elementary.edr_cast_as_numeric('training_avg') ~ ', 3)') }} {{ elementary.string_join() }} '.'
{% endmacro %}

{% macro column_metric_description() %}
    'In column ' {{ elementary.string_join() }} column_name {{ elementary.string_join() }} ', the last ' {{ elementary.string_join() }} metric_name {{ elementary.string_join() }} ' value is ' {{ elementary.string_join() }} {{ elementary.edr_cast_as_string('round(' ~ elementary.edr_cast_as_numeric('metric_value') ~ ', 3)') }} {{ elementary.string_join() }}
    '. The average for this metric is ' {{ elementary.string_join() }} {{ elementary.edr_cast_as_string('round(' ~ elementary.edr_cast_as_numeric('training_avg') ~ ', 3)') }} {{ elementary.string_join() }} '.'
{% endmacro %}

{% macro column_dimension_metric_description() %}
    'In column ' {{ elementary.string_join() }} column_name {{ elementary.string_join() }} ', the last ' {{ elementary.string_join() }} metric_name {{ elementary.string_join() }} ' value for dimension ' {{ elementary.string_join() }} dimension {{ elementary.string_join() }} ' is ' {{ elementary.string_join() }} {{ elementary.edr_cast_as_string('round(' ~ elementary.edr_cast_as_numeric('metric_value') ~ ', 3)') }} {{ elementary.string_join() }}
    '. The average for this metric is ' {{ elementary.string_join() }} {{ elementary.edr_cast_as_string('round(' ~ elementary.edr_cast_as_numeric('training_avg') ~ ', 3)') }} {{ elementary.string_join() }} '.'
{% endmacro %}

{% macro dimension_metric_description() %}
    'The last ' {{ elementary.string_join() }} metric_name {{ elementary.string_join() }} ' value for dimension ' {{ elementary.string_join() }} dimension {{ elementary.string_join() }} ' - ' {{ elementary.string_join() }}
    case when dimension_value is null then 'NULL' else dimension_value end {{ elementary.string_join() }} ' is ' {{ elementary.string_join() }} {{ elementary.edr_cast_as_string('round(' ~ elementary.edr_cast_as_numeric('metric_value') ~ ', 3)') }} {{ elementary.string_join() }}
    '. The average for this metric is ' {{ elementary.string_join() }} {{ elementary.edr_cast_as_string('round(' ~ elementary.edr_cast_as_numeric('training_avg') ~ ', 3)') }} {{ elementary.string_join() }} '.'
{% endmacro %}
