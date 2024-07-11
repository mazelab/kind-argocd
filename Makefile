cluster: ## (re)create a test cluster with kind
	kind delete cluster 
	kind create cluster --config kind-config.yaml
# install contour	
	@kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
	@kubectl wait --namespace ingress-nginx  --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s
	@kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml

clean: ## delete the test cluster
	@kind delete cluster
	@echo "Cluster deleted"   