data "template_file" "tag_startstop" {
  template = "rds-${var.name}-StartStop"
}

resource "aws_db_instance" "rds_backend_db" {
  count                   = "${var.backup_name != "" ? 0 : 1}"

//  depends_on              = ["aws_security_group.sg_backend_db"]
  identifier              = "${var.env}-rds-${var.name}"
  allocated_storage       = "${var.allocated_storage}"
  engine                  = "${var.engine}"
  engine_version          = "${var.engine_version}"
  instance_class          = "${var.instance_class}"
  name                    = "${var.name}"
  username                = "${var.username}"
  password                = "${var.password}"
  publicly_accessible     = "${var.publicly_accessible}"

  vpc_security_group_ids  = ["${var.security_group_ids}"]
  parameter_group_name    = "${aws_db_parameter_group.rds_pg.name}"
  db_subnet_group_name    = "${aws_db_subnet_group.sn_group_backend_db.id}"

//  snapshot_identifier = "${var.backup_name}"
  skip_final_snapshot = true

  tags {
    Env         = "${var.env}"
    StartStop   = "${data.template_file.tag_startstop.rendered}"
  }
}

resource "aws_db_instance" "rds_backend_backup" {
  count                   = "${var.backup_name != "" ? 1 : 0}"

  identifier              = "${var.env}-rds-${var.name}"
  engine                  = "${var.engine}"
  engine_version          = "${var.engine_version}"
  instance_class          = "${var.instance_class}"
//  name                    = "${var.name}"
  username                = "${var.username}"
  password                = "${var.password}"
  publicly_accessible     = "${var.publicly_accessible}"

  vpc_security_group_ids  = ["${var.security_group_ids}"]
  parameter_group_name    = "${aws_db_parameter_group.rds_pg.name}"
  db_subnet_group_name    = "${aws_db_subnet_group.sn_group_backend_db.id}"

  snapshot_identifier     = "${var.backup_name}"
  skip_final_snapshot     = true

  tags {
    Env       = "${var.env}"
    StartStop   = "${data.template_file.tag_startstop.rendered}"
  }
}

resource "aws_db_parameter_group" "rds_pg" {
  name = "${var.env}-pg-${var.name}"
  family = "${var.family}"

  parameter {
    name = "timezone"
    value = "America/Lima"
  }

  description = "Parameter group to RDS"
}

resource "aws_db_subnet_group" "sn_group_backend_db" {
  name        = "${var.env}-sng-rds-${var.name}"
  description = "Group of subnets"
  subnet_ids  = ["${var.subnet_ids}"]
}

//resource "aws_security_group" "sg_backend_db" {
//  name        = "${var.env}-sg-rds"
//  description = "Allow all inbound traffic"
//  vpc_id      = "${var.vpc_id}"
//
//  ingress {
//    from_port   = 5432
//    to_port     = 5432
//    protocol    = "TCP"
//    #cidr_blocks = ["${var.cidr_blocks}"]
//    security_groups = ["${var.security_group_access}"]
//  }
//
//  egress {
//    from_port   = 0
//    to_port     = 0
//    protocol    = "-1"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  tags {
//    Name        = "${var.env}-sg-rds"
//    Env         = "${var.env}"
//  }
//}
