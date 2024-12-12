# Rearc App  

## Overview  
This project demonstrates the creation and deployment of a Docker-based application onto an EKS cluster using Terraform, Helm, and Helmfile.  

---

## Docker Image Creation  

[Docker file link](https://github.com/raybanabhi/quest)

The Docker image for the Rearc app was created using the following steps:  
1. **Dockerfile Creation**: Created a `Dockerfile` with all required steps for the app.  
2. **Docker Build and Push**: Built and pushed the image to Docker Hub.  

### Commands Used  
```bash
docker build -t abhisshe/rearc-app:latest -f Dockerfile .
docker push abhisshe/rearc-app:latest
```

### Enhancements:
1. CI-CD pipeline for new changes in repo
2. Introduce scanning tools on PR/MR raise for linting & other vunralbilities check

## EKS Infrastructure
The EKS infrastructure was provisioned using Terraform. Terraform code is maintained in a separate repository [Link](https://github.com/raybanabhi/eks-pub-terraform).

### Commands used
- Validate
   ```bash
     terraform validate
    ```
- Plan
   ```bash
     terraform plan -var-file "variables.tfvars"
    ```
- Apply
   ```bash
     terraform apply -var-file "variables.tfvars" -auto-approve
   ```
- Destroy
   ```bash
     terraform destroy -var-file "variables.tfvars" -auto-approve
   ```
### Enhancement in Terraform
1. **Environment Management:** Use Terraform workspaces to support multiple environments (e.g., dev, staging, production).
2. **CI/CD Integration:** Automate Terraform commands via CI/CD:
     - Run terraform plan as a pre-check for PRs/MRs.
     - Allow approvers to review the plan.
     - Execute terraform apply automatically post-merge.
 
## Application Deployment on EKS
The application was deployed using Helm and Helmfile for streamlined management [Link](https://github.com/raybanabhi/rearc-app).

**Key Features**
1. **Dedicated Repository:** Deployment-specific code is maintained in a separate repository.
2. **Helm Chart:** Created a Helm chart (quest-app) for application deployment, with configurations stored under the templates/ directory.
3. **Helmfile:** Used to manage and orchestrate all Helm charts.
4. **Ingress and TLS:**
    - created a seprate repo where we are keeping code for deployments
    - created a helm chart quest-app & keeping files under templates folder
    - A helmfile is created to run all helm charts
    - I have used Ingress-Controller, Certs manager for tls certs

### Enhancement in Deployment

1. **Monitoring:** Implement Grafana and Prometheus for robust monitoring.
2. **Continuous Deployment:** Use ArgoCD for automated and continuous deployments.

---

## Future Enhancements  

If I would have more time to work on, then i'll pick below things as enhancements

1. **Automated Testing**  
   - Integrate unit and integration tests into the CI/CD pipeline for automated testing and quality assurance.  
   - Use frameworks such as Selenium for end-to-end testing.  

2. **Scalability**  
   - Implement **KEDA (Kubernetes Event-Driven Autoscaling)** for dynamic pod scaling based on event triggers and traffic patterns.  
   - Enhance HPA (Horizontal Pod Autoscaling) policies for optimal resource utilization.  

3. **Security**  
   - Use tools like **Snyk** or **Trivy** for container image scanning to detect vulnerabilities early.  
   - Introduce **Gatekeeper** for enforcing Kubernetes policies and ensuring compliance with organizational standards.  
   - Use **OPA (Open Policy Agent)** to establish a flexible, fine-grained access control mechanism.  

4. **Backup and Disaster Recovery**  
   - Implement **Velero** for cluster backup and disaster recovery, ensuring data resilience and quick recovery times.  
   - Test backup strategies with regular simulated failures.  

5. **Observability and Monitoring**  
   - Extend monitoring with **Prometheus** and **Grafana** for detailed metrics and alerting.  
   - Integrate **Loki** for log aggregation to centralize application logs.  

6. **CNCF Ecosystem Adoption**  
   - Leverage additional CNCF projects for extended functionality

7. **Continuous Deployment**  
   - Use **ArgoCD** for fully automated and continuous deployment pipelines to ensure quick and reliable updates.  

8. **Cost Optimization**  
   - Implement tools like **Kubecost** for real-time insights into Kubernetes resource costs.  
   - Optimize scaling policies to reduce cloud infrastructure expenses.  

---

## Visual Representations  

Below are the requested images showcasing endpoints:  

### Public Cloud & Index Page  
![Public Cloud & Index Page](https://github.com/user-attachments/assets/c4ed02d0-73a3-4889-9caf-e4e0e6c5dcc9)  

### Docker Check  
![Docker Check](https://github.com/user-attachments/assets/461c9106-fcd6-4f68-a88c-d5a846741019)  

### Secret Word Check  
![Secret Word Check](https://github.com/user-attachments/assets/8cca6d44-a52b-4951-a464-c28f64a6c6e2)  

### Load Balancer Check  
![Load Balancer Check](https://github.com/user-attachments/assets/f73787b8-f01e-42a5-9ba8-b02fc0e2578c)  

### TLS Check  
![TLS Check](https://github.com/user-attachments/assets/80fc2d36-426d-4065-97e0-af212d0e951b)  

---
FAQs

1. I have used self-signed certs as I don't have any valid domain (We can easily register it for free but i avoided as it's just a test project)
### Command Used
To create Certs:
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
   -keyout myapp.key \
   -out myapp.crt \
   -subj "/CN=myapp.local/O=myapp.local"
```
To create Secrets of Certs
```bash
kubectl create secret tls myapp-tls \
  --cert=myapp.crt \
  --key=myapp.key
```

   
