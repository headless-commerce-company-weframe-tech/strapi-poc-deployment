# ---------- STAGE 1: Build ----------
FROM node:18-alpine AS builder

# Install OS deps
RUN apk add --no-cache python3 make g++ curl git ca-certificates && update-ca-certificates

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the entire Strapi project
COPY . .

# Build Strapi admin panel
RUN npm run build

# ---------- STAGE 2: Run ----------
FROM node:18-alpine

WORKDIR /app

# Trust internal certs (optional)
# RUN apk add --no-cache ca-certificates && \
#   wget -O /usr/local/share/ca-certificates/intermediate.crt https://certs.ptp.local/intermediate.txt --no-check-certificate && \
#   wget -O /usr/local/share/ca-certificates/root.crt https://certs.ptp.local/root.txt --no-check-certificate && \
#   update-ca-certificates

# Copy only built app from builder
COPY --from=builder /app /app

# Install only runtime deps
COPY package*.json ./
RUN npm install --omit=dev

# Use a non-root user (optional best practice)
# RUN addgroup -g 1001 strapi && adduser -u 1001 -G strapi -s /bin/sh -D strapi
# USER strapi

EXPOSE 1337

CMD ["npm", "start"]
