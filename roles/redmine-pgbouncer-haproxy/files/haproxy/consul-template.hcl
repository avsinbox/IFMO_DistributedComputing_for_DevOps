consul {
  address = "127.0.0.1:8500"
}

template {
  source      = "/consul-template/config/haproxy.ctmpl"
  destination = "/usr/local/etc/haproxy/haproxy.cfg"
  command     = "kill -12 $(cat /var/run/haproxy/haproxy.pid)"
  perms       = 0644
}
