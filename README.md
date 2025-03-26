# Terraform Infrastructure for Flex Fintech

This repository manages the secure, modular deployment of microservices (HubSpot CRM, LMS, KYC, Card Issuer, etc.) using AWS EC2 and Terraform.

## Structure

- `modules/`: Reusable Terraform modules (e.g., EC2 microservice)
- `services/`: Service-specific deployment configs
- `environments/`: Separate state configs for dev, staging, prod

## Requirements

- Terraform >= 1.0
- AWS credentials with Secrets Manager + EC2 permissions
