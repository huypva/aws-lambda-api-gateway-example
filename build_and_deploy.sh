printf '\n\nBuilding the Java Lambda Function!\n\n'
cd hello-world
mvn clean package
if [ $? -ne 0 ]; then
  printf '\n\nJava application build failed! No new Lambda Function will be deployed!!!i\n'
  exit -1
fi
cd ..

printf '\n\nStarting the Terraform!\n\n'
cd terraform
terraform init
terraform plan -out=plan.out
terraform apply plan.out
cd ..