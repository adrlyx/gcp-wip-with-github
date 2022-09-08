# GCP Workload Identity Federation with Github Setup

### Introdcution

A little thing that I made for my boss John. He asked me if I knew anything about Google Cloud Platform with Workload Identity Federation to run CI/CD Actions in Github. I didn´t.
So I studied it and this repo is the result with working authentication to GCP WIP with Github Actions that runs a gcloud command and a python script in the same pipeline that collects the same information with the same credentials.

> :warning: **This project will create resources that will cost you. Make sure you have billing setup if you want to test the content in this repo.**

#### What does this do?

1. Sets up a project in GCP(terraform)
2. Sets up a Service Account(terraform)
3. Sets up a Compute Engine Instance(terraform)
4. Sets up a Workload Identity Federation Pool
4. Sets up a Workload Identity Federation Provider(Github Provider)
4. On push to main runs a pipeline that authenticates with OpenID and runs a gcloud command and a python scripts that uses a token generated with GCP Workload Identity Federation. 

### Prerequisites

1. Change all TODOs in the following terraform file

```
    tf/main.tf
```

2. You need to be authenticated with your GCP account to be able to run Terraform.

### HowTo

1. Clone repo.
2. Complete all "Prerequisites"
3. Run Terraform from the tf/ folder.

```
    $ > terraform init
    $ > terraform plan
    $ > terraform apply
```
From the terraform output update all TODOs in these files with the result:
```
    main.py
    .github/workflows/gcp_auth.yml
```

If you want to see the terraform outputs again run the command:

```
    terraform output
```

3. Push to main to trigger the Action in Github