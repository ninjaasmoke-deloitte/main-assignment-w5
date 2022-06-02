# Main Assignment Week 5 - Documentation

This is a documentation of the final assignment for week 5. This doc contains work with Snowflake, DBT & Data Studio.

___

#### Table of Contents

| Step        | Name        |
| ----------- | ----------- |
| 1.          | [Download & extract data](#step-1-download--extract-data) |
| 2.          | [Setup Snowflake](#step-2-setup-snowflake) |
| 3.          | [DBT](#step-3-dbt) |
| 4.          | [Screenshots](#screenshots) |

___

#### Step 1: Download & extract data

* Downloaded the given zip file and extracted to a folder.
* The  `NavHistory.csv` file had `"`.
* Removed those by a simple find & replace.

#### Step 2: Setup Snowflake

* Created a new Database `MAIN_ASSIGNMENT`
* Granted necessary permissions to `TRANSFORM_ROLE`

Next I created the required `csv file format`

```SQL
create or replace file format csv_format type = 'csv' field_delimiter = ',' skip_header = 1;
```

- Created a stage

```SQL
create or replace stage CSV_STAGE
``` 
<br />**Used SnowSQL to load data into SnowFlake**

Example:

```sql
// AMC table
select 
  c.$1 as Id, 
  c.$2 as name
from @CSV_STAGE (file_format => CSV_FILE_FORMAT) c;

create or replace table amc (
  id integer primary key, 
  name varchar (100)
)

copy into "MAIN_ASSIGNMENT"."PUBLIC"."AMC" from (select c.$1, c.$2 from @CSV_STAGE (file_format => CSV_FILE_FORMAT) c);

select * from amc

// Fund Category Table

drop stage CSV_STAGE

create or replace table fund_category (
  id integer primary key, 
  category varchar (100)
)

copy into "MAIN_ASSIGNMENT"."PUBLIC"."FUND_CATEGORY" from (select c.$1, c.$2 from @CSV_STAGE (file_format => CSV_FILE_FORMAT) c);

select * from fund_category;
```

Output of 
```SQL
select * from fund_category;
```

![image](https://user-images.githubusercontent.com/104750177/171588404-f1f44d26-94eb-49a3-8ca4-411365fe6039.png)



#### Step 3: DBT

- Used `dbt init` and credentials to set up dbt
- Create required tables

### Screenshots

- The models are in [here](main_assignment/models/main).

**M1.1**
```SQL
select 
    extract(month from nav_date) as Month,
    ROUND(avg(nav), 2) as AVG_NAV,
    ROUND(avg(REPURCHASE_PRICE), 2) as AVG_REPURCHASE_PRICE,
    ROUND(avg(SALE_PRICE),2) as AVG_SALE_PRICE
from  "MAIN_ASSIGNMENT"."PUBLIC"."NAV_HISTORY"
group by extract(month from nav_date)
```
![image](https://user-images.githubusercontent.com/104750177/171588762-f04e555b-8f90-4536-a3bc-5349ecfcfc3e.png)



**M1.2**
```SQL
select
    f.category,
    max(nav), min(nav)
from 
    nav_history as n,
    mutual_fund as m,
    fund_category as f
where 
    f.id=m.category_id and m.code=n.code
group by f.category
order by max(nav) desc
```

![image](https://user-images.githubusercontent.com/104750177/171588965-7ef42b9d-a01f-4e28-8abf-ecd9eb01ec0f.png)

**M2.1 MTD**
```SQL
select * from m2_1_mtd
```
![image](https://user-images.githubusercontent.com/104750177/171589202-9431ed99-245d-4222-b25b-f2f83e752dc4.png)

**YTD**
```SQL
select * from m2_1_ytd
```
![image](https://user-images.githubusercontent.com/104750177/171589488-793ae80d-f785-4456-8b15-237e0138cc4e.png)

**Year**  _I used the second clean data provided for nav_history, which has only 3 month's data_
```SQL
select * from m2_1_year
```
![image](https://user-images.githubusercontent.com/104750177/171589585-56986472-cd5e-4df3-98f7-d5d827b15df0.png)

**Performance Only**
![image](https://user-images.githubusercontent.com/104750177/171590423-8e970c49-3138-472c-8dbd-9b9c28242fe0.png)

<br />

**M2.2**
```SQL
select * from "MAIN_ASSIGNMENT"."PUBLIC"."M2_2"
```

![image](https://user-images.githubusercontent.com/104750177/171591031-6667b224-a864-431c-8227-57b99a516e0c.png)

**M2.4**
```SQL
select * from "MAIN_ASSIGNMENT"."PUBLIC"."M2_4_MTD"
```

![image](https://user-images.githubusercontent.com/104750177/171591197-911cd163-0124-4e74-8adb-1034f9f796f1.png)

**YTD**

```SQL
select * from "MAIN_ASSIGNMENT"."PUBLIC"."M2_4_YTD"
```
![image](https://user-images.githubusercontent.com/104750177/171591339-63ef1950-4549-42e6-a7dd-4bf0e566b798.png)

**M3: DataStudio**

Link: [Data Studio](https://datastudio.google.com/reporting/f909ef97-f9f1-4644-b14b-5f3b580b17f8)
