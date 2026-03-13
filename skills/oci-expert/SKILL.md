---
name: oci-expert
description: Expert in Oracle Cloud Infrastructure (OCI) and the OCI CLI. Use this skill when provisioning OCI resources, writing oci commands, designing Always Free tier architectures, understanding OCI pricing, troubleshooting CLI errors, or planning cloud deployments on Oracle Cloud. Triggers on questions like "how do I create a VCN", "what is the Always Free limit for A1", "oci compute instance launch fails", or any OCI-specific infrastructure task.
---

# OCI Expert

## Core Principle

Oracle's Always Free tier is the best permanent free cloud compute available (4 OCPU / 24 GB ARM64). Know the limits, provision correctly, and never pay for what free already gives you.

## Always Free Tier — What You Actually Get

| Resource | Always Free Limit | Shape |
|---|---|---|
| ARM Compute | 4 OCPU + 24 GB RAM total | VM.Standard.A1.Flex |
| x86 Compute | 2 x VM.Standard.E2.1.Micro | AMD |
| Block Volume | 200 GB total | — |
| Object Storage | 20 GB | Standard |
| Outbound bandwidth | 10 TB/month | — |
| Load Balancer | 1 x 10 Mbps flexible LB | — |
| Autonomous Database | 2 x 20 GB ATP or ADW | — |

**Key rule:** A1 Flex OCPU/RAM is a pool — split across multiple instances however you want (e.g., 1×4/24 or 4×1/6). Total must stay at or below 4 OCPU / 24 GB.

**Region tip:** us-chicago-1 (ORD) has better A1 availability than us-ashburn-1 or us-sanjose-1. If you hit "Out of host capacity", try ORD first.

## OCI CLI — Essential Patterns

### Authentication Setup
```bash
# Install
brew install oci-cli                           # Mac
pip install oci-cli                            # Linux/WSL

# Config at ~/.oci/config
[DEFAULT]
user=ocid1.user.oc1..aaa...
fingerprint=xx:xx:xx:...
tenancy=ocid1.tenancy.oc1..aaa...
region=us-chicago-1
key_file=~/.oci/oci_api_key.pem

# Generate key pair
openssl genrsa -out ~/.oci/oci_api_key.pem 2048
chmod 600 ~/.oci/oci_api_key.pem
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
openssl rsa -pubout -outform DER -in ~/.oci/oci_api_key.pem | openssl dgst -md5 -c  # fingerprint

# Verify
oci iam region list --output table
```

### Compute — A1 ARM Instance (Always Free)
```bash
# Get ARM Ubuntu 24.04 image
export IMAGE=$(oci compute image list \
  --compartment-id $TENANCY \
  --shape VM.Standard.A1.Flex \
  --operating-system "Canonical Ubuntu" \
  --operating-system-version "24.04" \
  --query 'data[0].id' --raw-output)

# Launch full Always Free entitlement
export INSTANCE=$(oci compute instance launch \
  --compartment-id $TENANCY \
  --availability-domain "$AD" \
  --display-name "my-instance" \
  --shape "VM.Standard.A1.Flex" \
  --shape-config '{"ocpus":4,"memoryInGBs":24}' \
  --image-id $IMAGE \
  --subnet-id $SUBNET \
  --assign-public-ip true \
  --metadata "{\"ssh_authorized_keys\":\"$SSH_KEY\"}" \
  --boot-volume-size-in-gbs 50 \
  --query 'data.id' --raw-output)

# ⚠️ Do NOT use --wait-for-state on instance launch — poll instead:
for i in {1..12}; do
  STATE=$(oci compute instance get --instance-id $INSTANCE \
    --query 'data."lifecycle-state"' --raw-output)
  echo "$STATE"; [ "$STATE" = "RUNNING" ] && break; sleep 10
done

# Get public IP
oci compute instance list-vnics --instance-id $INSTANCE \
  --query 'data[0]."public-ip"' --raw-output
```

### Network Stack (VCN → IGW → Route → Security List → Subnet)
```bash
# VCN
export VCN=$(oci network vcn create \
  --compartment-id $TENANCY --cidr-block "10.0.0.0/16" \
  --display-name "my-vcn" --dns-label "myvcn" \
  --wait-for-state AVAILABLE --query 'data.id' --raw-output)

# Internet Gateway
export IGW=$(oci network internet-gateway create \
  --compartment-id $TENANCY --vcn-id $VCN --is-enabled true \
  --display-name "my-igw" \
  --wait-for-state AVAILABLE --query 'data.id' --raw-output)

# Default route to IGW
export RT=$(oci network route-table list \
  --compartment-id $TENANCY --vcn-id $VCN \
  --query 'data[0].id' --raw-output)
oci network route-table update --rt-id $RT --force \
  --route-rules "[{\"destination\":\"0.0.0.0/0\",\"destinationType\":\"CIDR_BLOCK\",\"networkEntityId\":\"$IGW\"}]"

# Security list — SSH only by default (never open app ports publicly)
export SL=$(oci network security-list list \
  --compartment-id $TENANCY --vcn-id $VCN \
  --query 'data[0].id' --raw-output)
oci network security-list update --security-list-id $SL --force \
  --ingress-security-rules '[
    {"protocol":"6","source":"0.0.0.0/0","tcpOptions":{"destinationPortRange":{"min":22,"max":22}},"isStateless":false},
    {"protocol":"1","source":"0.0.0.0/0","isStateless":false}
  ]'

# Subnet
export SUBNET=$(oci network subnet create \
  --compartment-id $TENANCY --vcn-id $VCN --cidr-block "10.0.0.0/24" \
  --display-name "my-subnet" --dns-label "mysub" \
  --availability-domain "$AD" \
  --wait-for-state AVAILABLE --query 'data.id' --raw-output)
```

### Region & Tenancy
```bash
# List subscribed regions
oci iam region-subscription list --tenancy-id $TENANCY --output table

# Subscribe to a new region (Free Trial: CLI fails — use Console UI)
# Console → Profile → Tenancy → Subscribed Regions → Manage → Subscribe

# Get availability domains in a region
oci iam availability-domain list --compartment-id $TENANCY --query 'data[0].name' --raw-output
```

### Useful Query Patterns
```bash
# List all running instances
oci compute instance list --compartment-id $TENANCY \
  --lifecycle-state RUNNING --output table

# Find shape availability
oci compute shape list --compartment-id $TENANCY --output table | grep A1

# Get OCID from name (jmespath filter)
oci network vcn list --compartment-id $TENANCY \
  --query 'data[?."display-name"==`my-vcn`].id | [0]' --raw-output

# Output formats: --output table | json | raw-output (with --query)
```

## Common Errors & Fixes

| Error | Root Cause | Fix |
|---|---|---|
| `NotAuthenticated` | Wrong region or wrong key fingerprint | Check `~/.oci/config` region matches where resources live |
| `Out of host capacity` | A1 ARM slot unavailable in AD | Try another availability domain or us-chicago-1 |
| `TenantCapacityExceeded` on region subscribe | Free Trial 1-region limit | Upgrade to PAYG first; subscribe via Console UI |
| `--wait-for-state` unavailable on `instance get` | Not supported on that resource | Poll with a loop |
| `--ssh-authorized-keys` flag not found | Wrong flag | Use `--metadata '{"ssh_authorized_keys":"..."}'` |
| 401 on correct config | Region mismatch | Resources are in a different region than `config` specifies |

## Security-First Defaults

| Anti-Pattern | OCI Pattern |
|---|---|
| Opening app ports in security list | Bind app to `127.0.0.1`, use SSH tunnel |
| `0.0.0.0/0` for all ingress | SSH (22) only; all else via tunnel or Socket Mode |
| Using root/admin user for CLI | Create a limited IAM user with required policies only |
| API keys in scripts | Use instance principal auth for code running on OCI |

## Pricing Awareness

**Always Free never expires** (PAYG account required for multi-region).

| Scenario | Cost |
|---|---|
| 1× A1.Flex 4/24 in one region | $0/month forever |
| A1.Flex 4/24 + 2× E2.1.Micro | $0/month forever |
| 200 GB block volume | $0/month forever |
| Extra OCPU beyond 4 | ~$0.01/OCPU-hour |
| Extra RAM beyond 24 GB | ~$0.0015/GB-hour |
| Second region (same resources) | Billed at pay-as-you-go rates |

**PAYG upgrade is free** — you only pay if you exceed Always Free limits.

## Instance Principal Auth (for code on OCI)

Skip API keys for services running on OCI instances:

```python
import oci
signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
compute = oci.core.ComputeClient(config={}, signer=signer)
```

Requires: attach an IAM Dynamic Group policy to the instance.

## Cleanup — Deletion Order

Dependencies must go before parents:

```bash
oci compute instance terminate --instance-id $INSTANCE --force
sleep 30
oci network subnet delete --subnet-id $SUBNET --force
oci network internet-gateway delete --ig-id $IGW --force
oci network vcn delete --vcn-id $VCN --force
```
