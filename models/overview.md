{% docs __overview__ %}
# Welcome to the User Data Model of AE
This project includes a set of models to create the dimensional model of End Of Day Balance.

The layers on this dimensional model:
- **Staging:** Contains the source data and the views on top of the source data.
- **Data_Vault:** Contains the Data Vault 2.0 data model how data from different sources is stored in data layer.
- **Dim_DWH:** Contains the dimensional data model how these data sets are combined in Data Mart. Ready to use by the target application.

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

Try running the following commands:
- **dbt build** (or dbt seed + dbt test + dbt run) to regenerate the entire model
- **dbt docs generate** to regenerate the documentation

### Resources:
- GitHub link of this repository: [click]()
- Check out the ERD diagrams of the data model: [click]()
- Check out the DBT docs: [click]() for extensive information of each tables and columns
- The linked data lake: [click]()
- And lastly, check an example report which is created on dimensional data model: [click]()
{% enddocs %}
