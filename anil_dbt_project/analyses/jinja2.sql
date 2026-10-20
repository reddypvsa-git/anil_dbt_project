{%- set apples = ['gala','red dalicious', 'fuji','mcintosh','honeycrisp'] -%}

{% for i in apples %}
 
    {% if i != 'mcintosh' %}
            {{i}}
    {% else %}
            i hate {{i}}
    {% endif %}
{% endfor %}