# Fyde Proxy Computing

## Requirements

- Initial computing requirements are minimum and will depend on:

  - Configured resources

  - Requests being made from devices

- Components are stateless, discarding permanent storage requirement

## Baseline

| Component     | CPU               | Memory    |
| ------------- | ----------------- | --------- |
Envoy Proxy     | 0.25 core (2Ghz)  | 256MB     |
Proxy Client    | 0.1 core (2Ghz)   | 128MB     |
Redis (HA only) | 0.1 core (2Ghz)   | 32MB      |
