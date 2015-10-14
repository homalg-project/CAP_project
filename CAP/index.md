---
layout: packageCAP
---

# GAP Package {{site.data.packageCAP.name}}

{{site.data.packageCAP.abstract}}

The current version of this package is version {{site.data.packageCAP.version}}.
For more information, please refer to [the package manual]({{site.data.packageCAP.doc-html}}).
There is also a [README](README) file.

## Dependencies

This package requires GAP version {{site.data.packageCAP.GAP}}
{% if site.data.packageCAP.needed-pkgs %}
The following other GAP packages are needed:
{% for pkg in site.data.packageCAP.needed-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}
{% if site.data.packageCAP.suggested-pkgs %}
The following additional GAP packages are not required, but suggested:
{% for pkg in site.data.packageCAP.suggested-pkgs %}
- {% if pkg.url %}<a href="{{ pkg.url }}">{{ pkg.name }}</a>{% else %}{{ pkg.name }}{% endif %} {{ pkg.version }}{% endfor %}
{% endif %}


## Author{% if site.data.packageCAP.authors.size != 1 %}s{% endif %}
{% for person in site.data.packageCAP.authors %}
{% if person.url %}<a href="{{ person.url }}">{{ person.name }}</a>{% else %}{{ person.name }}{% endif %}{% unless forloop.last %}, {% endunless %}{% else %}
{% endfor %}

{% if site.github.issues_url %}
## Feedback

For bug reports, feature requests and suggestions, please use the
[issue tracker]({{site.github.issues_url}}).
{% endif %}
