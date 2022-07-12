#!/bin/sh

set -e

namespace=$1

export LANG=C
export LC_ALL=C

kubectl create secret generic -n "${namespace}" \
  cloud-auth-secrets \
  --from-literal=jwt-signing-key="$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)"

kubectl create secret generic -n "${namespace}" \
  pl-db-secrets \
  --from-literal=PL_POSTGRES_USERNAME=pl \
  --from-literal=PL_POSTGRES_PASSWORD="$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 24 | head -n 1)" \
  --from-literal=database-key="$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 24 | head -n 1)" \
  --from-literal=postgres-password="$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 24 | head -n 1)" \
  --from-literal=replication-password="$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 24 | head -n 1)"

kubectl create secret generic -n "${namespace}" \
  pl-hydra-secrets \
  --from-literal=SECRETS_SYSTEM="$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)" \
  --from-literal=OIDC_SUBJECT_IDENTIFIERS_PAIRWISE_SALT="$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)" \
  --from-literal=CLIENT_SECRET="$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)"

kubectl create secret generic -n "${namespace}" \
  cloud-session-secrets \
  --from-literal=session-key="$(< /dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 24 | head -n 1)"

SERVICE_TLS_CERTS="$(mktemp -d)"
cd "${SERVICE_TLS_CERTS}"

cat << EOS >> ssl.conf
[ req ]
default_bits       = 4096
distinguished_name = req_distinguished_name
req_extensions     = req_ext
[ req_distinguished_name ]
[ req_ext ]
subjectAltName = @alt_names
[alt_names]
DNS.1   = *.${namespace}
DNS.2   = *.${namespace}.svc.cluster.local
DNS.3   = *.pl-nats
DNS.4   = pl-nats
DNS.5   = *.dev
DNS.6   = *.${namespace}
DNS.7   = localhost
EOS

openssl genrsa -out ca.key 4096
openssl req -new -x509 -sha256 -days 365 -key ca.key -out ca.crt -subj "/O=Pixie/CN=pixie.dev"

openssl genrsa -out server.key 4096
openssl req -new -sha256 -key server.key -out server.csr -config ssl.conf -subj "/O=Pixie/CN=pixie.dev"

openssl x509 -req -sha256 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 \
    -out server.crt -extensions req_ext -extfile ssl.conf

openssl genrsa -out client.key 4096
openssl req -new -sha256 -key client.key -out client.csr -config ssl.conf -subj "/O=Pixie/CN=pixie.dev"

openssl x509 -req -sha256 -days 365 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 01 \
    -out client.crt -extensions req_ext -extfile ssl.conf

openssl genrsa -out tls.key 4096
openssl req -new -sha256 -key tls.key -out client.csr -config ssl.conf -subj "/O=Pixie/CN=pixie.dev"

openssl x509 -req -sha256 -days 365 -in client.csr -CA ca.crt -CAkey ca.key -set_serial 01 \
    -out tls.crt -extensions req_ext -extfile ssl.conf

kubectl create secret generic -n "${namespace}" \
  service-tls-certs \
  --from-file=ca.crt=./ca.crt \
  --from-file=client.crt=./client.crt \
  --from-file=client.key=./client.key \
  --from-file=tls.crt=./tls.crt \
  --from-file=tls.key=./tls.key \
  --from-file=server.crt=./server.crt \
  --from-file=server.key=./server.key

kubectl create secret generic -n "${namespace}" \
  cloud-proxy-tls-certs \
  --from-file=tls.crt=./tls.crt \
  --from-file=tls.key=./tls.key
