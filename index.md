---
layout: default
---

# The CAP project

This is the home of the CAP project. It consists of several GAP packages
build on top of its main package, CAP. A good way to start is having a look
at the [manual](CAPManual.pdf), which offers extensive tutorials and a 
good discription of CAP. Also, you can look at the packages references for detailed command descriptions.

## Packages in the CAP project

{% for package in site.data.packages.package_links %}
  [{{package.name}}]({{site.baseurl}}/CAP_project/{{package.name}})
{% endfor %}


## Dependencies

This project requires GAP version {{site.data.packageCAP.GAP}}
For more information see the packages


## Installation

### Docker

You can also use the [Docker](http://www.docker.com) image from the SPP Computeralgebra, [sppcomputeralgebra/sppdocker](https://hub.docker.com/r/sppcomputeralgebra/sppdocker).
It contains a proper installed version of GAP and the CAP project.

To use the image, please install Docker, then start a container via
`docker run -it sppcomputeralgebra/sppdocker`.


### Source

To install CAP, start by installing the latest version (4.7.9) of GAP from [gap-system.org](http://www.gap-system.org). Please
refer to the installation description there for details. Since CAP has fairly new dependencies, all earlier versions of GAP will
not work.

Then download the tarballs of the CAP project packages into GAPs pkg folder (usually inside the main GAP directory).

Alternatively download the sources of

* [CAP_project](http://www.github.com/homalg_project/CAP_project)

or clone the repositories via [git](http://git-scm.com).

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
