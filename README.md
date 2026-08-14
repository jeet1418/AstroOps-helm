<!-- markdownlint-disable-next-line -->
# <img src="https://cdn.jsdelivr.net/gh/callback-io/allogo@main/public/logos/helm/icon.svg" alt="Helm logo" width="35"> AstroOps Helm

Helm charts for deploying the **AstroOps microservices application** on Kubernetes.

This repository contains an independent Helm chart for each microservice and supporting component. These charts are used by the CI/CD and GitOps workflow to deploy and update services running on Kubernetes.

---

## Architecture

```text
                    Application Repository
                              |
                              | Git Push
                              v
                    +-------------------+
                    |      Jenkins      |
                    |      CI / CD      |
                    +---------+---------+
                              |
                              | Build Docker Image
                              | Security Scan
                              v
                    +-------------------+
                    |     Amazon ECR    |
                    |   Docker Images   |
                    +---------+---------+
                              |
                              | Update image tag
                              v
                    +-------------------+
                    |   AstroOps Helm   |
                    |    Repository     |
                    +---------+---------+
                              |
                              | Git Push
                              v
                    +-------------------+
                    |      Argo CD      |
                    |      GitOps       |
                    +---------+---------+
                              |
                              | Helm Deployment
                              v
                    +-------------------+
                    |   Kubernetes/EKS  |
                    |                   |
                    | AstroOps Services |
                    +-------------------+

```

## Design Principles

This Helm repository follows these principles:

- **Modularity** – Each microservice is maintained as a separate Helm chart.
- **Reusability** – Helm templates and values can be reused and customized across deployments.
- **Separation of Concerns** – Each service has its own `Chart.yaml`, `values.yaml`, and Kubernetes templates.
- **Configuration Management** – Service-specific configuration is maintained in `values.yaml`.
- **Consistency** – All microservices follow a common Helm chart structure.
- **Maintainability** – Kubernetes manifests are managed through Helm templates instead of duplicated raw YAML files.
- **Version Control** – All deployment configurations are stored and managed through Git.
- **CI/CD Integration** – Jenkins automatically updates image repository and image tags after building and pushing Docker images.
- **GitOps Ready** – The repository can be used as the desired-state source for Argo CD deployments.
- **Independent Deployment** – Each microservice can be updated and deployed independently without modifying other services.