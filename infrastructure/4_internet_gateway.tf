resource "aws_internet_gateway" "AVS-ig" {
  vpc_id = aws_vpc.AVS-vpc.id

  tags = {
    Name = "awesome-virus-simulation gateway"
  }
}