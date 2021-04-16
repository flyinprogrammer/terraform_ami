build:
	packer build -only=amazon-ebs.amd64 amzn2.pkr.hcl

build-debug:
	packer build -debug -only=amazon-ebs.amd64 amzn2.pkr.hcl

build-vagrant:
	packer build -only=vagrant.local amzn2.pkr.hcl

clean:
	rm -rf output-local