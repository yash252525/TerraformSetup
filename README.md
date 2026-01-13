# ☁️ Infrastructure as Code (IaC) Portfolio

This repository serves as a comprehensive collection of **Infrastructure as Code** patterns, automation scripts, and cloud architecture setups. It demonstrates the implementation of production-grade infrastructure using **Terraform**, **AWS**, **Kubernetes (EKS)**, and configuration management tools like **Ansible**.

The projects within this repository focus on modularity, scalability, and DevOps best practices such as **State Locking** and **GitOps**.

---

## 🛠️ Tech Stack & Tools

* **IaC:** Terraform (HCL)
* **Cloud Provider:** AWS (EC2, VPC, EKS, S3, DynamoDB, IAM)
* **Orchestration:** Kubernetes (EKS), Docker
* **Configuration Management:** Ansible
* **CI/CD:** Jenkins, ArgoCD
* **Scripting:** Bash/Shell

---

## 📂 Project Structure & Modules

This repository is organized into specific labs and modules, each demonstrating a core DevOps concept:

| Directory | Description | Key Concepts |
| :--- | :--- | :--- |
| **`Terraform-EKS_AWS/`** | Provisioning a managed Kubernetes Cluster on AWS. | EKS, IAM Roles, Node Groups, VPC CNI |
| **`Remote_Backend/`** | Setup for remote state management to enable team collaboration. | **S3** (Storage), **DynamoDB** (State Locking) |
| **`VPC_Module/`** | A reusable custom module to create a secure networking layer. | Modularization, Subnets, Route Tables, IGW |
| **`Ansible_Dev_Infra/`** | Hybrid setup using Terraform for provisioning and Ansible for configuration. | Provisioning vs. Config Management, Inventory Generation |
| **`Jenkins_Setup/`** | Automated deployment of a Jenkins CI server on EC2. | User Data Scripts, Security Groups, CI Automation |
| **`ArgoCD_Setup/`** | GitOps tooling setup on Kubernetes. | Helm Providers, GitOps Workflows, K8s Manifests |
| **`Module_App/`** | Example implementation demonstrating how to consume custom modules. | DRY (Don't Repeat Yourself) Principles |
| **`Linux_Server/`** | Baseline EC2 instance provisioning. | Basic Compute, SSH Key Management |

---

## 🚀 Key Features & Patterns implemented

### 1. Modular Architecture
Instead of monolithic configuration files, this repository utilizes **Terraform Modules** (e.g., `VPC_Module`). This promotes code reusability, consistency, and easier maintenance across different environments (Dev, Stage, Prod).

### 2. Robust State Management
The **`Remote_Backend`** setup demonstrates how to move away from local state files.
* **S3 Bucket:** Stores the `terraform.tfstate` file centrally.
* **DynamoDB Table:** Handles **State Locking** to prevent concurrent modifications and corruption during team collaboration.

### 3. Hybrid Engineering (Terraform + Ansible)
The **`Ansible_Dev_Infra`** project showcases the distinction between *Infrastructure Provisioning* and *Configuration Management*. Terraform builds the servers, and Ansible creates the inventory to configure the software packages inside them.

### 4. Cloud-Native Orchestration
The **`Terraform-EKS_AWS`** and **`ArgoCD_Setup`** folders demonstrate a modern, cloud-native workflow, setting up the complex networking and IAM requirements for a production-ready Kubernetes cluster.

---

## ⚡ Getting Started

### Prerequisites
* [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) installed (v1.0+)
* [AWS CLI](https://aws.amazon.com/cli/) configured with valid credentials (`aws configure`)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (for the Ansible directory)

### Usage Example

To deploy the **VPC Module** or **EKS Cluster**:

1.  **Navigate to the directory:**
    ```bash
    cd Terraform-EKS_AWS
    ```

2.  **Initialize Terraform:**
    Downloads providers and initializes the backend.
    ```bash
    terraform init
    ```

3.  **Plan the infrastructure:**
    Preview changes before applying.
    ```bash
    terraform plan
    ```

4.  **Apply the changes:**
    Provision the resources in AWS.
    ```bash
    terraform apply --auto-approve
    ```

5.  **Clean up:**
    Destroy resources to avoid AWS costs.
    ```bash
    terraform destroy --auto-approve
    ```
More information for commands could be found on the Terraform documentation
1. State Management (Concept)
2. Workspace
3. States
4. Imports
5. Renaming and removing states
6. Drift Management (Concept)
7. Graph
8. Provisioners
9. Life Cycle Meta Arguments
---

## ⚠️ Important Note
**Cost Warning:** Deploying resources like **EKS Clusters**, **NAT Gateways**, and **EC2 Instances** will incur costs on your AWS bill. Always ensure you run `terraform destroy` when you are finished testing.

---

## 👤 Author

**Yash**
* [GitHub Profile](https://github.com/yash252525)
