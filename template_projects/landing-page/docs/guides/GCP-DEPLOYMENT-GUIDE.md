---
name: gcp-deployment-guide
description: Step-by-step guide to deploying a landing page to Google Cloud using natural language with AI coding assistants.
---

# GCP Deployment Guide

**Deploy your landing page to Google Cloud using natural language with your AI coding assistant**

This guide walks you through the complete process: creating a GCP account, setting up credentials, and deploying your containerized application—all using natural language commands with Gemini CLI, Claude Code, or Codex.

---

## Table of Contents

1. [gcloud CLI vs Cloud Console](#gcloud-cli-vs-cloud-console)
2. [Create GCP Account](#1-create-gcp-account-manual)
3. [Create Project](#2-create-project)
4. [Enable APIs](#3-enable-apis)
5. [Create Service Account](#4-create-service-account)
6. [Install gcloud CLI](#5-install-gcloud-cli)
7. [Configure gcloud CLI](#6-configure-gcloud-cli-with-ai)
8. [Deploy Infrastructure](#7-deploy-infrastructure-with-ai)
9. [Deploy Application](#8-deploy-application-with-ai)
10. [Verify & Monitor](#9-verify--monitor)
11. [Clean Up](#10-clean-up-resources)
12. [Quick Reference](#quick-reference-card)
13. [Troubleshooting](#troubleshooting)
14. [Cost Breakdown](#cost-breakdown)

---

## gcloud CLI vs Cloud Console

### What's the Difference?

| Feature | Cloud Console (Web UI) | gcloud CLI (Command Line) |
|---------|----------------------|--------------------------|
| **What it is** | Website at console.cloud.google.com | Terminal commands (`gcloud ...`) |
| **How you access it** | Browser | Terminal/Shell |
| **Best for** | Visual exploration, learning, one-time setups | Automation, scripting, repeatable tasks |
| **Speed** | Slower (clicking through menus) | Faster (single commands) |
| **Reproducibility** | Hard to repeat exactly | Easy to script and share |
| **AI-assisted** | Difficult (manual clicking) | Perfect for natural language commands |

### When to Use Each

**Use Cloud Console (Web UI) when:**
- Creating your GCP account (required)
- Setting up billing for the first time
- Exploring services you're not familiar with
- Viewing dashboards and visualizations
- Managing billing and payment methods

**Use gcloud CLI when:**
- Deploying applications (what we do in this guide)
- Creating repeatable infrastructure
- Automating tasks
- Using AI coding assistants (Gemini CLI, Claude Code)
- Working in CI/CD pipelines

### How They Work Together

```
┌─────────────────────────────────────────────────────────────┐
│                      Google Cloud                            │
│                                                              │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐     │
│  │  Artifact   │    │  Cloud Run  │    │   Cloud     │     │
│  │  Registry   │    │             │    │  Logging    │     │
│  └─────────────┘    └─────────────┘    └─────────────┘     │
│         ▲                  ▲                  ▲              │
│         │                  │                  │              │
│         └──────────────────┼──────────────────┘              │
│                            │                                 │
│                    GCP API Layer                              │
│                            │                                 │
└────────────────────────────┼─────────────────────────────────┘
                             │
              ┌──────────────┴──────────────┐
              │                             │
              ▼                             ▼
     ┌─────────────────┐         ┌─────────────────┐
     │  Cloud Console  │         │   gcloud CLI    │
     │  (Web Browser)  │         │   (Terminal)    │
     │                 │         │                 │
     │  Click buttons  │         │  gcloud run ... │
     │  Fill forms     │         │  gcloud ar ...  │
     │  View dashboards│         │  gcloud logs .. │
     └─────────────────┘         └─────────────────┘
              │                             │
              │                             │
              ▼                             ▼
         You (Manual)              AI Agent (Automated)
                                   - Gemini CLI
                                   - Claude Code
                                   - Codex
```

**Key insight**: Both Console and CLI talk to the same GCP APIs. Everything you can do in the Console, you can do with the CLI (and vice versa). The CLI is just faster and automatable.

---

## Cost-Optimized Region

**Recommended Region: `us-central1` (Iowa)**

| Region | Why |
|--------|-----|
| **us-central1 (Iowa)** | Lowest cost US region, full Cloud Run support, excellent latency |
| us-east1 (South Carolina) | Good alternative, full service support |
| us-west1 (Oregon) | Good for West Coast, slightly higher cost |

**Estimated Monthly Cost**: **$0-5/month** for a landing page with low traffic (Cloud Run free tier covers most usage).

---

## 1. Create GCP Account (Manual)

This step must be done manually in your browser (Cloud Console).

### Steps

1. **Go to Google Cloud**: https://cloud.google.com/
2. **Click "Get started for free"**
3. **Sign in with your Google account** (or create one)
4. **Agree to terms of service**
5. **Select your country and organization type**
6. **Add payment method** (credit/debit card required)
   - You won't be charged unless you exceed free tier
   - New accounts get **$300 free credit** for 90 days
7. **Complete sign-up**

### Important Security Notes

- **Enable 2-Step Verification** on your Google account immediately
- **Never share your service account keys** — treat them like passwords
- The $300 free trial credit is a great way to experiment risk-free

---

## 2. Create Project

Every GCP resource lives inside a **project**. Think of it as a container for your app's infrastructure.

### Natural Language (Recommended)

Tell your AI agent:
```
"Create a new GCP project named 'my-landing-page' and set it as the active project"
```

### CLI Reference

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Create a new GCP project" | `gcloud projects create my-landing-page --name="My Landing Page"` | Creates an isolated project that groups all resources, billing, and permissions |
| "Set this as my active project" | `gcloud config set project my-landing-page` | Tells gcloud CLI to target this project for all subsequent commands |
| "Verify the active project" | `gcloud config get project` | Prints the currently active project ID |

### Link Billing Account

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "List my billing accounts" | `gcloud billing accounts list` | Shows available billing accounts and their IDs |
| "Link billing to my project" | `gcloud billing projects link my-landing-page --billing-account=BILLING_ACCOUNT_ID` | Connects your payment method to this project (required to use paid services) |

---

## 3. Enable APIs

GCP requires you to explicitly enable each API before using it.

### Natural Language (Recommended)

Tell your AI agent:
```
"Enable the Cloud Run, Artifact Registry, and Cloud Build APIs for my project"
```

### CLI Reference

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Enable all required APIs" | `gcloud services enable run.googleapis.com artifactregistry.googleapis.com cloudbuild.googleapis.com` | Activates the Cloud Run, Artifact Registry, and Cloud Build APIs in your project |
| "Verify APIs are enabled" | `gcloud services list --enabled` | Lists all currently enabled APIs to confirm activation |

### Required APIs

| API | Purpose |
|-----|---------|
| `run.googleapis.com` | Deploy and manage Cloud Run services |
| `artifactregistry.googleapis.com` | Store Docker container images |
| `cloudbuild.googleapis.com` | Build container images (optional, for remote builds) |

---

## 4. Create Service Account

Service accounts are GCP's equivalent of AWS IAM users for programmatic access.

### Natural Language (Recommended)

Tell your AI agent:
```
"Create a service account named 'landing-deployer' with permissions for
Cloud Run Admin, Artifact Registry Writer, and Cloud Build Editor.
Then create a JSON key file for it."
```

The agent will create the service account, bind the roles, and generate a key file. **Save the key file securely** — you'll need it for CI/CD deployments.

### CLI Reference

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Create the service account" | `gcloud iam service-accounts create landing-deployer --display-name="Landing Page Deployer"` | Creates a service account identity for deployments |
| "Grant Cloud Run Admin" | `gcloud projects add-iam-policy-binding my-landing-page --member="serviceAccount:landing-deployer@my-landing-page.iam.gserviceaccount.com" --role="roles/run.admin"` | Allows deploying and managing Cloud Run services |
| "Grant Artifact Registry Writer" | `gcloud projects add-iam-policy-binding my-landing-page --member="serviceAccount:landing-deployer@my-landing-page.iam.gserviceaccount.com" --role="roles/artifactregistry.writer"` | Allows pushing images to Artifact Registry |
| "Grant Service Account User" | `gcloud projects add-iam-policy-binding my-landing-page --member="serviceAccount:landing-deployer@my-landing-page.iam.gserviceaccount.com" --role="roles/iam.serviceAccountUser"` | Allows the service account to act as itself when deploying Cloud Run |
| "Create key file" | `gcloud iam service-accounts keys create key.json --iam-account=landing-deployer@my-landing-page.iam.gserviceaccount.com` | Downloads a JSON credential file for authenticating as this service account |

### Required Roles

| Role | Purpose |
|------|---------|
| `roles/run.admin` | Create and manage Cloud Run services |
| `roles/artifactregistry.writer` | Push container images to Artifact Registry |
| `roles/iam.serviceAccountUser` | Allows deploying Cloud Run with the service account identity |

### Security Best Practices

- Never commit `key.json` to git (add it to `.gitignore`)
- Never share key files via email or chat
- Rotate keys periodically
- Use Workload Identity Federation for CI/CD instead of key files when possible
- Delete key files after configuring your environment

---

## 5. Install gcloud CLI

### macOS (Homebrew) - Recommended

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Install gcloud CLI using Homebrew" | `brew install --cask google-cloud-sdk` | Downloads and installs the gcloud CLI tool from Homebrew |
| "Verify gcloud is installed" | `gcloud version` | Prints the installed gcloud CLI version to confirm installation |

### Manual Installation (if not using Homebrew)

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Download and install gcloud CLI for macOS" | `curl https://sdk.cloud.google.com \| bash` | Downloads and runs the interactive installer script |
| "Restart your shell" | `exec -l $SHELL` | Reloads shell to pick up gcloud in your PATH |

### Windows

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Install gcloud CLI on Windows" | Download from https://cloud.google.com/sdk/docs/install#windows | Downloads the Windows installer; run it to install |

### Linux

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Install gcloud CLI on Linux" | `curl https://sdk.cloud.google.com \| bash` | Downloads and runs the interactive installer |

---

## 6. Configure gcloud CLI with AI

Use your AI coding assistant to configure gcloud CLI with your credentials.

### Authenticate Your Account

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Log in to gcloud CLI" | `gcloud auth login` | Opens a browser for OAuth login, then stores credentials locally |
| "Set my default project" | `gcloud config set project my-landing-page` | Configures all commands to target this project by default |
| "Set my default region" | `gcloud config set run/region us-central1` | Sets Cloud Run region default so you don't need `--region` every time |

### Verify Configuration

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Test my gcloud credentials are working" | `gcloud auth list` | Shows all authenticated accounts and highlights the active one |
| "Show my current gcloud configuration" | `gcloud config list` | Displays project, region, account, and other active settings |
| "Get my project number" | `gcloud projects describe my-landing-page --format="value(projectNumber)"` | Returns the numeric project ID (needed for some advanced configurations) |

### Authenticate Docker with gcloud

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Configure Docker to use gcloud for Artifact Registry" | `gcloud auth configure-docker us-central1-docker.pkg.dev` | Registers gcloud as a Docker credential helper for your registry region |

---

## 7. Deploy Infrastructure with AI

Use your AI coding assistant to set up the required GCP infrastructure.

### Step 7.1: Create Artifact Registry Repository

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Create an Artifact Registry Docker repository named 'my-landing-page' in us-central1" | `gcloud artifacts repositories create my-landing-page --repository-format=docker --location=us-central1 --description="Landing page container images"` | Creates a private Docker image registry in GCP where you'll store your container images |
| "Verify the repository was created" | `gcloud artifacts repositories describe my-landing-page --location=us-central1` | Shows repository details including the full URI |

**Repository URI format:**
```
us-central1-docker.pkg.dev/my-landing-page/my-landing-page
```

---

## 8. Deploy Application with AI

### Step 8.1: Build Production Docker Image

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Build the production Docker image tagged as my-landing-page:latest" | `docker build -t my-landing-page:latest .` | Reads Dockerfile, downloads base images, installs dependencies, builds Next.js app, creates optimized image |
| "Verify the image was built" | `docker images my-landing-page` | Lists local Docker images matching the name, shows size and creation time |

### Step 8.2: Tag Image for Artifact Registry

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Tag my image for Artifact Registry" | `docker tag my-landing-page:latest us-central1-docker.pkg.dev/my-landing-page/my-landing-page/app:latest` | Creates an alias with the full Artifact Registry URI so Docker knows where to push |

### Step 8.3: Push Image to Artifact Registry

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Push my landing page image to Artifact Registry" | `docker push us-central1-docker.pkg.dev/my-landing-page/my-landing-page/app:latest` | Uploads all image layers to Artifact Registry; subsequent pushes only upload changed layers |
| "Verify the image is in Artifact Registry" | `gcloud artifacts docker images list us-central1-docker.pkg.dev/my-landing-page/my-landing-page` | Lists all images in the repository with their tags and sizes |

### Step 8.4: Deploy to Cloud Run

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Deploy my landing page image to Cloud Run with minimum resources" | See command below | Creates a fully managed web service that pulls your image, runs it, handles scaling, and provides a public URL |

**Full deployment command:**

```bash
gcloud run deploy my-landing-page \
  --image us-central1-docker.pkg.dev/my-landing-page/my-landing-page/app:latest \
  --region us-central1 \
  --platform managed \
  --port 3000 \
  --memory 512Mi \
  --cpu 1 \
  --min-instances 0 \
  --max-instances 3 \
  --allow-unauthenticated
```

**What each flag does:**
- `--image`: The full URI of your Docker image in Artifact Registry
- `--region`: Where to run the service (us-central1 for lowest cost)
- `--platform managed`: Use fully managed Cloud Run (serverless)
- `--port`: Which port your app listens on (Next.js uses 3000)
- `--memory`: RAM allocated per instance (512Mi is enough for a landing page)
- `--cpu`: Number of vCPUs per instance
- `--min-instances 0`: **Scale to zero** when no traffic (saves money!)
- `--max-instances 3`: Cap scaling to control costs
- `--allow-unauthenticated`: Makes the service publicly accessible

### Step 8.5: Wait for Deployment

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Check the status of my Cloud Run deployment" | `gcloud run services describe my-landing-page --region us-central1 --format="value(status.conditions[0].type, status.conditions[0].status)"` | Queries the current state of your service |
| "Get my Cloud Run service URL" | `gcloud run services describe my-landing-page --region us-central1 --format="value(status.url)"` | Returns the public HTTPS URL where your app is accessible |

**Deployment typically completes in under a minute.** Cloud Run provisions faster than App Runner.

---

## 9. Verify & Monitor

### Check Your Live Site

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Open my deployed landing page in the browser" | Open `https://my-landing-page-XXXXXX-uc.a.run.app` | Access your live website via the auto-generated HTTPS URL |
| "Get the full URL of my Cloud Run service" | `gcloud run services describe my-landing-page --region us-central1 --format="value(status.url)"` | Retrieves the public URL from GCP |

### View Logs

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Show me the logs from my Cloud Run service" | `gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=my-landing-page" --limit 50 --format="table(timestamp,textPayload)"` | Fetches recent logs from your application |
| "Stream live logs from my Cloud Run service" | `gcloud beta run services logs tail my-landing-page --region us-central1` | Streams live logs in real-time (like `tail -f`) |

### Monitor Costs

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Show me my current GCP billing" | `gcloud billing projects describe my-landing-page` | Shows the billing account linked to your project |

Or check the Cloud Console: https://console.cloud.google.com/billing

---

## 10. Clean Up Resources

**Important:** Delete resources when not in use to avoid charges (though Cloud Run at scale-to-zero costs nearly nothing).

### Delete Cloud Run Service

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Delete my Cloud Run service" | `gcloud run services delete my-landing-page --region us-central1 --quiet` | Stops the service and removes it (stops billing for requests) |
| "Confirm the service was deleted" | `gcloud run services list --region us-central1` | Lists all services to verify deletion |

### Delete Artifact Registry Repository

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Delete my Artifact Registry repository and all images" | `gcloud artifacts repositories delete my-landing-page --location us-central1 --quiet` | Deletes the repository and all stored images (frees storage costs) |

### Delete Service Account (Optional)

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Delete the deployer service account" | `gcloud iam service-accounts delete landing-deployer@my-landing-page.iam.gserviceaccount.com --quiet` | Removes the service account and revokes all its permissions |

### Delete Project (Nuclear Option)

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Delete the entire GCP project" | `gcloud projects delete my-landing-page` | Schedules the project for deletion after 30 days (removes ALL resources) |

---

## Quick Reference Card

### One-Time Setup (do once)

| Step | Natural Language | What's Happening |
|------|-----------------|------------------|
| 1 | "Install gcloud CLI using Homebrew" | Installs the gcloud command-line tool |
| 2 | "Log in to gcloud and set my project" | Authenticates and configures your environment |
| 3 | "Enable Cloud Run and Artifact Registry APIs" | Activates the services you need |
| 4 | "Create Artifact Registry repository named 'my-landing-page'" | Creates your private Docker registry |

### Deploy (repeat for each update)

| Step | Natural Language | What's Happening |
|------|-----------------|------------------|
| 1 | "Build the production Docker image" | Packages your app into a container |
| 2 | "Tag the image for Artifact Registry" | Prepares image with registry destination |
| 3 | "Push the image to Artifact Registry" | Uploads your container to GCP |
| 4 | "Deploy to Cloud Run" | Launches your app on GCP infrastructure |

### Monitor

| Task | Natural Language | What's Happening |
|------|-----------------|------------------|
| Check status | "What's the status of my Cloud Run service?" | Queries service health |
| View logs | "Show me the Cloud Run logs" | Streams application output |
| Get URL | "What's my Cloud Run service URL?" | Returns public website address |

### Clean Up

| Task | Natural Language | What's Happening |
|------|-----------------|------------------|
| Stop charges | "Delete my Cloud Run service and Artifact Registry repository" | Removes all billable resources |

---

## Troubleshooting

### Common Issues

| Problem | Natural Language to Fix | What's Happening |
|---------|------------------------|------------------|
| "Permission denied" errors | "Check if my gcloud credentials are valid" | Token expired or wrong project |
| Docker push fails | "Re-authenticate Docker with Artifact Registry" | gcloud Docker credential helper needs refresh |
| Cloud Run stuck deploying | "Check Cloud Run service events for errors" | Image pull failed or app crashed on startup |
| Image push fails | "Verify Artifact Registry repository exists" | Wrong region or repository name |
| Service won't start | "Show me the Cloud Run logs" | Application error during startup |
| "API not enabled" error | "Enable the required API for my project" | Forgot to enable a GCP API |

### Debug Commands

| Natural Language | CLI Command | What's Happening |
|-----------------|-------------|------------------|
| "Show detailed Cloud Run info" | `gcloud run services describe my-landing-page --region us-central1` | Returns full service configuration and status |
| "List all my Cloud Run services" | `gcloud run services list` | Shows all services across all regions |
| "Show recent revisions" | `gcloud run revisions list --service my-landing-page --region us-central1` | Shows deployment history with traffic allocation |
| "Check which APIs are enabled" | `gcloud services list --enabled` | Lists all active APIs in the project |

---

## Cost Breakdown

### Estimated Monthly Costs (Low Traffic Landing Page)

| Service | Configuration | Monthly Cost |
|---------|--------------|--------------|
| Cloud Run | 1 vCPU, 512 MB, scale-to-zero | **$0** (free tier) |
| Artifact Registry | < 0.5 GB | **$0** (free tier) |
| Cloud Logging | < 50 GB | **$0** (free tier) |
| **Total** | | **$0-2/month** |

**Key advantage over AWS**: Cloud Run's free tier includes 2 million requests/month and 360,000 vCPU-seconds/month. A low-traffic landing page stays well within these limits, meaning **$0/month** in most cases.

### Cost Optimization Tips

1. **Set `--min-instances 0`** — scale to zero when no traffic (no charge when idle)
2. **Use CPU throttling** — Cloud Run only charges for CPU during request processing by default
3. **Cap `--max-instances`** to prevent runaway scaling
4. **Set up budget alerts** to catch unexpected charges early
5. **Delete unused resources** when done experimenting

---

## Related Documentation

- [GCP Glossary](../reference/GCP-GLOSSARY.md) — Learn what each GCP service does
- [GCP Pricing Guide](../reference/GCP-PRICING-GUIDE.md) — Understand costs and free tier details
- [GCP Deployment Roadmap](./GCP-DEPLOYMENT-ROADMAP.md) — Phase-by-phase walkthrough

---

**Need help?** Tell your AI agent:
```
"I'm getting this GCP error: [paste error]. Help me fix it."
```
