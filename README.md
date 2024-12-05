# keycloak-docker

# Comando docker mínimo para iniciar o projeto

```bash
docker run -d --name keycloak \
  -p 8080:8080 \
  -e KC_BOOTSTRAP_ADMIN_USERNAME=admin \
  -e KC_BOOTSTRAP_ADMIN_PASSWORD=admin \
  keycloak26:v1.0.0 start-dev
```