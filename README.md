# Arquitetura de Rede do Kubernetes no AWS EKS

## Componentes de Rede e Balanceamento de Carga

### Pods
* Unidades básicas de computação no Kubernetes
* Cada pod possui seu próprio endereço IP dentro do cluster
* IPs são efêmeros e mudam quando pods são recriados

### Service
* Fornece endpoint estável (IP e DNS fixos) para um conjunto de pods
* Realiza balanceamento de carga interno entre os pods selecionados
* Tipos principais:
    * **ClusterIP**: Expõe o serviço apenas internamente no cluster (padrão)
    * **NodePort**: Expõe o serviço em uma porta específica em todos os nós
    * **LoadBalancer**: Provisiona automaticamente um balanceador de carga externo

### Ingress
* Funciona como gateway HTTP/HTTPS para o cluster
* Gerencia roteamento baseado em hosts, caminhos e outras regras
* Define configurações como redirecionamentos, SSL/TLS, reescrita de URLs
* Recurso declarativo que precisa de um controlador para implementar suas regras

### Ingress Controller
* Implementa as regras definidas nos recursos Ingress
* No AWS, cria automaticamente recursos como ALB/NLB/Classic Load Balancer
* Exemplos: NGINX Ingress Controller, AWS Load Balancer Controller

## Como Funciona o Fluxo de Tráfego

O fluxo de tráfego segue esta hierarquia:

1. **Internet** → Requisições de usuários externos
2. **AWS Load Balancer** → Criado pelo Ingress Controller ou Service tipo LoadBalancer
3. **Ingress Controller** → Processa regras de roteamento HTTP/HTTPS
4. **Service** → Balanceia tráfego entre pods da aplicação
5. **Pods** → Executam a aplicação e processam as requisições

## Diferenças de Balanceamento em Cada Camada

* **AWS Load Balancer**: Balanceia tráfego da internet para o cluster
* **Ingress Controller**: Roteia tráfego HTTP/HTTPS com base em regras de host/caminho
* **Service**: Distribui tráfego entre os pods de uma aplicação específica

## Exemplo Prático

Quando um usuário acessa `app.exemplo.com/api`:

1. A requisição chega ao AWS Load Balancer (ALB/NLB)
2. O Load Balancer encaminha para o Ingress Controller
3. O Ingress Controller verifica suas regras e identifica que `/api` deve ir para o serviço `api-service`
4. O `api-service` seleciona um dos pods disponíveis usando seu algoritmo de balanceamento
5. O pod selecionado processa a requisição e retorna a resposta

Esta arquitetura em camadas permite alta disponibilidade, escalabilidade e gerenciamento eficiente do tráfego em aplicações Kubernetes.
- para acessar
```
http://ENDEREÇO_DO_LOAD_BALANCER/hello
```