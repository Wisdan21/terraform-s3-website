# Static Website Hosting with Terraform and AWS

## Objective
Deploy a static website on AWS S3 using Terraform. This exercise will cover using modules from the Terraform Registry, managing resources with the AWS CLI, and utilizing variables and outputs in Terraform.

## Exercise Steps

### Step 0; Log into your Cloud 9 environment and familarise yourself with the IDE

This guide will walk you through the process of accessing AWS Cloud9, a cloud-based 
integrated development environment (IDE) that lets you write, run, and debug your code with just a browser.

## Sign in to the AWS Management Console

- **Navigate to** the [AWS Management Console](https://aws.amazon.com/console/).
- **Sign in** with your AWS account credentials.

##  Access the Cloud9 Service

- Once signed in, locate the **Services** dropdown menu at the top of the console.
- **Search for** Cloud9 by typing "Cloud9" into the search bar or navigating through the services list.
- **Select** AWS Cloud9 from the results to open the Cloud

##  Open Your Existing Cloud9 Environment

- Within the AWS Cloud9 dashboard, you'll see a list of your existing Cloud9 environments.
- **Find the environment** you wish to work with from the list. These are environments you've previously created.
- **Click on the name** of the environment you want to open. This action will take you to the Cloud9 IDE where you can start working on your projects.

##  Start Working

- Once your Cloud9 environment opens, you'll be in the IDE where you can begin coding, running, and debugging your projects.
- The environment comes with a terminal, a code editor, and other tools pre-configured for your development needs.

Remember, Cloud9 environments are cloud-based, so you can access your development environment from any computer with internet
access, allowing for a flexible and portable coding experience.

Go to the Terminal, this is where you will perform most actions 

### Step 1: Setup and Initialization
1. **Clone the Repository**: Clone the provided repository to get the static website files. Run these commands in the Cloud 9 terminal. 
   ```bash
   git clone https://github.com/glennbechdevops/terraform-s3-website.git .
   cd terraform-s3-website
   ```
   this will create a terraform-s3-website folder on your file system. This will also be your working directory from now on. 

### Step 2: Terraform Configuration

Important! Make this file in your terraform-s3-website folder, NOT the root folder. 

1. **Create a `main.tf` File**: Define the infrastructure for hosting the static website in an S3 bucket.
2. **Use a Module for S3 Website**: Incorporate a module for creating an S3 bucket configured for website hosting.

```hcl
module "website" {
   source = "github.com/glennbechdevops/s3-website-module?ref=1.0.0"
   bucket_name = var.bucket_name
}
```

* This will use the Terraform module located in GitHub here https://github.com/glennbechdevops/s3-website-module
* Also notice that you're using a specific version of the module 

3. **Variables File**: Define necessary variables in a `variables.tf` file.
   ```hcl
   variable "bucket_name" {
     description = "The name of the bucket"
     type        = string
   }
   ```
4. **Outputs File**: Create an `outputs.tf` file to extract the domain name of the bucket.
   ```hcl
   output "website_url" {
     value = module.s3_bucket.website_endpoint
   }
   ```

### Step 3: Deployment

In this step, you will see that you can provide values for variables on the Terraform command line.
Replace <unique-bucket-name> with for example your name, initials or something that is unique

1. **Initialize Terraform** and download the necessary modules.
2. **Plan and Apply**: Execute the infrastructure deployment.
   ```bash
   terraform init
   terraform apply -var 'bucket_name=<unique-bucket-name>'
   ```

If you get an error message saying 
```
│ Error: putting S3 Bucket (bech-final) Policy: operation error S3: PutBucketPolicy, https response error StatusCode: 403, RequestID: J1K4KCMHADJMZMV1, HostID: dUSuqDOOUzLsUCp2OVqZmFKnYX4tsQdEwaxZiQZe76/uRhPTuKILLw7PFjtW5J/z4T6G7f1uduM=, api error AccessDenied: Access Denied```
```

Retry the operation. Ask the instructor why this happens if you have time and are interested :) 

### Step 4: Upload Files to S3 Bucket
1. **AWS CLI**: Use the AWS CLI to upload the website files to the S3 bucket.
   ```bash
   aws s3 sync s3_demo_website s3://<bucket-name> 
   ```

### Step 5: Accessing the Website
- **Retrieve Website URL**: Use Terraform to get the S3 bucket website endpoint.
  ```bash
  terraform output s3_website_url
  ```
- Access the website through the provided URL.

### Manipulate HTML and / or CSS files 

You can try to modify the CSS and HTML files and re-run the sync command to change how it looks.

## Conclusion
This exercise demonstrates deploying and managing web resources on the cloud using Terraform and AWS CLI.
