# create-aws-lambda-layer-using-docker
Creating lambda layer for aws using Docker

Clone the repo
```
git clone https://github.com/hanifalisohag/create-aws-lambda-layer-using-docker.git

cd create-aws-lambda-layer-using-docker

```

Modify the `requirements.txt` file
```
requests==2.31.0
```

Make sure the `runner.sh` file has executable permission
```
chmod +x runner.sh
```

Run the runner file
```
./runner.sh
```

You can find the tag Name (1st column): https://gallery.ecr.aws/lambda/python

Replace Enter the tag name and it will use that python version while building. Default tag is `3.11`

```
hanifalisohag@Hanif-Alienware:~/create-aws-lambda-layer-using-docker$ ./runner.sh

Enter zip package [package_layer]: req
Enter Python Version Tag [3.11]: 3.12

[+] Building 0.2s (11/11)
  ......
  adding: python/urllib3/_version.py (deflated 3%)
  adding: python/urllib3/filepost.py (deflated 61%)
The zip file req_py_3.12.zip created successfully.
Successfully copied 995kB to /home/hanifalisohag/create-aws-lambda-layer-using-docker/.
aws_lambda_layer
aws_lambda_layer
```