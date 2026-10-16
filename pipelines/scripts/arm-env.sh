#!/usr/bin/env bash
# Maps the Azure DevOps service connection credentials (exposed by AzureCLI@2 with
# addSpnToEnvironment: true) to the ARM_* variables the azurerm Terraform provider reads.
# Supports both workload identity federation (recommended, no secret) and client secret.

export ARM_CLIENT_ID="${servicePrincipalId}"
export ARM_TENANT_ID="${tenantId}"
export ARM_SUBSCRIPTION_ID="$(az account show --query id -o tsv)"

if [[ -n "${idToken:-}" ]]; then
  export ARM_USE_OIDC=true
  export ARM_OIDC_TOKEN="${idToken}"
else
  export ARM_CLIENT_SECRET="${servicePrincipalKey}"
fi
