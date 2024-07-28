# Build phase

FROM node:18-alpine AS builder

WORKDIR "/app"

COPY package.json .
RUN npm install
COPY . .
RUN npm run build
RUN rm -rf node_modules

# Run phase
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# No need to specify CMD, it's already defined in the base image

