# Production Dockerfile — multi-stage build for Next.js standalone
# Produces a minimal image (~150MB) for Cloud Run / App Runner
#
# LESSONS LEARNED:
# 1. Builder needs ALL deps (npm ci, not --omit=dev) because next.config.ts
#    requires TypeScript at build time.
# 2. COPY fails hard on missing sources. Use glob pattern (publi[c]) to make
#    optional copies that skip silently when the directory doesn't exist.
# 3. Cloud Run / App Runner require linux/amd64. On Apple Silicon, build with:
#      docker build --platform linux/amd64 -t <tag> .
# 4. Always test locally with `npm run docker:prod` before pushing to the cloud.

# Stage 1: Build the application (needs ALL deps — TypeScript is required
# to transpile next.config.ts even though it's a devDependency)
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci
COPY . .
RUN mkdir -p public
RUN npm run build

# Stage 2: Production runner
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

RUN addgroup --system --gid 1001 nodejs \
 && adduser --system --uid 1001 nextjs

# Copy standalone output
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
# Ensure public exists (created in builder stage)
COPY --from=builder /app/public ./public

USER nextjs
EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]
