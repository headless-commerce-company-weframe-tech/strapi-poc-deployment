# --- STAGE 1: Build ---
FROM node:18-alpine AS builder

WORKDIR /app

# Install dependencies
COPY ./package*.json ./
RUN npm install

# Copy the full project and build
COPY . .
RUN npm run build


# --- STAGE 2: Runtime ---
FROM node:18-alpine

WORKDIR /app

# Install runtime dependencies
COPY ./package*.json ./
RUN npm install --omit=dev

# Copy build from builder stage
COPY --from=builder /app ./

# Expose default Strapi port
EXPOSE 1337

# Start Strapi
CMD ["npm", "start"]
