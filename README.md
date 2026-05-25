# Brazilian E-commerce ELT Pipeline

Pipeline de dados completo construído sobre o dataset público [Olist Brazilian E-commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) do Kaggle, implementando a arquitetura medalhão (Bronze → Silver → Gold) com Python, dbt e PostgreSQL.

## Escolhas Técnicas
Decisões tomadas durante o desenvolvimento: 
- dbt test em tabelas staging, visando mitigar erros desde a base; 
- Manter a camada bronze original visando possíveis cenários futuros em que a regra de negócio mude, dessa forma não perderemos a historicidade dos dados e poderemos aplicar a nova regra de negócio aos dados antigos;
- Alternância entre views/tables nos models, optando pelo custo-benefício entre performance (nas marts) e armazenamento (nas stagings e intermediates), já que os dados mais utilizados se encontram nas marts(análises) e na bronze (machine learning)
- Análise exploratória eficiente, visando descartar colunas desnecessárias e executar joins com qualidade
- Métricas centralizadas na camada gold, evitando divergência de resultados entre analistas

Resultado observável: 8 models essenciais passando em todos os testes dbt.


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
- **Docker**  containerização do banco de dados
- **PowerBI** —  Análise de métricas

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
├── Bi/
│   └── dashboard.pbix           # análise visual de métricas
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

### 7. Consumir métricas dos dados
- Abrir o arquivo .pbix em /BI
- Analisar dados

## Testes de qualidade

Testes implementados na camada staging via `dbt test`:

- `unique` e `not_null` em chaves primárias
- `accepted_values` em colunas categóricas (`order_status`)
- `relationships` para integridade referencial entre tabelas


## Contato

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Joalbo%20Junior-blue)](www.linkedin.com/in/joalbo-nascimento-9b01a6236/)
