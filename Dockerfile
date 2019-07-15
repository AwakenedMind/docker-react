# builder phase multi-step build process
FROM node:alpine as builder
# app dir
WORKDIR '/app'
# copy package.json
COPY package.json .
# install dependencies
RUN npm install
# In production we can copy over everything (no volumes)
COPY . .
# run react script to build a production ready app
RUN npm run build

# Second Phase of build
FROM nginx
# Want to copy the build folding in our working directory into nginx's folder that auto starts
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

