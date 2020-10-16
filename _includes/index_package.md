# GAP Package {{site.data[page.package_name].name}}

{{site.data[page.package_name].abstract}}

The current version of this package is version {{site.data[page.package_name].version}}.
For more information, please refer to [the package manual]({{site.data[page.package_name].doc-html}}).
There is also a [README](README.md) file.

## Dependencies

This package requires GAP version {{site.data[page.package_name].GAP}}
{% if site.data[page.package_name].needed-pkgs %}
The following other GAP packages are needed:
{% for pkg in site.data[page.package_name].needed-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}
{% if site.data[page.package_name].suggested-pkgs %}
The following additional GAP packages are not required, but suggested:
{% for pkg in site.data[page.package_name].suggested-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}


## Author{% if site.data[page.package_name].authors.size != 1 %}s{% endif %}
{% for person in site.data[page.package_name].authors %}
{% if person.url %}<a href="{{ person.url }}">{{ person.name }}</a>{% else %}{{ person.name }}{% endif %}{% unless forloop.last %}, {% endunless %}{% else %}
{% endfor %}

{% if site.github.issues_url %}
## Feedback

For bug reports, feature requests and suggestions, please use the
[issue tracker]({{site.github.issues_url}}).
{% endif %}
