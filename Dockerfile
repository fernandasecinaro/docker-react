FROM node:16-alpine AS builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# /app/build <- This folder has all the stuff we care for production

FROM nginx

WORKDIR /the/workdir/path

# copy from a different phase (builder)
COPY --from=builder /app/build /usr/share/nginx/html

