resource "aws_route_table" "AVS-alpha-route" {
  vpc_id = aws_vpc.AVS-vpc.id

  route {
    cidr_block = "0.0.0.0/0" // 让 alpha 拥有对外通讯能力
    gateway_id = aws_internet_gateway.AVS-ig.id
  }

  tags = {
    Name = "awesome-virus-simulation alpha route"
  }
}

resource "aws_route_table" "AVS-beta-route" {
  vpc_id = aws_vpc.AVS-vpc.id

  tags = {
    Name = "awesome-virus-simulation beta route"
  }
}

resource "aws_route_table_association" "alpha" {
  // 将子网和路由相关联
  subnet_id      = aws_subnet.AVS-subnet-alpha.id
  route_table_id = aws_route_table.AVS-alpha-route.id
}

resource "aws_route_table_association" "beta" {
  // 将子网和路由相关联
  subnet_id      = aws_subnet.AVS-subnet-beta.id
  route_table_id = aws_route_table.AVS-beta-route.id
}