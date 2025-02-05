
# Terraform - Google Cloud Platform - Infrastructure as a Cloud(IaaC)

## Project Description

The project makes use of Terraform to provide the infrastructure as code (IaC) for Google Cloud Platform Compute Engine Instances (Virtual Machines) and Virtual Private Cloud (VPC) networks and subnets. Resource segregation based on different use cases or environments is made possible by this configuration, which makes it easier to create several VPCs and related subnets.

In addition, Packer-created custom images are used to furnish the virtual machines. This expedites deployment and improves consistency throughout the infrastructure by guaranteeing that the Virtual Machines are constructed from a common and pre-configured image.


## Infrastructure Setup

This repository contains Terraform configurations for setting up infrastructure on Google Cloud Platform (GCP).

## 
### Prerequisites

Before you begin, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed.
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and configured.

### Setup

*Clone the Repository:*

 
 git clone git@github.com:aayushshetty12/Terraform-GCP-Infra.git
 
 terraform init

 terraform plan
 
 terraform apply
 

 ## List of all APIs Used

 1. Compute Engine API
 2. Cloud DNS API
 3. BigQuery API
 4. BigQuery Migration API
 5. BigQuery Storage API
 6. Cloud Datastore API
 7. Cloud Deployment Manager V2 API
 8. Cloud Logging API
 9. Cloud Monitoring API
 10. Cloud OS Login API
 11. Cloud SQL
 12. Cloud Storage
 13. Cloud Storage API
 14. Cloud Trace API
 15. Cloud Vision API
 16. Google Cloud APIs
 17. Google Cloud Storage JSON API
 18. Service Management API
 19. Service Usage API
 


 
