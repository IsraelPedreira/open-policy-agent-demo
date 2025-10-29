# Policy as Code Demo (Open Policy Agent + Docker)

## Demonstração prática de **Policy as Code** com **Open Policy Agent (OPA)** e **Conftest**.

## Como executar

### 1. Suba o ambiente

```bash
docker compose up -d --build
docker exec -it opa-demo bash
```

### 2. Execute o Open Policy Agent

```bash
opa eval --input examples/pod-valid.yaml --data policy/ "data.kubernetes.admission.deny"
opa eval --input examples/pod-invalid.yaml --data policy/ "data.kubernetes.admission.deny"
```

Você também pode executar os testes da política utilizando Conftest:

```bash
opa test policy/
```
