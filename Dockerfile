# Stage 1: Dependencies
FROM node:20-alpine AS deps
WORKDIR /app

# Install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Install dependencies necessary for node-gyp
RUN apk add --no-cache libc6-compat

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Stage 2: Builder
FROM node:20-alpine AS builder
WORKDIR /app

# Install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy package files and install dependencies
COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile

# Copy application code
COPY . .

# Set environment to production
ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=production

# Build the Next.js application
RUN pnpm build

# Stage 3: Runner
FROM node:20-alpine AS runner
WORKDIR /app

# Set environment variables
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV NEXT_PUBLIC_API_URL=https://api.solvario.app


# Create a non-root user
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Copy necessary files from builder stage
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# Set user to non-root
USER nextjs

# Expose the port the app will run on
EXPOSE 3000

# Set host to listen on all interfaces
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Start the application
CMD ["node", "server.js"]
