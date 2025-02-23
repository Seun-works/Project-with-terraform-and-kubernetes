resource "aws_vpc" "kubernetes_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "kubernetes-project-vpc"
    }
}

resource "aws_internet_gateway" "kubernetes_igw" {
    vpc_id = aws_vpc.kubernetes_vpc.id

    tags = {
        Name = "kubernetes-project-igw"
    }
}

resource "aws_subnet" "kubernetes_subnets" {
    for_each = var.subnets

    vpc_id                  = aws_vpc.kubernetes_vpc.id
    cidr_block              = each.value.cidr_block
    availability_zone       = each.value.availability_zone
    map_public_ip_on_launch = each.value.visibility == "public"

    tags = {
        Name = "kubernetes-project-subnet-${each.value.visibility}"
    }
}

resource "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.kubernetes_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.kubernetes_igw.id
    }
}

resource "aws_route_table_association" "public_subnet" {
    for_each = { for key, value in aws_subnet.kubernetes_subnets : key => value if value.tags["Name"] == "kubernetes-project-subnet-public" }
    subnet_id = each.value.id
    route_table_id = aws_route_table.public_rtb.id
}