# --------------------------------
# Variables and default values
# -------------------------------

# k8s specs
# -----------------------
# count of k8s worker nodes
WORKER_NODES_COUNT=3
# count of k8s control plane nodes
CP_NODES_COUNT=3 

# Terminal output colors
# -----------------------
RED    =$(shell tput -Txterm setab 1 && tput -Txterm setaf 0)
GREEN  =$(shell tput -Txterm setab 2 && tput -Txterm setaf 0)
PURPLE =$(shell tput -Txterm setab 2 && tput -Txterm setaf 7)
RESET  =$(shell tput -Txterm sgr0)


# --------------------------------
# Targets
# -------------------------------
targs = RunUpdate TerraformInstall TerraformRun GoodByePart

all: $(targs)

# --------------------------------
# Scripts
# -------------------------------
HelloPart:
	@echo "*****$(PURPLE) Make script started 🚀$(RESET)*****"

UpdateSoftware:
	@echo "Updating software"
	sudo apt update -y && sudo apt upgrade -y

TerraformInstall:
	@echo '*****$(PURPLE) Installing Terraform $(RESET)*****'
    # check if Terraform is already installed
	if [ -x "$(command -v terraform)" ]; then \
		echo "Terraform is already installed. Skipping installation."; \
		exit 0; \
	fi
    # install Terraform
	sudo snap install terraform --classic
    # verify version
	echo terraform -v

TerraformRun:
	@echo '*****$(PURPLE) Running Terraform $(RESET)*****'
	if [ -d "./Terraform-VirtualBox" ] && [ "$(shell ls ./Terraform-VirtualBox/*.tf 2> /dev/null | wc -l)" -gt "0" ]; then \
			cd ./Terraform-VirtualBox && terraform init && terraform plan; \
	else \
			echo "No Terraform configuration files found in ./Terraform-VirtualBox or directory does not exist."; \
	fi
	cd ./Terraform-VirtualBox && terraform apply -auto-approve

GoodByePart:
	@echo '***** END of Make script. Have a nice day 😊 *****'

RunUpdate: HelloPart UpdateSoftware 
