# Demo
Demo script - WIP

## Plan
- `terraform workspace list`
- `terraform workspace select default`
- `terraform init`
- `terraform show`
- `terraform output`
- `terraform plan -out=plan.out -var-file=default.tfvars`

## Apply
- `terraform apply plan.out`
- `terraform show`

## Make change
TBD

## Switch environment
- `terraform workspace select test`
- `terraform show`
- `terraform plan -out=plan.out -var-file=test.tfvars`

## Destroy
- `terraform workspace select default`
- `terraform plan -destroy -out=plan.out -var-file=default.tfvars`
- `terraform apply plan.out`

## Refresh
If output is stale: `terraform refresh -var-file=default.tfvars`
