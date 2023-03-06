# devops101

## Docker
1. Docker Desktop (Windows / macOS)
## AWS
1. create iam account
2. create Access keys for aws-cli
3. create EC2 key pair for access the instance
## Terraform
1. install terraform
2. run terraform to setup infra for our application
or  use docker compose below
pre-install
1. export AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
2. replace key_name with your key pair name for access to ec2
```
    docker compose run --rm tf init
    docker compose run --rm tf fmt
    docker compose run --rm tf validate
    docker compose run --rm tf plan
    docker compose run --rm tf apply
```

https://youtu.be/qfOSaCFnYCk