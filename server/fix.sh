#!/bin/bash

clear

REPO_NAME="cytomine-mmu-dist"
REPO_URL="https://github.com/hyphensaad/$REPO_NAME"
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
CLONE_DIR="$SCRIPT_DIR/$REPO_NAME"
DEST_CONTAINER="web_UI"
DEST_PATH="/app"

cd "$SCRIPT_DIR" || exit

rm -rf cytomine-mmu-dist

git clone "$REPO_URL"

clear

cd "$CLONE_DIR/dist/js" || exit

ls -lh

for file in *; do
    docker cp "$file" "$DEST_CONTAINER:$DEST_PATH/js"
done

cd "$CLONE_DIR/dist" || exit

ls -lh

mv index.html app.html
docker cp app.html "$DEST_CONTAINER:$DEST_PATH"

cd "$CLONE_DIR/dist/css" || exit

ls -lh

for file in *; do
    docker cp "$file" "$DEST_CONTAINER:$DEST_PATH/css"
done

echo "Stopping Docker Containers:"
docker stop memcached rabbitmq postgresql mongodb slurm iipOff iipCyto bioformat ims core web_UI nginx software_router

echo "Starting Docker Containers:"
docker start memcached rabbitmq postgresql mongodb slurm iipOff iipCyto bioformat ims core web_UI nginx software_router

echo "All files copied and containers restarted successfully."