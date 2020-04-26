# Run workflows with [Argo](https://github.com/argoproj/argo/)

See [d2s.semanticscience.org](http://d2s.semanticscience.org/docs/argo-install) for detailed documentation.

* Access Maastricht University [DSRI OpenShift platform](https://app.dsri.unimaas.nl:8443/).
* Access its [Argo UI](http://argo-ui-argo.app.dsri.unimaas.nl/workflows).

## Requirements

### Install [oc client](https://www.okd.io/download.html)

```shell
wget https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz

tar xvf openshift-origin-client-tools*.tar.gz
cd openshift-origin-client*/
sudo mv oc kubectl /usr/local/bin/
```

### Install [Argo](https://argoproj.github.io/argo/)

Install [Argo client](https://github.com/argoproj/argo/blob/master/demo.md#1-download-argo)

---

## Run workflows

## oc login

[Login to the cluster](https://app.dsri.unimaas.nl:8443/) using the OpenShift client

```shell
oc login https://openshift_cluster:8443 --token=MY_TOKEN
```

* Get the command with the token from the `Copy Login Command` button in the user details at the top right of the [OpenShift webpage](https://app.dsri.unimaas.nl:8443/).

### Run [examples](https://github.com/MaastrichtU-IDS/data2services-transform-biolink)

As example we will use config files from [d2s-transform-template](https://github.com/MaastrichtU-IDS/d2s-transform-template). Clone it with the argo submodule:

```shell
git clone --recursive https://github.com/MaastrichtU-IDS/d2s-transform-template.git
cd d2s-transform-biolink
```

Run `oc login` to connect to the [OpenShift cluster](https://app.dsri.unimaas.nl:8443/).

```shell
# steps based workflow
argo submit d2s-argo-workflows/workflows/d2s-workflow-transform-xml.yml \
  -f support/config/config-transform-xml-drugbank.yml

# DAG workflow
argo submit d2s-argo-workflows/workflows/d2s-workflow-transform-xml-dag.yml \
  -f support/config/config-transform-xml-drugbank.yml

# Test
argo submit --watch d2s-argo-workflows/workflows/d2s-workflow-sparql.yml
```

### Check running workflows

```shell
argo list
```

---

## oc commands

### List pods

```shell
oc get pod
```

### Create pod from JSON

```shell
oc create -f examples/hello-openshift/hello-pod.json
```

---

## Workflow administration

### Create persistent volume

https://app.dsri.unimaas.nl:8443/console/project/argo/create-pvc

* Storage class > `maprfs-ephemeral`
* Shared Acces (RWX)

### Mount filesystem

Deploy a [filebrowser](https://hub.docker.com/r/filebrowser/filebrowser) on MapR to access volumes

Go to https://app.dsri.unimaas.nl:8443/console/catalog > click `Deploy image`

* Add to Project: `argo`
* Image Name: `filebrowser/filebrowser` 
* Give a name to your image: `filebrowser`
* Click `Deploy`
* Go to `argo` project > Click on latest deployment of the `filebrowser`
* Delete the automatically mounted volume, and add the persistent volume (`data2services-storage`). Should be on `/srv`
* Add route

* Access on http://d2s-filebrowser-argo.app.dsri.unimaas.nl/files/

### Create temporary volume in the workflow

```yaml
volumeClaimTemplates:                 # define volume, same syntax as k8s Pod spec
  - metadata:
      name: workdir                     # name of volume claim
      annotations:
        volume.beta.kubernetes.io/storage-class: maprfs-ephemeral
        volume.beta.kubernetes.io/storage-provisioner: mapr.com/maprfs
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 100Gi 
```

### Create secret

* Access [OpenShift](https://app.dsri.unimaas.nl:8443/) > `Argo` project > `Resources` > `Secret`
* `Secret Type`: Generic Secret
* `Secret Name`: d2s-sparql-password
* `Key`: password
* Enter the password in the text box `Clean Value`

Now in the workflow definition you can use the secret as environment variable

```yaml
- name: d2s-sparql-operations
  inputs:
    parameters:
    - name: sparql-queries-path
    - name: sparql-input-graph
    - name: sparql-output-graph
    - name: sparql-service-url
    - name: sparql-triplestore-url
    - name: sparql-triplestore-repository
    - name: sparql-triplestore-username
  container:
    image: umids/d2s-sparql-operations:latest
    args: ["-ep", "{{inputs.parameters.sparql-triplestore-url}}", 
      "-rep", "{{inputs.parameters.sparql-triplestore-repository}}", 
      "-op", "update", "-f", "{{inputs.parameters.sparql-queries-path}}",
      "-un", "{{inputs.parameters.sparql-triplestore-username}}", 
      "-pw", "{{inputs.parameters.sparql-triplestore-password}}",
      "-pw", "$SPARQLPASSWORD",  # secret from env
      "--var-input", "{{inputs.parameters.sparql-input-graph}}",
      "--var-output", "{{inputs.parameters.sparql-output-graph}}", 
      "--var-service", "{{inputs.parameters.sparql-service-url}}", ]
    env:
    - name: SPARQLPASSWORD
      valueFrom:
        secretKeyRef:
          name: d2s-sparql-password
          key: password
```

