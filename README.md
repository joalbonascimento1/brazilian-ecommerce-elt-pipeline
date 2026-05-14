# Brazilian E-commerce ELT Pipeline

Pipeline de dados completo construído sobre o dataset público [Olist Brazilian E-commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) do Kaggle, implementando a arquitetura medalhão (Bronze → Silver → Gold) com Python, dbt e PostgreSQL.

## Arquitetura

```
Kaggle API
    │
    ▼
[Extract & Load]  Python + pandas + SQLAlchemy
    │
    ▼
Bronze (schema: public)   ← dados crus, preservados para reprocessamento
    │
    ▼
[Transform]  dbt
    │
    ├── Silver (schema: silver)   ← staging: tipagem e renomeação
    │                             ← intermediate: joins e regras de negócio
    ▼
Gold (schema: gold)       ← marts: métricas prontas para análise
```

## Tecnologias

- **Python** — extração via Kaggle API e carga com `pandas` + `SQLAlchemy`
- **PostgreSQL 15** — banco de dados, executado via Docker
- **dbt-postgres** — transformação, testes e documentação dos dados
- **Docker** — containerização do banco de dados

## Perguntas de negócio respondidas

| Mart | Pergunta |
|------|----------|
| `sales_per_category` | Qual categoria de produto gera mais receita? |
| `delivery_time_by_state` | Qual o tempo médio de entrega por estado? |
| `sellers_evaluation` | Quais vendedores têm melhor avaliação e maior receita? |
| `revenue_per_month` | Como evoluiu o faturamento mês a mês? |
| `category_per_state` | Qual a categoria mais vendida em cada estado? |

## Estrutura do projeto

```
├── ingestion/
│   └── extract_load.py          # extração do Kaggle e carga no Postgres
├── dbt/
│   ├── dbt_project.yml          # configuração do projeto dbt
│   ├── models/
│   │   ├── staging/             # 9 modelos — tipagem e renomeação das raw tables
│   │   ├── intermediate/        # 5 modelos — joins entre stagings
│   │   └── marts/               # 5 modelos — métricas por domínio de negócio
│   ├── analyses/                # queries exploratórias
│   └── macros/
│       └── generate_schema_name.sql
├── yaml pgsql/
│   └── docker-compose.yml       # PostgreSQL 15 via Docker
├── .gitignore
└── requirements.txt
```

## Como executar localmente

### Pré-requisitos

- Python 3.10+
- Docker
- Conta no Kaggle com API key configurada

### 1. Subir o banco de dados

```bash
cd "yaml pgsql"
docker-compose up -d
```

### 2. Instalar dependências Python

```bash
python -m venv venv
venv\Scripts\activate       # Windows
pip install -r requirements.txt
```

### 3. Configurar o dbt

Crie o arquivo `~/.dbt/profiles.yml`:

```yaml
brazillian_ecomerce_dw:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      port: 5433
      user: joalbo
      password: joalbo
      dbname: dbtestes
      schema: public
      threads: 4
```

### 4. Extrair e carregar os dados

```bash
python ingestion/extract_load.py
```

### 5. Executar as transformações

```bash
dbt run --project-dir dbt
dbt test --project-dir dbt
```

### 6. Documentação e linhagem

```bash
dbt docs generate --project-dir dbt
dbt docs serve --project-dir dbt
```

Acesse `http://localhost:8080` para visualizar o grafo de linhagem completo.

## Testes de qualidade

Testes implementados na camada staging via `dbt test`:

- `unique` e `not_null` em chaves primárias
- `accepted_values` em colunas categóricas (`order_status`)
- `relationships` para integridade referencial entre tabelas

## Contato

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Joalbo%20Junior-blue)](https://www.linkedin.com/in/joalbo-junior-9b01a6236/)
