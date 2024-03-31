locals {
  defaults = ["bog-reaper.com.ng", "terraform-test"]
}

resource "aws_route53_zone" "domain" {
  name = local.defaults[0]

  tags = {
    Name = local.defaults[0]
  }
}

resource "aws_route53_record" "subdomain" {
  zone_id = aws_route53_zone.domain.zone_id
  name    = "${local.defaults[1]}.${aws_route53_zone.domain.name}"
  type    = "CNAME"
  ttl     = "5"
  records = ["${aws_lb.webServerALB.dns_name}"]
}