The example project for StringBoot service

<div align="center">
    <img src="./assets/images/spring_boot_icon.png"/>
</div>

## Getting Started

## Project structure
```
.
├── hello-world
│   ├── src
|   ├── pom.xml
│   ...
├── terraform
|
└── README.md
```

## Prerequisites
- Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

Make sure that you have a [Amazon Account](https://aws.amazon.com/account/) and configurate aws account in ~/.aws/credentials
```
[default]
aws_access_key_id=<your-key>
aws_secret_access_key=<your-key>
```

- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Build and deploy

Build and deploy all in once by using Makefile
 - ```make build```     : Build application
 - ```make deploy```    : Deploy on aws
 - ```make apply```     : Build & deploy on aws
 - ```make destroy```   : Destroy aws resource

Or step by step as below

### Build spring-boot application

- Build project
```shell script
$ cd hello-world
$ ../mvnw clean package
...
$ cd ..
```

### Create AWS Lambda 

```shell script
$ cd terraform
$ terraform init
$ terraform apply
$ cd ..
```

### Destroy resource on AWS

```shell script
$ cd terraform
$ terraform destroy
$ cd ..
```

## Test 
Send HTTP request to AWS API Gateway by using curl

```shell script
$ curl -X GET -H "Content-Type: application/x-www-form-urlencoded" "<your_url>/welcome?userName=huypva"
"Welcome null to the lambda function"%
```

## Contributing

The code is open sourced. I encourage fellow developers to contribute and help improve it!

- Fork it
- Create your feature branch (git checkout -b new-feature)
- Ensure all tests are passing
- Commit your changes (git commit -am 'Add some feature')
- Push to the branch (git push origin my-new-feature)
- Create new Pull Request

## Reference

- https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway?in=terraform/aws
- https://www.youtube.com/watch?v=euLs1SbYKzE&t=807s
- https://mydeveloperplanet.com/2020/11/04/how-to-deploy-a-spring-cloud-function-on-aws-lambda/

## License
This project is licensed under the Apache License v2.0. Please see LICENSE located at the project's root for more details.