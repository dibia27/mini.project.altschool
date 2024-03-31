locals {
  name = ["webServerTG", "HTTP", "instance", "webServerALB", "application", "webServerTGListener"]
}

resource "aws_lb_target_group" "webServerTG" {
  name        = local.name[0]
  port        = 80
  protocol    = local.name[1]
  vpc_id      = aws_vpc.webVPC.id
  target_type = local.name[2]
  health_check {
    path     = "/"
    protocol = local.name[1]
  }

  tags = {
    Name = local.name[0]
  }
}

resource "aws_lb_target_group_attachment" "webServerTG" {
  count            = length(aws_instance.webServer)
  target_group_arn = aws_lb_target_group.webServerTG.arn
  target_id        = aws_instance.webServer[count.index].id
  port             = 80
}

resource "aws_lb" "webServerALB" {
  name               = local.name[3]
  internal           = false
  load_balancer_type = local.name[4]
  security_groups    = [aws_security_group.webServerPubSG.id]
  ip_address_type    = "ipv4"
  subnets            = [aws_subnet.webPubSunet1.id, aws_subnet.webPubSunet2.id, aws_subnet.webPubSunet3.id]

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_listener" "webServerTGListener" {
  load_balancer_arn = aws_lb.webServerALB.arn
  port              = "80"
  protocol          = local.name[1]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webServerTG.arn
  }

  tags = {
    Name = local.name[5]
  }
}