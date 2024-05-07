# Coworking Space Service Extension
The Coworking Space Service is a set of APIs that enables users to request one-time tokens and administrators to authorize access to a coworking space. This service follows a microservice pattern and the APIs are split into distinct services that can be deployed and managed independently of one another.

For this project, you are a DevOps engineer who will be collaborating with a team that is building an API for business analysts. The API provides business analysts basic analytics data on user activity in the service. The application they provide you functions as expected locally and you are expected to help build a pipeline to deploy it in Kubernetes.

## Getting Started

### Dependencies
#### Local Environment
1. Python Environment - run Python 3.6+ applications and install Python dependencies via `pip`
2. Docker CLI - build and run Docker images locally
3. `kubectl` - run commands against a Kubernetes cluster

#### Remote Resources
1. AWS CodeBuild - build Docker images remotely
2. AWS ECR - host Docker images
3. Kubernetes Environment with AWS EKS - run applications in k8s
4. AWS CloudWatch - monitor activity and logs in EKS
5. GitHub - pull and clone code

### Setup
1. Set up Cluster & Node Group
2. 
- Ensure the AWS CLI is configured correctly.
```bash
aws sts get-caller-identity
```
- Create Cluster
```bash
eksctl create cluster --name my-cluster --region us-east-1 --nodegroup-name my-nodes --node-type t3.small --nodes 1 --nodes-min 1 --nodes-max 2
aws eks --region us-east-1 update-kubeconfig --name my-cluster
```

2. Configure database and run seed files

- You need to modify these YAML files to make the configurations correct.

```bash
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
kubectl apply -f postgresql-deployment.yaml
kubectl apply -f postgresql-service.yaml
```

- Run seed files:
```bash
kubectl port-forward --namespace default svc/<SERVICE_NAME>-postgresql 5432:5432 &
PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432 < <FILE_NAME.sql>
```

3. Build a Docker file.

- Ensure that the Docker File deployment has enough steps for running applications (requirement library, env args, etc.).
Should make the local test:

```bash
docker build -t test-coworking-analytics .
```
then 
```bash
docker run --network="host" test-coworking-analytics
```

4. Create an AWS CodeBuild

- Create an AWS CodeBuild and link to the Github repo. You should choose the option to trigger auto-deploy when the repo code is changed.

5. Create an AWS ECR.

- Create an AWS ECR to store Docker images.

- After that, make sure your ECR address matches your deployment and Kubectl files.

6. CloudWatch log:
- Make sure CloudWatch Container Insights logs show the logs of the application, which periodically prints the health status of the application.
### Stand Out Suggestions
1. Specify reasonable Memory and CPU allocation in the Kubernetes deployment configuration: Properly configuring resource requests and limits for memory and CPU ensures efficient resource utilization and prevents resource contention in the Kubernetes cluster, enhancing application performance and stability.
2. Specify the best AWS instance type for the application in the README: Recommending the most suitable AWS instance type based on the application's resource requirements and workload characteristics can optimize performance and cost-effectiveness. For instance, if the application has high CPU demand but low memory usage, an instance type with a higher CPU-to-memory ratio like c5 instances might be ideal.
3. Provide cost-saving strategies in the README: Discussing strategies such as leveraging AWS Spot Instances for non-critical workloads, implementing autoscaling based on demand, and optimizing resource utilization through rightsizing can help reduce operational costs while maintaining application performance and scalability. Additionally, highlighting AWS cost management tools like AWS Cost Explorer and AWS Budgets can aid in monitoring and controlling expenses effectively.

### Best Practices
* Dockerfile uses an appropriate base image for the application being deployed. Complex commands in the Dockerfile include a comment describing what it is doing.
* The Docker images use semantic versioning with three numbers separated by dots, e.g. `1.2.1` and  versioning is visible in the  screenshot. See [Semantic Versioning](https://semver.org/) for more details.emantic versioning with three numbers separated by dots, e.g. `1.2.1` and  versioning is visible in the  screenshot. See [Semantic Versioning](https://semver.org/) for more details.