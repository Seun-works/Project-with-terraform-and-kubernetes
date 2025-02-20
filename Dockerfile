# Use the official Node.js 18 image as the base image
FROM node:18-alpine AS base

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the Next.js application
RUN npm run build

# Use the official Node.js 18 image as the base image for the final stage
FROM node:18-alpine AS final

# Set the working directory
WORKDIR /app

# Copy the built application from the previous stage
COPY --from=base /app/.next ./.next
COPY --from=base /app/public ./public
COPY --from=base /app/package.json ./package.json
COPY --from=base /app/next.config.ts ./next.config.ts

# Install only production dependencies
RUN npm install

# Expose the port the app runs on
EXPOSE 3000

# Start the Next.js application
CMD npm run start