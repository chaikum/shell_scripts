provider "aws"{
    region="us-east-2"
    access_key="AKIAZDC5NTNFDJEGXIL5"
    secret_key="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"
}


resource "aws_vpc" "Green_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Green_vpc"
  }
}
resource "aws_subnet" "Green_subnet-1" {
    vpc_id = "${aws_vpc.Green_vpc.id}"
    cidr_block = "10.0.10.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-2a"
    tags = {
        Name = "Green_subnet-1"
    }
}
resource "aws_subnet" "Green_subnet-2" {
    vpc_id = "${aws_vpc.Green_vpc.id}"
    cidr_block = "10.0.20.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-2b"
    tags = {
        Name = "Green_subnet-2"
    }
}
resource "aws_subnet" "Green_subnet-3" {
    vpc_id = "${aws_vpc.Green_vpc.id}"
    cidr_block = "10.0.30.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-2c"
    tags = {
        Name = "Green_subnet-3"
    }
}

resource "aws_internet_gateway" "green_gate_way" {
  vpc_id = "${aws_vpc.Green_vpc.id}"

  tags = {
    Name = "green_gate_way"
  }
}
resource "aws_route_table" "Green_route_table" {
    vpc_id =  aws_vpc.Green_vpc.id
         route {
    cidr_block = "0.0.0.0/0"               
    gateway_id = aws_internet_gateway.green_gate_way.id      
     }
    tags = {
    Name = "green_route_table"
  }
}

resource "aws_route_table_association" "green_subnet_associations-1" {
    subnet_id = aws_subnet.Green_subnet-1.id
    route_table_id = aws_route_table.Green_route_table.id
}
resource "aws_route_table_association" "green_subnet_associations-2" {
    subnet_id = aws_subnet.Green_subnet-2.id
    route_table_id = aws_route_table.Green_route_table.id
}
resource "aws_route_table_association" "green_subnet_associations-3" {
    subnet_id = aws_subnet.Green_subnet-3.id
    route_table_id = aws_route_table.Green_route_table.id
}



resource "aws_security_group" "allow_traffic" {
  name        = "allow_traffic"
  description = "Allow Traffic inbound traffic"
  vpc_id      = aws_vpc.Green_vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "green_security_group"
  }
}

resource "aws_instance" "first_server" {
  ami           = "ami-0fb653ca2d3203ac1"
  count = 3
  instance_type = "t2.micro"
  subnet_id = aws_subnet.Green_subnet-1.id
  availability_zone = "us-east-2a"
  key_name = "main-key"
  vpc_security_group_ids = [aws_security_group.allow_traffic.id]
  user_data = <<EOF
#!/bin/bash
su ubuntu -c "git clone git@github.com:chaikum/shell_scripts.git"
EOF


  tags = {
    Name = "ubuntu-${count.index + 1}"
  }
}
