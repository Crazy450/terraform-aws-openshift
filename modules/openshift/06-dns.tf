//  Notes: We could make the internal domain a variable, but not sure it is
//  really necessary.

//  Create the internal DNS.
resource "aws_route53_zone" "internal" {
  name    = "openshift.local"
  comment = "OpenShift Cluster Internal DNS"
  vpc_id  = "${aws_vpc.openshift.id}"

  tags {
    Name    = "OpenShift Internal DNS"
    Project = "openshift"
  }
}

//  DNS for 'masters', 'infras', 'loggings', 'metrics', 'nodes', 'lb'.
resource "aws_route53_record" "master-a-record" {
  // same number of records as instances
  count   = "3"
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "master00${count.index}.openshift.local"
  type    = "A"
  ttl     = "300"

  // matches up record N to instance N
  records = ["${element(aws_instance.master.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "infra-a-record" {
  // same number of records as instances
  count   = "2"
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "infra00${count.index}.openshift.local"
  type    = "A"
  ttl     = "300"

  // matches up record N to instance N
  records = ["${element(aws_instance.infra.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "logging-a-record" {
  // same number of records as instances
  count   = "1"
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "logging00${count.index}.openshift.local"
  type    = "A"
  ttl     = "300"

  // matches up record N to instance N
  records = ["${element(aws_instance.logging.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "metric-a-record" {
  // same number of records as instances
  count   = "1"
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "metric00${count.index}.openshift.local"
  type    = "A"
  ttl     = "300"

  // matches up record N to instance N
  records = ["${element(aws_instance.metric.*.private_ip, count.index)}"]
}

resource "aws_route53_record" "node-a-record" {
  // same number of records as instances
  count   = "2"
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "node00${count.index}.openshift.local"
  type    = "A"
  ttl     = "300"

  // matches up record N to instance N
  records = ["${element(aws_instance.node.*.private_ip, count.index)}"]
}

//  DNS for Load Balancers
resource "aws_route53_record" "lb-master-a-record" {
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "openshift-master.openshift.local"
  type    = "A"

  alias {
    name                   = "${aws_lb.ocp-master-ingress-lb.dns_name}"
    zone_id                = "${aws_lb.ocp-master-ingress-lb.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "lb-infra-a-record" {
  zone_id = "${aws_route53_zone.internal.zone_id}"
  name    = "*.apps.openshift.local"
  type    = "A"

  alias {
    name                   = "${aws_lb.ocp-infra-ingress-lb.dns_name}"
    zone_id                = "${aws_lb.ocp-infra-ingress-lb.zone_id}"
    evaluate_target_health = true
  }
}
