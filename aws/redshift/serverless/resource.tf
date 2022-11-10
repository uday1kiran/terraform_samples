resource "aws_redshiftserverless_namespace" "example" {
  namespace_name = "concurrency-scaling"
  ## optional
  admin_username      = "adminuser"
  admin_user_password = "Admin123"
  db_name             = "dbname"
  ##default_iam_role_arn = 
  ##iam_roles = ["${aws_iam_role.redshift_role.arn}"]
}

resource "aws_redshiftserverless_workgroup" "example" {
  namespace_name = aws_redshiftserverless_namespace.example.namespace_name
  workgroup_name = "concurrency-scaling"

  #optional
  enhanced_vpc_routing = true
  publicly_accessible  = false
  security_group_ids   = [aws_security_group.redshift_security_group.id]
  #subnet_ids           = [aws_redshift_subnet_group.redshift_subnet_group.id]
  subnet_ids = [aws_subnet.redshift_subnet_1.id, aws_subnet.redshift_subnet_2.id, aws_subnet.redshift_subnet_3.id]
  tags = {

    Name = "redshift-vpc"

  }

}

data "aws_default_tags" "example" {}

resource "aws_ec2_tag" "example" {
  resource_id = aws_redshiftserverless_workgroup.example.endpoint[0].vpc_endpoint[0].vpc_endpoint_id
  key         = "Name"
  value       = "vpc testing tag"
}
resource "aws_ec2_tag" "example1" {
  resource_id = aws_redshiftserverless_workgroup.example.endpoint[0].vpc_endpoint[0].vpc_endpoint_id
  key         = "Name1"
  value       = "vpc testing tag"
}
resource "aws_ec2_tag" "example2" {


  for_each = data.aws_default_tags.example.tags ##{ "Name" : "MyAttachment", "Owner" : "Operations" }

  resource_id = aws_redshiftserverless_workgroup.example.endpoint[0].vpc_endpoint[0].vpc_endpoint_id
  key         = each.key
  value       = each.value


}

resource "aws_vpc" "redshift_vpc" {

  cidr_block = var.vpc_cidr

  instance_tenancy = "default"

  tags = {

    Name = "redshift-vpc"

  }

}

resource "aws_internet_gateway" "redshift_vpc_gw" {

  vpc_id = aws_vpc.redshift_vpc.id

  depends_on = [

    aws_vpc.redshift_vpc

  ]

}

resource "aws_security_group" "redshift_security_group" {

  vpc_id = aws_vpc.redshift_vpc.id

  ingress {

    from_port = 5439

    to_port = 5439

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }


  tags = {

    Name = "redshift-sg"

  }

  depends_on = [

    aws_vpc.redshift_vpc

  ]

}

resource "aws_subnet" "redshift_subnet_1" {

  vpc_id = aws_vpc.redshift_vpc.id

  cidr_block = var.redshift_subnet_cidr_first

  availability_zone = "${var.aws_region}a"

  map_public_ip_on_launch = "true"

  tags = {

    Name = "subnet-1"

  }

  depends_on = [

    aws_vpc.redshift_vpc

  ]

}

resource "aws_subnet" "redshift_subnet_2" {

  vpc_id = aws_vpc.redshift_vpc.id

  cidr_block = var.redshift_subnet_cidr_second

  availability_zone = "${var.aws_region}b"

  map_public_ip_on_launch = "true"

  tags = {

    Name = "subnet-2"

  }

  depends_on = [

    aws_vpc.redshift_vpc

  ]
}

resource "aws_subnet" "redshift_subnet_3" {

  vpc_id = aws_vpc.redshift_vpc.id

  cidr_block = var.redshift_subnet_cidr_third

  availability_zone = "${var.aws_region}c"

  map_public_ip_on_launch = "true"

  tags = {

    Name = "subnet-3"

  }

  depends_on = [

    aws_vpc.redshift_vpc

  ]
}

