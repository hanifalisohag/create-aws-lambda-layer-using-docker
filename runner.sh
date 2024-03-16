# Default value for the package name
default_package="package_layer"
# Prompt the user for input
read -p "Enter zip package [$default_package]: " package


# Default value for the package name
default_python_ver="3.11"
# Prompt the user for input
read -p "Enter Python Version Tag [$default_python_ver]: " python_ver
PYTHON_TAG_VERSION=${python_ver:-$default_python_ver}

PACKAGE_NAME=${package:-$default_package}_py_${PYTHON_TAG_VERSION}.zip

CONTAINER_NAME=aws_lambda_layer
docker build --build-arg BASE_IMAGE=public.ecr.aws/lambda/python:$PYTHON_TAG_VERSION -t $CONTAINER_NAME .

docker rm $CONTAINER_NAME
docker run --name $CONTAINER_NAME --entrypoint /bin/bash $CONTAINER_NAME -c "zip -r9 $PACKAGE_NAME python"
#docker run --name $CONTAINER_NAME --entrypoint /bin/bash  $CONTAINER_NAME < ./docker_install.sh

if [ $? -eq 0 ]; then
    echo "The zip file ${package:-$default_package}_py_${PYTHON_TAG_VERSION}.zip created successfully."
else
    echo "Docker command failed"
fi

# Delete the distribution package if it exists
if [ -f $PACKAGE_NAME ]; then
    rm $PACKAGE_NAME
fi

docker cp $CONTAINER_NAME:/var/task/$PACKAGE_NAME .
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

