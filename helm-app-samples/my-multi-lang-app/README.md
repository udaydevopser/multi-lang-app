# `my-multi-lang-app` Helm Chart

This Helm chart is a demonstration of how to manage dynamic and language-specific Kubernetes deployments using a single, flexible chart. It showcases conditional logic for images, ports, config paths, resource limits, health checks, and Ingress routing based on application language and type.

## Chart Values

The primary configuration is done via `values.yaml`. Key configurable parameters include:

* **`application.language`**: Set to `"java"`, `"dotnet"`, `"python"`, or `"react"`. This drives many dynamic behaviors.
* **`application.type`**: Set to `"api"` or `"ui"`. This controls Ingress routing behavior.
* **`ingress.enabled`**: Set to `true` to deploy an Ingress resource.
* **`enableHeartbeatConfig`**: Set to `true` or `false` to conditionally include a separate heartbeat ConfigMap.
* **`resources.<language>`**: Define specific CPU/memory requests and limits for each language.

## Usage Examples

Make sure you have `kubectl` configured to your Kubernetes cluster and `helm` installed.

1.  **Install for a Java API Application:**

    ```bash
    helm install java-api ./my-multi-lang-app \
      --set application.language=java \
      --set application.type=api \
      --set ingress.api.host=api-java.example.com
    ```
    *Observe:* This will deploy a Java application, mount `application.yml`, set Java-specific resources, and create an Ingress rule for `api-java.example.com`.

2.  **Install for a .NET API Application:**

    ```bash
    helm install dotnet-api ./my-multi-lang-app \
      --set application.language=dotnet \
      --set application.type=api \
      --set ingress.api.host=api-dotnet.example.com
    ```
    *Observe:* This will deploy a .NET application, mount `appsettings.json`, set .NET-specific resources, and create an Ingress rule for `api-dotnet.example.com`.

3.  **Install for a React UI Application:**

    ```bash
    helm install react-ui ./my-multi-lang-app \
      --set application.language=react \
      --set application.type=ui \
      --set ingress.ui.host=ui-react.example.com \
      --set application.nodePort=80 # Nginx default for React static files
    ```
    *Observe:* This will deploy an Nginx container (simulating React app), mount `config.js`, set React-specific resources, and create an Ingress rule for `ui-react.example.com` with UI-specific annotations.

4.  **Install a Python API Application (without heartbeat config):**

    ```bash
    helm install python-api ./my-multi-lang-app \
      --set application.language=python \
      --set application.type=api \
      --set application.nodePort=3000 \
      --set ingress.api.host=api-python.example.com \
      --set enableHeartbeatConfig=false
    ```
    *Observe:* This will deploy a Python application, use port 3000, and *not* create the additional `heartbeat-config` ConfigMap.

## Cleaning Up

To uninstall any of the sample deployments:

```bash
helm uninstall java-api
helm uninstall dotnet-api
helm uninstall react-ui
helm uninstall python-api