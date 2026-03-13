---
name: gcp-glossary
description: Beginner-friendly reference explaining core Google Cloud Platform services with AWS equivalents and free tier details.
---

# GCP Services Glossary

**A beginner-friendly reference for Google Cloud Platform services**

This glossary explains core GCP services you'll encounter when deploying applications. Each entry includes what it does, the AWS equivalent, when to use it, and free tier information.

---

## Table of Contents

1. [Identity & Access](#identity--access)
2. [Compute Services](#compute-services)
3. [Container Services](#container-services)
4. [Networking & DNS](#networking--dns)
5. [Monitoring & Logging](#monitoring--logging)
6. [Security & Secrets](#security--secrets)
7. [Developer Tools](#developer-tools)
8. [Cost Management](#cost-management)

---

## Identity & Access

### IAM & Service Accounts

**What it is**: GCP's security system that controls WHO can access WHAT in your Google Cloud project.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Google Account** | Your personal or Workspace identity used to access GCP |
| **Project** | The fundamental organizational unit in GCP — all resources live inside a project |
| **IAM Role** | A collection of permissions (Viewer, Editor, Owner, or custom) |
| **Service Account** | A special account for applications and services (not humans) to authenticate |
| **IAM Policy** | Binds members (users, groups, service accounts) to roles on a resource |
| **Workload Identity** | Lets Kubernetes or Cloud Run services impersonate service accounts without keys |

**AWS Equivalent**: IAM Users, Roles, and Policies. GCP Service Accounts ≈ AWS IAM Roles for services.

**Real-world analogy**: IAM is the building's security system. Your Google Account is your employee badge. Service Accounts are robot workers with their own badges. Roles define which rooms each badge can unlock.

**When you use it**: Every time you create resources, deploy apps, or access any GCP service.

**Free tier**: IAM itself is free. No charge for creating accounts, roles, or policies.

**Key difference from AWS**: GCP binds roles to resources (project, folder, org level), not to the identity itself. There are no "IAM Users" — you use Google Accounts directly.

---

## Compute Services

### Cloud Run

**What it is**: A fully managed serverless platform that runs containers. Give it a container image, it handles scaling, HTTPS, and infrastructure automatically.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Service** | Your deployed application, accessible via a unique URL |
| **Revision** | An immutable snapshot of your service configuration and container image |
| **Instance** | A running copy of your container handling requests |
| **Scale to Zero** | When no traffic arrives, instances drop to zero — you pay nothing |
| **Concurrency** | Number of simultaneous requests each instance handles (default: 80) |
| **CPU Throttling** | CPU is only allocated during request processing (default), saving cost |

**AWS Equivalent**: App Runner (closest), but Cloud Run is more mature and has a generous free tier.

**Real-world analogy**: A food truck that appears when customers arrive and disappears when the street is empty. You only pay for the hours the truck is open.

**When to use it**:
- Web applications and APIs
- Landing pages (runs FREE for low traffic)
- Microservices
- Background jobs and event-driven processing

**Why we USE it for this project**: Cloud Run is ideal for landing pages — it scales to zero (no cost when idle), provides automatic HTTPS, and has a generous free tier that covers most low-traffic sites entirely.

**Free tier** (Always Free, not trial):
| Resource | Monthly Free Allowance |
|----------|----------------------|
| Requests | 2 million |
| vCPU-seconds | 360,000 (100 vCPU-hours) |
| Memory | 360,000 GiB-seconds |
| Networking | 1 GB North America egress |

**A low-traffic landing page runs completely FREE on Cloud Run.**

---

## Container Services

### Artifact Registry

**What it is**: GCP's managed container and package registry. Stores Docker images, npm packages, Maven artifacts, and more.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Repository** | A named collection of artifacts (Docker images, packages) |
| **Image** | A packaged application ready to run as a container |
| **Tag** | A version label (latest, v1.0, prod) |
| **Image URI** | Full address: `us-docker.pkg.dev/PROJECT/REPO/IMAGE:TAG` |
| **Vulnerability Scanning** | Automatic security scanning of container images |

**AWS Equivalent**: ECR (Elastic Container Registry).

**Real-world analogy**: A private warehouse where you store your packaged products (container images) before shipping them to stores (Cloud Run).

**When to use it**: Storing Docker images for deployment to Cloud Run, GKE, or any container platform.

**In this project**: We push our landing page Docker image to Artifact Registry, then Cloud Run pulls it to deploy.

**Free tier**: 0.5 GB of storage per month (Always Free).

---

### Cloud Build

**What it is**: GCP's serverless CI/CD platform. Builds Docker images, runs tests, and deploys applications from source code.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Build** | A single execution of your build steps |
| **Build Config** | YAML file (`cloudbuild.yaml`) defining build steps |
| **Builder** | Pre-built container images for common tasks (docker, gcloud, npm) |
| **Trigger** | Automatically starts builds on git push or other events |
| **Build Step** | A single action in a build (e.g., build image, run tests, deploy) |

**AWS Equivalent**: CodeBuild + CodePipeline combined.

**Real-world analogy**: A factory assembly line. Each step in the line does one thing (compile, test, package, ship), and the whole line runs automatically when you deliver raw materials (push code).

**When to use it**:
- Building Docker images from source
- CI/CD pipelines triggered by git pushes
- Running tests before deployment
- Automating deployments to Cloud Run

**Free tier**: 120 build-minutes per day on e2-small machines (Always Free).

---

## Networking & DNS

### VPC (Virtual Private Cloud)

**What it is**: A private, isolated network within GCP where your resources communicate securely.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Network** | The top-level VPC resource (GCP creates a default one) |
| **Subnet** | A range of IP addresses within a VPC, tied to a region |
| **Firewall Rule** | Controls which traffic is allowed in/out of your network |
| **Private Google Access** | Lets resources without public IPs reach Google APIs |
| **VPC Connector** | Connects serverless services (Cloud Run) to your VPC |

**AWS Equivalent**: VPC (very similar concepts).

**Real-world analogy**: A private office building with its own internal phone system. Firewall rules are the security guards deciding who enters and exits.

**When to use it**: When resources need to communicate privately (databases, internal services). Cloud Run uses VPC connectors to reach private resources.

**Free tier**: VPC itself is free. VPC Connectors have a small cost when used with Cloud Run.

**For landing pages**: You usually don't need VPC configuration. Cloud Run handles networking automatically.

---

### Cloud DNS

**What it is**: GCP's managed DNS service. Translates domain names (example.com) into IP addresses.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Managed Zone** | A container for DNS records for a domain |
| **Record Set** | Maps a domain name to an IP address or another domain |
| **A Record** | Points domain to an IPv4 address |
| **CNAME** | Points domain to another domain name |

**AWS Equivalent**: Route 53.

**Real-world analogy**: A phone book that translates business names ("Cloud Coffee Shop") into phone numbers.

**When to use it**: Connecting your custom domain to your Cloud Run service.

**Free tier**: No free tier. Managed zones cost $0.20/month each, plus $0.40/million queries.

**For landing pages**: Use Cloud DNS to point your custom domain (yourbusiness.com) to your Cloud Run URL. Alternatively, many domain registrars provide free DNS.

---

### Cloud CDN

**What it is**: Google's global content delivery network. Caches your content at edge locations worldwide for faster delivery.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Edge Location** | A point of presence near end users |
| **Cache Hit** | Content served from edge cache (fast, cheap) |
| **Cache Miss** | Content fetched from origin (slower, costs more) |
| **Origin** | Your backend service (Cloud Run, Cloud Storage) |

**AWS Equivalent**: CloudFront.

**Real-world analogy**: Instead of everyone driving to one central warehouse, copies of popular products are stocked at local stores worldwide.

**When to use it**:
- High-traffic websites needing fast global delivery
- Serving static assets (images, CSS, JS) from edge locations

**Free tier**: No free tier. Charges per GB served and per cache lookup.

**For landing pages**: Not needed for low-traffic sites. Cloud Run already has good latency. Consider CDN only if you need global performance at scale.

---

## Monitoring & Logging

### Cloud Logging

**What it is**: GCP's centralized logging service. Collects, stores, and lets you search logs from all GCP services.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Log Entry** | A single log record with timestamp, severity, and message |
| **Log Explorer** | Web UI for searching and filtering logs |
| **Log Sink** | Routes logs to storage (BigQuery, Cloud Storage, Pub/Sub) |
| **Log-based Metrics** | Create custom metrics from log patterns |
| **Retention** | Default 30 days; configurable for longer |

**AWS Equivalent**: CloudWatch Logs.

**Real-world analogy**: A building's security camera system. Everything is recorded automatically, and you can search footage by time, location, or event type.

**When to use it**:
- Debugging application errors
- Monitoring deployments
- Auditing access and changes

**In this project**: Cloud Run automatically sends stdout/stderr to Cloud Logging. Use it to debug deployment issues.

**Free tier**: 50 GB of log ingestion per month (Always Free). This is very generous — most small projects never exceed this.

---

### Cloud Monitoring

**What it is**: GCP's metrics, dashboards, and alerting service. Tracks the health and performance of your resources.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Metric** | A numerical measurement over time (CPU, request count, latency) |
| **Dashboard** | Visual display of metrics and charts |
| **Alerting Policy** | Triggers notifications when metrics exceed thresholds |
| **Uptime Check** | Periodically tests if your service is responding |
| **Notification Channel** | Where alerts go (email, SMS, Slack, PagerDuty) |

**AWS Equivalent**: CloudWatch Metrics + Alarms.

**Real-world analogy**: A car dashboard showing speed, fuel level, engine temperature, and warning lights for your cloud services.

**When to use it**:
- Monitoring Cloud Run service health
- Setting up alerts for downtime or errors
- Creating dashboards for visibility

**Free tier**: Generous — includes Cloud Run built-in metrics, uptime checks, and alerting at no charge for most small deployments.

---

## Security & Secrets

### Secret Manager

**What it is**: A secure, managed service for storing API keys, passwords, certificates, and other sensitive data.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Secret** | A named container for sensitive data |
| **Version** | An immutable snapshot of the secret value (supports rotation) |
| **Access** | IAM-controlled — only authorized services can read secrets |
| **Integration** | Cloud Run can mount secrets as env vars or files automatically |

**AWS Equivalent**: Secrets Manager / SSM Parameter Store.

**Real-world analogy**: A bank vault with numbered safe deposit boxes. Only people with the right key (IAM permissions) can open a specific box.

**When to use it**:
- Storing API keys, database passwords, tokens
- Any value you don't want in your source code or environment variables
- Rotating credentials without redeploying

**Free tier**: 6 active secret versions (Always Free). Additional versions cost $0.06/version/month.

---

## Developer Tools

### Cloud Shell

**What it is**: A free, browser-based terminal with the `gcloud` CLI, Docker, and common dev tools pre-installed. Includes 5 GB of persistent home directory storage.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Cloud Shell** | Browser-based terminal with gcloud pre-configured |
| **Cloud Shell Editor** | VS Code-like editor in the browser |
| **Persistent Disk** | 5 GB home directory that persists across sessions |
| **Ephemeral VM** | The underlying VM resets after 20 minutes of inactivity |

**AWS Equivalent**: CloudShell (similar but more limited).

**Real-world analogy**: Walking into a workshop where all the tools are already set up and ready to use. You just start building.

**When to use it**:
- Quick GCP tasks when you don't have gcloud installed locally
- Learning and experimenting with GCP services
- Running one-off deployment commands

**Free tier**: Completely free. Weekly usage limits apply (50 hours/week).

---

### gcloud CLI

**What it is**: The command-line interface for interacting with all GCP services. The primary tool for managing GCP resources programmatically.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **gcloud** | Main CLI for compute, IAM, Cloud Run, etc. |
| **gsutil** | CLI for Cloud Storage (part of Google Cloud SDK) |
| **bq** | CLI for BigQuery (part of Google Cloud SDK) |
| **Project** | You set a default project: `gcloud config set project PROJECT_ID` |
| **Region** | Set a default region: `gcloud config set run/region us-central1` |

**AWS Equivalent**: AWS CLI.

**Installation**:

**Natural Language (Recommended)**:
```
"Install the Google Cloud SDK on my machine"
```

**CLI Reference**:
```bash
# macOS
brew install google-cloud-sdk

# Verify installation
gcloud version

# Authenticate
gcloud auth login

# Set default project
gcloud config set project YOUR_PROJECT_ID
```

**When to use it**: Every GCP interaction — deploying, managing resources, viewing logs, everything.

**Free tier**: The CLI itself is free. You pay only for the resources you create.

---

## Cost Management

### Billing & Projects

**What it is**: GCP organizes resources into Projects, each linked to a Billing Account. All charges are tracked at the project level.

**Key Concepts**:
| Term | Description |
|------|-------------|
| **Billing Account** | Payment method (credit card or invoice) linked to one or more projects |
| **Project** | Organizational unit containing all your resources |
| **Budget** | Spending threshold with email/programmatic alerts |
| **Budget Alert** | Notification when spending reaches a percentage of your budget |
| **Billing Export** | Send detailed billing data to BigQuery for analysis |
| **Cost Table** | View spending breakdown by service, SKU, or project |

**AWS Equivalent**: AWS Organizations (Billing Account) + AWS Budgets + Cost Explorer.

**Real-world analogy**: A company credit card (Billing Account) shared across departments (Projects). Each department tracks its own spending, and you set alerts if any department spends too much.

**Setting up Budget Alerts**:

**Natural Language (Recommended)**:
```
"Create a GCP budget of $10/month for my project with alerts at 50%, 80%, and 100%"
```

**CLI Reference**:
```bash
# Create a budget with alerts
gcloud billing budgets create \
  --billing-account=BILLING_ACCOUNT_ID \
  --display-name="Landing Page Budget" \
  --budget-amount=10.00USD \
  --threshold-rule=percent=0.5 \
  --threshold-rule=percent=0.8 \
  --threshold-rule=percent=1.0 \
  --all-updates-rule-monitoring-notification-channels=projects/PROJECT_ID/notificationChannels/CHANNEL_ID
```

**Console fallback** (one-time setup): Billing → Budgets & alerts → Create Budget.

**Free tier**: Budget alerts are free. No charge for creating budgets or viewing billing data.

---

## Service Comparison Chart

### Container Deployment Options on GCP

| Service | Complexity | Control | Cost | Best For |
|---------|------------|---------|------|----------|
| **Cloud Run** | Low | Low | Free–$ | Web apps, landing pages, APIs |
| **Cloud Run Jobs** | Low | Low | Free–$ | Batch tasks, scheduled work |
| **GKE Autopilot** | Medium | Medium | $$ | Microservices, Kubernetes workloads |
| **GKE Standard** | High | High | $$ | Full Kubernetes control |
| **Compute Engine** | High | Very High | $–$$$ | Custom VMs, legacy apps |

### GCP vs AWS Service Mapping

| GCP Service | AWS Equivalent | Notes |
|-------------|---------------|-------|
| Cloud Run | App Runner | Cloud Run has free tier; App Runner does not |
| Artifact Registry | ECR | Artifact Registry also handles npm, Maven, Python |
| Cloud Build | CodeBuild | Cloud Build has 120 free min/day |
| Cloud Logging | CloudWatch Logs | 50 GB free ingestion vs 5 GB on AWS |
| Cloud Monitoring | CloudWatch Metrics | Similar feature set |
| Secret Manager | Secrets Manager | 6 free versions on GCP |
| Cloud DNS | Route 53 | Similar pricing |
| Cloud CDN | CloudFront | Similar feature set |
| IAM + Service Accounts | IAM | GCP uses Google Accounts, not IAM Users |
| Cloud Shell | CloudShell | GCP version is more full-featured |
| gcloud CLI | AWS CLI | Similar functionality |
| Billing Budgets | AWS Budgets | Both free to set up |

---

## Quick Reference: Services Used in This Project

| Service | Purpose in This Project |
|---------|------------------------|
| **IAM & Service Accounts** | Authenticate deployments and limit permissions |
| **Artifact Registry** | Store our Docker image |
| **Cloud Run** | Host and serve our landing page (free for low traffic) |
| **Cloud Build** | Build Docker images and automate deployments |
| **Cloud Logging** | View application logs and debug issues |
| **Secret Manager** | (Optional) Store API keys or config securely |

---

## Next Steps

- [GCP Deployment Guide](../guides/GCP-DEPLOYMENT-GUIDE.md) — Deploy your landing page to Cloud Run
- [GCP Pricing Guide](./GCP-PRICING-GUIDE.md) — Understand costs and free tier
- [GCP Official Documentation](https://cloud.google.com/docs) — Deep dive into any service
