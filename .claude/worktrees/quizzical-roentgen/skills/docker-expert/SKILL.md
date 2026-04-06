---
name: docker-expert
description: Containerize anything with production-grade Docker skills—image optimization, compose workflows, registry management, and GPU-ready AI/ML builds. Use when building containers, writing Dockerfiles, debugging running services, or when installing dependencies on the host machine would be the wrong move.
---

# Docker Expert

## Core Principle

Never install on the host. Containers are the unit of delivery, the unit of isolation, and the unit of reproducibility. If it runs, it runs in a container.

## Container-First Mental Model

```
Bad:  "pip install tensorflow && python train.py"
Good: "Build a GPU-enabled training container with pinned dependencies,
       mount the dataset as a volume, cache model weights in a named volume,
       and output artifacts to a bind mount the CI pipeline can collect."
```

## Core Concepts

Every Docker workflow rests on four primitives. Master these before reaching for orchestration.

| Primitive | What It Is | Think of It As |
|-----------|-----------|----------------|
| **Image** | Read-only blueprint built from a Dockerfile | A class definition |
| **Container** | Running (or stopped) instance of an image | An object instance |
| **Volume** | Persistent storage that outlives containers | An external hard drive |
| **Network** | Isolated communication channel between containers | A private LAN |

```bash
# See what you have
docker images                    # local image inventory
docker ps -a                     # all containers (running + stopped)
docker volume ls                 # persistent volumes
docker network ls                # available networks
```

## Dockerfile Best Practices

### Multi-Stage Builds (Smaller Images, Safer Images)

Separate build-time dependencies from runtime. Your production image should never contain compilers, dev headers, or test frameworks.

```dockerfile
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --production=false
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:20-alpine AS production
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
USER appuser
EXPOSE 3000
CMD ["node", "dist/main.js"]
```

### Layer Caching (Build Speed)

Docker caches each layer. Order instructions from least-changed to most-changed.

```dockerfile
# Good: dependencies cached unless package.json changes
COPY package*.json ./
RUN npm ci
COPY . .

# Bad: any source change invalidates the npm install cache
COPY . .
RUN npm ci
```

### .dockerignore (Smaller Context, Faster Builds)

Always include a `.dockerignore`. Without one, Docker sends everything to the daemon -- including `node_modules`, `.git`, test fixtures, and secrets.

```
.git
node_modules
.env
*.md
__pycache__
.pytest_cache
dist
coverage
```

### Security Defaults

- **Never run as root.** Use `USER` directive.
- **Pin base image digests** for reproducible builds: `FROM python:3.12-slim@sha256:abc123...`
- **No secrets in layers.** Use build secrets (`--mount=type=secret`) or runtime env injection.
- **Scan images** with `docker scout cves` or Trivy before pushing.

## Docker Compose for Local Development

Compose is your local infrastructure definition. One file, one command, entire stack running.

```yaml
# docker-compose.yml
services:
  app:
    build:
      context: .
      target: development          # use dev stage of multi-stage Dockerfile
    ports:
      - "3000:3000"
    volumes:
      - .:/app                     # live reload via bind mount
      - /app/node_modules          # anonymous volume prevents host override
    environment:
      - DATABASE_URL=postgres://user:pass@db:5432/appdb
    depends_on:
      db:
        condition: service_healthy

  db:
    image: postgres:16-alpine
    volumes:
      - pgdata:/var/lib/postgresql/data
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
      POSTGRES_DB: appdb
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 5s
      timeout: 3s
      retries: 5

volumes:
  pgdata:
```

```bash
docker compose up -d             # start stack in background
docker compose logs -f app       # tail app logs
docker compose down -v           # tear down including volumes (clean slate)
docker compose build --no-cache  # force full rebuild
```

## Dev Containers vs Production Containers

Build both from the same Dockerfile using multi-stage targets.

| Concern | Dev Container | Production Container |
|---------|---------------|----------------------|
| Base image | Full SDK/tools | Slim or distroless |
| Source code | Bind-mounted (live reload) | Copied into image |
| Dependencies | All (including devDependencies) | Production only |
| Debug tools | Yes (curl, vim, shell) | No -- minimal attack surface |
| User | Can be root for convenience | Never root |
| Size target | Does not matter | As small as possible |

```dockerfile
# Unified Dockerfile with targets
FROM python:3.12-slim AS base
WORKDIR /app
COPY requirements.txt .

FROM base AS development
RUN pip install -r requirements.txt && pip install debugpy pytest
COPY . .
CMD ["python", "-m", "debugpy", "--listen", "0.0.0.0:5678", "app.py"]

FROM base AS production
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN adduser --system --no-create-home appuser
USER appuser
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:8000", "app:create_app()"]
```

## Debugging Containers

When something breaks, follow this sequence.

```bash
# 1. Check container status and exit codes
docker ps -a --filter "name=myapp"

# 2. Read the logs (most problems surface here)
docker logs myapp --tail 100 -f

# 3. Inspect the container metadata (env vars, mounts, network, health)
docker inspect myapp --format '{{json .State}}' | jq .

# 4. Get a shell inside a running container
docker exec -it myapp /bin/sh

# 5. If the container crashes on start, override entrypoint to keep it alive
docker run -it --entrypoint /bin/sh myapp:latest

# 6. Check resource usage
docker stats myapp --no-stream

# 7. Inspect networking between containers
docker network inspect my-network
```

### Compose-Specific Debugging

```bash
# See why a service failed to start
docker compose ps
docker compose logs --since 5m failing-service

# Validate your compose file
docker compose config

# Run a one-off command in a service container
docker compose exec app python manage.py shell
```

## Docker for AI/ML Workloads

AI/ML containers have unique challenges: huge base images, GPU requirements, and massive model files.

### GPU Passthrough

```yaml
# docker-compose.yml for GPU workloads
services:
  training:
    build: .
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
    volumes:
      - model-cache:/root/.cache/huggingface
      - ./data:/data
      - ./outputs:/outputs

volumes:
  model-cache:                    # persist downloaded models across runs
```

```bash
# Verify GPU access inside container
docker run --gpus all nvidia/cuda:12.3.1-runtime-ubuntu22.04 nvidia-smi
```

### Model Caching Strategy

Never re-download multi-gigabyte models on every build or run.

```dockerfile
# Bad: model downloaded on every container start
CMD ["python", "-c", "from transformers import pipeline; pipeline('sentiment-analysis')('hello')"]

# Good: cache directory is a persistent volume
ENV HF_HOME=/model-cache
ENV TRANSFORMERS_CACHE=/model-cache
# Mount /model-cache as a named volume at runtime
```

### Image Size Management for ML

```dockerfile
# Use NVIDIA's optimized base images
FROM nvcr.io/nvidia/pytorch:24.01-py3 AS builder
# Install only what you need on top of it

# For inference-only containers, strip training dependencies
FROM python:3.12-slim AS inference
COPY --from=builder /opt/conda/lib/python3.12/site-packages/torch /opt/torch
# Copy only the runtime libraries you actually import
```

## Registry Management

### Push to Multiple Registries

```bash
# Docker Hub
docker tag myapp:latest myuser/myapp:v1.2.0
docker push myuser/myapp:v1.2.0

# Amazon ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789.dkr.ecr.us-east-1.amazonaws.com
docker tag myapp:latest 123456789.dkr.ecr.us-east-1.amazonaws.com/myapp:v1.2.0
docker push 123456789.dkr.ecr.us-east-1.amazonaws.com/myapp:v1.2.0

# Google Container Registry / Artifact Registry
gcloud auth configure-docker us-central1-docker.pkg.dev
docker tag myapp:latest us-central1-docker.pkg.dev/my-project/my-repo/myapp:v1.2.0
docker push us-central1-docker.pkg.dev/my-project/my-repo/myapp:v1.2.0

# GitHub Container Registry
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
docker tag myapp:latest ghcr.io/username/myapp:v1.2.0
docker push ghcr.io/username/myapp:v1.2.0
```

### Tagging Strategy

```bash
# Always tag with version AND latest (latest alone is not a strategy)
docker tag myapp:latest myuser/myapp:v1.2.0
docker tag myapp:latest myuser/myapp:latest

# For CI: tag with git SHA for traceability
docker tag myapp:latest myuser/myapp:$(git rev-parse --short HEAD)
```

## Performance Optimization

### Image Size Reduction

```bash
# Check what is eating space
docker history myapp:latest --human --no-trunc

# Compare sizes across build strategies
docker images --format "{{.Repository}}:{{.Tag}} {{.Size}}" | sort -k2 -h
```

| Technique | Typical Impact |
|-----------|---------------|
| Multi-stage builds | 50-90% size reduction |
| Alpine or distroless base | 60-80% vs full Ubuntu |
| `.dockerignore` | 10-50% build context reduction |
| `--no-cache-dir` on pip | 10-30% for Python images |
| Combine RUN layers | 5-20% from layer deduplication |
| Remove apt cache (`rm -rf /var/lib/apt/lists/*`) | 20-50 MB saved |

### Build Speed

```bash
# Use BuildKit (Docker 23+ default)
DOCKER_BUILDKIT=1 docker build .

# Cache dependency layers in CI
docker build --cache-from myuser/myapp:latest -t myapp:latest .

# Parallel multi-stage builds happen automatically with BuildKit
```

### Startup Time

- Use lightweight base images (Alpine, distroless).
- Precompile Python bytecode: `RUN python -m compileall .`
- Avoid shell wrapper scripts when possible -- use `exec` form: `CMD ["node", "server.js"]`
- For Java: use CDS (Class Data Sharing) or GraalVM native images.

## Anti-Patterns

| Anti-Pattern | Why It Hurts | Do This Instead |
|-------------|-------------|-----------------|
| Running as root | One exploit owns the host | `RUN adduser ...` + `USER appuser` |
| No `.dockerignore` | Sends `.git`, `node_modules`, secrets to daemon | Always create `.dockerignore` first |
| Giant monolithic images (2GB+) | Slow pulls, slow deploys, wasted storage | Multi-stage builds, slim bases |
| One massive `RUN` with `&&` for everything | Unreadable, hard to debug cache misses | Group by logical concern (OS deps, app deps, app code) |
| Using `latest` tag in production | "Latest" is a moving target -- breaks reproducibility | Pin exact version tags or digests |
| `COPY . .` before installing dependencies | Every code change invalidates dependency cache | Copy lockfile first, install, then copy source |
| Storing secrets in `ENV` or `ARG` | Secrets baked into image layers forever | Use `--mount=type=secret` or runtime injection |
| Installing dev tools in production image | Larger attack surface, bigger image | Multi-stage: dev target vs production target |
| Ignoring healthchecks | Orchestrators cannot detect unhealthy containers | Add `HEALTHCHECK` or configure in compose/k8s |
| Running `docker compose up` without `depends_on` + healthcheck | Race conditions between services | Use `depends_on` with `condition: service_healthy` |

## Orchestration Prompts

### Containerize an Existing Project

```
"Containerize this project for both development and production:
- Multi-stage Dockerfile with dev and prod targets
- docker-compose.yml with the app, database, and any background workers
- .dockerignore that excludes everything unnecessary
- Dev stage: live reload with bind mounts, debug port exposed
- Prod stage: non-root user, minimal image, healthcheck
- README section on how to run with a single command"
```

### Debug a Failing Container

```
"This container exits immediately. Walk me through diagnosis:
1. Check exit code and OOM status via docker inspect
2. Read the last 200 lines of logs
3. Try running with entrypoint override to get a shell
4. Verify all required env vars are set
5. Check if mounted volumes have correct permissions
6. Test network connectivity to dependent services"
```

### Optimize a Bloated Image

```
"This image is 2.3GB. Reduce it to under 300MB:
1. Analyze layer sizes with docker history
2. Convert to multi-stage build
3. Switch to Alpine or distroless base
4. Remove build tools, caches, and package manager artifacts
5. Audit COPY statements for unnecessary files
6. Show before/after size comparison"
```

## Power Move

"Before I build this container, show me: the final image size estimate, which user it runs as, what ports are exposed, how secrets are injected, what happens when the process crashes, and whether the dependency cache will survive a source code change."

The agent becomes your container architect -- security, performance, and developer experience validated before a single layer is built.

## Related Skills

| Skill | When to use it |
|-------|---------------|
| `python-dependency-expert` | Resolve Python-specific dependency conflicts, pip/conda issues, CUDA version matching |
