# keycloak-docker
#docker

# Comando docker mínimo para iniciar o projeto

```bash
docker run -d --name keycloak -p 8080:8080 -e KC_BOOTSTRAP_ADMIN_USERNAME=admin -e KC_BOOTSTRAP_ADMIN_PASSWORD=admin keycloak26:v1.0.0 start-dev
```

# Comando docker para buildar com buildx
```bash
docker buildx build -t  keycloak26:v*.*.* .
```

# Comando para copiar arquivos para o container
```bash
docker cp resources\themes\sebrae\login\resources\css\styles.css keycloak:/opt/keycloak/themes/sebrae/login/resources/css/styles.css
```