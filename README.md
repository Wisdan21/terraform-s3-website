
# Static Website Hosting with Terraform and AWS

## Objective
Deploy a static website on AWS S3 using Terraform. This exercise will cover using modules from the Terraform Registry, managing resources with the AWS CLI, and utilizing variables and outputs in Terraform.

## Exercise Steps

### Step 1: Setup and Initialization
1. **Clone the Repository**: Clone the provided repository to get the static website files.
   ```bash
   git clone <repository-url>
   ```
2. **Initialize a Terraform Project**: Create and initialize a new directory for the Terraform project.
   ```bash
   mkdir terraform-static-website
   cd terraform-static-website
   terraform init
   ```

### Step 2: Terraform Configuration
1. **Create a `main.tf` File**: Define the infrastructure for hosting the static website in an S3 bucket.
2. **Use a Module for S3 Website**: Incorporate a module for creating an S3 bucket configured for website hosting.
   ```hcl
   module "s3_bucket" {
     source  = "terraform-aws-modules/s3-bucket/aws"
     version = "~> 2.0"

     bucket = var.bucket_name
     acl    = "public-read"

     website = {
       index_document = "index.html"
       error_document = "error.html"
     }

     tags = {
       Name        = "Static Website"
       Environment = "Learning"
     }
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
   terraform apply -var 'bucket_name=<unique-bucket-name>'
   ```

### Step 4: Upload Files to S3 Bucket
1. **AWS CLI**: Use the AWS CLI to upload the website files to the S3 bucket.
   ```bash
   aws s3 sync <local-website-folder> s3://<bucket-name> --acl public-read
   ```

### Step 5: Accessing the Website
- **Retrieve Website URL**: Use Terraform to get the S3 bucket website endpoint.
  ```bash
  terraform output website_url
  ```
- Access the website through the provided URL.

## Conclusion
This exercise demonstrates deploying and managing web resources on the cloud using Terraform and AWS CLI.
