# sql-data-warehouse-project-for-olist-store

This project serves as both a portfolio project and a practical reference for building modern data warehouse solutions.

**Welcome to the sql-data-warehouse-project-for-olist-store repository**.

This project demonstrates how to design and build a modern SQL data warehouse using the Brazilian e-commerce Olist public dataset. The goal of this repository is to show the complete workflow of transforming raw operational data into a structured warehouse ready for analytics and business intelligence.

**The project covers the full data engineering lifecycle, including**:

- Extracting raw transactional data from the Olist dataset

- Designing a Medallion Architecture (Bronze, Silver, Gold layers)

-  Building ETL pipelines to clean and transform data

- Creating fact and dimension tables using dimensional modeling

- Preparing analytical datasets for reporting and insights

This repository is intended as a hands-on data warehouse project for learning and demonstrating practical skills in SQL, data modeling, and analytics engineering.

By the end of this project, the warehouse will support business analysis such as sales performance, customer behavior, product trends, and seller performance.

### Project Requirements

1. ## Objective

The objective of this project is to design and implement a modern SQL Data Warehouse using the Brazilian e-commerce **Olist public dataset.
The warehouse will transform raw transactional data into structured analytical datasets to support business intelligence, reporting, and advanced analytics.

### This project demonstrates practical skills in:

Data warehousing architecture

ETL pipeline development

Dimensional data modeling

Analytical data preparation

The final warehouse will enable analysis of sales performance, customer behavior, product trends, and seller performance.

2. ## Architecture

This project follows the Medallion Architecture, which organizes data into progressive layers for improved reliability and analytics readiness.

Bronze Layer (Raw Data)

Ingest raw datasets directly from source files.

Store the data in its original format.

No transformations are applied at this stage.

Silver Layer (Cleaned & Standardized Data)

Data cleansing and validation.

Handling null values and inconsistencies.

Standardizing formats and structures.

Gold Layer (Business-Ready Data)

Build fact and dimension tables.

Create analytical datasets optimized for reporting.

Prepare aggregated metrics for BI tools.

3. ## Data Sources

The project uses the Brazilian E-Commerce Public Dataset by Olist, which contains real transactional data from a Brazilian online marketplace.

Key datasets include:

Customers

Orders

Order Items

Order Payments

Order Reviews

Products

Sellers

Geolocation

Product Category Translation

4. ## Data Warehouse Development Steps
Step 1 — Data Ingestion

Import raw CSV datasets into SQL staging tables.

Validate schema and data types.

Step 2 — Data Cleaning & Transformation

Remove duplicates and invalid records.

Standardize columns and formats.

Handle missing values.

Step 3 — Data Modeling

Design a dimensional data model including:

Dimension Tables

DimCustomers

DimProducts

DimSellers

DimDate

DimLocation

Fact Tables

FactOrders

FactPayments

FactOrderItems

FactReviews

Step 4 — ETL Pipeline Development

Extract raw data from staging tables.

Transform and normalize datasets.

Load data into Silver and Gold layers.

Step 5 — Data Validation

Ensure referential integrity.

Validate data accuracy and completeness.

Test joins between fact and dimension tables.

5. ## BI: Analytics & Reporting

### The Gold Layer will support Business Intelligence dashboards and analytical reporting, enabling insights such as:

Sales performance analysis

Customer purchasing behavior

Product category performance

Seller performance metrics

Order delivery and review analysis

The warehouse can be connected to BI tools such as:

Power BI

Tableau

Looker Studio

6. ## Specifications
Component	Description
Database	MySQL
Architecture	Medallion Data Architecture
Data Modeling	Star Schema
Data Source	Olist Public E-commerce Dataset
ETL Processing	SQL-based transformations
Analytics	Business Intelligence dashboards

7. ## License

This project is licensed under the MIT License.

You are free to use, modify, and distribute this project with proper attribution.

8. ## About Me

I am a Data Analyst / Data Engineer enthusiast with a background in software engineering. I am passionate about building data-driven systems, modern data warehouses, and analytics solutions that help businesses make better decisions.

#### This project is part of my portfolio to demonstrate practical skills in:

Data Engineering

Data Warehousing

SQL Analytics

Business Intelligence

GitHub Portfolio:
https://github.com/pete-nime
