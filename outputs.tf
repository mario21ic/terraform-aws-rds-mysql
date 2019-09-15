output "db_id" {
  value = "${aws_db_instance.rds_backend_db.*.id}"
}

output "db_address" {
  value = "${aws_db_instance.rds_backend_db.*.address}"
}

output "backup_id" {
  value = "${aws_db_instance.rds_backend_backup.*.id}"
}

output "backup_address" {
  value = "${aws_db_instance.rds_backend_backup.*.address}"
}

output "subnet_group" {
  value = "${aws_db_subnet_group.sn_group_backend_db.name}"
}

output "tag_startstop" {
  value = "${data.template_file.tag_startstop.rendered}"
}