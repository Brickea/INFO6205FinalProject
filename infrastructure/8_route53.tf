resource "aws_route53_record" "AVS-subdomain" {
    zone_id = var.subdomain_zone_id
    name    = var.subdomain_name
    type    = "A"

    records = [ aws_instance.AVS-ec2-instance.public_ip ]
}