Bailey is a utility tool to help you find a new home in the crazy London real
state market.

## Running it

Bailey is meant to send property notifications using `postfix`, this is by design. Configuration is up to the user but using a common, free SMTP provider (like Gmail) is advised. 

* Open `/etc/postfix/main.cf` and add the following to the bottom of the file.
```
#Gmail SMTP
relayhost=smtp.gmail.com:587

# Enable SASL authentication in the Postfix SMTP client.
smtp_sasl_auth_enable=yes
smtp_sasl_password_maps=hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options=noanonymous
smtp_sasl_mechanism_filter=plain

# Enable Transport Layer Security (TLS), i.e. SSL.
smtp_use_tls=yes
smtp_tls_security_level=encrypt
tls_random_source=dev:/dev/urandom
```

* Create a sasl_passwd file to authenticate with your SMTP server
`$ echo mtp.gmail.com:587 me@gmail.com:password >> /etc/postfix/sasl_passwd`

* Create postfix lookup table and restart postfix
`$ sudo postmap /etc/postfix/sasl_passwd && postfix reload`

* You might have to turn on ["less secure apps"](https://www.google.com/settings/security/lesssecureapps) access if using Gmail
