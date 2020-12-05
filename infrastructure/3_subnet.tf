resource "aws_subnet" "AVS_subnet_alpha" {
  vpc_id     = aws_vpc.AVS_vpc.id
  cidr_block = "10.0.0.0/17"

  tags = {
    Name = "awesome-virus-simulation Subnet alpha"
  }
}

resource "aws_subnet" "AVS_subnet_beta" {
  vpc_id     = aws_vpc.AVS_vpc.id
  cidr_block = "10.0.128.0/17"

  tags = {
    Name = "awesome-virus-simulation Subnet beta"
  }
}