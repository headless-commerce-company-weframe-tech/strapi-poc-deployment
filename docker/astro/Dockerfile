# =============================
# ⛏️ Build Stage
# =============================
FROM node:18-alpine AS builder

WORKDIR /app

# Install CA trust and necessary build deps
RUN apk add --no-cache curl wget git ca-certificates && update-ca-certificates

# Copy source code
COPY . .

# Install dependencies and build site
RUN npm install
RUN npm run build

# =============================
# 🏃 Runtime Stage
# =============================
FROM node:18-alpine AS runner

WORKDIR /app

# Trust internal HTTPS CA certs
RUN apk add --no-cache ca-certificates && \
  wget -O /usr/local/share/ca-certificates/intermediate.crt https://certs.ptp.local/intermediate.txt --no-check-certificate && \
  wget -O /usr/local/share/ca-certificates/root.crt https://certs.ptp.local/root.txt --no-check-certificate && \
  update-ca-certificates

# Install only runtime dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy built assets from builder
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/public ./public
COPY --from=builder /app/.astro ./.astro
COPY --from=builder /app/astro.config.* ./
COPY --from=builder /app/package.json ./
COPY --from=builder /app/server/ ./server/

# Default port (change in Helm if needed)
EXPOSE 3000

# Run Astro server (for SSR), or serve static
CMD ["npm", "run", "preview"]
