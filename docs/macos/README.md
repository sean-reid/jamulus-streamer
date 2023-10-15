[back](..)

# MacOS Documentation

This guide will walk you through a full server deployment and streaming setup on a MacOS laptop.

## Prerequisites

You can install dependencies and configure your environment with this script:
```
./scripts/setup
```


Then, deploy a Jamulus server to Google Cloud.
```
./scripts/deploy
```
Note: this step uses [Terraform](https://www.terraform.io) and [Ansible](https://www.ansible.com). Please consult the respective READMEs ([here](./terraform) and [here](./ansible)) and the [docs](./docs) for extra setup.

Finally, start streaming.
```
./scripts/stream
```
Note: this step requires that you have a YouTube account set up, and a streaming key. Please consult the [docs](./docs) for more details.
