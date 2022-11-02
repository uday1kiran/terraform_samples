resource "aws_redshiftserverless_namespace" "example" {
  namespace_name = "concurrency-scaling"
  ## optional
  admin_username      = "adminuser"
  admin_user_password = "Admin123"
  db_name             = "dbname"
  ##default_iam_role_arn = 
  iam_roles = ["${aws_iam_role.redshift_role.arn}"]
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

}

resource "aws_redshiftserverless_endpoint_access" "example" {
  endpoint_name  = "example"
  workgroup_name = aws_redshiftserverless_workgroup.example.workgroup_name

  #optional
  vpc_security_group_ids = [aws_security_group.redshift_security_group.id]
  #subnet_ids             = [aws_redshift_subnet_group.redshift_subnet_group.id]
  subnet_ids = [aws_subnet.redshift_subnet_1.id, aws_subnet.redshift_subnet_2.id, aws_subnet.redshift_subnet_3.id]
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
# resource "aws_redshift_subnet_group" "redshift_subnet_group" {

#   name = "subnet-group"

#   subnet_ids = ["${aws_subnet.redshift_subnet_1.id}",

#     "${aws_subnet.redshift_subnet_2.id}",
#     "${aws_subnet.redshift_subnet_3.id}"
#   ]

#   tags = {

#     environment = "dev"

#     Name = "subnet-group"

#   }

# }
resource "aws_iam_role_policy" "s3_full_access_policy" {
  name   = "redshift_s3_policy"
  role   = aws_iam_role.redshift_role.id
  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": "s3:*",
           "Resource": "*"
       }
   ]
}
EOF
}
resource "aws_iam_role" "redshift_role" {

  name = "redshift_role"

  assume_role_policy = <<EOF

{

 "Version": "2012-10-17",

 "Statement": [

   {

     "Action": "sts:AssumeRole",

     "Principal": {

       "Service": "redshift.amazonaws.com"

     },

     "Effect": "Allow",

     "Sid": ""

   }

 ]

}

EOF

  tags = {

    tag-key = "redshift-role"

  }

}

# resource "aws_redshift_cluster" "default" {

#   cluster_identifier = var.rs_cluster_identifier

#   database_name = var.rs_database_name

#   master_username = var.rs_master_username

#   master_password = var.rs_master_pass

#   node_type = var.rs_nodetype

#   cluster_type = var.rs_cluster_type

#   cluster_subnet_group_name = aws_redshift_subnet_group.redshift_subnet_group.id

#   skip_final_snapshot = true

#   iam_roles = ["${aws_iam_role.redshift_role.arn}"]

#   depends_on = [

#     "aws_vpc.redshift_vpc",

#     "aws_security_group.redshift_security_group",

#     "aws_redshift_subnet_group.redshift_subnet_group",

#     "aws_iam_role.redshift_role"

#   ]

# }