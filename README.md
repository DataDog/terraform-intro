# Terraform Introduction Demo
A demo project for introducting terraform. A short presentation goes with this
code base, [available
here](https://docs.google.com/presentation/d/1L8BQ1ckdRQq1J-3uISvu8icPzTgpkEVlZR0EllCeMz4/edit?usp=sharing).

# Environments
This repo currently uses two environments, they are listed in the sub-sections
below. The "default" environment is utilized as development because it cannot be
removed. [You can read more about the "default" environment by clicking
here](https://www.terraform.io/docs/state/environments.html#using-environments).

## Development ("Default")
Use `terraform env select default` to switch to this environment. The
`dev.tfvars` should be used with this environment when executing terraform
commands, e.g. `terraform plan -var-file=dev.tfvars`. This environment is for
the development team to create a one-for-one likeness with production at a
smaller scale to reduce cost.

## Test
Use `terraform env select test` to switch to this environment. The
`test.tfvars` should be used with this environment when executing terraform
commands, e.g. `terraform plan -var-file=test.tfvars`. This environment is to
be used by QA when promoting changes from development prior to going to
production.

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

# Authors
[Chris Kelner](http://github.com/ckelner)

# License
MIT; see [LICENSE](LICENSE) for details.
