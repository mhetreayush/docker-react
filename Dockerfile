# Build phase

FROM node:18-alpine AS builder

WORKDIR /usr/frontend

COPY package.json .
RUN npm install
COPY . .
RUN npm run build
RUN rm -rf node_modules

# Run phase
FROM nginx
COPY --from=builder /usr/frontend/build /usr/share/nginx/html
# No need to specify CMD, it's already defined in the base image

