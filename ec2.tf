resource "aws_instance" "public_subnet-1" {
ami="ami-005fc0f236362e99f"
instance_type="t2.micro"
count=1
key_name="ec1"
vpc_security_group_ids=["${aws_security_group.demosg.id}"]
subnet_id="${aws_subnet.public_subnet-1.id}"
associate_public_ip_address=true
user_data="${file("data.sh")}"
tags={
Name="My public Instance 1 "
}
}

resource "aws_security_group" "demosg" {
vpc_id="${aws_vpc.demovpc.id}"

ingress{
from_port=80
to_port=80
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

ingress{
from_port=8080
to_port=8080
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

ingress{
from_port=7000
to_port=7000
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

ingress{
from_port=22
to_port=22
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

egress{
from_port=0
to_port=0
protocol="-1"
cidr_blocks=["0.0.0.0/0"]
}
tags={
Name="WEB SG"
}
}
