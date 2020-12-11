resource "aws_route53_record" "AVS-subdomain" {
    zone_id = var.subdomain_zone_id
    name    = var.subdomain_name
    type    = "A"
    ttl = 300	
    records = [ aws_instance.AVS_ec2_instance.public_ip ]
}