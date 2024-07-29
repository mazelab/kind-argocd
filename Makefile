create-cluster: ## (re)create a test cluster with kind
	kind create cluster --config kind-config.yaml
	@kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
	@kubectl wait --namespace ingress-nginx  --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s
	@helm repo add argo-cd https://argoproj.github.io/argo-helm
	@helm repo update
	@helm dep update charts/argo-cd/
	@helm install argo-cd charts/argo-cd/

recreate-cluster: clean create-cluster ## delete and create a test cluster with kind

start: ## start the test cluster
	@docker start kind-worker2 kind-worker kind-control-plan
	@echo "Cluster started"

stop: ## stop the test cluster
	@docker stop kind-worker2 kind-worker kind-control-plan
	@echo "Cluster stopped"
	
clean: ## delete the test cluster
	@kind delete cluster
	@echo "Cluster deleted"   

reinstall-argocd:
	@helm install argo-cd charts/argo-cd/

get-initial-argo-password:
	kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
