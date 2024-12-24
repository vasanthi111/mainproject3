resource "aws_instance" "public_subnet_instance" {
  ami           = "ami-005fc0f236362e99f"  # Use the correct AMI ID
  instance_type = "t2.micro"
  key_name      = "ec1"  # Use an existing key pair

  # Use local-exec to run the script on instance creation
  user_data = <<-EOF
              #!/bin/bash
              # Update the package list
              sudo apt update -y

              # Install Git and Python3-pip
              sudo apt install git -y
              sudo apt install python3-pip -y

              # Clone the repository (adjust the repository URL if necessary)
              cd /home/ubuntu/
              git clone https://github.com/vasanthi111/USA-Housing.git

              # Navigate to the cloned repository
              cd /home/ubuntu/USA-Housing

              # Create a virtual environment (optional but recommended)
              python3 -m venv venv

              # Activate the virtual environment
              source venv/bin/activate

              # Install the required Python packages inside the virtual environment
              pip install -r requirements.txt

              # Run the Python application in the background using screen
              screen -m -d python3 ./app.py

              # Deactivate the virtual environment (optional)
              deactivate
              EOF

  # Associate the security group with the instance
  security_group = aws_security_group.demosg.id

  # Associate the subnet with the instance
  subnet_id = aws_subnet.public_subnet-1.id

  tags = {
    Name = "PublicSubnetAppInstance"
  }
}

