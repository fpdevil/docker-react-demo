# -----------
# build phase
# fetch nodejs 19
FROM node:19-alpine as builder

# specify the working directory
WORKDIR '/app'

# copy the package.json file first
COPY package.json .

# install the dependencies
RUN npm install

# copy everything else
COPY . .

# now run the command for building
RUN npm run build

# -----------
# run phase
# get nginx server https://hub.docker.com/_/nginx
FROM nginx

# copy something from the earlier or other phase
COPY --from=builder /app/build /usr/share/nginx/html
