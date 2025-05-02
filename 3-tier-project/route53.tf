# Route traffic to frontend (www.hepin.site)
resource "aws_route53_record" "frontend" {
  zone_id = "Z0144096352SNKIKOAZYU"    
  name    = "www.hepin.site"
  type    = "A"

  alias {
    name                   = aws_lb.my-frontend.dns_name
    zone_id                = aws_lb.my-frontend.zone_id
    evaluate_target_health = true
  }
}

# Route traffic to backend (hepin.site)
resource "aws_route53_record" "backend" {
  zone_id = "Z0144096352SNKIKOAZYU"    
  name    = "hepin.site"
  type    = "A"

  alias {
    name                   = aws_lb.my-backend.dns_name
    zone_id                = aws_lb.my-backend.zone_id
    evaluate_target_health = true
  }
}
