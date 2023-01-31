# Java

## Como rodar os testes
### Pré-requisitos
- [Java 17](https://www.oracle.com/java/technologies/javase-jdk17-downloads.html)

### Terminal

No terminal, execute os comandos:
```
cd java
./mvnw test
```

### Docker
Se prefir, pode utilizar a imagem docker disponível no repositório

```
cd java

# Só precisa buildar a imagem uma vez
docker build  -t rdstation-challenge-java .

# Você pode executar todos os testes
docker run \
--rm \
--volume="$PWD/src:/app/src" \
--volume="$PWD/target:/app/target" \
--volume="$HOME/.m2/repository:/root/.m2/repository" \
rdstation-challenge-java


# ou acessar o container para executar comandos personalizados
docker run \
--rm \
-it \
--volume="$PWD/src:/app/src" \
--volume="$PWD/target:/app/target" \
--volume="$HOME/.m2/repository:/root/.m2/repository" \
rdstation-challenge-java /bin/bash
```
 


docker run \
--rm \
-it \
--volume="$PWD/target:/app/target" \
--volume="$HOME/.m2/repository:/root/.m2/repository" \
rdstation-challenge-java /bin/bash
