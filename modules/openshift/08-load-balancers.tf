// Setup for the Load Balancers
resource "aws_lb" "ocp-master-ingress-lb" {
  name                       = "ocp-master-ingress-lb"
  enable_deletion_protection = "false"
  internal                   = "false"
  ip_address_type            = "ipv4"
  load_balancer_type         = "network"
  subnets                    = ["${aws_subnet.public-subnet.id}"]
}

resource "aws_lb" "ocp-infra-ingress-lb" {
  name                       = "ocp-infra-ingress-lb"
  enable_deletion_protection = "false"
  internal                   = "false"
  ip_address_type            = "ipv4"
  load_balancer_type         = "network"
  subnets                    = ["${aws_subnet.public-subnet.id}"]
}

// Setup the Target Groups for the Load Balancers
resource "aws_lb_target_group" "ocp-master-ingress-8443-tg" {
  name        = "ocp-master-ingress-8443-tg"
  port        = 8443
  protocol    = "TCP"
  vpc_id      = "${aws_vpc.openshift.id}"
  target_type = "instance"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    port                = "traffic-port"
    protocol            = "TCP"
    unhealthy_threshold = "3"
  }
}

resource "aws_lb_target_group" "ocp-infra-ingress-443-tg" {
  name        = "ocp-infra-ingress-443-tg"
  port        = 443
  protocol    = "TCP"
  vpc_id      = "${aws_vpc.openshift.id}"
  target_type = "instance"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    port                = "traffic-port"
    protocol            = "TCP"
    unhealthy_threshold = "3"
  }
}

resource "aws_lb_target_group" "ocp-infra-ingress-80-tg" {
  name        = "ocp-infra-ingress-80-tg"
  port        = 80
  protocol    = "TCP"
  vpc_id      = "${aws_vpc.openshift.id}"
  target_type = "instance"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    port                = "traffic-port"
    protocol            = "TCP"
    unhealthy_threshold = "3"
  }
}

// Setup the Listener for the Load Balancers
resource "aws_lb_listener" "ocp-master-ingress-8443-lb-lst" {
  load_balancer_arn = "${aws_lb.ocp-master-ingress-lb.arn}"
  port              = "8443"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.ocp-master-ingress-8443-tg.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "ocp-infra-ingress-443-lb-lst" {
  load_balancer_arn = "${aws_lb.ocp-infra-ingress-lb.arn}"
  port              = "443"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.ocp-infra-ingress-443-tg.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "ocp-infra-ingress-80-lb-lst" {
  load_balancer_arn = "${aws_lb.ocp-infra-ingress-lb.arn}"
  port              = "80"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${aws_lb_target_group.ocp-infra-ingress-80-tg.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "ocp-master-ingress-8443-lb-tga1" {
  target_group_arn = "${aws_lb_target_group.ocp-master-ingress-8443-tg.arn}"
  target_id        = "${aws_instance.master.id}"
  port             = 8443
}

resource "aws_lb_target_group_attachment" "ocp-infra-ingress-443-lb-tga1" {
  target_group_arn = "${aws_lb_target_group.ocp-infra-ingress-443-tg.arn}"
  target_id        = "${aws_instance.infra.id}"
  port             = 443
}

resource "aws_lb_target_group_attachment" "ocp-infra-ingress-80-lb-tga1" {
  target_group_arn = "${aws_lb_target_group.ocp-infra-ingress-80-tg.arn}"
  target_id        = "${aws_instance.infra.id}"
  port             = 80
}
