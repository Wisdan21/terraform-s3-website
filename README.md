# Static Website Hosting with Terraform and AWS

## Objective
Deploy a static website on AWS S3 using Terraform. This exercise will cover using modules from the Terraform Registry, managing resources with the AWS CLI, and utilizing variables and outputs in Terraform.

## Exercise Steps

### Step 0; Log into your Cloud 9 environment and familarise yourself with the IDE

1. Go to the Terminal, this is where you will perform most actions 

### Step 1: Setup and Initialization
1. **Clone the Repository**: Clone the provided repository to get the static website files. Run this command in the Cloud 9 terminal. 
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
   source = "github.com/glennbechdevops/s3-website-module/"
   bucket_name = var.bucket_name
}
```

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
