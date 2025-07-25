# ============================
# ⛏️ Build Stage
# ============================
FROM node:18-alpine as builder

WORKDIR /app

# Install required dependencies for building native modules and TLS trust
RUN apk add --no-cache \
    python3 make g++ wget curl ca-certificates \
    && update-ca-certificates

# Copy app files
COPY ./ ./   

# Install plugins
RUN npm install mysql2 \
    && npm install @strapi/plugin-graphql \
    && npm install strapi-plugin-ckeditor5 \
    && npm install

# Build Strapi (optional, for plugins/ts, not needed for dev mode)
# RUN npm run build

# ============================
# 🐳 Runtime Stage
# ============================
FROM node:18-alpine

WORKDIR /app

# Trust internal CA certificates
# RUN apk add --no-cache ca-certificates && \
#   wget -O /usr/local/share/ca-certificates/intermediate.crt https://certs.ptp.local/intermediate.txt --no-check-certificate && \
#   wget -O /usr/local/share/ca-certificates/root.crt https://certs.ptp.local/root.txt --no-check-certificate && \
#   update-ca-certificates

# Copy node modules and app from builder
COPY --from=builder /app /app
COPY --from=builder /etc/ssl/certs /etc/ssl/certs

# Expose Strapi port
EXPOSE 1337

# Run Strapi
CMD ["npm", "start"]