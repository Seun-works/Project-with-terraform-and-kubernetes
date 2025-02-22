# Use the official Node.js 18 image as the builder image
FROM node:18-alpine AS base

# Create deps stage for installing dependencies
FROM base AS deps

RUN apk add --no-cache libc6-compat

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

# Create build stage for building the application

FROM base AS builder

WORKDIR /app

COPY  --from=deps /app/node_modules ./node_modules

COPY . .

RUN npm run build


# Create the final stage
FROM base AS runner

# ENV NODE_ENV=production


# Add group and user for permissions
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

COPY --from=builder /app/public ./public

RUN mkdir .next

# Grant permissions to the nextjs user
RUN chown -R nextjs:nodejs .next

#copy the built files from the builder stage
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

#Switch to the nextjs user and not root user for security
USER nextjs

EXPOSE 3000

ENV PORT=3000

CMD HOSTNAME="0.0.0.0" node server.js