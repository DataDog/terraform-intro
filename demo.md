# Demo
Demo script for Datadog

## Plan
- `terraform env list`
- `terraform env select default`
- `terraform show`
- `terraform output`
- `terraform plan -out=plan.out -var-file=dev.tfvars`

## Apply
- `terraform apply plan.out`
- `terraform show`

## Instance IP for SSH if we want
`aws ec2 describe-instances --instance-ids <IDHERE> --region=us-east-2`

## Make change
TBD

## Switch environment
- `terraform env select test`
- `terraform show`
- `terraform plan -out=plan.out -var-file=test.tfvars`

## Destroy
- `terraform env select default`
- `terraform plan -destroy -out=plan.out -var-file=dev.tfvars`
- `terraform apply plan.out`

## Refresh
If output is stale: `terraform refresh -var-file=dev.tfvars`
