# Terraform Cheatsheet

## Workflow
```bash
terraform init                   # Initialize
terraform fmt                    # Format code
terraform validate               # Validate
terraform plan                   # Preview
terraform plan -out=tfplan       # Save plan
terraform apply                  # Apply
terraform apply tfplan           # Apply saved plan
terraform destroy                # Destroy all
terraform destroy -target=aws_vpc.main  # Destroy specific
```

## State
```bash
terraform state list             # List resources
terraform state show aws_vpc.main
terraform state rm aws_vpc.main  # Remove from state
terraform import aws_vpc.main vpc-xxxx  # Import existing
terraform refresh                # Sync state with real infra
```

## Useful Flags
```bash
terraform plan -var="env=prod"
terraform apply -auto-approve    # Skip confirmation
terraform output                 # Show outputs
terraform graph | dot -Tpng > graph.png
```
