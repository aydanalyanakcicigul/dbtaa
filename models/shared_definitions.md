## Shared Definitions - Entities

{% docs def_source_data %}
is a table of source data.  
- The data is already loaded into BigQuery.  
- For remapping this source data into a different file, please change the credentials of database & schema in the "sources" configuration accordingly.
{% enddocs %}

{% docs def_staging_entity %}
is a staging entity for multiple use of the data source
{% enddocs %}

{% docs def_ent_contact %}
is a name given to an individual who is a customer of the bank.
{% enddocs %}

{% docs def_ent_account %}
contains the account(contract) details of the customers. 
{% enddocs %}

{% docs def_ent_product %}
contains the product details of the customer accounts. 
{% enddocs %}

{% docs def_ent_balance %}
is the transaction events that a customer makes via the account.
{% enddocs %}

{% docs def_ent_link %}
is the link inbetween
{% enddocs %}

## Shared Definitions - Attributes

{% docs def_load_dt %}
A Load Dt is the date when the data is loaded into the table.
{% enddocs %}

{% docs def_rec_src %}
A Rec Src is the source name of the data.
{% enddocs %}

{% docs def_valid_from_date %}
A Valid From Date is the date which the data is valid from (SCD2 column).
{% enddocs %}

{% docs def_valid_to_date %}
A Valid To Date is the date which the data is valid until (SCD2 column).
{% enddocs %}

{% docs def_current_indicator %}
A Current Indicator indicates if the data is still the up to date (SCD2 column).
{% enddocs %}

{% docs def_deleted_indicator %}
A Deleted Indicator indicates if the data is not up to date anymore (SCD2 column).
{% enddocs %}

{% docs def_hsh %}
Hsh is the generated surrogate (hashed) key for a
{% enddocs %}

{% docs def_hsh_diff %}
Hsh Diff is a computation of the smallest difference between two hashes in different dates.
{% enddocs %}

{% docs def_att_id %}
is the unique identifier of
{% enddocs %}

## Shared Definitions - Extra Information
