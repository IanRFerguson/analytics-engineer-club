# dbt - Introductions

## What is dbt?

* dbt == data build tool

* Command line tool to transform data quickly and efficiently

* Select statements are stored as dbt models
	** Handles turning select statements into tables and views
	** Understands the order and dependencies of each model
	** Allows for testing
	** Can generate project documentation automatically

* To use dbt...
	** Must be installed locally
	** You need a dbt project that contains models
	** Credentials to a data warehouse

* A dbt project is just a few things
	** dbt_project.yml is a YMAL file that configures the dbt pipeline
	** A model is a single select statement stored in a .sql file

* The way that dbt materializes the results of a query is set via model configurations

```bash
# Option 1 - use a config block within a model
{{ config(materialized='table')}}

# Option - Change the models key in the YAML file
models:
  coffee_shop:
    materialized: view
```

* All configuration options: https://docs.getdbt.com/reference/model-configs

* Use the ref function to take the name of another model as an argument
	
```bash
from {{ ref('users') }}
```

* DAGs == Directed Acyclic Graphs

* In short, a DAG is a graph where tasks are shown as nodes, and dependencies are shown as arrows

## dbt Syntax / Vernacular

* Once a query is stored in a DBT project they are called `models`

* Lots of things to do ... change from views to tables, infer which order to build models in, test / document models

* DBT can generate documentation of your workflow! (Lineage Graphs)

```bash
# Local install + setup
pip install dbt-bigquery
dbt init

# Write a bunch of models
# ...

dbt run
```