# Default value for the color
default_package="requests_layer"

# Prompt the user for input
read -p "Enter zip package [$default_package]:" package
PACKAGE_NAME=${package:-$default_package}.zip

CONTAINER_NAME=aws_lambda_layer
docker build -t $CONTAINER_NAME .
docker rm $CONTAINER_NAME
docker run --name $CONTAINER_NAME --entrypoint /bin/bash $CONTAINER_NAME -c "zip -r9 $PACKAGE_NAME python"
#docker run --name $CONTAINER_NAME --entrypoint /bin/bash  $CONTAINER_NAME < ./docker_install.sh

# Delete the distribution package if it exists
if [ -f $PACKAGE_NAME ]; then
    rm $PACKAGE_NAME
fi

docker cp $CONTAINER_NAME:/var/task/$PACKAGE_NAME .
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME