# Deploying to the Cloud

> Phase 4 of your build journey: Make your site live on the internet.

## Overview

You will push your Docker image to a cloud container registry and deploy it to a managed hosting service. When someone visits your URL, the cloud serves your site 24/7.

## Deployment Pipeline

```
┌─────────────┐     ┌─────────────┐     ┌──────────────────┐
│  Develop     │ --> │ Containerize │ --> │   Deploy         │
│ docker:dev   │     │ docker:prod  │     │ AWS App Runner   │
│              │     │              │     │   -- or --       │
│              │     │              │     │ GCP Cloud Run    │
└─────────────┘     └─────────────┘     └──────────────────┘
```

## Quick Summary

### Option A: AWS App Runner

1. Push your Docker image to AWS ECR (container registry)
2. Create an App Runner service (managed hosting)
3. Get your public URL

### Option B: GCP Cloud Run

1. Push your Docker image to Google Artifact Registry
2. Deploy to Cloud Run (managed hosting)
3. Get your public URL

Cloud Run offers a generous free tier: up to 2 million requests/month at no cost, making it $0/month for low-traffic sites compared to $5-15/month on AWS App Runner.

## Detailed Guides

For step-by-step deployment instructions, see the guides in the project docs:

- [Deployment Roadmap](../../projects/agentic-landing-template/docs/guides/DEPLOYMENT-ROADMAP.md) -- Full deployment walkthrough
- [AWS Deployment Guide](../../projects/agentic-landing-template/docs/guides/AWS-DEPLOYMENT-GUIDE.md) -- AWS-specific instructions
- [AWS Glossary](../../projects/agentic-landing-template/docs/reference/AWS-GLOSSARY.md) -- Cloud terminology explained
- [AWS Pricing Guide](../../projects/agentic-landing-template/docs/reference/AWS-PRICING-GUIDE.md) -- Cost estimates and optimization
- [GCP Deployment Guide](../../projects/agentic-landing-template/docs/guides/GCP-DEPLOYMENT-GUIDE.md) -- GCP Cloud Run instructions
- [GCP Deployment Roadmap](../../projects/agentic-landing-template/docs/guides/GCP-DEPLOYMENT-ROADMAP.md) -- GCP deployment walkthrough
- [GCP Glossary](../../projects/agentic-landing-template/docs/reference/GCP-GLOSSARY.md) -- GCP terminology explained
- [GCP Pricing Guide](../../projects/agentic-landing-template/docs/reference/GCP-PRICING-GUIDE.md) -- GCP cost estimates and optimization

## Estimated Costs

### AWS

| Service | Monthly Cost |
|---------|-------------|
| AWS App Runner (1 vCPU, 2GB) | $5-15 |
| ECR Storage | <$1 |
| Data Transfer | <$1 |
| **Total** | **~$7-17/month** |

*Costs vary based on traffic. First 12 months may qualify for AWS Free Tier.*

### GCP

| Service | Monthly Cost |
|---------|-------------|
| GCP Cloud Run (low traffic) | $0 (free tier) |
| Artifact Registry Storage | <$1 |
| Data Transfer | <$1 |
| **Total** | **~$0-2/month** |

*Cloud Run free tier includes 2M requests/month and 360,000 vCPU-seconds. Most personal sites stay well within free limits.*

## Checkpoint

> Can you share your live URL with someone? If yes, congratulations -- you have deployed your first cloud application.

---

**Previous:** [Customizing Your Landing Page with AI](customize.md)
