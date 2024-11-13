ARG BUN_VERSION=1.1.34
FROM oven/bun:${BUN_VERSION} AS builder

# Install required dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Set the Node.js version
ENV NODE_VERSION=20.18.0

# Download and install Node.js
RUN curl -fsSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz -o node-v${NODE_VERSION}-linux-x64.tar.xz && \
    tar -xf node-v${NODE_VERSION}-linux-x64.tar.xz && \
    mv node-v${NODE_VERSION}-linux-x64 /usr/local/node && \
    ln -s /usr/local/node/bin/node /usr/local/bin/node && \
    ln -s /usr/local/node/bin/npm /usr/local/bin/npm && \
    ln -s /usr/local/node/bin/npx /usr/local/bin/npx && \
    rm node-v${NODE_VERSION}-linux-x64.tar.xz

# Verify installation
RUN node --version && npm --version

WORKDIR /app

# Set environment variables
ENV NODE_ENV=production

COPY --link bun.lockb package.json ./
RUN bun install --ci

# Generate Prisma Client
# COPY --link prisma .
# RUN bun x prisma generate

# Copy application code
COPY --link . .

# Build application
RUN bun run build

# Remove development dependencies
#RUN rm -rf node_modules && bun install --ci

FROM oven/bun:${BUN_VERSION}

# Copy Node.js binaries and curl from the builder stage
COPY --from=builder /usr/local/node /usr/local/node
COPY --from=builder /usr/bin/curl /usr/bin/curl
COPY --from=builder /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu

# Create symbolic links to Node.js binaries
RUN ln -s /usr/local/node/bin/node /usr/local/bin/node && \
    ln -s /usr/local/node/bin/npm /usr/local/bin/npm && \
    ln -s /usr/local/node/bin/npx /usr/local/bin/npx

# Copy the built application and necessary files from the builder stage
COPY  --chown=bun:bun  --from=builder /app /app

#
ENV PORT=3000
EXPOSE 3000/tcp

# Set user and define healthcheck
USER bun
HEALTHCHECK --interval=5s --timeout=5s --start-period=5s --retries=3 CMD curl --fail http://localhost:3000/healthcheck

CMD ["bun", "/app/build/index.js"]