FROM --platform=linux/amd64 public.ecr.aws/lambda/python:3.11
WORKDIR /var/task
RUN yum install -y zip
RUN python3 -m pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt --target python