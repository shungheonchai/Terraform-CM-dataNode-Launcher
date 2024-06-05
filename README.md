# Terraform-CM-dataNode-Launcher
Launch a 3 node replica set of mongoD's and install agents to them to appear on CM automatically.

You may need terraform and AWS CLI to make this work. If using a MacOS, use Homebrew to install

Delete the .example from the terraform.tfvars.example and fill out your custom environment variables. Look out for the {ChangeHereRemoveBracket}. It means to put the data in there and delete the curly braces. Currently I'm retrieving the AWS access key, secret key, and the session key from the AWS Solution-Architect.User (federated user) access portal which keeps changing every 30-60 min or so. This may need to be edited so that a single permanent user is able to run this.

Once the terraform.tfvars is ready, then just run the 3 lines below on the terminal.
```
terraform init
terraform plan
terraform apply
```

When finished with everything you may allow the reaper to work its magic with the date you specified or run the terraform code below to delete

```
terraform destroy
```
