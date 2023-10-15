[back](..)

# Terraform Documentation

[Terraform](https://www.terraform.io) is used to provision a VM in [Google Cloud](https://cloud.google.com) which will run Jamulus and serve as the source of the stream.

This guide shows you how to set up your GCP account and create Terraform variables, then apply the VM configuration.

## Google Cloud Setup

You will need a GCP account if you don't already. Once you sign up and set up billing (yes, creating a server incurs a cost), follow these steps.

If you already have a project in a GCP account, and a terraform service account, skip these steps.

### Setup CLI

First, download and run the installer for the `gcloud` CLI. For MacOS and Linux:
```
curl https://sdk.cloud.google.com | bash
```

Restart your shell when the installer completes:
```
exec -l $SHELL
```

Then to authenticate, run:
```
gcloud init
```

This will open a browser. Select `Allow` for gcloud to access your account.

### Create and configure project

After the CLI is installed, create a project. Choose a meaningful id and name, like `jamulus-streamer`:
```
gcloud projects create project-id --name=project-name # edit the ID and name
```

List the billing accounts associated with your user:
```
gcloud billing accounts list
```

Choose the correct billing account and link it with your newly created project:
```
gcloud billing projects link project-id --billing-account 0X0X0X-0X0X0X-0X0X0X
```

Then, enable the compute API in your project:
```
gcloud services enable compute
```

### Create Terraform service account

You will need to create a service account with the appropriate credentials so that Terraform can make changes to your cloud infrastructure.

First, create the service account:
```
gcloud iam service-accounts create terraform-sa --display-name "Terraform Service Account"
```

Then, bind the compute, network, and security admin roles to the service account. Make sure to replace `project-id` with your project ID:
```
PROJECT_ID=project-id # edit this

gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:terraform-sa@${PROJECT_ID}.iam.gserviceaccount.com" --role "roles/compute.instanceAdmin"
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:terraform-sa@${PROJECT_ID}.iam.gserviceaccount.com" --role "roles/compute.networkAdmin"
gcloud projects add-iam-policy-binding $PROJECT_ID --member "serviceAccount:terraform-sa@${PROJECT_ID}.iam.gserviceaccount.com" --role "roles/compute.securityAdmin"
```

Finally, download the credential file to your laptop. Keep this file safe!
```
gcloud iam service-accounts keys create /path/to/credential/file.json --iam-account terraform-sa@${PROJECT_ID}.iam.gserviceaccount.com
```

Now you are ready to use Terraform!

## Terraform Setup

The Terraform module included in this repo requires a few variables to be set before you can deploy infrastructure. Examples of these variables are templated in `terraform.tfvars.template`. To get started, copy this file:
```
cp terraform.tfvars.template terraform.tfvars
```

Open the file in the editor of your choice and modify each variable.

### Key Path

You will need an SSH key to secure the Jamulus streaming server. First, create a keypair:
```
ssh-keygen -t ed25519 -C "your_email@example.com"
```

The above command should save the keys to `~/.ssh/key-name` and `~/.ssh/key-name.pub`. Name the key something more descriptive. In `terraform.tfvars`, change the `key_path` variable to point to the **public** key.

### Allowed Source Ranges

To ensure that the Jamulus server is truly private, the `allowed_source_ranges` variable specifies a set of IP addresses that are authorized to enter the server. For a band with five members, this list could contain five IP addresses, for example.

To find your IP address, run the following:
```
curl ipinfo.io
```

This will print out your laptop's public IP in the "ip" field. To enable access to a single IP, add the following to the variable list:
```
allowed_source_ranges = [
    "xxx.xxx.xxx.xxx/32", # output of "curl ipinfo.io", with "/32" appended to the "ip" field.
]
```

### Region

The location of the Jamulus server. For example, use `us-west1` for the US west coast.

### Credentials File

The full path to the GCP terraform service account credentials JSON file that you saved earlier.

### Project ID

The meaningful ID that you'd assigned previously to your GCP project.

## Provision

Now you are ready to create some infrastructure!

First, run `terraform plan`. Inspect the plan- if anything looks incorrect, do not apply changes. If the plan looks ok, move on to the next step.

Now you are ready to apply changes! Run the following:
```
terraform apply
```

Enter `yes` and watch your Jamulus server appear!

## Cleanup

If you'd like to start over or destroy all of your infrastructure created in this guide (to avoid incurring extra cost), do the following:
```
terraform destroy
```
