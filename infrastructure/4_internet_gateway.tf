resource "aws_internet_gateway" "AVS_ig" {
  vpc_id = aws_vpc.AVS_vpc.id

  tags = {
    Name = "awesome-virus-simulation gateway"
  }
}