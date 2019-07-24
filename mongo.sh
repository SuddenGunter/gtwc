
               docker run \
               --volume=/data:/data/db \
               --env=MONGO_INITDB_ROOT_USERNAME=_ \
               --env=MONGO_INITDB_ROOT_PASSWORD=__ \
               --publish=27017:27017 \
               --restart=always \
               --detach=true \
               --name=mongo \
               mongo:latest \
