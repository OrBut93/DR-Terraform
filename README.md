# Terraform Configuration for GCP Networking Setup

This repository contains Terraform configurations to set up networking resources in GCP across multiple projects. The configurations include setting up networking resources such as VPCs, subnets and connecting multiple GCP projects using peering connections.
## Prerequisites

Before you begin, make sure you have:


- GCP Credentials: You need valid GCP credentials with appropriate permissions to create networking resources in GCP projects (Network,Backup,Production).
- Terraform Installed: Ensure Terraform is installed on your local machine. You can download Terraform from the official website and follow the installation instructions.
- VPC and Subnets for Backup & Production projects.
- GCP CLI (Optional): Having GCP CLI installed can be helpful for configuring GCP credentials and verifying resources.

## Configuration

### Editing Configuration Files

There are two files that require editing:

#### 1. `terraform.tfvars`

In this file, you should provide:

- **GCP service account json credentials**: add the json file path of the 3 GCP projects SA: network, backup, and production.


#### 2. `variables.var`

In this file, you should specify:

- **Region**: Specify the GCP region where you want to deploy the resources. The default is `europe-west3`.
- **Project ID**: Add the IDs of the 3 GCP projects: network, backup, and production.
- **VPCS NAME**: Add the names of the 3 GCP VPCs: vpc-network, vpc-backup, and vpc-production.
- **SUBNETS NAME&CIDR**: Add the names of the 3 GCP VPCs: vpc-network, vpc-backup, and vpc-production.


#### 3. Initializing Terraform**
Run the following command to initialize Terraform:
```
terraform init
```

#### 4. Reviewing and Applying Changes**
Review the Terraform plan to ensure it will create the desired resources:
```
terraform plan
```
If everything looks good, apply the changes:
```
terraform apply
```
## Customization

You may need to customize the Terraform files further based on your specific requirements. Refer to the variables.tf file for configurable options.

## Cleaning Up

To destroy the resources created by Terraform, run:
```
terraform destroy
```
## Contributing

If you find any issues or have suggestions for improvement, feel free to open an issue or create a pull request.

## License

This project is licensed under the MPL-2.0 License. See the LICENSE file for details.