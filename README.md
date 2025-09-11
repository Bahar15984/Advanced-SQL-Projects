# Advanced SQL Projects  

This repository contains advanced SQL case studies implemented on **SQL Server 2022** using **Docker**.  
It includes **Banking KPIs**, **Product Sales Analysis**, and **Transaction Management** with optimized queries and scripts.  

---

## 📂 Project Structure

A_SQL
├── analysis/ # Case study SQL queries
│ ├── bank_analysis.sql
│ ├── library_management_analysis.sql
│ ├── shopify_case_study.sql
│ └── transaction_account_management_analysis.sql
│
├── docker/ # Docker setup for SQL Server
│ └── docker-compose.yml
│
├── reports/ # KPI queries and analysis reports
│ ├── kpi_queries.sql
│ ├── optimization_notes.md
│ ├── shopify_questions.sql
│ ├── theory_questions.sql
│ └── txn_account_indexes.sql
│
├── schema/ # Database creation and setup scripts
│ ├── Processing/
│ │ └── product_sales_processing.sql
│ ├── bank_create_insert_tables.sql
│ ├── Databases_create.sql
│ ├── LibraryManagement_create_insert_table.sql
│ ├── productSales_create_insert_tables.sql
│ └── shopify_create_insert_tables.sql
│
├── scripts/ # Shell scripts to run SQL files
│ ├── run_all.sh
│ └── run_file.sh
│
├── .env # Environment variables (not uploaded)
├── .gitignore # Git ignored files
└── README.md # Project documentation

Copy code

---

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
- Banking KPI analysis (profitability, loan performance, customer segmentation)  
- Product sales performance with revenue, discount, and margin analysis  
- Transaction monitoring and case study with Shopify dataset  
- Query optimization using indexing, joins, and CTEs  

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
