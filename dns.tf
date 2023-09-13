resource "cloudflare_record" "frontend" {
  name    = "coco"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "cname.vercel-dns.com"
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "backend" {
  name    = "api.coco"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = azurerm_public_ip.public_ip.ip_address
  zone_id = var.cloudflare_zone_id
}
