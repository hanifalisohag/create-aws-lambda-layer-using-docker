ARG BASE_IMAGE=public.ecr.aws/lambda/python:3.11
FROM --platform=linux/amd64 ${BASE_IMAGE}
WORKDIR /var/task
RUN if command -v yum &> /dev/null; then \
        yum install -y zip; \
    else \
        microdnf install -y zip; \
    fi
	
RUN python3 -m pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt --target python