TERRAFORM_DIR := ./terraform
AUTO_APPROVE := -auto-approve
PARALLELISM := -parallelism=5

.PHONY: default
default: help

.PHONY: init
init:
	@echo "Initializing Terraform..."
	@cd $(TERRAFORM_DIR) && terraform init

.PHONY: apply
apply: init
	@echo "Applying Terraform changes..."
	@cd $(TERRAFORM_DIR) && terraform apply $(AUTO_APPROVE) $(PARALLELISM)

.PHONY: destroy
destroy:
	@echo "Destroying Terraform-managed infrastructure..."
	@cd $(TERRAFORM_DIR) && terraform destroy $(AUTO_APPROVE) $(PARALLELISM)

.PHONY: recreate
recreate: init destroy apply

.PHONY: validate
validate:
	@echo "Validating Terraform files..."
	@cd $(TERRAFORM_DIR) && terraform validate

.PHONY: fmt
fmt:
	@echo "Formatting Terraform files..."
	@cd $(TERRAFORM_DIR) && terraform fmt -recursive

.PHONY: clean
clean:
	@echo "Cleaning up Terraform .tfstate backup files..."
	@cd $(TERRAFORM_DIR) && rm -rf *.tfstate.backup

.PHONY: help
help:
	@echo "Usage:"
	@echo "  make init      - Initialize Terraform"
	@echo "  make apply     - Apply Terraform changes"
	@echo "  make destroy   - Destroy Terraform-managed infrastructure"
	@echo "  make recreate  - Recreate Terraform-managed infrastructure"
	@echo "  make validate  - Validate Terraform files"
	@echo "  make fmt       - Format Terraform files"
	@echo "  make clean     - Clean backup Terraform state files"
	@echo "  make help      - Show this help message"
