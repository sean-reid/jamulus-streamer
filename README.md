# Jamulus Streamer
Instantly set up a private Jamulus server in GCP, and effortlessly stream your jam sessions to YouTube Live!

## About
[Jamulus](https://jamulus.io) is a popular open-source software that allows musicians to join online, low-latency jam sessions.

[YouTube](https://www.youtube.com) is... well, you know. Youtube.

What do you do if you want to stream a private online jam session to YouTube Live with low latency? The current workflow is complicated, and not very well documented. This project was created to make low-latency jam session streaming as easy as 1, 2, 3:
1. Setup your environment
2. Deploy and configure server in GCP
3. Stream audio from server to YouTube

## Documentation
For platform-specific docs, please go [here](./docs). Read these docs before attempting a deployment.

## Quick Start
Clone this repo if you haven't already. You'll need `git` for this:
```
git clone git@github.com:sean-reid/jamulus-streamer.git
```

Change into the repo directory:
```
cd jamulus-streamer
```

And run the scripts!

First, install dependencies and configure your environment.
```
./scripts/setup
```
Note: this step will install software on your laptop.

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

## Author
* [Sean Reid](https://sean-reid.github.io)
