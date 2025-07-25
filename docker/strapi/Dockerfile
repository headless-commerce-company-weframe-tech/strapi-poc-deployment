# Stage 1
FROM node:18-alpine as builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Stage 2
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app . 
RUN npm install --omit=dev
CMD ["npm", "start"]
