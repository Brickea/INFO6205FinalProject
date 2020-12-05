resource "aws_route_table" "AVS_alpha_route" {
  vpc_id = aws_vpc.AVS_vpc.id

  route {
    cidr_block = "0.0.0.0/0" // 让 alpha 拥有对外通讯能力
    gateway_id = aws_internet_gateway.AVS_ig.id
  }

  tags = {
    Name = "awesome-virus-simulation alpha route"
  }
}

resource "aws_route_table" "AVS_beta_route" {
  vpc_id = aws_vpc.AVS_vpc.id

  tags = {
    Name = "awesome-virus-simulation beta route"
  }
}

resource "aws_route_table_association" "alpha" {
  // 将子网和路由相关联
  subnet_id      = aws_subnet.AVS_subnet_alpha.id
  route_table_id = aws_route_table.AVS_alpha_route.id
}

resource "aws_route_table_association" "beta" {
  // 将子网和路由相关联
  subnet_id      = aws_subnet.AVS_subnet_beta.id
  route_table_id = aws_route_table.AVS_beta_route.id
}