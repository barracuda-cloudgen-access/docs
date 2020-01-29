---
layout: default
title: Install in AWS
parent: Fyde Access Proxy
nav_order: 1
---
# Install in AWS

## AMI

- Fyde Access Proxy AMI is based on the oficial Amazon Linux 2 AMI

- The AMI is available in the account 766535289950 in all regions under the prefix `amazonlinux-2-base_*`

- Fyde Access Proxy AMI details:
  - [CIS](https://www.cisecurity.org/){:target="_blank"} recommendations for CentOS
  - [CIS](https://www.cisecurity.org/){:target="_blank"} recommendations for SSH
  - Updated regularly to ensure the latest packages
  - Performs automatic install of security updates via [yum-cron](http://man7.org/linux/man-pages/man8/yum-cron.8.html){:target="_blank"} when deployed

- Example for listing the available AMIs with aws-cli tools

  - Please note these ids will change with new versions

    ```sh
    → date -u
    Wed Jan 22 21:42:01 UTC 2020

    → for region in $(aws ec2 describe-regions --query "Regions[].RegionName" --output text); \
      do echo "${region}: $(aws ec2 describe-images --owners 766535289950 \
        --filters Name=name,Values=amazonlinux-2-base_* \
        --query "reverse(sort_by(Images, &CreationDate))[0].ImageId" \
        --output text --region ${region})"; \
      done
    eu-north-1: ami-01776f96a2bcba9c0
    ap-south-1: ami-060533e21f97843fe
    eu-west-3: ami-058a7b459aa9742ce
    eu-west-2: ami-0da8e217042aa1b9f
    eu-west-1: ami-06d428d348ad6634a
    ap-northeast-2: ami-0a315a5409f2c4283
    ap-northeast-1: ami-0e77a541fb2ef41f1
    sa-east-1: ami-03a71597766642f8a
    ca-central-1: ami-0ea12b59141d17ccd
    ap-southeast-1: ami-04741feffb4f38b37
    ap-southeast-2: ami-0b1feebb9f2a57e56
    eu-central-1: ami-0f10c8bc67da07640
    us-east-1: ami-00ee7d804af55cf4c
    us-east-2: ami-024d399c7a47c3ead
    us-west-1: ami-012d519302625eb00
    us-west-2: ami-0d023437b65cbea27
    ```

- Please note that Fyde software is not included in the AMI, this image is intended to be used as the base to install the latest packages available with the provided scripts in [Install in Bare Metal / Virtual Machine]({{ site.baseurl }}{% link fyde-access-proxy/install-bm-vm.md %})

## Cloudformation

- The Cloudformation template contains all the resources and steps needed to deploy Fyde Access Proxy in an ASG behind an NLB

- The template creates a highly available / self-healing infrastructure with a minimum of 2 EC2 instances that are part of an ASG and sit behind an NLB. Required security groups and ports are included. The latest AMI for the deployed region is automatically configured, at the date of the deploy

- Install steps:

  1. Get a [Fyde Access Proxy enrollment link]({{ site.baseurl }}{% link fyde-enterprise-console/add-fyde-access-proxy.md %}#adding-a-proxy) by creating a new Fyde Access Proxy. Since we don't have the Host value yet, please insert a placeholder (e.g. temp.local)

  2. Create the Cloudformation stack with the Cloudformation template obtained from [https://url.fyde.me/fyde-proxy-aws-cf](https://url.fyde.me/fyde-proxy-aws-cf){:target="_blank"}

  3. Update the created Fyde Access Proxy Host with the DNS name obtained in the stack output key `NetworkLoadBalancerDnsName`

  4. Configure access to the desired resources with the security group id obtained in the stack output key `SecurityGroupforResources`

## ECS on AWS Fargate

- Coming soon

## Troubleshoot

- For troubleshooting steps please visit: [Troubleshooting]({{ site.baseurl }}{% link fyde-access-proxy/troubleshoot.md %})