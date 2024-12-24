resource "aws_internet_gateway" "demogateway_route" {
  vpc_id = aws_vpc.demovpc.id  # Reference the VPC
  tags = {
    Name = "Internet Gateway for Route"
  }
}

