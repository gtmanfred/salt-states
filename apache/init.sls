/etc/httpd/conf.d/website.com.conf:
  apache.configfile:
    - config:
      - VirtualHost:
          this: '*:80'
          ServerName: website.com
          ServerAlias:
          - www.website.com
          - dev.website.com
          ErrorLog: logs/www.website.com-error_log
          CustomLog: logs/www.website.com-access_log combinded
          Directory:
            this: /var/ww/vhosts/website.com
            Order: Deny,Allow
            Deny from: all
            Allow from:
            - 127.0.0.1
            - 192.168.100.0/24
            Options:
            - +Indexes
            - FollowSymlinks
            AllowOverride: None

  service:
    - running
    - name: httpd
    - reload: True
    - enable: True
    - watch:
      - apache: /etc/httpd/conf.d/website.com.conf
