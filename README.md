# CWL workflows for Data2Services

See **[d2s.semanticscience.org](http://d2s.semanticscience.org/)** for detailed documentation.

The [Common Workflow Language](https://www.commonwl.org/) is used to describe workflows to transform heterogeneous structured data (CSV, TSV, RDB, XML, JSON) to a target RDF data model. A generic RDF is generated depending on the input data structure (AutoR2RML, xml2rdf), then [SPARQL queries](https://github.com/MaastrichtU-IDS/data2services-transform-biolink/blob/master/mapping/pharmgkb/insert-pharmgkb.rq), defined by the user, are executed to transform the generic RDF to the target data model.

---

## Requirements

- Install [Docker](https://docs.docker.com/install/) to run the modules.
- Install [cwltool](https://github.com/common-workflow-language/cwltool#install) to get cwl-runner to run workflows of Docker modules.

```bash
sudo apt install cwltool
```

- Those workflows use Data2Services modules, see the [data2services-pipeline](https://github.com/MaastrichtU-IDS/data2services-pipeline) project.
- It is recommended to build the Docker images before running workflows, as the `docker pull` might crash when done through `cwl-runner`.

---

## Clone

```bash
git clone --recursive https://github.com/MaastrichtU-IDS/d2s-cwl-workflows.git
```

