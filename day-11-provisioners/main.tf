

resource "aws_key_pair" "example" {
  key_name   = "task" # Replace with your desired key name
  public_key = file("~/.ssh/id_ed25519.pub")


}
resource "aws_instance" "server" {
  ami           = "ami-0261755bbcb8c4a84"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example.key_name


  connection {
    type = "ssh"
    user = "ubuntu" # Replace with the appropriate username for your EC2 instance
    private_key = file("C:/Users/AMIPARA HEPIN/.ssh/id_ed25519")
    # private_key = file("~/.ssh/id_rsa") #private key path
    host        = self.public_ip
  }
  # local execution procee 

  provisioner "local-exec" {
    command = "touch file200"
  }
  # File provisioner to copy a file from local to the remote EC2 instance

  provisioner "file" {
    source      = "myfile"                  # Replace with the path to your local file
    destination = "/home/ubuntu/fileremote" # Replace with the path on the remote instance
  }
  # remote execution process 

  provisioner "remote-exec" {
    inline = ["touch fileremote",
    "echo hello from server >> fileremote"]
  }
}
