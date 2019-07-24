mkdir /var/lib/cache

docker run \
  --volume=/var/run/docker.sock:/var/run/docker.sock \
  --volume=/var/lib/drone:/data \
  --env=DRONE_GITHUB_SERVER=https://github.com \
  --env=DRONE_GITHUB_CLIENT_ID=$GITHUB_CLIENT_ID \
  --env=DRONE_GITHUB_CLIENT_SECRET=$GITHUB_CLIENT_SECRET \
  --env=DRONE_RUNNER_CAPACITY=2 \
  --env=DRONE_SERVER_HOST=$DRONE_DOMAIN \
  --env=DRONE_SERVER_PROTO=https \
  --env=DRONE_TLS_AUTOCERT=true \
  --env=DRONE_USER_CREATE=username:$DRONE_ADMIN_USERNAME,admin:true,token:$DRONE_ADMIN_PASSWORD\
  --publish=80:80 \
  --publish=443:443 \
  --restart=always \
  --detach=true \
  --name=drone \
  drone/drone:1