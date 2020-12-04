resource "aws_subnet" "AVS-subnet-alpha" {
  vpc_id     = aws_vpc.AVS-vpc.id
  cidr_block = "10.0.0.0/17"

  tags = {
    Name = "awesome-virus-simulation Subnet alpha"
  }
}

resource "aws_subnet" "AVS-subnet-beta" {
  vpc_id     = aws_vpc.AVS-vpc.id
  cidr_block = "10.0.128.0/17"

  tags = {
    Name = "awesome-virus-simulation Subnet beta"
  }
}