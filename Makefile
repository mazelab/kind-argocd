cluster: ## (re)create a test cluster with kind
	kind delete cluster 
	kind create cluster --config kind-config.yaml
# install contour	
	@kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
	@kubectl wait --namespace ingress-nginx  --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s
	@kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
	@helm install argo-cd charts/argo-cd/

stop: ## stop the test cluster
	@docker stop kind-worker2 kind-worker kind-control-plan
	@echo "Cluster stopped"
	
clean: ## delete the test cluster
	@kind delete cluster
	@echo "Cluster deleted"   

argopass:
	kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
