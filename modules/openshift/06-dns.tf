//  Notes: We could make the internal domain a variable, but not sure it is
//  really necessary.

//  Create the internal DNS.
resource "aws_route53_zone" "internal" {
  name = "openshift.local"
  comment = "OpenShift Cluster Internal DNS"
  vpc_id = "${aws_vpc.openshift.id}"
  tags {
    Name    = "OpenShift Internal DNS"
    Project = "openshift"
  }
}

//  DNS for 'masters', 'infras', 'loggings', 'metrics', 'nodes'.
resource "aws_route53_record" "master1-a-record" {
    zone_id = "${aws_route53_zone.internal.zone_id}"
    name = "master1.openshift.local"
    type = "A"
    ttl  = 300
    records = [
        "${aws_instance.master1.private_ip}"
    ]
}
resource "aws_route53_record" "master2-a-record" {
    zone_id = "${aws_route53_zone.internal.zone_id}"
    name = "master2.openshift.local"
    type = "A"
    ttl  = 300
    records = [
        "${aws_instance.master2.private_ip}"
    ]
}
resource "aws_route53_record" "master3-a-record" {
    zone_id = "${aws_route53_zone.internal.zone_id}"
    name = "master3.openshift.local"
    type = "A"
    ttl  = 300
    records = [
        "${aws_instance.master3.private_ip}"
    ]
}
resource "aws_route53_record" "infra1-a-record" {
    zone_id = "${aws_route53_zone.internal.zone_id}"
    name = "infra1.openshift.local"
    type = "A"
    ttl  = 300
    records = [
        "${aws_instance.infra1.private_ip}"
    ]
}
resource "aws_route53_record" "infra2-a-record" {
    zone_id = "${aws_route53_zone.internal.zone_id}"
    name = "infra2.openshift.local"
    type = "A"
    ttl  = 300
    records = [
        "${aws_instance.infra2.private_ip}"
    ]
}
resource "aws_route53_record" "logging1-a-record" {
    zone_id = "${aws_route53_zone.internal.zone_id}"
    name = "logging1.openshift.local"
    type = "A"
    ttl  = 300
    records = [
        "${aws_instance.logging1.private_ip}"
    ]
}
resource "aws_route53_record" "metric1-a-record" {
    zone_id = "${aws_route53_zone.internal.zone_id}"
    name = "metric1.openshift.local"
    type = "A"
    ttl  = 300
    records = [
        "${aws_instance.metric1.private_ip}"
    ]
}
resource "aws_route53_record" "node1-a-record" {
    zone_id = "${aws_route53_zone.internal.zone_id}"
    name = "node1.openshift.local"
    type = "A"
    ttl  = 300
    records = [
        "${aws_instance.node1.private_ip}"
    ]
}
resource "aws_route53_record" "node2-a-record" {
    zone_id = "${aws_route53_zone.internal.zone_id}"
    name = "node2.openshift.local"
    type = "A"
    ttl  = 300
    records = [
        "${aws_instance.node2.private_ip}"
    ]
}
//  DNS for Load Balancers
resource "aws_route53_record" "lb-master-a-record" {
    zone_id = "${aws_route53_zone.internal.zone_id}"
    name = "openshift-master.openshift.local"
    type = "A"

    alias {
      name = "${aws_lb.ocp-master-ingress-lb.dns_name}"
      zone_id = "${aws_lb.ocp-master-ingress-lb.zone_id}"
      evaluate_target_health = true
  }
}
resource "aws_route53_record" "lb-infra-a-record" {
    zone_id = "${aws_route53_zone.internal.zone_id}"
    name = "*.apps.openshift.local"
    type = "A"

     alias {
       name = "${aws_lb.ocp-infra-ingress-lb.dns_name}"
       zone_id = "${aws_lb.ocp-infra-ingress-lb.zone_id}"
       evaluate_target_health = true
  }
}
