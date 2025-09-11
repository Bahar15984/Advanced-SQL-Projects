# Advanced SQL Projects  

This repository contains advanced SQL case studies implemented on **SQL Server 2022** using **Docker**.  
It includes **Banking KPIs**, **Product Sales Analysis**, and **Transaction Management** with optimized queries and scripts.  

---
## Project Structure

```plaintext
A_SQL/
├── analysis/ # Case study SQL queries
│   ├── bank_analysis.sql
│   ├── library_management_analysis.sql
│   ├── shopify_case_study.sql
│   └── transaction_account_management_analysis.sql
│
├── schema/ # Database creation and setup scripts
│   ├── Databases_create.sql
│   ├── LibraryManagement_create_insert_table.sql
│   ├── bank_create_insert_tables.sql
│   ├── productSales_create_insert_tables.sql
│   ├── shopify_create_insert_tables.sql
│   └── Processing/
│       └── product_sales_processing.sql
│
├── reports/ # KPI queries and analysis reports
│   ├── kpi_queries.sql
│   ├── optimization_notes.md
│   ├── shopify_questions.sql
│   ├── theory_questions.sql
│   └── txn_account_indexes.sql
│
├── docker/ # Docker setup for SQL Server
│   └── docker-compose.yml
│
├── scripts/ # Shell scripts to run SQL files
│   ├── run_all.sh
│   └── run_file.sh
│
├── .gitignore # Git ignored files
├── .env # Environment variables (NOT uploaded)
└── README.md # Project documentation



## Getting Started  

### 1. Run SQL Server with Docker  
Make sure Docker is installed and running:  
docker compose -f docker/docker-compose.yml up -d  

### 2. Run All SQL Scripts  
Execute schema and data population scripts:  
./scripts/run_all.sh  

Or run a single SQL file:  
./scripts/run_file.sh schema/01_create_tables.sql  

---

## Features  
Banking Analysis
 – profitability, loan performance, and customer segmentation

Product Sales Analysis
 – revenue, discount, and margin queries

Product Sales Processing
 – merged sales tables and reporting queries

Library Management System
 – borrower, branch, and book circulation analysis

Transaction & Account Monitoring
 – account KPIs and transaction insights

Shopify Case Study
 – e-commerce dataset exploration and KPIs

Query Optimization
 – indexing strategies and performance tuning

Optimization Notes
 – theoretical guidance and best practices

---

## Technologies  
- SQL Server 2022 (via Docker)  
- T-SQL (queries, joins, window functions, indexing)  
- Bash scripts (automation)  

---

## Notes  
- Store credentials in `.env` file (ignored by Git)  
- Ensure Docker is running before executing SQL scripts  
- Contributions and suggestions are welcome!  

---

## Author  
**Bahar Almasi**  
[LinkedIn](https://www.linkedin.com/in/baharal/)  
[GitHub](https://github.com/Bahar15984)
