---
name: skill-inference-rules
description: Rules for inferring adjacent skills from documented experience with confidence levels. Ensures factual resume generation without stretching the truth.
---

# Skill Inference Rules

Rules for inferring adjacent skills from documented experience. The goal: surface relevant capabilities without fabricating.

## Inference Philosophy

**Principle:** If you did X at scale/production, you necessarily understand the fundamentals that X requires.

**Anti-principle:** Using a tool once doesn't make you expert in its ecosystem.

---

## Software Development — Backend

### Python

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| FastAPI production apps | REST API design, Pydantic, async/await, type hints | High |
| Django production apps | ORM concepts, MVC/MVT, middleware, migrations | High |
| Flask production apps | WSGI, routing, Jinja templating | High |
| Celery task queues | Async processing, Redis/RabbitMQ basics, job scheduling | High |
| SQLAlchemy ORM | Database modeling, query optimization, migrations | High |
| Pandas data pipelines | Data manipulation, NumPy basics, CSV/Excel processing | High |
| pytest test suites | Unit testing, fixtures, mocking, TDD concepts | High |
| Python package publishing | setuptools, pyproject.toml, versioning | Medium |
| Production automation scripts | Error handling, logging, argparse, file I/O | High |
| Teaching Python | Deep language knowledge, debugging, best practices | High |

### Java

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Spring Boot production | Dependency injection, REST controllers, JPA | High |
| Spring Security implementation | Authentication, authorization, OAuth2 concepts | High |
| Hibernate/JPA usage | ORM patterns, entity relationships, JPQL | High |
| Maven/Gradle builds | Dependency management, build lifecycle, plugins | High |
| JUnit test suites | Unit testing, Mockito, integration testing | High |
| Microservices with Spring Cloud | Service discovery, config server, circuit breakers | High |
| Java 8+ features | Streams, lambdas, Optional, functional interfaces | High |
| Multithreaded applications | Concurrency, ExecutorService, thread safety | Medium |

### Go

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Go production services | Goroutines, channels, error handling patterns | High |
| Go REST APIs | net/http, Gin/Echo frameworks, middleware | High |
| Go CLI tools | Cobra, flag parsing, cross-compilation | High |
| Go concurrency patterns | Goroutines, channels, select, sync primitives | High |
| Go testing | table-driven tests, benchmarks, test coverage | High |

### Node.js

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Express.js production | Middleware, routing, error handling | High |
| NestJS applications | Decorators, modules, dependency injection | High |
| Node.js event loop | Async patterns, callbacks, Promises | High |
| npm package management | package.json, semantic versioning, scripts | High |
| Node.js streams | Readable/Writable streams, piping, backpressure | Medium |

### Rust

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Rust production code | Ownership, borrowing, lifetimes | High |
| Rust async with Tokio | Async/await, futures, runtime concepts | High |
| Rust CLI tools | clap, error handling with anyhow/thiserror | High |

---

## Software Development — Frontend

### React

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| React production apps | JSX, components, props, state, lifecycle | High |
| React Hooks usage | useState, useEffect, useContext, custom hooks | High |
| Redux state management | Actions, reducers, selectors, middleware | High |
| React Query/SWR | Data fetching, caching, optimistic updates | High |
| React Router | Client-side routing, navigation, params | High |
| React Testing Library | Component testing, user-event, queries | High |
| React performance optimization | memo, useMemo, useCallback, code splitting | Medium |

### Vue.js

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Vue 3 production apps | Composition API, reactivity, components | High |
| Vuex/Pinia state | State management patterns | High |
| Vue Router | SPA routing, navigation guards | High |
| Nuxt.js applications | SSR, file-based routing, modules | High |

### Angular

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Angular production apps | Components, services, modules, DI | High |
| RxJS usage | Observables, operators, subscriptions | High |
| Angular forms | Reactive forms, validation, form arrays | High |
| Angular routing | Lazy loading, guards, resolvers | High |

### General Frontend

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| TypeScript production | Type systems, interfaces, generics, ES6+ | High |
| Webpack configuration | Bundling, loaders, plugins, code splitting | High |
| Vite usage | ES modules, HMR, build optimization | Medium |
| CSS-in-JS (Styled Components, Emotion) | Component styling, theming | High |
| Tailwind CSS | Utility-first CSS, responsive design | High |
| Responsive web design | Media queries, flexbox, grid, mobile-first | High |
| Web accessibility (a11y) | ARIA, semantic HTML, screen readers | Medium |
| Browser DevTools | Debugging, network analysis, performance profiling | High |

---

## Full Stack Development

### Next.js

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Next.js production apps | SSR, SSG, ISR, API routes, file-based routing | High |
| Next.js App Router | Server components, layouts, loading states | High |
| Next.js with databases | Prisma/Drizzle, server actions, data fetching | High |
| Next.js deployment | Vercel, edge functions, environment variables | High |
| Next.js authentication | NextAuth.js, session management, JWT | High |

### Full Stack Patterns

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Built full-stack SaaS app | Frontend + backend + database + auth + deployment | High |
| REST API design & consumption | HTTP methods, status codes, request/response | High |
| GraphQL implementation | Schema design, resolvers, queries, mutations | High |
| WebSocket real-time features | Bi-directional communication, Socket.io | High |
| OAuth2 implementation | Authorization flows, tokens, refresh tokens | High |
| JWT authentication | Token structure, signing, validation, expiration | High |
| Session management | Cookies, session stores, security considerations | High |
| File upload handling | Multipart forms, streaming, cloud storage | Medium |
| Payment integration (Stripe) | Checkout, subscriptions, webhooks | High |
| Email integration (SendGrid, SES) | Transactional email, templates, deliverability | Medium |

---

## Databases & Data

### SQL Databases

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| PostgreSQL production | SQL proficiency, indexing, JSONB, extensions | High |
| MySQL/MariaDB production | SQL, replication basics, InnoDB | High |
| Database migrations | Schema versioning, Flyway/Alembic/Prisma | High |
| Query optimization | EXPLAIN plans, indexing strategies, N+1 prevention | High |
| Database transactions | ACID, isolation levels, deadlock prevention | High |
| Stored procedures/functions | PL/pgSQL or T-SQL basics | Medium |
| Database replication | Read replicas, failover concepts | Medium |
| Connection pooling | PgBouncer, HikariCP, pool management | Medium |

### NoSQL Databases

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| MongoDB production | Document modeling, aggregation pipeline, indexes | High |
| Redis production | Caching patterns, data structures, pub/sub | High |
| DynamoDB production | Partition keys, GSI/LSI, single-table design | High |
| Elasticsearch usage | Full-text search, mappings, aggregations | High |
| Cassandra usage | Wide-column modeling, partition strategies | Medium |

### Data Processing

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| ETL pipeline development | Data extraction, transformation, loading patterns | High |
| Apache Kafka usage | Event streaming, producers, consumers, topics | High |
| Apache Spark usage | Distributed processing, DataFrames, SQL | High |
| Data warehouse design | Star schema, fact/dimension tables | Medium |
| dbt usage | SQL transformations, data modeling, testing | High |

---

## DevOps & Infrastructure

### Containers

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Dockerfile authoring | Multi-stage builds, layer optimization, best practices | High |
| Docker Compose | Multi-container apps, networking, volumes | High |
| Container security | Image scanning, non-root users, secrets management | Medium |
| Container registries | ECR, Docker Hub, GCR, image tagging strategies | High |
| Podman usage | Rootless containers, Docker compatibility | Medium |

### Kubernetes

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| K8s deployments in production | Pods, Deployments, Services, ConfigMaps, Secrets | High |
| Helm chart development | Templating, values, chart dependencies | High |
| K8s networking | Ingress, Services, NetworkPolicies | High |
| K8s RBAC | ServiceAccounts, Roles, ClusterRoles | High |
| K8s autoscaling | HPA, VPA, cluster autoscaler concepts | High |
| K8s troubleshooting | kubectl debug, logs, describe, events | High |
| K8s operators | Custom resources, controller patterns | Medium |
| Service mesh (Istio/Linkerd) | Traffic management, observability, mTLS | Medium |

### CI/CD

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| GitHub Actions workflows | YAML syntax, jobs, steps, matrix builds | High |
| GitLab CI pipelines | Stages, jobs, artifacts, environments | High |
| Jenkins pipelines | Groovy DSL, Jenkinsfile, plugins | High |
| CircleCI configuration | Orbs, workflows, caching | High |
| ArgoCD GitOps | Declarative deployments, sync strategies | High |
| CI/CD best practices | Build caching, parallel jobs, deployment strategies | High |
| Blue-green deployments | Zero-downtime releases, traffic switching | High |
| Canary deployments | Progressive rollouts, feature flags | Medium |
| Rollback strategies | Version management, quick recovery | High |

### Infrastructure as Code

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Terraform production | HCL, state management, modules, workspaces | High |
| Terraform AWS provider | Resource definitions, data sources, outputs | High |
| CloudFormation | YAML/JSON templates, stacks, change sets | High |
| Pulumi usage | Programming language IaC, state management | High |
| Ansible automation | Playbooks, roles, inventory, idempotency | High |
| Infrastructure testing | Terratest, kitchen-terraform, policy as code | Medium |

### Monitoring & Observability

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Prometheus + Grafana | Metrics collection, PromQL, dashboards | High |
| Datadog implementation | APM, logs, metrics, dashboards, alerts | High |
| ELK/EFK stack | Log aggregation, Elasticsearch queries, Kibana | High |
| Distributed tracing (Jaeger, Zipkin) | Trace propagation, span analysis | High |
| PagerDuty/OpsGenie | Alert routing, on-call schedules, escalations | High |
| SLOs/SLIs/Error budgets | Reliability engineering concepts | Medium |
| OpenTelemetry | Unified observability, instrumentation | Medium |

### Networking & Security

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| VPC design | Subnets, route tables, NAT gateways, peering | High |
| Load balancer configuration | ALB/NLB, target groups, health checks | High |
| DNS management | Route 53, record types, routing policies | High |
| SSL/TLS certificate management | ACM, Let's Encrypt, certificate renewal | High |
| WAF configuration | Rules, rate limiting, IP blocking | Medium |
| Secrets management (Vault, AWS Secrets Manager) | Secret rotation, access policies | High |
| Network security groups | Inbound/outbound rules, least privilege | High |

---

## Cloud Platforms

### AWS

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Lambda production | Serverless patterns, cold starts, layers | High |
| API Gateway | REST/HTTP APIs, authorizers, throttling | High |
| SQS/SNS | Message queues, pub/sub, DLQs, FIFO | High |
| Step Functions | State machines, workflow orchestration | High |
| ECS/Fargate | Container orchestration, task definitions | High |
| RDS management | Parameter groups, snapshots, Multi-AZ | High |
| CloudWatch | Logs, metrics, alarms, dashboards | High |
| IAM policies | Policy documents, roles, least privilege | High |
| S3 advanced | Lifecycle rules, versioning, replication, presigned URLs | High |
| EventBridge | Event-driven architecture, rules, targets | High |
| CDK usage | TypeScript/Python IaC, constructs | High |

### GCP

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Cloud Run | Serverless containers, auto-scaling | High |
| Cloud Functions | Event-driven serverless, triggers | High |
| Cloud SQL | Managed databases, connections, backups | High |
| Pub/Sub | Message queuing, push/pull subscriptions | High |
| GKE | Managed Kubernetes, node pools, Autopilot | High |
| Cloud Build | CI/CD, build triggers, cloudbuild.yaml | High |
| BigQuery | Data warehouse, SQL, partitioning, streaming | High |

### Azure

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Azure Functions | Serverless, triggers, bindings | High |
| Azure App Service | Web app hosting, deployment slots | High |
| Azure DevOps | Pipelines, boards, repos, artifacts | High |
| AKS | Managed Kubernetes, Azure CNI | High |
| Cosmos DB | Multi-model database, partitioning | High |
| Azure Storage | Blobs, queues, tables, files | High |

---

## Testing & Quality

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Unit testing frameworks | Test isolation, assertions, coverage | High |
| Integration testing | Test databases, API testing, fixtures | High |
| E2E testing (Cypress, Playwright) | Browser automation, selectors, assertions | High |
| API testing (Postman, Newman) | Request/response validation, collections | High |
| Load testing (k6, Locust, JMeter) | Performance benchmarking, bottleneck identification | High |
| Test-driven development (TDD) | Red-green-refactor, test-first mindset | High |
| Mocking/stubbing | Test doubles, dependency isolation | High |
| Code coverage analysis | Coverage metrics, gap identification | Medium |
| Contract testing (Pact) | Consumer-driven contracts, API compatibility | Medium |

---

## Version Control & Collaboration

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Git advanced usage | Rebasing, cherry-picking, bisect, reflog | High |
| Git branching strategies | GitFlow, trunk-based, feature branches | High |
| Pull request workflows | Code review, approvals, merge strategies | High |
| Monorepo management | Nx, Turborepo, workspace tooling | Medium |
| GitHub advanced | Actions, branch protection, CODEOWNERS | High |
| GitLab advanced | Merge requests, CI/CD, environments | High |

---

## API Development

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| REST API design | Resource naming, HTTP verbs, status codes, HATEOAS | High |
| OpenAPI/Swagger | API documentation, code generation | High |
| GraphQL server | Schema design, resolvers, dataloaders | High |
| gRPC services | Protocol buffers, service definitions | High |
| API versioning | URL, header, or query param strategies | High |
| Rate limiting | Token bucket, sliding window, implementation | High |
| API authentication | API keys, OAuth2, JWT, basic auth | High |
| Webhook implementation | Event delivery, retry logic, signatures | High |

---

## AI/ML for Developers

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| LLM API integration (OpenAI, Claude) | Prompt design, token management, streaming | High |
| LangChain/LlamaIndex | Chain composition, document loaders, retrievers | High |
| RAG implementation | Embeddings, vector stores, retrieval strategies | High |
| Vector databases (Pinecone, Weaviate) | Similarity search, indexing, metadata filtering | High |
| AI agent development (crewAI, AutoGen) | Multi-agent orchestration, tool use | High |
| Prompt engineering | Few-shot, chain-of-thought, system prompts | High |
| Fine-tuning basics | Dataset preparation, training concepts | Medium |
| Model evaluation | Metrics, benchmarking, A/B testing | Medium |

### NOT Inferred (AI/ML)

| Documented | Don't Infer | Why |
|------------|-------------|-----|
| Using ChatGPT/Claude | ML engineering | Consumer ≠ builder |
| Prompt engineering | Model training from scratch | Using ≠ creating |
| LangChain usage | Deep learning fundamentals | Framework ≠ theory |
| RAG implementation | Neural network architecture | Application ≠ research |

---

## Leadership & Soft Skills

| Documented | Can Infer | Confidence |
|------------|-----------|------------|
| Tech lead role | Architecture decisions, mentoring, code standards | High |
| Code review leadership | Feedback delivery, quality standards, knowledge sharing | High |
| Sprint planning | Story estimation, capacity planning, backlog grooming | High |
| Incident commander | Crisis communication, coordination, post-mortems | High |
| Technical documentation | Writing skills, architecture diagrams, ADRs | High |
| Cross-team collaboration | Stakeholder management, dependency coordination | High |
| Hiring/interviewing | Technical assessment, culture fit evaluation | High |
| Onboarding new engineers | Documentation, mentoring, ramp-up planning | High |
| Teaching/training | Curriculum design, presentation, patience | High |
| Remote team leadership | Async communication, documentation-first | High |

---

## What We DON'T Infer

### General Rules

| Documented | Won't Infer | Why |
|------------|-------------|-----|
| Used Docker | Kubernetes expert | Container ≠ orchestration |
| Python scripting | Machine Learning | Automation ≠ data science |
| Team lead (5 people) | VP/Director level | Scope difference |
| Cloud cost analysis | Solutions Architect | Cost ≠ design |
| Read the docs | Production experience | Reading ≠ doing |
| Side project | Production scale | Hobby ≠ enterprise |
| Bootcamp certificate | Senior-level skills | Learning ≠ expertise |
| One PR to open source | Maintainer-level | Contribution ≠ ownership |

### Framework Limitations

| Framework/Tool | Can Infer | Cannot Infer |
|----------------|-----------|--------------|
| React | Component thinking, JSX | Vue or Angular |
| PostgreSQL | SQL, relational modeling | MongoDB |
| AWS | Cloud concepts | Azure/GCP specifics |
| Python | Scripting mindset | Go/Rust/Java |
| REST APIs | HTTP, request/response | GraphQL or gRPC |
| Monolith | Application development | Microservices architecture |

---

## Confidence Levels

| Level | Meaning | Resume Usage |
|-------|---------|--------------|
| **High** | Logically necessary to do the documented work | List confidently |
| **Medium** | Likely encountered but could be peripheral | "Familiar with" or "Exposure to" |
| **Low** | Possible but uncertain | Don't list unless specifically asked |

---

## Applying Rules: Examples

### Example 1: Backend Developer

**Documented:** "Built FastAPI services processing 10K requests/minute with PostgreSQL and Redis caching, deployed on ECS with GitHub Actions CI/CD"

**Inferences:**

| Skill | Source | Confidence |
|-------|--------|------------|
| Python proficiency | FastAPI | High |
| REST API design | FastAPI + scale | High |
| Async Python | FastAPI | High |
| SQL, PostgreSQL | Direct mention | High |
| Caching patterns | Redis | High |
| Docker | ECS deployment | High |
| CI/CD concepts | GitHub Actions | High |
| AWS basics | ECS | High |
| Container orchestration basics | ECS | Medium |
| Performance optimization | 10K req/min | Medium |

**Not Inferred:**
- Kubernetes (ECS ≠ K8s)
- Database administration (using ≠ administering)
- AWS Solutions Architect level (one service ≠ broad expertise)

### Example 2: Full Stack Developer

**Documented:** "Built SaaS application with Next.js, Prisma, PostgreSQL, Stripe integration, deployed on Vercel with 500 active users"

**Inferences:**

| Skill | Source | Confidence |
|-------|--------|------------|
| React | Next.js | High |
| TypeScript | Next.js + Prisma typical stack | High |
| SSR/SSG concepts | Next.js | High |
| SQL, database design | Prisma + PostgreSQL | High |
| ORM usage | Prisma | High |
| Payment integration | Stripe | High |
| Auth implementation | SaaS implies auth | High |
| Vercel deployment | Direct mention | High |
| User management | 500 users | Medium |

**Not Inferred:**
- Vue/Angular (Next.js = React)
- High-scale architecture (500 users is small)
- DevOps expertise (Vercel abstracts infrastructure)

### Example 3: DevOps Engineer

**Documented:** "Managed Kubernetes clusters (50+ nodes) with Terraform, implemented GitOps with ArgoCD, Prometheus/Grafana monitoring"

**Inferences:**

| Skill | Source | Confidence |
|-------|--------|------------|
| Kubernetes administration | 50+ nodes | High |
| Helm | K8s at scale typically uses Helm | High |
| Infrastructure as Code | Terraform | High |
| GitOps principles | ArgoCD | High |
| Monitoring & alerting | Prometheus/Grafana | High |
| PromQL | Prometheus | High |
| Dashboard creation | Grafana | High |
| YAML proficiency | K8s + Terraform + ArgoCD | High |
| Troubleshooting | Scale implies issues | High |
| Networking basics | K8s requires it | Medium |

**Not Inferred:**
- Application development (infra ≠ code)
- Specific cloud expertise (K8s is portable)
- Security specialization (ops ≠ security)

---

## Adding New Rules

Ask three questions:

1. **Logically necessary?** Did they HAVE to know X to do Y?
2. **Verifiable?** Could they demonstrate this in an interview?
3. **Honest?** Would they agree they have this skill?

All three yes → Add rule with appropriate confidence.
Any no → Don't infer.
