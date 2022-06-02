# Main Assignment Week 5 - Documentation

This is a documentation of the final assignment for week 5. This doc contains work with Snowflake, DBT & Data Studio.

___

#### Table of Contents

| Step        | Name        |
| ----------- | ----------- |
| 1.          | [Download & extract data](#step-1-download--extract-data)
| 2.          | [Initalize DBT](#step-2-initalize-dbt)
| 2.          | [Initalize DBT](#step-2-initalize-dbt)
| 2.          | [Initalize DBT](#step-2-initalize-dbt)
| 2.          | [Initalize DBT](#step-2-initalize-dbt)

___

#### Step 1: Download & extract data

* I downloaded the given zip file and extracted to a folder.
* The  `NavHistory.csv` file had `"`.
* I removed those by a simple find & replace.

#### Step 2: Setup Snowflake

* I created a new Database `MAIN_ASSIGNMENT`
* Granted necessary permissions to `TRANSFORM_ROLE`

Next I created the required `csv file format`

```SQL
create or replace file format csv_format type = 'csv' field_delimiter = ',' skip_header = 1;
```

#### Step 2: Initalize DBT