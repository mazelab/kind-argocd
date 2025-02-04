.PHONY: create-dirs

create-dirs:
	mkdir -p $(shell echo $$HOME)/.kindpro/data

create-cluster: create-dirs ## (re)create a test cluster with kind
	@./scripts/create_cluster.sh

recreate-cluster: clean create-cluster ## delete and create a test cluster with kind

start: ## start the test cluster
	@docker start kind-control-plane kind-worker2 kind-worker 
	@echo "Cluster started"

stop: ## stop the test cluster
	@docker stop kind-worker2 kind-worker kind-control-plane
	@echo "Cluster stopped"
	
clean: ## delete the test cluster
	@kind delete cluster
	@echo "Cluster deleted"   

reinstall-argocd:
	@helm install argo-cd charts/argo-cd/

get-initial-argo-password:
	kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
