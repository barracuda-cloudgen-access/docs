---
title: Glossary
has_children: false
nav_order: 6
---
# Glossary
{: .no_toc }

## Table of contents
{: .no_toc }
- TOC
{:toc}

## Admin

An administrator for the Fyde Enterprise Console.

## Device

A user device where the Fyde App is installed.

## Envoy Proxy

From [Envoy documentation](https://www.envoyproxy.io/docs/envoy/latest/intro/what_is_envoy){:target="_blank"}:

> Envoy is an L7 proxy and communication bus designed for large modern service oriented architectures

Envoy Proxy is part of the Fyde Access Proxy combo, it listens to requests and proxies them to the correct destination.

## Fyde Access Proxy

Fyde Access Proxy is the software combo that contains Envoy Proxy and Fyde Proxy Orchestrator.

## Fyde Access Proxy enrollment link

Required by Fyde Access Proxy and used to bootstrap and authorize the service. Obtained only when created a Fyde Access Proxy.

## Fyde App

Agent software installed in a user's device. Bundles the end user UI and the Fyde agent.

## fyde-cli

Command-line software used to interact with the Fyde Enterprise Console.

## Fyde Enterprise Console

Web application to manage the Fyde's customer platform.

## Fyde Proxy Orchestrator

Fyde Proxy Orchestrator ensures that Envoy Proxy is configured with the correct requests and takes care of requests authorization and authentication.

Requires a valid token (Fyde Access Proxy enrollment link) that contains the necessary information to bootstrap and authorize the service.

## Fyde User Directory Connector

Program that retrieves users and groups from multiple sources and sync them into a Fyde Enterprise tenant

## User

Entity associated with a real person that can have multiple devices associated.