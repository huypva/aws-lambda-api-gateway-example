hello:
	@echo "Hello, World"

build:
	@printf "Building the application!\n"
	@mvn clean package
	@if [ $$? -ne 0 ]; then \
	printf "Java application build failed! No new Lambda Function will be deployed!!!i\n"; \
	exit -1;\
	fi;

deploy:
	@echo "Deploying the Terraform!"
	@terraform -chdir="terraform/" init
	@terraform -chdir="terraform/" apply -auto-approve

destroy:
	@echo "Destroying the Terraform!"
	@terraform -chdir="terraform/" destroy -auto-approve

apply: build deploy

clean:
	@mvn clean
	@(cd terraform && terraform state rm )