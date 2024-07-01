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
# Scripts
# -------------------------------
HelloPart:
  @echo '*****$(PURPLE) Make script started 🚀$(RESET) *****'

UpdateSoftware:
  @echo 'Updating software'
  @sudo apt update -y

TerraformInstall:
  # download and save the hashicorp PGP keys
  @wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  # add to package providers
  @echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  # install Terraform
  @sudo apt update && sudo apt install terraform
  # verify version
  @terraform -v

TerraformRun:
  @echo '*****$(PURPLE) Running Terraform $(RESET)*****'
  @cd ./Terraform-VirtualBox 
  @terraform init

GoodByePart:
  @echo '***** END of Make script. Have a nice day 😊 *****'

RunUpdate: HelloPart UpdateSoftware GoodByePart
