#!/usr/bin/env bash
# One-time setup: creates the Storage Account that holds Terraform remote state.
# Run locally after `az login`.  Usage: ./scripts/bootstrap-tfstate.sh [region]
set -euo pipefail

LOCATION="${1:-centralindia}"
RG="rg-tfstate"
SA="tfstate$RANDOM$RANDOM"   # must be globally unique, lowercase, 3-24 chars
CONTAINER="tfstate"

az group create --name "$RG" --location "$LOCATION" --output none
az storage account create \
  --name "$SA" --resource-group "$RG" --location "$LOCATION" \
  --sku Standard_LRS --min-tls-version TLS1_2 \
  --allow-blob-public-access false --output none
az storage container create --name "$CONTAINER" --account-name "$SA" --auth-mode login --output none

echo ""
echo "Terraform state storage is ready. Put these in the 'tfstate' variable group in Azure DevOps:"
echo "  TF_STATE_RG        = $RG"
echo "  TF_STATE_SA        = $SA"
echo "  TF_STATE_CONTAINER = $CONTAINER"
