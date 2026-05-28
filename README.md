# 🚀 End-to-End DevOps Cloud Pipeline

![Architecture: AWS](https://img.shields.io/badge/AWS-EC2%20%7C%20Security%20Groups-FF9900?logo=amazonaws&logoColor=white)
![IaC: Terraform](https://img.shields.io/badge/Terraform-Infrastructure%20as%20Code-7B42BC?logo=terraform&logoColor=white)
![Config: Ansible](https://img.shields.io/badge/Ansible-Configuration%20Management-EE0000?logo=ansible&logoColor=white)
![Containers: Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?logo=docker&logoColor=white)
![Backend: Python](https://img.shields.io/badge/Python-FastAPI-3776AB?logo=python&logoColor=white)

## 📌 Project Overview
This project is a fully automated, end-to-end DevOps pipeline. It provisions cloud infrastructure from scratch, configures the server, and deploys a containerized Python REST API without requiring any manual server logins or GUI interactions. 

The goal of this project is to demonstrate the core principles of **Immutable Infrastructure**, **Configuration Management**, and **Containerization**.

## 🏗️ Architecture

1. **Application Layer:** A lightweight Python/FastAPI microservice packaged into a Docker image.
2. **Infrastructure Layer (Terraform):** Automatically provisions an AWS EC2 instance (`t3.micro` in `eu-north-1`), configures VPC Security Groups for SSH/HTTP access, and injects cryptographic SSH keys.
3. **Configuration Layer (Ansible):** Connects to the raw EC2 instance via SSH, installs Docker, transfers the application code, builds the image, and orchestrates the container.

## 📂 Repository Structure
* `/app` - Contains the Python API source code, `requirements.txt`, and the `Dockerfile`.
* `/terraform` - Contains the declarative `main.tf` script to provision the AWS environment.
* `/ansible` - Contains the `deploy.yml` playbook and inventory files for server configuration.
