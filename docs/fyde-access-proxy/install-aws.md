---
layout: default
title: Install in AWS
parent: Fyde Access Proxy
nav_order: 1
---
# Install in AWS
{: .no_toc }

## Table of contents
{: .no_toc }
- TOC
{:toc}

## Terraform modules

  1. Get a [Fyde Access Proxy enrollment link]({{ site.baseurl }}{% link fyde-enterprise-console/add-fyde-access-proxy.md %}#adding-a-proxy) by creating a new Fyde Access Proxy. Since we don't have the value for Host parameters yet, please insert a placeholder (e.g. temp.example.org)

  1. Go to [Terraform modules](https://github.com/fyde/terraform-modules){:target="_blank"} for detailed deployment steps

  1. After the instalation, update the created Fyde Access Proxy Host with the DNS name obtained in the terraform output resource `Network_Load_Balancer_DNS_Name`

## Cloudformation Templates

### Install steps

  1. Get a [Fyde Access Proxy enrollment link]({{ site.baseurl }}{% link fyde-enterprise-console/add-fyde-access-proxy.md %}#adding-a-proxy) by creating a new Fyde Access Proxy. Since we don't have the value for Host parameters yet, please insert a placeholder (e.g. temp.example.org)

  1. Choose one of the templates:

      - [ASG with NLB](#asg-with-nlb)

      - [ECS on AWS Fargate](#ecs-on-aws-fargate)

  1. Update the created Fyde Access Proxy Host with the DNS name obtained in the stack output key `NetworkLoadBalancerDnsName`

  1. Configure access to the desired resources with the security group id obtained in the stack output key `SecurityGroupforResources`

[launch-stack-logo]: https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png "Launch Stack"

### ASG with NLB

- Contains all the resources and steps needed to deploy Fyde Access Proxy in an ASG behind an NLB

- The template creates a highly available / self-healing infrastructure with a minimum of 2 EC2 instances that are part of an ASG and sit behind an NLB

- All the resources are created with the principle of least privilege

- The latest AMI for the deployed region is automatically configured, at the date of the deploy

- When the parameter `EC2ASGDesiredCapacity` is higher than `1` (defaults to `2`), the stack will deploy a Redis Replication Group with 2 nodes on different Availability Zones. This is required for communication between Fyde Orchestrators

- [![launch-stack-logo]](https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=fyde&templateURL=https://fyde-cloudformation-store.s3.amazonaws.com/fyde-access-proxy-aws-cf-asg.yaml){:target="_blank"}

- Template available [here](https://url.fyde.me/fyde-proxy-aws-cf-asg){:target="_blank"}

### ECS on AWS Fargate

- Contains all the resources and steps needed to deploy Fyde Access Proxy in an [ECS](https://aws.amazon.com/ecs/){:target="_blank"} cluster hosted on [AWS Fargate](https://aws.amazon.com/fargate/){:target="_blank"}

- The template creates the required containers behind an NLB. Required security groups are included. The template will use the latest container versions

- [![launch-stack-logo]](https://console.aws.amazon.com/cloudformation/home#/stacks/new?stackName=fyde&templateURL=https://fyde-cloudformation-store.s3.amazonaws.com/fyde-access-proxy-aws-cf-ecs-fargate.yaml){:target="_blank"}

- Template available [here](https://url.fyde.me/fyde-proxy-aws-cf-ecs-fargate){:target="_blank"}

## AMI

- Fyde Access Proxy AMI is based on the oficial Amazon Linux 2 AMI

- The AMI is available in the account 766535289950 in all regions under the prefix `amazonlinux-2-base_*`

- Fyde Access Proxy AMI includes:
  - [CIS](https://www.cisecurity.org/){:target="_blank"} recommendations for CentOS
  - [CIS](https://www.cisecurity.org/){:target="_blank"} recommendations for SSH
  - Updated regularly to ensure the latest packages
  - Performs automatic install of security updates via [yum-cron](http://man7.org/linux/man-pages/man8/yum-cron.8.html){:target="_blank"}

- Latest AMIs

  - The ids will change with new versions
  - Update: 2020.09.29

  ```txt
  ap-northeast-1: ami-0e0313875a5d5e6eb
  ap-northeast-2: ami-0f23a2f6eac85ddad
  ap-south-1: ami-0d16041bffb3c0325
  ap-southeast-1: ami-0c27b55ffe958e7ad
  ap-southeast-2: ami-09f1391351e80b115
  ca-central-1: ami-00302b74d7dec8b5f
  eu-central-1: ami-00d752df7a2d84347
  eu-north-1: ami-01de00f26f31eaaac
  eu-west-1: ami-0d2ef373a5b0adf10
  eu-west-2: ami-0c05321fc62d47126
  eu-west-3: ami-0e1f41f834e33bd3f
  sa-east-1: ami-0189741b4f7063ebe
  us-east-1: ami-09dea62ce16b051ca
  us-east-2: ami-0bb58cf9c890b60a3
  us-west-1: ami-08e6bfb27a03b8a07
  us-west-2: ami-0c5d9af262b1c0c54
  ```

- Listing the available AMIs with aws-cli tools

  ```sh
  for region in $(aws ec2 describe-regions --query "Regions[].RegionName" --output text); do
    echo "${region}: $(aws ec2 describe-images --owners 766535289950 \
    --filters Name=name,Values=amazonlinux-2-base_* \
    --query "reverse(sort_by(Images, &CreationDate))[0].ImageId" \
    --output text --region ${region})"
  done
  ```

- Please note that Fyde software is not included in the AMI, this image is intended to be used as the base to install the latest packages available with the provided scripts in [Install in Bare Metal / Virtual Machine]({{ site.baseurl }}{% link fyde-access-proxy/install-bm-vm.md %})

## Troubleshoot

- For troubleshooting steps please visit: [Troubleshooting]({{ site.baseurl }}{% link fyde-access-proxy/troubleshoot/README.md %})
