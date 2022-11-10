provider "aws" {

  #profile = var.profile

  region = var.aws_region

  default_tags {
    tags = {
      "username" = "terraform",
      "password" = "terraform"
    }
  }

}
