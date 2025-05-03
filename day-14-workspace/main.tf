#A Terraform workspace is a way to manage multiple copies of the same infrastructure (e.g., dev, test, prod) using the same codebase.
# Subcommands:
#     delete    Delete a workspace
#     list      List Workspaces
#     new       Create a new workspace
#     select    Select a workspace
#     show      Show the name of the current workspace
# terraform workspace select dev
# terraform workspace list

resource "aws_instance" "name" {
  ami           = "ami-00a929b66ed6e0de6"
  instance_type = "t2.micro"
}
