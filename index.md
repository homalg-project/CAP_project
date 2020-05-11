---
layout: default
---

# The CAP project

This is the home of the CAP project. It consists of several GAP packages
build on top of its main package, CAP. A good way to start is having a look
at the [manual](https://github.com/homalg-project/CAP_Manual/raw/master/CAPManual.pdf), which offers extensive tutorials and a
good description of CAP. Also, you can look at the packages' references for detailed command descriptions.

## Packages in the CAP project

{% for package in site.data.packages.package_links %}
  [{{package.name}}]({{site.baseurl}}/{{package.name}})
{% endfor %}


## Dependencies

This project requires GAP version {{site.data.CAP.GAP}}.
For more information about the dependencies take a look at the individual packages' sites.


## Installation

### Source

To install CAP, start by installing the latest version of GAP from [gap-system.org](http://www.gap-system.org). Please
refer to the installation description there for details. Since CAP has fairly new dependencies, all earlier versions of GAP will
not work.

Then download the tarballs of the CAP project packages into GAP's pkg folder (usually inside the main GAP directory).

_Alternatively_, clone or download the repository

* [CAP_project](https://github.com/homalg-project/CAP_project)

via [git](http://git-scm.com) and put it into GAP's pkg folder.

Now you should be able to load CAP via LoadPackage( "CAP" );.


## Author{% if site.data.frontpage.authors.size != 1 %}s{% endif %}
{% for person in site.data.frontpage.authors %}
{% if person.url %}<a href="{{ person.url }}">{{ person.name }}</a>{% else %}{{ person.name }}{% endif %}{% unless forloop.last %}, {% endunless %}{% else %}
{% endfor %}

{% if site.github.issues_url %}
## Feedback

For bug reports, feature requests and suggestions, please use the
[issue tracker]({{site.github.issues_url}}).
{% endif %}
