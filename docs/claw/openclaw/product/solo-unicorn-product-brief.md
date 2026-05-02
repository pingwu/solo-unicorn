# Solo-Unicorn: OpenClaw on OCI — Product Brief

> Platform: https://github.com/<your-username>/solo-unicorn
> Author: Ping Wu
> Date: 2026-03-12
> Status: Concept → Definition

---

## The Core Positioning — 養龍蝦的心法

> "龍蝦裝出來以後不知道怎麼用？不知道怎麼養？Writitation 就是針對這個問題來的。"
> — Ping Wu

The #1 pain point in the OpenClaw/Claw ecosystem is not installation — it's **what to do after**.
Everyone installs the Claw. Almost no one knows how to raise it productively.

**WRITITATION™ is the 心法 (inner methodology) for 養龍蝦 (raising your AI agent).**

The deployment stack (OCI + Claude Code + Slack) is the infrastructure.
WRITITATION™ is the practice that makes it valuable.

Proof: "Just Ask" (novel) was built using WRITITATION. Solo-Unicorn itself was generated using the same methodology.

---

## The Technical Insight

Wei Li's OpenClaw targets consumers and developers with a local install model.
The gap: **no zero-cost cloud-hosted path for non-technical builders and SMBs.**

Solo-Unicorn fills that gap by turning OCI Always Free A1 ARM servers into a
one-command OpenClaw deployment — using Claude Code or Gemini CLI as the
vibe-coding launch pad, and Slack as the professional communication interface.

---

## Differentiation vs. Wei Li's Approach

| Dimension | Wei Li (OpenClaw) | Solo-Unicorn |
|---|---|---|
| **Hosting** | Local machine (Windows) | OCI Always Free A1 ARM ($0 cloud) |
| **Install method** | Manual download / npm | Vibe command via Claude Code / Gemini CLI |
| **Communication** | Telegram, Discord | **Slack** (professional, SMB-friendly) |
| **Target user** | Developer / AI enthusiast | Dev community builders, SMBs, influencers |
| **Barrier** | Local Python/Node setup | Fork repo → vibe deploy |
| **Content building** | DIY | **WRITATIO framework** |
| **IP / platform** | OpenClaw (Wei Li's) | solo-unicorn (open source, Ping Wu) |
| **Demo story** | "Install and configure" | "Fork → deploy → interact via Slack" |

---

## Target Audience

**Not enterprise** (OCI free tier is not enterprise SLA).
**Not pure consumer** (Slack + cloud = professional context).

Primary segments:
- **Developer community builders** — run AI agents in their dev Slack workspaces
- **SMBs** — replace chatbot tools with a self-hosted AI agent, $0 infra cost
- **Influencers / content creators** — build and demo AI-powered Slack communities
- **Educators / workshop organizers** — reproducible, zero-cost teaching environment

---

## The Demo Path

```
1. Fork / clone solo-unicorn from GitHub
      ↓
2. Open Claude Code or Gemini CLI in the repo
      ↓
3. Run vibe command:
   "deploy openclaw to OCI"
      ↓
4. Claude Code / Gemini CLI runs oci-cli + bash scripts
   (provisions VCN, subnet, A1 instance, installs OpenClaw via SSH)
      ↓
5. Follow Slack setup instructions (OAuth app, bot token, channel)
      ↓
6. Interact with OpenClaw instance hosted on OCI via Slack
      ↓
7. Build Claw content using WRITATIO framework
```

This is the **full story in one session** — from zero to a live AI agent in Slack,
hosted for free on OCI, deployed via vibe coding.

---

## solo-unicorn Platform Architecture

```
solo-unicorn/
├── provision/
│   ├── oci/
│   │   ├── setup-cli.sh          # OCI CLI config helper
│   │   ├── provision-network.sh  # VCN, IGW, subnet, security list
│   │   ├── launch-instance.sh    # A1 ARM instance launch
│   │   └── install-openclaw.sh   # SSH remote install + systemd
│   └── PROVISION.md              # Runbook (already started in this project)
├── integrations/
│   └── slack/
│       ├── SLACK_SETUP.md        # Step-by-step Slack app + OAuth
│       └── ssh-tunnel.md         # SSH tunnel for secure gateway access
├── content/
│   └── writatio/
│       ├── WRITATIO.md           # Framework definition
│       └── examples/             # Sample agent content / skills
├── CLAUDE.md                     # Claude Code instructions for vibe deployment
├── .gemini/                      # Gemini CLI context
└── README.md                     # Main entry point
```

---

## The Vibe Coding Interface

The key insight: **Claude Code / Gemini CLI is the installer.**

Instead of a bash script the user has to run manually, the user opens Claude Code
in the solo-unicorn repo and says:

> "Deploy OpenClaw to my OCI account"

Claude Code reads `PROVISION.md`, has the oci-cli commands ready, asks for
OCIDs if not configured, and executes the full provisioning sequence.

This turns a 30-step technical process into a conversation.

### CLAUDE.md for solo-unicorn (draft)

```markdown
# solo-unicorn — Claude Code Instructions

When the user asks to deploy OpenClaw, follow PROVISION.md in order.
Use oci-cli for all infrastructure commands.
SSH into the instance for OpenClaw installation.
After deployment, guide the user through SLACK_SETUP.md.
The SSH tunnel in ssh-tunnel.md must be applied — never expose port 18789.
```

---

## Slack Integration Design

Why Slack over Telegram/Discord:
- **Professional context** — SMBs and dev teams already live in Slack
- **OAuth is standard** — no phone number required
- **Channels = structure** — dedicated `#openclaw` channel, not a chat thread
- **Free tier is generous** — Slack free plan works for demo and small teams
- **Enterprise path** — Slack Connect, Slack Enterprise Grid for future upsell

### Slack Setup Flow
1. Create Slack App at api.slack.com
2. Add Bot Token Scopes: `chat:write`, `channels:history`, `app_mentions:read`
3. Enable Event Subscriptions → point to OpenClaw gateway (via ngrok or Cloudflare Tunnel for demo, SSH tunnel for production)
4. Install app to workspace
5. Configure OpenClaw with Bot Token + Signing Secret
6. Invite bot to channel → live

### Security note
OpenClaw gateway port 18789 is never exposed publicly.
For Slack webhook, two options:
- **Demo**: Cloudflare Tunnel (`cloudflared tunnel`) — free, no port opening required
- **Production**: Slack Socket Mode — no public URL needed at all, works entirely over outbound WebSocket

---

## WRITITATION™ — The 心法 for 養龍蝦

> Full definition: `WRITITATION.md`
> Trademark: WRITITATION™ — Ping Wu

**The problem WRITITATION solves:**
Everyone in the Claw ecosystem installs the tool. Almost no one knows how to
raise it (養龍蝦) — how to feed it context, how to build habits around it, how to
extract real value over time. This is the "paid ¥499 and still stuck" problem
documented in the ArkClaw user segments.

**WRITITATION = Writing + Meditation.**
A creation methodology that turns attention into shipped work and shipped work
into income. Not a productivity system — a strange loop where each cycle of
creation feeds the next, compounding quality and value over time.

### The Five Steps (Strange Loop)

```
1. ATTENTION   → Notice what pulls at you. Start with real pain.
2. CAPTURE     → Use AI to summarize, collect, save into knowledge base.
3. SYNTHESIZE  → Connect patterns into a point of view and value proposition.
4. CREATE VALUE→ Ship something real — app, content, talk, service.
5. CLOSE LOOP  → Feedback, income, new connections change what you notice → back to 1.
```

### How WRITITATION applies to OpenClaw agent building

| Step | OpenClaw Application |
|---|---|
| **Attention** | What real problem does your Slack community need solved? |
| **Capture** | Feed that context into OpenClaw as agent knowledge / system prompt |
| **Synthesize** | Design the agent's persona, skills, and interaction patterns |
| **Create Value** | Deploy the agent — it runs 24/7 on OCI, responds in Slack |
| **Close the Loop** | Slack conversations = feedback that sharpens the next agent iteration |

### The Formula

```
Vₙ = H(Aₙ) × M(Kₙ)

H = human NLP (your pattern recognition)
M = AI/OpenClaw NLP (agent processing)
Aₙ = attention quality (sharpened each cycle)
Kₙ = knowledge base (grows with every capture)
```

**The agent IS the M(K) term** — OpenClaw running on OCI is the AI NLP function
in your WRITITATION loop. The human provides direction and attention (H×A).
The agent handles synthesis and response at scale (M×K).

**This framework is the IP differentiator** — provisioning scripts can be copied,
but WRITITATION is the methodology that makes the deployed agent valuable.
Solo Unicorn is the open-source implementation engine for WRITITATION.

---

## Comparison: Local Install vs. Solo-Unicorn OCI

| Factor | Local Install (Wei Li) | Solo-Unicorn (OCI) |
|---|---|---|
| **Cost** | $0 (local) | $0 (OCI Always Free) |
| **Always-on** | No (laptop must be on) | Yes (cloud server) |
| **Accessible remotely** | No | Yes (SSH tunnel / Slack) |
| **Setup complexity** | Medium (npm, Node 22, daemon) | Low (vibe command) |
| **Security** | Local only | SSH tunnel, no exposed ports |
| **Shareable** | No | Yes (Slack channel) |
| **Windows required** | Yes (scanner) | No (OCI + any dev machine) |
| **Reproducible** | Partially | Fully (fork → deploy) |

---

## OSS Investment Scorecard Delta (vs. OpenClaw standalone)

Solo-Unicorn changes the investment picture significantly:

| Dimension | OpenClaw alone | + Solo-Unicorn |
|---|---|---|
| A. Community | 3/10 | +1 (solo-unicorn contributes new OSS project with clear harness) |
| B. Team | 5/10 | +1 (Ping Wu's OCI + Claude Code expertise adds credibility) |
| C. Technical Moat | 4/10 | +2 (vibe-deploy paradigm + Slack + OCI free tier = differentiated stack) |
| D. Commercialisation | 2/10 | +1 (SMB Slack use case has clearer paid path than developer hobbyist) |
| E. Exit | 3/10 | 0 (unchanged at this stage) |
| **Revised total** | **3.40** | **~4.8/10** |

Still a Watch/Track, but closer to 5.5 threshold than OpenClaw standalone.
The gap to close: first paying SMB customer and external contributors to solo-unicorn.

---

## Next Steps

### Immediate (for webinar March 14)
- [ ] Define WRITATIO framework — even 3 bullet points
- [ ] Create solo-unicorn GitHub repo with README
- [ ] Finish OCI provisioning scripts (blocked on us-chicago-1 capacity)
- [ ] Write SLACK_SETUP.md
- [ ] Draft CLAUDE.md for vibe deploy command

### Near-term (post-webinar)
- [ ] Record demo: fork → vibe deploy → Slack interaction
- [ ] Define paid tier (managed hosting? premium WRITATIO templates? Slack app?)
- [ ] Publish PROVISION.md as solo-unicorn's first content piece
- [ ] Open GitHub issues for community contributions

### Watch triggers (from scorecard)
- 15%+ external contributors on solo-unicorn
- First SMB paying customer
- WRITATIO framework published as content asset
