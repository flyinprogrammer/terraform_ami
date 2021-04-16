apply:
	terraform apply tfplan
clean:
	rm -rf .terraform tfplan
destroy:
	terraform destroy
fmt:
	terraform fmt -recursive .
get:
	terraform get -update
init:
	terraform init
plan:
	terraform plan -out tfplan
upgrade:
	terraform init -upgrade=true

get_key:
	rm -f tmp_keypair.pem
	terraform output -raw private_keypair > tmp_keypair.pem
	chmod 400 tmp_keypair.pem
