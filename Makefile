paperless-ngx-0.1.0.tgz:
	helm package .

install: paperless-ngx-0.1.0.tgz
	helm push paperless-ngx-0.1.0.tgz oci://registry.nick.wtf/library
