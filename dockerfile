FROM quay.io/keycloak/keycloak:26.0.6

WORKDIR /opt/keycloak

COPY resources/themes/ /opt/keycloak/themes