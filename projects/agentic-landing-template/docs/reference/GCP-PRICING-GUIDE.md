# GCP Pricing Guide

**Understanding Google Cloud costs, free tier, and how to keep your landing page deployment free (or nearly free)**

This guide explains GCP's pricing model, its generous free tier, and how to ensure your landing page runs at minimal cost.

---

## Table of Contents

1. [GCP Pricing Philosophy](#gcp-pricing-philosophy)
2. [Free Tier Details](#gcp-free-tier)
3. [Service-Specific Pricing](#service-specific-pricing)
4. [Cost Management](#cost-management)
5. [Cost Optimization Tips](#cost-optimization-tips)
6. [Sample Monthly Budgets](#sample-monthly-budgets)
7. [Cost Comparison: GCP vs AWS](#cost-comparison-gcp-vs-aws)
8. [Red Flags: Unexpected Costs](#red-flags-unexpected-costs)
9. [Natural Language Quick Commands](#natural-language-quick-commands)

---

## GCP Pricing Philosophy

### Pay-As-You-Go with Generous Free Tier

GCP charges you only for what you use — no upfront costs, no long-term contracts required. What sets GCP apart is its **Always Free tier**, which is permanent (not a 12-month trial) and covers real production workloads.

**The Good**:
- Always Free tier covers low-traffic sites entirely
- Cloud Run scales to zero — you pay nothing when idle
- Per-second billing on most services (no rounding up to the hour)
- Sustained use discounts applied automatically (no commitment needed)

**The Risk**:
- Misconfigured minimum instances can prevent scale-to-zero
- Cloud Build minutes can add up with frequent deployments
- Forgetting to set budget alerts

### Three Core Pricing Dimensions

| Dimension | Description | Example |
|-----------|-------------|---------|
| **Compute** | vCPU-seconds and memory used | Cloud Run request handling |
| **Storage** | Data stored | Artifact Registry images, Cloud Logging |
| **Networking** | Data egress (outbound traffic) | Responses sent to users |

**Key insight**: Data INTO GCP is free. Data OUT costs money — but Cloud Run includes 1 GB free North America egress monthly.

---

## GCP Free Tier

GCP's Always Free tier is **permanent** — it does not expire after 12 months. These limits reset monthly.

### Always Free Services (Used in This Project)

| Service | Free Monthly Allowance | Typical Landing Page Usage |
|---------|----------------------|---------------------------|
| **Cloud Run** | 2M requests, 360K vCPU-sec, 360K GiB-sec | Well within limits |
| **Artifact Registry** | 0.5 GB storage | ~200-500 MB for one image |
| **Cloud Build** | 120 build-minutes/day (e2-small) | 2-5 min per build |
| **Cloud Logging** | 50 GB ingestion | Negligible for landing page |
| **Cloud Monitoring** | Built-in metrics, alerting | Free for Cloud Run |
| **Secret Manager** | 6 active secret versions | Sufficient for most apps |

### Cloud Run Free Tier Breakdown

This is the most important free tier for this project:

| Resource | Free Allowance | What It Means |
|----------|---------------|---------------|
| **Requests** | 2,000,000/month | ~66,000 page views/day |
| **vCPU-seconds** | 360,000/month | ~100 vCPU-hours of processing |
| **Memory (GiB-seconds)** | 360,000/month | ~100 GiB-hours |
| **Networking (egress)** | 1 GB/month (N. America) | ~10,000 page loads at 100KB each |

**Bottom line**: A landing page with a few hundred daily visitors runs **completely free** on Cloud Run.

### $300 Free Trial Credit (New Accounts)

New GCP accounts get $300 in free credits valid for 90 days. This is separate from the Always Free tier and covers any GCP service.

---

## Service-Specific Pricing

### Cloud Run Pricing

Cloud Run charges only when your service is handling requests (with default CPU throttling).

| Component | Price | Notes |
|-----------|-------|-------|
| **vCPU-second** | $0.00002400 | Only during request processing |
| **GiB-second** | $0.00000250 | Memory allocated during requests |
| **Requests** | $0.40 per million | After 2M free |
| **Networking (egress)** | $0.12/GB (N. America) | After 1 GB free |

**CPU Allocation Modes**:
| Mode | Behavior | Cost | Best For |
|------|----------|------|----------|
| **CPU throttled** (default) | CPU only during requests | Lowest | Landing pages, APIs |
| **CPU always allocated** | CPU always on per instance | Higher | WebSocket, background work |

**With default settings (CPU throttled, min instances 0)**, you pay nothing when no one is visiting your site.

---

### Artifact Registry Pricing

| Component | Price | Notes |
|-----------|-------|-------|
| **Storage** | $0.10/GB/month | After 0.5 GB free |
| **Network egress** | Same region to Cloud Run: Free | Cross-region costs apply |

**Typical landing page**: Free (images are usually 200-500 MB, within the 0.5 GB free tier).

**Tip**: Delete old image tags to stay within the free tier:

**Natural Language**:
```
"Delete all old Docker image tags from Artifact Registry, keep only the latest"
```

**CLI Reference**:
```bash
# List images
gcloud artifacts docker images list us-docker.pkg.dev/PROJECT/REPO

# Delete old tags
gcloud artifacts docker images delete us-docker.pkg.dev/PROJECT/REPO/IMAGE:old-tag
```

---

### Cloud Build Pricing

| Component | Free Tier | Price After |
|-----------|-----------|-------------|
| **e2-small (default)** | 120 min/day | $0.003/build-minute |
| **e2-medium** | Not free | $0.006/build-minute |
| **e2-highcpu-8** | Not free | $0.016/build-minute |

**Typical landing page build**: 2-5 minutes. The 120 min/day free tier is more than enough for any development workflow.

---

### Cloud Logging Pricing

| Component | Free Tier | Price After |
|-----------|-----------|-------------|
| **Log ingestion** | 50 GB/month | $0.50/GB |
| **Log storage (30 days)** | Included with ingestion | — |
| **Log storage (>30 days)** | — | $0.01/GB/month |

**Typical landing page**: Generates negligible log volume. The 50 GB free tier is extremely generous — you'd need thousands of requests per second to approach it.

---

### Cloud DNS Pricing

| Component | Price |
|-----------|-------|
| **Managed Zone** | $0.20/month per zone |
| **DNS Queries** | $0.40/million queries |

**For landing pages**: ~$0.20-0.50/month if using Cloud DNS. Many domain registrars offer free DNS as an alternative.

---

### Secret Manager Pricing

| Component | Free Tier | Price After |
|-----------|-----------|-------------|
| **Active secret versions** | 6 | $0.06/version/month |
| **Access operations** | 10,000 | $0.03/10,000 operations |

**Typical landing page**: Well within free tier.

---

## Cost Management

### Budget Alerts (Essential First Step)

Set up budget alerts immediately after creating your project. This is the single most important thing you can do to avoid surprises.

**Natural Language (Recommended)**:
```
"Create a GCP budget of $5/month for my project with alerts at 50%, 80%, and 100%"
```

**CLI Reference**:
```bash
# List billing accounts
gcloud billing accounts list

# Create a budget (requires billing API enabled)
gcloud billing budgets create \
  --billing-account=BILLING_ACCOUNT_ID \
  --display-name="Landing Page Budget" \
  --budget-amount=5.00USD \
  --threshold-rule=percent=0.5 \
  --threshold-rule=percent=0.8 \
  --threshold-rule=percent=1.0
```

**Console fallback** (one-time): Billing → Budgets & alerts → Create Budget → Set amount and thresholds.

**Recommended Alert Thresholds**:
| Alert Type | Threshold | Purpose |
|------------|-----------|---------|
| Forecasted | 50% of budget | Early warning |
| Actual | 80% of budget | Getting close |
| Actual | 100% of budget | At budget limit |

---

### Viewing Current Costs

**Natural Language (Recommended)**:
```
"Show me my GCP costs for this month"
"Which GCP service is costing me the most?"
"What's my projected GCP bill this month?"
```

**CLI Reference**:
```bash
# View billing info for your project
gcloud billing projects describe PROJECT_ID

# Open billing in browser
gcloud billing accounts list
```

**Console fallback**: Console → Billing → Cost Table → Filter by project and date range.

---

### Billing Export to BigQuery

For advanced analysis, export billing data to BigQuery.

**Natural Language**:
```
"Set up GCP billing export to BigQuery for my project"
```

**Console fallback** (one-time setup): Billing → Billing export → BigQuery export → Enable.

**For beginners**: The Cost Table in the Console is sufficient. BigQuery export is for advanced analysis.

---

## Cost Optimization Tips

### 1. Keep Scale-to-Zero Enabled (Critical)

The single most important cost optimization for Cloud Run. With scale-to-zero, you pay nothing when no requests are arriving.

**Verify your settings**:

**Natural Language**:
```
"Check my Cloud Run service scaling settings — confirm minimum instances is 0"
```

**CLI Reference**:
```bash
gcloud run services describe SERVICE_NAME \
  --region=us-central1 \
  --format="value(spec.template.metadata.annotations)"
```

**Ensure these settings**:
| Setting | Value | Why |
|---------|-------|-----|
| **Min instances** | 0 | Enables scale-to-zero |
| **CPU throttling** | Enabled (default) | CPU only during requests |
| **Max instances** | 2-5 | Caps runaway scaling |

---

### 2. Use CPU Throttling (Default)

CPU throttling means Cloud Run only allocates CPU while processing a request. Between requests, CPU drops to zero. This is the default and you should keep it.

| Mode | Monthly Cost (low traffic) | When to Change |
|------|---------------------------|----------------|
| CPU throttled (default) | $0 | Keep this for landing pages |
| CPU always allocated | $5-15+ | Only for WebSocket or background tasks |

---

### 3. Set Minimum Instances to 0

Setting `min-instances` to anything above 0 means you always have warm instances running, even with zero traffic. This defeats scale-to-zero.

| Min Instances | Monthly Cost (idle) | Cold Start | Use Case |
|---------------|-----------------------|------------|----------|
| 0 (default) | $0 | ~1-2 sec first request | Landing pages, low traffic |
| 1 | ~$5-10 | None | Production APIs needing low latency |

**For landing pages**: Keep min-instances at 0. A 1-2 second cold start on the first request is perfectly acceptable.

---

### 4. Right-Size Your Container

| Setting | Recommended | Why |
|---------|-------------|-----|
| vCPU | 1 (default minimum) | Sufficient for Next.js |
| Memory | 256-512 MiB | Enough for most landing pages |
| Max instances | 2-5 | Prevents runaway scaling |

**Natural Language**:
```
"Deploy to Cloud Run with 256 MiB memory and max 3 instances"
```

---

### 5. Delete Old Artifact Registry Images

Keep only the latest image to stay within the 0.5 GB free tier.

**Natural Language**:
```
"Delete all old Docker images from Artifact Registry, keep only latest"
```

**CLI Reference**:
```bash
# List images with sizes
gcloud artifacts docker images list us-docker.pkg.dev/PROJECT/REPO --include-tags

# Delete specific old image
gcloud artifacts docker images delete us-docker.pkg.dev/PROJECT/REPO/IMAGE@sha256:HASH --quiet
```

---

### 6. Use the Right Region

| Region | Cost Level | Notes |
|--------|-----------|-------|
| **us-central1 (Iowa)** | Lowest | Recommended default |
| **us-east1 (S. Carolina)** | Low | Good alternative |
| **us-west1 (Oregon)** | Low | Good for West Coast |
| **europe-west1 (Belgium)** | Medium | Best for EU users |
| **asia-east1 (Taiwan)** | Medium | Best for APAC users |

---

## Sample Monthly Budgets

### Landing Page — Low Traffic (1-100 daily visitors)

| Service | Estimated Cost |
|---------|---------------|
| Cloud Run | **$0** (within free tier) |
| Artifact Registry | **$0** (within 0.5 GB free) |
| Cloud Build | **$0** (within 120 min/day free) |
| Cloud Logging | **$0** (within 50 GB free) |
| Cloud Monitoring | **$0** (built-in metrics free) |
| **Total** | **$0/month** |

**Yes, a low-traffic landing page runs completely free on GCP.**

---

### Landing Page — Medium Traffic (100-1,000 daily visitors)

| Service | Estimated Cost |
|---------|---------------|
| Cloud Run | $0-2 (mostly within free tier) |
| Artifact Registry | $0 (within free tier) |
| Cloud Build | $0 (within free tier) |
| Cloud Logging | $0 (within free tier) |
| Cloud DNS (optional) | $0.20 |
| **Total** | **$0-2/month** |

---

### Landing Page — High Traffic (1,000-10,000 daily visitors)

| Service | Estimated Cost |
|---------|---------------|
| Cloud Run | $2-8 |
| Artifact Registry | $0-0.10 |
| Cloud Build | $0 (within free tier) |
| Cloud Logging | $0 (within free tier) |
| Cloud DNS | $0.20-0.50 |
| Networking egress | $0-1 |
| **Total** | **$2-10/month** |

---

## Cost Comparison: GCP vs AWS

### Landing Page Deployment

| Factor | GCP (Cloud Run) | AWS (App Runner) |
|--------|-----------------|------------------|
| **Free tier** | 2M requests, 360K vCPU-sec/month | **No free tier** |
| **Low traffic monthly cost** | **$0** | $5-8 |
| **Medium traffic monthly cost** | $0-2 | $10-15 |
| **Scale to zero** | Yes (default) | Yes (auto-pause) |
| **HTTPS included** | Yes | Yes |
| **Custom domain** | Yes | Yes |
| **Container registry free** | 0.5 GB free | No free tier ($0.10/GB) |
| **Build minutes free** | 120 min/day | Not included |
| **Log ingestion free** | 50 GB/month | 5 GB/month |

**Bottom line**: For a low-traffic landing page, GCP Cloud Run is free while AWS App Runner costs $5-10/month.

### When to Choose Each

| Choose GCP When | Choose AWS When |
|----------------|-----------------|
| Budget is critical ($0 matters) | Already invested in AWS ecosystem |
| Landing pages and low-traffic apps | Need App Runner's GitHub integration |
| Want generous free logging (50 GB) | Team already knows AWS |
| Need scale-to-zero by default | Using other AWS services (Bedrock, etc.) |

---

## Red Flags: Unexpected Costs

Watch for these in your billing dashboard:

| Red Flag | Possible Cause | Solution |
|----------|---------------|----------|
| Cloud Run charges when idle | Min instances > 0 | Set min instances to 0 |
| High Cloud Run compute | CPU always allocated | Switch to CPU throttled |
| Artifact Registry storage | Old images accumulating | Delete old image tags |
| Cloud Build charges | Using larger machine types | Stick to e2-small (free tier) |
| Networking egress spikes | Large responses or assets | Optimize images, use CDN |
| VPC Connector charges | Serverless VPC Connector running | Remove if not needed |
| Unexpected API charges | Billing API, other APIs | Review enabled APIs |

**Weekly check (Natural Language)**:
```
"Show me any GCP resources that are running and costing money"
```

---

## Natural Language Quick Commands

| Task | Say This to Your AI Agent |
|------|--------------------------|
| Check current spend | "Show me my GCP costs for this month" |
| Create budget alert | "Create a $5 monthly GCP budget with email alerts" |
| Check Cloud Run scaling | "Are my Cloud Run services set to scale to zero?" |
| Find running resources | "List all running GCP resources in my project" |
| Clean up old images | "Delete old Docker images from Artifact Registry, keep latest" |
| Check free tier usage | "How much of my GCP free tier have I used this month?" |
| Estimate Cloud Run cost | "How much will Cloud Run cost for a landing page with 500 daily visitors?" |
| Disable unused APIs | "List all enabled GCP APIs and disable unused ones" |
| View Cloud Run logs | "Show me the latest Cloud Run logs for my service" |
| Describe Cloud Run service | "Show me the configuration of my Cloud Run service" |

---

## Next Steps

- [GCP Deployment Guide](../guides/GCP-DEPLOYMENT-GUIDE.md) — Deploy your landing page to Cloud Run
- [GCP Glossary](./GCP-GLOSSARY.md) — Learn GCP services
- [GCP Pricing Calculator](https://cloud.google.com/products/calculator) — Estimate costs before deploying
- [GCP Free Tier Documentation](https://cloud.google.com/free) — Official Always Free limits
