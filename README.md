This project covers the core concepts of cloud engineering and devOps by adopting multiple principles to create a next js application that is easy to transport, and its build process automated through the use of github actions and cloud infrastructure created through the use of terraform.

# Project Visual Diagram and walkthrough
![React-with-terraform drawio](https://github.com/user-attachments/assets/071977ec-90f3-4617-aef3-b2dae0f29b01)
- Frontend was created through the use of react and the nextJs framework
- The application was turned into an image through the use of Docker and a Dockerfile.
- The continuous deployment process was done through the use of Github actions workflows.
- The Infrastructure as code tool used to create the cloud resources for this application to be hosted was done with Terraform.
- The application is hosted on a VPC network with multiple subnets. The application is stored as a container, which is hosted within a kubernetes cluster across multiple availabilty zones.


## Major Components and Technologies used
- Frontend - NextJs
- Deployment - Github Actions
- Infrastructure as Code - Terraform
- Cloud Services - AWS VPC, AWS EC2, AWS S3, AWS EKS, AWS IAM
- Containerisation - Docker
- Container Orchestration - Kubernetes


## Lessons Learned 
-  Authenticating into aws by using the OIDC and iam role method to gain access to aws services.
- Creating Kubernetes resources through terraform.
- Optimizing docker image through the use of multi stage deployments and not repeating installation processes.
- Appropriate CIDR blocks for both private and public subnets.
- Spinning up an EKS cluster takes time through the use of terraform.
- Creating an IAM Role with least privilege permission to allow the GitHub action server to run the terraform commands in the workflow.
- Utilizing Kubernetes pods and servicse to make container available through the service load balancer.
- Deployed Kubernetes node cluster in private subnets across three availability zones for high availability.


