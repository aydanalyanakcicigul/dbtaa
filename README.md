## Hi! Welcome to the AE Project! 


This project includes a set of models to create the dimensional model of End Of Day Balance.


#### Design: 

The layers on this dimensional model:
- **Staging:** Contains the source data and the views on top of the source data.
- **Data_Vault:** Contains the Data Vault 2.0 data model how data from different sources is stored in data layer.
- **Dim_DWH:** Contains the dimensional data model how these data sets are combined in Data Mart. Ready to use by the target application.

#### Technologies used:
* DBT Cloud (version: 1.6.0) 
* GitHub integration
* GCP BigQuery integration (can also be integrated to other databases)

#### To run the project on DBT Cloud:
- **dbt build** (or dbt seed + dbt test + dbt run) to regenerate the entire model
- **dbt docs generate** to regenerate the documentation

#### To reproduce the results via a different dataset:
Please change the "sources" configuration in [*models/staging/stg_sources.yml*](https://github.com/aydanalyanakcicigul/dbtaa/blob/main/models/staging/stg_sources.yml)  file.

```
sources:
  - name: crm_a
    database: key-hope-406212
    schema: crm_a
    tables:
        - name: contact
    .
        - name: account
    .
  - name: crm_b
    database: key-hope-406212
    schema: crm_b
    tables:
        - name: contact
    .
        - name: account
    .
  - name: fin_a
    database: key-hope-406212
    schema: fin_a
    tables:
        - name: completedtrans
    .
  - name: fin_b
    database: key-hope-406212
    schema: fin_b
    tables:
        - name: completedtrans
    .
```

#### The locations of DRY (don't repeat yourself) code source files:
- In [*dbt_project.yml*](https://github.com/aydanalyanakcicigul/dbtaa/blob/main/dbt_project.yml) file, you can find the variables used in models.
- In [*models/shared_definitions.md*](https://github.com/aydanalyanakcicigul/dbtaa/blob/main/models/shared_definitions.md) file, you can find the code blocks of shared definitions used in yml files.

### Resources:
- GitHub link of this repository: [click](https://github.com/aydanalyanakcicigul/dbtaa)
- Check out the ERD diagrams of the data model: [click]()
- Check out the DBT docs: [click](https://aydanalyanakcicigul.github.io/dbtaa/#!/overview) for extensive information of each tables and columns
- The linked data lake: [click](https://console.cloud.google.com/bigquery?project=key-hope-406212)