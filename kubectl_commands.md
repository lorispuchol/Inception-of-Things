
# Kubectl Main Commands

## Basic Commands
- `kubectl version` - Show the Kubernetes version.
- `kubectl config` - Modify kubeconfig files.
- `kubectl cluster-info` - Display cluster info.
- `kubectl get` - List resources.
- `kubectl describe` - Show details of a specific resource or group of resources.
- `kubectl create` - Create a resource from a file or stdin.
- `kubectl apply` - Apply a configuration to a resource by filename or stdin.
- `kubectl delete` - Delete resources by filenames, stdin, resources, and names.

## Application Management Commands
- `kubectl rollout` - Manage the rollout of a resource.
  - `kubectl rollout status` - Show the status of the rollout.
  - `kubectl rollout undo` - Roll back to a previous deployment.
- `kubectl scale` - Set a new size for a deployment, replica set, replication controller, or job.
- `kubectl autoscale` - Auto-scale a deployment, replica set, or replication controller.

## Cluster Management Commands
- `kubectl cordon` - Mark a node as unschedulable.
- `kubectl drain` - Drain a node in preparation for maintenance.
- `kubectl taint` - Taint nodes to repel a set of pods.

## Debugging and Troubleshooting Commands
- `kubectl logs` - Print the logs for a container in a pod.
- `kubectl attach` - Attach to a running container in a pod.
- `kubectl exec` - Execute a command in a container.
- `kubectl port-forward` - Forward one or more local ports to a pod.
- `kubectl proxy` - Run a proxy to the Kubernetes API server.
- `kubectl cp` - Copy files and directories to and from containers.
- `kubectl auth` - Inspect authorization.

## Deployment Commands
- `kubectl run` - Run a particular image on the cluster.
- `kubectl expose` - Expose a resource as a new Kubernetes service.

## Configuration and Management Commands
- `kubectl edit` - Edit a resource on the server.
- `kubectl patch` - Update fields of a resource.
- `kubectl label` - Add or update labels on resources.
- `kubectl annotate` - Add or update the annotations on a resource.
- `kubectl config` - Modify kubeconfig files.

## Resource Commands
- `kubectl get` - List one or more resources.
- `kubectl describe` - Show detailed information about a resource.
- `kubectl delete` - Delete resources by filenames, stdin, resources, and names.
- `kubectl replace` - Replace a resource by filename or stdin.
- `kubectl patch` - Update fields of a resource.
- `kubectl label` - Update the labels on a resource.
- `kubectl annotate` - Update the annotations on a resource.

## Namespace Commands
- `kubectl get namespace` - List all namespaces.
- `kubectl create namespace` - Create a new namespace.
- `kubectl delete namespace` - Delete a namespace.

## Resource Types
- `kubectl get pods` - List all pods.
- `kubectl get services` - List all services.
- `kubectl get deployments` - List all deployments.
- `kubectl get nodes` - List all nodes.
- `kubectl get configmaps` - List all config maps.
- `kubectl get secrets` - List all secrets.
- `kubectl get ingresses` - List all ingresses.

## Additional Commands

### Advanced Commands

#### Apply & Create
- `kubectl apply -f <file|url>` - Apply a configuration to a resource.
- `kubectl create -f <file|url>` - Create a resource from a file or URL.
- `kubectl apply set` - Set specific features on objects.
  - `kubectl apply set image` - Update image of a pod template.
  - `kubectl apply set resources` - Update resource requests/limits of a pod template.

#### Edit & Patch
- `kubectl edit <resource>/<name>` - Edit a resource on the server.
- `kubectl patch <resource>/<name> --patch <patch-data>` - Update fields of a resource using strategic merge patch, JSON merge patch, or JSON patch.

#### Deployment Management
- `kubectl rollout history` - View rollout history.
- `kubectl set` - Configure application resources.
  - `kubectl set image` - Update image of a pod template.
  - `kubectl set resources` - Update resource requests/limits of a pod template.
  - `kubectl set selector` - Set selector on an object.

#### Scaling
- `kubectl scale <resource>/<name> --replicas=<number>` - Set a new size for a deployment, replica set, replication controller, or job.
- `kubectl autoscale <resource>/<name> --min=<min> --max=<max> --cpu-percent=<percentage>` - Auto-scale a deployment, replica set, or replication controller.

### Resource Management Commands

#### Secrets
- `kubectl create secret generic <name> --from-literal=<key>=<value>` - Create a generic secret.
- `kubectl create secret docker-registry <name> --docker-username=<username> --docker-password=<password> --docker-email=<email>` - Create a secret for Docker registry.

#### ConfigMaps
- `kubectl create configmap <name> --from-file=<source-file>` - Create a config map from a file.

#### Jobs and CronJobs
- `kubectl create job <name> --image=<image>` - Create a job.
- `kubectl create cronjob <name> --image=<image> --schedule="<cron-schedule>"` - Create a cron job.

#### RBAC (Role-Based Access Control)
- `kubectl create role <name> --verb=<verb> --resource=<resource>` - Create a role.
- `kubectl create clusterrole <name> --verb=<verb> --resource=<resource>` - Create a cluster role.
- `kubectl create rolebinding <name> --role=<role> --user=<user>` - Create a role binding.
- `kubectl create clusterrolebinding <name> --clusterrole=<role> --user=<user>` - Create a cluster role binding.

### Networking

#### Services
- `kubectl expose <resource>/<name> --port=<port> --target-port=<target-port>` - Expose a resource as a new Kubernetes service.
- `kubectl get services` - List all services.
- `kubectl delete service <name>` - Delete a service.

#### Ingress
- `kubectl create ingress <name> --rule="<host>/<path>=<service>:<port>"` - Create an ingress resource.
- `kubectl get ingresses` - List all ingresses.
- `kubectl delete ingress <name>` - Delete an ingress.

### Cluster Operations

#### Nodes
- `kubectl get nodes` - List all nodes.
- `kubectl describe node <name>` - Show details of a node.
- `kubectl drain <node-name>` - Drain a node in preparation for maintenance.
- `kubectl cordon <node-name>` - Mark a node as unschedulable.
- `kubectl uncordon <node-name>` - Mark a node as schedulable.

#### Persistent Volumes (PVs) and Persistent Volume Claims (PVCs)
- `kubectl get pv` - List all persistent volumes.
- `kubectl get pvc` - List all persistent volume claims.
- `kubectl describe pv <name>` - Show details of a persistent volume.
- `kubectl describe pvc <name>` - Show details of a persistent volume claim.

#### Storage Classes
- `kubectl get storageclass` - List all storage classes.
- `kubectl describe storageclass <name>` - Show details of a storage class.

### Utility Commands

#### Labels and Annotations
- `kubectl label <resource>/<name> <label-key>=<label-value>` - Add or update a label on a resource.
- `kubectl annotate <resource>/<name> <annotation-key>=<annotation-value>` - Add or update an annotation on a resource.

#### Events
- `kubectl get events` - List all events in the namespace.
- `kubectl get events --all-namespaces` - List all events across all namespaces.

#### Resource Quotas
- `kubectl create quota <name> --hard=<resource>=<value>` - Create a resource quota.
- `kubectl get quota` - List resource quotas.
- `kubectl describe quota <name>` - Show details of a resource quota.

#### Limits
- `kubectl create limitrange <name> --default=<resource>=<value>` - Create a limit range.
- `kubectl get limitrange` - List limit ranges.
- `kubectl describe limitrange <name>` - Show details of a limit range.

### Resource Shortcuts

#### Pods
- `kubectl get pods` or `kubectl get po`
- `kubectl delete pods` or `kubectl delete po`

#### Services
- `kubectl get services` or `kubectl get svc`
- `kubectl delete services` or `kubectl delete svc`

#### Replication Controllers
- `kubectl get replicationcontrollers` or `kubectl get rc`
- `kubectl delete replicationcontrollers` or `kubectl delete rc`

#### Deployments
- `kubectl get deployments` or `kubectl get deploy`
- `kubectl delete deployments` or `kubectl delete deploy`


#### Common Flags
- `-o` - Output format (`json`, `yaml`, `wide`, `name`).
- `--watch` - Watch for changes.
- `--selector` - Filter resources by label.
- `--namespace` - Specify a namespace.
- `-f` - Filename or directory.
- `--all` - Select all resources or nodes.
- `--edit` - Edit the resource before creating.
- `--record` - Record current kubectl command in the resource annotation.
- `--dry-run` - Only print the object that would be sent.
- `-i` - Stdin.
- `-t` - Tty.
- `--previous` - Print the logs for the previous instance of the container.
- `--ignore-daemonsets` - Ignore daemonsets.
- `--delete-local-data` - Delete local data.
- `--force` - Force drain.
- `--overwrite` - Overwrite existing label, taint, or annotation.
- `--replicas` - Number of replicas.
- `--min` - Min replicas.
- `--max` - Max replicas.
- `--cpu-percent` - Target average CPU utilization.
- `--image` - Image to run.
- `--port` - Port to expose.
- `--target-port` - Target port.
- `--type` - Service type (`ClusterIP`, `NodePort`, `LoadBalancer`, `ExternalName`).
- `-p` - Patch data.
- `--type` - Patch type (`json`, `merge`, `strategic`).
- `--context` - Specify a context to use.
- `--address` - Addresses to listen on.
- `--previous` - Print the logs for the previous instance of the container.
- `--short` - Display version information in a short format.