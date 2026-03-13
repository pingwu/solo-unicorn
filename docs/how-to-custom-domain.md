# 🚀 Cloud Run: Custom Domain & HTTPS Setup

To map your Cloud Run service to a custom domain (e.g., `app1.yourdomain.com`) with a free, auto-renewing SSL certificate, follow these steps.

## Prerequisites
1.  **GCP Project**: Ensure you are in the correct project: `gcloud config set project [PROJECT_ID]`
2.  **Domain Ownership**: The domain must be managed or verified in your GCP project (e.g., via Cloud DNS).

## Implementation Guide (Side-by-Side)

| Task                  | 🌈 The "Vibe" Prompt (For Gemini CLI/AI)                                                        | 💻 The CLI Command (Manual)                                                                                                                                                                                                                    |
| :-------------------- | :---------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1. Create Mapping** | "Map my Cloud Run service **[SERVICE]** to domain **[DOMAIN]** in region **[REGION]**."         | `gcloud beta run domain-mappings create --service=[SERVICE] --domain=[DOMAIN] --region=[REGION]`                                                                                                                                               |
| **2. Update DNS**     | "Update my Cloud DNS zone **[ZONE]** with the CNAME record required for my new domain mapping." | `gcloud dns record-sets transaction start --zone=[ZONE]`<br>`gcloud dns record-sets transaction add ghs.googlehosted.com. --name=[DOMAIN]. --ttl=300 --type=CNAME --zone=[ZONE]`<br>`gcloud dns record-sets transaction execute --zone=[ZONE]` |
| **3. Check Status**   | "Check if the SSL certificate for **[DOMAIN]** is ready yet."                                   | `gcloud beta run domain-mappings describe --domain=[DOMAIN] --region=[REGION]`                                                                                                                                                                 |

---

## 🔍 Where to find these values?

| Placeholder | Example Value | Where to find it in GCP Console |
| :--- | :--- | :--- |
| **[SERVICE]** | `my-web-app` | **Cloud Run** > Click your service name at the top of the page. |
| **[DOMAIN]** | `app1.example.com` | This is your custom URL (ensure you own the base domain). |
| **[REGION]** | `us-west1` | **Cloud Run** > Look at the "Region" column next to your service. |
| **[ZONE]** | `example-com-zone` | **Network Services** > **Cloud DNS** > The "Name" of your zone. |

---

## 💡 What's Happening Under the Hood?

- **DNS Verification**: Google waits to see your CNAME pointing to `ghs.googlehosted.com` before it issues the certificate.
- **SSL Provisioning**: This typically takes **15–60 minutes**. 
- **Ready: True**: Once the status shows `Ready: True`, your site will have the secure green lock.

### Why this is better than Self-Signed Certs:
- **Zero Maintenance**: Google renews the certificate for you every 90 days.
- **Trust**: Users see the "Secure" padlock in their browser (no warnings).
- **Global Speed**: Traffic is served through Google's global edge network.

---

## 💰 Estimated Costs (MVP Level)

| Item | Description | Estimated Cost |
| :--- | :--- | :--- |
| **Domain Registration** | `.com`, `.net`, `.app`, etc. | **$12 – $60 / year** (approx. $1-$5/mo) |
| **Cloud DNS Zone** | 1 Managed Public Zone | **$0.20 / month** |
| **DNS Queries** | ~100K visitors/month | **$0.04 / month** ($0.40 per 1M queries) |
| **SSL Certificate** | Google-managed SSL | **$0.00** (Free) |
| **Cloud Run** | Computing time | **Free Tier** (usually $0 for low/mid traffic) |
| **Total Estimated** | **Base infra for 1 site** | **~$1.25 – $5.25 / month** |

*Note: Domain prices vary by TLD (e.g., `.ai` or `.io` are more expensive). Prices are based on standard Google Cloud pricing as of Feb 2026.*
