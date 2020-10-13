---
title: Fyde Deployment Scripts
has_children: false
nav_order: 7
parent: Releases
---
# Fyde Deployment Scripts

### 2020.10.11

- [terraform] Require terraform 0.13 to allow validations
- [terraform] Update README and misc logic
- [terraform] Allow using custom AMI
- [terraform] Add CloudWatch logs configuration
- [terraform] Add Fyde Access Proxy log level configuration
- [terraform] Prevent lingering token after module removal
- [terraform] Create redis elasticache when instance count is more than 1
- [terraform] Recycle instances on launch configuration change
- [terraform] Update to v1.1.0

### 2020.09.29

- [Cloudformation] Add option to specify custom AMI
- [Bootstrap Scripts] Add check for yum lock

### 2020.09.28

- [Cloudformation] Add configuration to set fydeproxy service loglevel

### 2020.09.19

- [Cloudformation] Add redis configuration for ASG
- [Cloudformation] Add configuration to send logs to Cloudformation for ASG
- [Bootstrap Scripts] Add redis configuration parameters

### 2020.09.16

- [Cloudformation] Add AssociatePublicIpAddress configuration for ASG

### 2020.08.11

- [terraform] Add modules for Fyde Access Proxy deployment

### 2020.08.02

- [Cloudformation] Allow specifying private subnets for EC2 instances

### 2020.06.02

- [Cloudformation] Add AllowedPattern to `fydeAccessProxyToken`

### 2020.05.27

- [Bootstrap Scripts]  Several fixes

### 2020.02.11

- [Cloudformation] Add template for Fyde Access Proxy in ECS Fargate

### 2020.02.10

- [Bootstrap Scripts] Ensure timesync for RHEL/CentOS

### 2020.01.23

- [Cloudformation] Add templates for Fyde Access Proxy deployment with ASG
