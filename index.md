---
layout: default
---

# The CAP project

This is the home of the CAP project. For more information, please see the packages listed below.

## Packages in the CAP project



{% for package in site.data.packages.package_links %}
  [{{package.name}}]({{site.baseurl}}/CAP_project/{{package.name}})
{% endfor %}


## Dependencies

This project requires GAP version {{site.data.packageCAP.GAP}}
For more information see the packages

## Installation

### Source

To install CAP, start by installing the latest version of GAP from [gap-system.org](http://www.gap-system.org). Please
refer to the installation description there for details.

Then download the tarballs of CAP and its required packages into GAPs pkg folder (usually inside the main GAP directory).

Alternatively download the sources of

* [homalg_project](http://www.github.com/homalg-project/homalg_project)
* [CAP_project](http://www.github.com/homalg_project/CAP_project)

or clone the repositories via [git](http://git-scm.com).

Now you should be able to load CAP via LoadPackage( "CAP" );.

### Docker

You can also use the [Docker](http://www.docker.com) image from the SPP Computeralgebra, sppcomputeralgebra/sppdocker. It contains a proper
installed version of GAP and CAP.

## Author{% if site.data.frontpage.authors.size != 1 %}s{% endif %}
{% for person in site.data.frontpage.authors %}
{% if person.url %}<a href="{{ person.url }}">{{ person.name }}</a>{% else %}{{ person.name }}{% endif %}{% unless forloop.last %}, {% endunless %}{% else %}
{% endfor %}

{% if site.github.issues_url %}
## Feedback

For bug reports, feature requests and suggestions, please use the
[issue tracker]({{site.github.issues_url}}).
{% endif %}
