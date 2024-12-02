# Importing verifiable self-signed certificate
## Download certs from google drive or attached on this notion page
$ open https://drive.google.com/file/d/abc/view?usp=drive_link
$ unzip ~/Downloads/cert.zip -d ~

## Add to Keychain
$ sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/.ssl/abc.me.crt


# Creating verifiable self-signed certificate
## We are using .ssl not .ssh
$ mkdir ~/.ssl
$ cd .ssl

# Create abc.me.conf
printf "[req]\ndefault_bits = 2048\nprompt = no\ndefault_md = sha256\ndistinguished_name = dn\nreq_extensions = req_ext\n\n[dn]\nC = JP\nST = Tokyo\nL = Shinagawa\nO = abc dev\nCN = *.abc.me\n\n[req_ext]\nsubjectAltName = @alt_names\n\n[alt_names]\nDNS.1 = *.abc.me\nDNS.2 = abc.me\nIP.1 = 127.0.0.1\n" > abc.me.conf

# Create a private key
$ sudo openssl genrsa -out ~/.ssl/abc.me.key 2048

# Generate the Certificate Signing Request (CSR)
$ sudo openssl req -new -key abc.me.key -out abc.me.csr -config abc.me.conf

# Generate the Self-signed SSL Certificate
$ sudo openssl x509 -req -days 3650 -in abc.me.csr -signkey abc.me.key -out abc.me.crt -extensions req_ext -extfile abc.me.conf

# Add to Keychain
$ sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/.ssl/abc.me.crt


Showing abc.me.conf for your reference.
```
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
req_extensions = req_ext

[dn]
C = JP
ST = Tokyo
L = Shinagawa
O = abc dev
CN = *.abc.me

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = *.abc.me
DNS.2 = abc.me
IP.1 = 127.0.0.1
```

# Verifying created certificate

Open `keychain access` app and check added certificate is marked as “Verified”.

# FAQ

- The certificate has been loaded, but a warning about the certificate still appears.
    - Please try restarting your browser. You can also check if the certificate is temporarily valid in a different browser, such as Safari.
