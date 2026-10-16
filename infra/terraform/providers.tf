terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Remote state in Azure Storage (created once by scripts/bootstrap-tfstate.sh).
  # Values are supplied at `terraform init -backend-config=...` time by the pipeline.
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  # Subscription and credentials come from ARM_* environment variables set by the pipeline.
}
