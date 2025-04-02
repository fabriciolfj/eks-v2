#!/bin/bash
# Este script demonstra os passos para implantar a aplicação e configurar o Ingress

# 1. Instalar o Ingress-NGINX Controller
echo "Instalando o Ingress-NGINX Controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.1/deploy/static/provider/aws/deploy.yaml

# 2. Aguardar a instalação do controlador
echo "Aguardando o Ingress Controller ficar pronto..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

# 3. Implantar a aplicação de exemplo
echo "Implantando a aplicação de exemplo..."
kubectl apply -f deployment.yml

# 5. Criar o Ingress para expor a aplicação
echo "Configurando o Ingress..."
kubectl apply -f ingress.yml

# 6. Verificar o estado da implantação
echo "Verificando a implantação..."
kubectl get pods
kubectl get services
kubectl get ingress

# 7. Obter o endereço do Ingress (pode levar alguns minutos para ficar disponível)
echo "Aguardando o endereço do Ingress ser atribuído (pode levar alguns minutos)..."
sleep 60
echo "Endereço do Ingress:"
kubectl get ingress hello-ingress -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

echo ""
echo "Sua aplicação agora deve estar acessível em: http://ENDEREÇO_DO_INGRESS/hello"
echo "Observe que pode levar alguns minutos para que o DNS seja propagado."