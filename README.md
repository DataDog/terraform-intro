# Terraform Introduction Demo
A demo project for introducing terraform.

# NOTE
This repo doesn't use a [Terraform
Backend](https://www.terraform.io/docs/backends/state.html) which is generally
a good practice. This repo is for DEMO purposes only.

For Datadog employees, you'll need to have
`[aws-vault](https://github.com/99designs/aws-vault)` configured to provision
AWS resources.

# Workspaces
This repo expects [Terraform
Workspaces](https://www.terraform.io/docs/state/workspaces.html) to be used.
See the [example.tfvars](/.example.tfvars) file for workspace based variable
definitions that are expected. For the purposes of this document, the workspace
name and filename used for will be `default`.

## Development ("Default")
Use `terraform env select default` to switch to this environment. The
`default.tfvars` should be used with this environment when executing terraform
commands, e.g. `terraform plan -var-file=dev.tfvars`. This environment is for
the development team to create a one-for-one likeness with production at a
smaller scale to reduce cost.

# Usage
For a quick rough script for the demo, please look at [demo.md](demo.md); below
are instructions on how to work with this terraform configuration template.

- Switch into the environment you want to create, update, or destroy
infrastructure for, e.g. `terraform env select default`. A list of environments
can be made available by typing `terraform env list`. *Remember* `default` is
the development environment, see the [Development
("Default")](#development-default) section for details.
- Execute `terraform get` to download any modules that are being used in the
configuration.
- Execute `terraform plan -out=plan.out -var-file=<env>.tfvars` - be sure to use
the right `<env>.tfvars` file; see the [Environments](#environments) section for
more details.
- When you are comfortable with the plan output, you can run `terraform apply
plan.out` which will apply the plan from the previous step. The variable file
does not need to be supplied again, it is built into the plan output.
- To destroy infrastructure simply run `terraform destroy -var-file=dev.tfvars`
though there are times where you may want to plan a destroy first. To do so,
add the `-destroy` flag to `terraform plan` and then `apply` the destroy plan.
# License
MIT; see [LICENSE](LICENSE) for details.
