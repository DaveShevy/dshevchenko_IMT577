/*
Course: IMT 577
Instructor: Sean Petterson
Date: 02/04/2022
Notes: Complete various stages per IT Session
*/


-- Create a Database
CREATE DATABASE IMT577_DW_DAVID_SHEVCHENKO;

-- Create a DataWarehouse
CREATE WAREHOUSE IMT577_DW_DAVID_SHEVCHENKO WITH WAREHOUSE_SIZE = 'XSMALL' WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 600 AUTO_RESUME = TRUE;

-- Code for Creating Staging Tables
CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Channel URL = 'azure://imt577sourcedata.blob.core.windows.net/channel' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');


CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Channel_Category URL = 'azure://imt577sourcedata.blob.core.windows.net/channelcategory' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');


CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Customer URL = 'azure://imt577sourcedata.blob.core.windows.net/customer' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');


CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Product URL = 'azure://imt577sourcedata.blob.core.windows.net/product' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');


CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Product_Category URL = 'azure://imt577sourcedata.blob.core.windows.net/productcategory' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');


CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Product_Type URL = 'azure://imt577sourcedata.blob.core.windows.net/producttype' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');


CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Reseller URL = 'azure://imt577sourcedata.blob.core.windows.net/reseller' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');


CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Sales_Detail URL = 'azure://imt577sourcedata.blob.core.windows.net/salesdetail' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');


CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Sales_Header URL = 'azure://imt577sourcedata.blob.core.windows.net/salesheader' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');


CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Store URL = 'azure://imt577sourcedata.blob.core.windows.net/store' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');


CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Target_Data URL = 'azure://imt577sourcedata.blob.core.windows.net/targetdatachannel' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');


CREATE STAGE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC".Stage_Target_Data_Product URL = 'azure://imt577sourcedata.blob.core.windows.net/targetdataproduct' CREDENTIALS = (AZURE_SAS_TOKEN = '**********************************************************************************************************************************************************');



-- File Format Code
create or replace file format CSV_SKIP_HEADER
type = 'CSV'
field_delimiter = ','
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
skip_header = 1;

--  Mannually Creating Tables
CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_PRODUCT_CATEGORY" ("PRODUCTCATEGORYID" INTEGER, "PRODUCTCATEGORY" VARCHAR (255), "CREATEDDATE" DATE, "CREATEDBY" VARCHAR (255), "MODIFIEDDATE" DATE, "MODIFIEDBY" VARCHAR (255));

-- Creating Tables via SQL
CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_PRODUCT_TYPE" ("PRODUCTTYPEID" INTEGER, "PRODUCTCATEGORYID" INTEGER, "PRODUCTTYPE" VARCHAR(255), "CREATEDDATE" DATE, "CREATEDBY" VARCHAR (255), "MODIFIEDDATE" DATE, "MODIFIEDBY" VARCHAR (255));

CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_PRODUCT" ("PRODUCTID" INTEGER, "PRODUCTTYPEID" INTEGER, "PRODUCT" VARCHAR (255), "COLOR" VARCHAR (255), "STYLE" VARCHAR (255), "UNITOFMEASUREID" INTEGER, "WEIGHT" FLOAT, "PRICE" FLOAT, "COST" FLOAT, "CREATEDDATE" DATETIME, "CREATEDBY" VARCHAR (255), "MODIFIEDDATE" DATETIME, "MODIFIEDBY" VARCHAR (255), "WHOLESALEPRICE" FLOAT);

CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_SALES_DETAIL" ("SALESDETAILID" INTEGER, "SALESHEADERID" INTEGER, "PRODUCTID" INTEGER, "SALESQUANTITY" INTEGER, "SALESAMOUNT" FLOAT, "CREATEDDATE" DATETIME, "CREATEDBY" VARCHAR (255), "MODIFIEDDATE" DATETIME, "MODIFIEDBY" VARCHAR (255));

CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_CHANNEL" ("CHANNELID" INTEGER, "CHANNELCATEGORYID" INTEGER, "CHANNEL" VARCHAR (255), "CREATEDDATE" VARCHAR (255), "CREATEDBY" VARCHAR (255), "MODIFIEDDATE" VARCHAR (255), "MODIFIEDBY" VARCHAR (255));

CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_CHANNEL_CATEGORY" ("CHANNELCATEGORYID" INTEGER, "CHANNELCATEGORY" VARCHAR (255), "CREATEDDATE" DATETIME, "CREATEDBY" VARCHAR (255), "MODIFIEDDATE" DATETIME, "ModifiedBy " VARCHAR (255));

CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_SALES_HEADER" ("SALESHEADERID" INTEGER, "DATE" DATE, "CHANNELID" INTEGER, "STOREDID" INTEGER, "CUSTOMERID" VARCHAR (255), "RESELLERID" VARCHAR (255), "CREATEDDATE" DATETIME, "CREATEDBY" VARCHAR (255), "MODIFIEDDATE" DATETIME, "MODIFIEDBY" VARCHAR (255));

CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_RESELLER" ("RESELLERID" VARCHAR (255), "CONTACT" VARCHAR (255), "EMAILADDRESS" VARCHAR (255), "ADDRESS" VARCHAR (255), "CITY" VARCHAR (255), "STATEPROVINCE" VARCHAR (255), "COUNTRY" VARCHAR (255), "POSTALCODE" VARCHAR (255), "PHONENUMBER" VARCHAR (255), "CREATEDDATE" DATETIME, "CREATEDBY" VARCHAR (255), "MODIFIEDDATE" DATETIME, "MODIFIEDBY" VARCHAR (255), "RESELLERNAME" VARCHAR (255));

CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_STORE" ("STOREID" INTEGER, "SUBSEGMENTID" INTEGER, "STORENUMBER" INTEGER, "STOREMANAGER" VARCHAR (255), "ADDRESS" VARCHAR (255), "CITY" VARCHAR (255), "STATEPROVINCE" VARCHAR (255), "COUNTRY" VARCHAR (255), "POSTALCODE" VARCHAR (255), "PHONENUMBER" VARCHAR (255), "CREATEDDATE" DATETIME, "CREATEDBY" VARCHAR (255), "MODIFIEDDATE" DATETIME, "MODIFIEDBY" VARCHAR (255));

CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_CUSTOMER" ("CUSTOMERID" VARCHAR (255), "SUBSEGMENTID" INTEGER, "FIRSTNAME" VARCHAR (255), "LASTNAME" VARCHAR (255), "GENDER" VARCHAR (255), "EMAILADDRESS" VARCHAR (255), "ADDRESS" VARCHAR (255), "CITY" VARCHAR (255), "STATEPROVINCE" VARCHAR (255), "COUNTRY" VARCHAR (255), "POSTALCODE" VARCHAR (255), "PHONENUMBER" VARCHAR (255), "CREATEDDATE" DATETIME, "CREATEDBY" VARCHAR (255), "MODIFIEDDATE" DATETIME, "MODIFIEDBY" VARCHAR (255));

CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_TARGET_DATA" ("YEAR" DATE, "CHANNELNAME" VARCHAR (255), "TARGETNAME" VARCHAR (255), "TARGETSALESAMOUNT" INTEGER);

CREATE TABLE "IMT577_DW_DAVID_SHEVCHENKO"."PUBLIC"."STAGE_TARGET_DATA_PRODUCT" ("PRODUCTID" INTEGER, "PRODUCT" VARCHAR (255), "YEAR" DATE, "SALESQUANTITYTARGET" INTEGER);



remove @STAGE_TARGET_DATA_PRODUCT
remove @STAGE_TARGET_DATA
remove @STAGE_STORE
remove @STAGE_SALES_HEADER
remove @STAGE_SALES_DETAIL
remove @STAGE_RESELLER
remove @STAGE_PRODUCT_TYPE
remove @STAGE_PRODUCT_CATEGORY
remove @STAGE_PRODUCT
remove @STAGE_CUSTOMER
remove @STAGE_CHANNEL_CATEGORY
remove @STAGE_CHANNEL


SELECT *
FROM STAGE_TARGET_DATA_PRODUCT

SELECT * 
FROM STAGE_CHANNEL


SELECT *
FROM STAGE_STORE



--===================================================
-------------DIM_DATE
--==================================================
-- Create table script for Dimension DIM_DATE
create or replace table DIM_DATE (
	DATE_PKEY				number(9) PRIMARY KEY,
	DATE					date not null,
	FULL_DATE_DESC			varchar(64) not null,
	DAY_NUM_IN_WEEK			number(1) not null,
	DAY_NUM_IN_MONTH		number(2) not null,
	DAY_NUM_IN_YEAR			number(3) not null,
	DAY_NAME				varchar(10) not null,
	DAY_ABBREV				varchar(3) not null,
	WEEKDAY_IND				varchar(64) not null,
	US_HOLIDAY_IND			varchar(64) not null,
	/*<COMPANYNAME>*/_HOLIDAY_IND varchar(64) not null,
	MONTH_END_IND			varchar(64) not null,
	WEEK_BEGIN_DATE_NKEY		number(9) not null,
	WEEK_BEGIN_DATE			date not null,
	WEEK_END_DATE_NKEY		number(9) not null,
	WEEK_END_DATE			date not null,
	WEEK_NUM_IN_YEAR		number(9) not null,
	MONTH_NAME				varchar(10) not null,
	MONTH_ABBREV			varchar(3) not null,
	MONTH_NUM_IN_YEAR		number(2) not null,
	YEARMONTH				varchar(10) not null,
	QUARTER					number(1) not null,
	YEARQUARTER				varchar(10) not null,
	YEAR					number(5) not null,
	FISCAL_WEEK_NUM			number(2) not null,
	FISCAL_MONTH_NUM		number(2) not null,
	FISCAL_YEARMONTH		varchar(10) not null,
	FISCAL_QUARTER			number(1) not null,
	FISCAL_YEARQUARTER		varchar(10) not null,
	FISCAL_HALFYEAR			number(1) not null,
	FISCAL_YEAR				number(5) not null,
	SQL_TIMESTAMP			timestamp_ntz,
	CURRENT_ROW_IND			char(1) default 'Y',
	EFFECTIVE_DATE			date default to_date(current_timestamp),
	EXPIRATION_DATE			date default To_date('9999-12-31') 
)
comment = 'Type 0 Dimension Table Housing Calendar and Fiscal Year Date Attributes'; 

-- Populate data into DIM_DATE
insert into DIM_DATE
select DATE_PKEY,
		DATE_COLUMN,
        FULL_DATE_DESC,
		DAY_NUM_IN_WEEK,
		DAY_NUM_IN_MONTH,
		DAY_NUM_IN_YEAR,
		DAY_NAME,
		DAY_ABBREV,
		WEEKDAY_IND,
		US_HOLIDAY_IND,
        COMPANY_HOLIDAY_IND,
		MONTH_END_IND,
		WEEK_BEGIN_DATE_NKEY,
		WEEK_BEGIN_DATE,
		WEEK_END_DATE_NKEY,
		WEEK_END_DATE,
		WEEK_NUM_IN_YEAR,
		MONTH_NAME,
		MONTH_ABBREV,
		MONTH_NUM_IN_YEAR,
		YEARMONTH,
		CURRENT_QUARTER,
		YEARQUARTER,
		CURRENT_YEAR,
		FISCAL_WEEK_NUM,
		FISCAL_MONTH_NUM,
		FISCAL_YEARMONTH,
		FISCAL_QUARTER,
		FISCAL_YEARQUARTER,
		FISCAL_HALFYEAR,
		FISCAL_YEAR,
		SQL_TIMESTAMP,
		CURRENT_ROW_IND,
		EFFECTIVE_DATE,
		EXPIRA_DATE
	from 
	    
        
    --( select to_date('01-25-2019 23:25:11.120','MM-DD-YYYY HH24:MI:SS.FF') as DD, /*<<Modify date for preferred table start date*/    
    ( select to_date('2013-01-01 00:00:01','YYYY-MM-DD HH24:MI:SS') as DD, /*<<Modify date for preferred table start date*/
			seq1() as Sl,row_number() over (order by Sl) as row_numbers,
			dateadd(day,row_numbers,DD) as V_DATE,
			case when date_part(dd, V_DATE) < 10 and date_part(mm, V_DATE) > 9 then
				date_part(year, V_DATE)||date_part(mm, V_DATE)||'0'||date_part(dd, V_DATE)
				 when date_part(dd, V_DATE) < 10 and  date_part(mm, V_DATE) < 10 then 
				 date_part(year, V_DATE)||'0'||date_part(mm, V_DATE)||'0'||date_part(dd, V_DATE)
				 when date_part(dd, V_DATE) > 9 and  date_part(mm, V_DATE) < 10 then
				 date_part(year, V_DATE)||'0'||date_part(mm, V_DATE)||date_part(dd, V_DATE)
				 when date_part(dd, V_DATE) > 9 and  date_part(mm, V_DATE) > 9 then
				 date_part(year, V_DATE)||date_part(mm, V_DATE)||date_part(dd, V_DATE) end as DATE_PKEY,
			V_DATE as DATE_COLUMN,
			dayname(dateadd(day,row_numbers,DD)) as DAY_NAME_1,
			case 
				when dayname(dateadd(day,row_numbers,DD)) = 'Mon' then 'Monday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Tue' then 'Tuesday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Wed' then 'Wednesday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Thu' then 'Thursday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Fri' then 'Friday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Sat' then 'Saturday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Sun' then 'Sunday' end ||', '||
			case when monthname(dateadd(day,row_numbers,DD)) ='Jan' then 'January'
				   when monthname(dateadd(day,row_numbers,DD)) ='Feb' then 'February'
				   when monthname(dateadd(day,row_numbers,DD)) ='Mar' then 'March'
				   when monthname(dateadd(day,row_numbers,DD)) ='Apr' then 'April'
				   when monthname(dateadd(day,row_numbers,DD)) ='May' then 'May'
				   when monthname(dateadd(day,row_numbers,DD)) ='Jun' then 'June'
				   when monthname(dateadd(day,row_numbers,DD)) ='Jul' then 'July'
				   when monthname(dateadd(day,row_numbers,DD)) ='Aug' then 'August'
				   when monthname(dateadd(day,row_numbers,DD)) ='Sep' then 'September'
				   when monthname(dateadd(day,row_numbers,DD)) ='Oct' then 'October'
				   when monthname(dateadd(day,row_numbers,DD)) ='Nov' then 'November'
				   when monthname(dateadd(day,row_numbers,DD)) ='Dec' then 'December' end
				   ||' '|| to_varchar(dateadd(day,row_numbers,DD), ' dd, yyyy') as FULL_DATE_DESC,
			dateadd(day,row_numbers,DD) as V_DATE_1,
			dayofweek(V_DATE_1)+1 as DAY_NUM_IN_WEEK,
			Date_part(dd,V_DATE_1) as DAY_NUM_IN_MONTH,
			dayofyear(V_DATE_1) as DAY_NUM_IN_YEAR,
			case 
				when dayname(V_DATE_1) = 'Mon' then 'Monday'
				when dayname(V_DATE_1) = 'Tue' then 'Tuesday'
				when dayname(V_DATE_1) = 'Wed' then 'Wednesday'
				when dayname(V_DATE_1) = 'Thu' then 'Thursday'
				when dayname(V_DATE_1) = 'Fri' then 'Friday'
				when dayname(V_DATE_1) = 'Sat' then 'Saturday'
				when dayname(V_DATE_1) = 'Sun' then 'Sunday' end as	DAY_NAME,
			dayname(dateadd(day,row_numbers,DD)) as DAY_ABBREV,
			case  
				when dayname(V_DATE_1) = 'Sun' and dayname(V_DATE_1) = 'Sat' then 
                 'Not-Weekday'
				else 'Weekday' end as WEEKDAY_IND,
			 case 
				when (DATE_PKEY = date_part(year, V_DATE)||'0101' or DATE_PKEY = date_part(year, V_DATE)||'0704' or
				DATE_PKEY = date_part(year, V_DATE)||'1225' or DATE_PKEY = date_part(year, V_DATE)||'1226') then  
				'Holiday' 
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Wed' 
				and dateadd(day,-2,last_day(V_DATE_1)) = V_DATE_1  then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Thu' 
				and dateadd(day,-3,last_day(V_DATE_1)) = V_DATE_1  then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Fri' 
				and dateadd(day,-4,last_day(V_DATE_1)) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Sat' 
				and dateadd(day,-5,last_day(V_DATE_1)) = V_DATE_1  then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Sun' 
				and dateadd(day,-6,last_day(V_DATE_1)) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Mon' 
				and last_day(V_DATE_1) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Tue' 
				and dateadd(day,-1 ,last_day(V_DATE_1)) = V_DATE_1  then
				'Holiday'
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Wed' 
				and dateadd(day,5,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Thu' 
				and dateadd(day,4,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Fri' 
				and dateadd(day,3,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sat' 
				and dateadd(day,2,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sun' 
				and dateadd(day,1,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Mon' 
				and date_part(year, V_DATE_1)||'-09-01' = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Tue' 
				and dateadd(day,6 ,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Wed' 
				and (dateadd(day,23,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1  or 
					 dateadd(day,22,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Thu' 
				and ( dateadd(day,22,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,21,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Fri' 
				and ( dateadd(day,21,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,20,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				 'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sat' 
				and ( dateadd(day,27,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,26,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sun' 
				and ( dateadd(day,26,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,25,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Mon' 
				and (dateadd(day,25,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,24,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Tue' 
				and (dateadd(day,24,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,23,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				 'Holiday'    
				else
				'Not-Holiday' end as US_HOLIDAY_IND,
			/*Modify the following for Company Specific Holidays*/
			case 
				when (DATE_PKEY = date_part(year, V_DATE)||'0101' or DATE_PKEY = date_part(year, V_DATE)||'0219'
				or DATE_PKEY = date_part(year, V_DATE)||'0528' or DATE_PKEY = date_part(year, V_DATE)||'0704' 
				or DATE_PKEY = date_part(year, V_DATE)||'1225' )then 
				'Holiday'               
                when monthname(V_DATE_1) ='Mar' and dayname(last_day(V_DATE_1)) = 'Fri' 
				and last_day(V_DATE_1) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Mar' and dayname(last_day(V_DATE_1)) = 'Sat' 
				and dateadd(day,-1,last_day(V_DATE_1)) = V_DATE_1  then
				'Holiday'
				when monthname(V_DATE_1) ='Mar' and dayname(last_day(V_DATE_1)) = 'Sun' 
				and dateadd(day,-2,last_day(V_DATE_1)) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Tue'
                and dateadd(day,3,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Wed' 
				and dateadd(day,2,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Thu'
                and dateadd(day,1,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Fri' 
				and date_part(year, V_DATE_1)||'-04-01' = V_DATE_1 then
				'Holiday'
                when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Wed' 
				and dateadd(day,5,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Thu' 
				and dateadd(day,4,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Fri' 
				and dateadd(day,3,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Sat' 
				and dateadd(day,2,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Sun' 
				and dateadd(day,1,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Mon' 
                and date_part(year, V_DATE_1)||'-04-01'= V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Tue' 
				and dateadd(day,6 ,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
				'Holiday'   
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Wed' 
				and dateadd(day,5,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Thu' 
				and dateadd(day,4,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Fri' 
				and dateadd(day,3,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sat' 
				and dateadd(day,2,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sun' 
				and dateadd(day,1,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Mon' 
                and date_part(year, V_DATE_1)||'-09-01' = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Tue' 
				and dateadd(day,6 ,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Wed' 
				and dateadd(day,23,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Thu' 
				and dateadd(day,22,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Fri' 
				and dateadd(day,21,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1  then
				 'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sat' 
				and dateadd(day,27,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sun' 
				and dateadd(day,26,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Mon' 
				and dateadd(day,25,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Tue' 
				and dateadd(day,24,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1  then
				 'Holiday'     
				else
				'Not-Holiday' end as COMPANY_HOLIDAY_IND,
			case                                           
				when last_day(V_DATE_1) = V_DATE_1 then 
				'Month-end'
				else 'Not-Month-end' end as MONTH_END_IND,
					
			case when date_part(mm,date_trunc('week',V_DATE_1)) < 10 and date_part(dd,date_trunc('week',V_DATE_1)) < 10 then
					  date_part(yyyy,date_trunc('week',V_DATE_1))||'0'||
					  date_part(mm,date_trunc('week',V_DATE_1))||'0'||
					  date_part(dd,date_trunc('week',V_DATE_1))  
				 when date_part(mm,date_trunc('week',V_DATE_1)) < 10 and date_part(dd,date_trunc('week',V_DATE_1)) > 9 then
						date_part(yyyy,date_trunc('week',V_DATE_1))||'0'||
						date_part(mm,date_trunc('week',V_DATE_1))||date_part(dd,date_trunc('week',V_DATE_1))    
				 when date_part(mm,date_trunc('week',V_DATE_1)) > 9 and date_part(dd,date_trunc('week',V_DATE_1)) < 10 then
						date_part(yyyy,date_trunc('week',V_DATE_1))||date_part(mm,date_trunc('week',V_DATE_1))||
						'0'||date_part(dd,date_trunc('week',V_DATE_1))    
				when date_part(mm,date_trunc('week',V_DATE_1)) > 9 and date_part(dd,date_trunc('week',V_DATE_1)) > 9 then
						date_part(yyyy,date_trunc('week',V_DATE_1))||
						date_part(mm,date_trunc('week',V_DATE_1))||
						date_part(dd,date_trunc('week',V_DATE_1)) end as WEEK_BEGIN_DATE_NKEY,
			date_trunc('week',V_DATE_1) as WEEK_BEGIN_DATE,

			case when  date_part(mm,last_day(V_DATE_1,'week')) < 10 and date_part(dd,last_day(V_DATE_1,'week')) < 10 then
					  date_part(yyyy,last_day(V_DATE_1,'week'))||'0'||
					  date_part(mm,last_day(V_DATE_1,'week'))||'0'||
					  date_part(dd,last_day(V_DATE_1,'week')) 
				 when  date_part(mm,last_day(V_DATE_1,'week')) < 10 and date_part(dd,last_day(V_DATE_1,'week')) > 9 then
					  date_part(yyyy,last_day(V_DATE_1,'week'))||'0'||
					  date_part(mm,last_day(V_DATE_1,'week'))||date_part(dd,last_day(V_DATE_1,'week'))   
				 when  date_part(mm,last_day(V_DATE_1,'week')) > 9 and date_part(dd,last_day(V_DATE_1,'week')) < 10  then
					  date_part(yyyy,last_day(V_DATE_1,'week'))||date_part(mm,last_day(V_DATE_1,'week'))||'0'||
					  date_part(dd,last_day(V_DATE_1,'week'))   
				 when  date_part(mm,last_day(V_DATE_1,'week')) > 9 and date_part(dd,last_day(V_DATE_1,'week')) > 9 then
					  date_part(yyyy,last_day(V_DATE_1,'week'))||
					  date_part(mm,last_day(V_DATE_1,'week'))||
					  date_part(dd,last_day(V_DATE_1,'week')) end as WEEK_END_DATE_NKEY,
			last_day(V_DATE_1,'week') as WEEK_END_DATE,
			week(V_DATE_1) as WEEK_NUM_IN_YEAR,
			case when monthname(V_DATE_1) ='Jan' then 'January'
				   when monthname(V_DATE_1) ='Feb' then 'February'
				   when monthname(V_DATE_1) ='Mar' then 'March'
				   when monthname(V_DATE_1) ='Apr' then 'April'
				   when monthname(V_DATE_1) ='May' then 'May'
				   when monthname(V_DATE_1) ='Jun' then 'June'
				   when monthname(V_DATE_1) ='Jul' then 'July'
				   when monthname(V_DATE_1) ='Aug' then 'August'
				   when monthname(V_DATE_1) ='Sep' then 'September'
				   when monthname(V_DATE_1) ='Oct' then 'October'
				   when monthname(V_DATE_1) ='Nov' then 'November'
				   when monthname(V_DATE_1) ='Dec' then 'December' end as MONTH_NAME,
			monthname(V_DATE_1) as MONTH_ABBREV,
			month(V_DATE_1) as MONTH_NUM_IN_YEAR,
			case when month(V_DATE_1) < 10 then 
			year(V_DATE_1)||'-0'||month(V_DATE_1)   
			else year(V_DATE_1)||'-'||month(V_DATE_1) end as YEARMONTH,
			quarter(V_DATE_1) as CURRENT_QUARTER,
			year(V_DATE_1)||'-0'||quarter(V_DATE_1) as YEARQUARTER,
			year(V_DATE_1) as CURRENT_YEAR,
			/*Modify the following based on company fiscal year - assumes Jan 01*/
            to_date(year(V_DATE_1)||'-01-01','YYYY-MM-DD') as FISCAL_CUR_YEAR,
            to_date(year(V_DATE_1) -1||'-01-01','YYYY-MM-DD') as FISCAL_PREV_YEAR,
			case when   V_DATE_1 < FISCAL_CUR_YEAR then
			datediff('week', FISCAL_PREV_YEAR,V_DATE_1)
			else 
			datediff('week', FISCAL_CUR_YEAR,V_DATE_1)  end as FISCAL_WEEK_NUM  ,
			decode(datediff('MONTH',FISCAL_CUR_YEAR, V_DATE_1)+1 ,-2,10,-1,11,0,12,
                   datediff('MONTH',FISCAL_CUR_YEAR, V_DATE_1)+1 ) as FISCAL_MONTH_NUM,
			concat( year(FISCAL_CUR_YEAR) 
				   ,case when to_number(FISCAL_MONTH_NUM) = 10 or 
							to_number(FISCAL_MONTH_NUM) = 11 or 
                            to_number(FISCAL_MONTH_NUM) = 12  then
							'-'||FISCAL_MONTH_NUM
					else  concat('-0',FISCAL_MONTH_NUM) end ) as FISCAL_YEARMONTH,
			case when quarter(V_DATE_1) = 4 then 4
				 when quarter(V_DATE_1) = 3 then 3
				 when quarter(V_DATE_1) = 2 then 2
				 when quarter(V_DATE_1) = 1 then 1 end as FISCAL_QUARTER,
			
			case when   V_DATE_1 < FISCAL_CUR_YEAR then
					year(FISCAL_CUR_YEAR)
					else year(FISCAL_CUR_YEAR)+1 end
					||'-0'||case when quarter(V_DATE_1) = 4 then 4
					 when quarter(V_DATE_1) = 3 then 3
					 when quarter(V_DATE_1) = 2 then 2
					 when quarter(V_DATE_1) = 1 then 1 end as FISCAL_YEARQUARTER,
			case when quarter(V_DATE_1) = 4  then 2 when quarter(V_DATE_1) = 3 then 2
				when quarter(V_DATE_1) = 1  then 1 when quarter(V_DATE_1) = 2 then 1
			end as FISCAL_HALFYEAR,
			year(FISCAL_CUR_YEAR) as FISCAL_YEAR,
			to_timestamp_ntz(V_DATE) as SQL_TIMESTAMP,
			'Y' as CURRENT_ROW_IND,
			to_date(current_timestamp) as EFFECTIVE_DATE,
			to_date('9999-12-31') as EXPIRA_DATE
			--from table(generator(rowcount => 8401)) /*<< Set to generate 20 years. Modify rowcount to increase or decrease size*/
	        from table(generator(rowcount => 730)) /*<< Set to generate 20 years. Modify rowcount to increase or decrease size*/
    )v;

--Miscellaneous queries
select * from  DIM_DATE
ORDER BY DATE;


--delete from DIM_DATE;

--drop table DIM_DATE;




// ------------------------------------------------------------------------------------------- Load Dim_Product
/*
Steps:
    1. Create dimension tables
    2. Load Unknown Members
    3. Load Data
*****************************************/

--Check that table is clear
SELECT * FROM Dim_Product;

--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Product(
  DimProductID INT IDENTITY(1,1) CONSTRAINT PK_DimProductID PRIMARY KEY NOT NULL                               
  ,ProductID INTEGER NOT NULL
  ,ProductTypeID INTEGER NOT NULL                                
  ,ProductCategoryID INTEGER NOT NULL
  ,ProductName VARCHAR(255) NOT NULL                              
  ,ProductType VARCHAR(255) NOT NULL                               
  ,ProductCategory VARCHAR(255) NOT NULL                              
  ,ProductRetailPrice FLOAT NOT NULL                            
  ,ProductWholesalePrice FLOAT NOT NULL                                 
  ,ProductCost FLOAT NOT NULL                                
  ,ProductRetailProfit FLOAT NOT NULL                                  
  ,ProductWholesaleUnitProfit FLOAT NOT NULL                                    
  ,ProductProfitMarginUnitPercent FLOAT NOT NULL
);
  

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.

DROP TABLE Dim_Product

--Load unknown members
INSERT INTO Dim_Product
(
DimProductID 
  ,ProductID
  ,ProductTypeID 
  ,ProductCategoryID 
  ,ProductName 
  ,ProductType
  ,ProductCategory 
  ,ProductRetailPrice 
  ,ProductWholesalePrice 
  ,ProductCost 
  ,ProductRetailProfit 
  ,ProductWholesaleUnitProfit 
  ,ProductProfitMarginUnitPercent  
)
VALUES
( 
     -1
    ,-1
    ,-1
    ,-1
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    , 0
    , 0
    , 0
    , 0
    , 0
    , 0
);

SELECT * FROM Dim_Product;

--Load characters
INSERT INTO Dim_Product
(
DimProductID 
  ,ProductID
  ,ProductTypeID 
  ,ProductCategoryID 
  ,ProductName 
  ,ProductType
  ,ProductCategory 
  ,ProductRetailPrice 
  ,ProductWholesalePrice 
  ,ProductCost 
  ,ProductRetailProfit 
  ,ProductWholesaleUnitProfit 
  ,ProductProfitMarginUnitPercent  
)
	SELECT P.ProductID As DimProductID 
  ,P.ProductID As ProductID
  ,P.ProductTypeID 
  ,PT.ProductCategoryID 
  ,P.Product As ProductName
  ,PT.ProductType
  ,PG.ProductCategory 
  ,P.Price As ProductRetailPrice
  ,P.WholesalePrice As ProductWholesaleprice
  ,P.Cost As ProductCost
  ,(P.UnitOfMeasureID*P.Price) - (P.UnitOfMeasureID*P.Cost) As ProductRetailProfit
  ,(P.Price * P.WholesalePrice) - (P.UnitOfMeasureID * P.Cost) As ProductWholesaleUnitProfit
  ,(P.Price - P.Cost) / (P.Price) As ProductProfitMarginUnitPercent
	From STAGE_PRODUCT As P
Join STAGE_PRODUCT_TYPE As PT on P.ProductTypeID = PT.ProductTypeID
Join STAGE_PRODUCT_CATEGORY As PG on PT.ProductCategoryID = PG.ProductCategoryID


SELECT * FROM Dim_Product;

// ------------------------------------------------------------------------------------------- Load Dim_Store

--Check that table is clear
SELECT * FROM Dim_Store;

--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Store(
  DimStoreID INT IDENTITY(1,1) CONSTRAINT PK_DimStoreID PRIMARY KEY NOT NULL
  , DimLocationID INT FOREIGN KEY REFERENCES DIM_LOCATION(DimLocationID) NOT NULL
  , SourceStoreID INTEGER NOT NULL
  , StoreName VARCHAR(255) NOT NULL
  , StoreNumber INTEGER NOT NULL
  , StoreManager VARCHAR(255) NOT NULL
  );
  

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.

DROP TABLE Dim_Store

--Load unknown members
INSERT INTO Dim_Store
(
  DimStoreID
  , DimLocationID
  , SourceStoreID
  , StoreName 
  , StoreNumber
  , StoreManager
)
VALUES
( 
     -1
    ,-1
    ,-1
    ,'Unknown' 
    ,-1
    ,'Unknown'
);

SELECT * FROM Dim_Store;

--Load characters
INSERT INTO Dim_Store
(
  DimStoreID
  , DimLocationID
  , SourceStoreID
  , StoreName
  , StoreNumber
  , StoreManager
)
	SELECT S.StoreID AS DimStoreID
  , L.DimLocationID
  , S.StoreID As SourceStoreID
  , CONCAT('Store Name ', S.StoreNumber)
  , S.StoreNumber
  , S.StoreManager
	FROM STAGE_STORE AS S
    JOIN DIM_LOCATION AS L ON S.Address = L.Address


SELECT * FROM Dim_Store;




// ------------------------------------------------------------------------------------------- Load Dim_Reseller

--Check that table is clear
SELECT * FROM Dim_Reseller;

--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Reseller(
  DimResellerID INT IDENTITY(1,1) CONSTRAINT PK_DimResellerID PRIMARY KEY NOT NULL
  , DimLocationID INT FOREIGN KEY REFERENCES DIM_LOCATION(DimLocationID) NOT NULL
  , ResellerID VARCHAR(255) NOT NULL
  , ResellerName VARCHAR(255) NOT NULL
  , ContactName VARCHAR(255) NOT NULL
  , PhoneNumber VARCHAR(255) NOT NULL
  , Email VARCHAR(255) NOT NULL
  );
  

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.

DROP TABLE Dim_Reseller

--Load unknown members
INSERT INTO Dim_Reseller
(
  DimResellerID
  , DimLocationID
  , ResellerID
  , ResellerName
  , ContactName
  , PhoneNumber
  , Email
)
VALUES
( 
     -1
    ,-1
    ,'Unknown'
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
);

SELECT * FROM Dim_Reseller;

--Load characters
INSERT INTO Dim_Reseller
(
  DimLocationID
  , ResellerID
  , ResellerName
  , ContactName
  , PhoneNumber
  , Email
)
	SELECT 
  L.DimLocationID
  , R.ResellerID 
  , R.ResellerName
  , R.Contact As ContactName
  , R.PhoneNumber
  , R.EmailAddress As Email
	FROM STAGE_RESELLER AS R
    JOIN DIM_LOCATION AS L ON R.Address = L.Address


SELECT * FROM Dim_Reseller;



// ------------------------------------------------------------------------------------------- Load Dim_Customer

--Check that table is clear
SELECT * FROM Dim_Customer;

--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Customer(
    DimCustomerID INT IDENTITY(1,1) CONSTRAINT PK_DimCustomerID PRIMARY KEY NOT NULL
  , DimLocationID INT FOREIGN KEY REFERENCES DIM_LOCATION(DimLocationID) NOT NULL
  , CustomerID VARCHAR(255) NOT NULL
  , CustomerFullName VARCHAR(255) NOT NULL
  , CustomerFirstName VARCHAR(255) NOT NULL 
  , CustomerLastName VARCHAR(255) NOT NULL
  , CustomerGender VARCHAR(255) NOT NULL
  );
  

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.

DROP TABLE Dim_Customer

--Load unknown members
INSERT INTO Dim_Customer
(
    DimCustomerID
  , DimLocationID
  , CustomerID
  , CustomerFullName 
  , CustomerFirstName
  , CustomerLastName
  , CustomerGender
)
VALUES
( 
     -1
    ,-1
    ,'Unknown'
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
);

SELECT * FROM Dim_Customer;

--Load characters
INSERT INTO Dim_Customer
(

  DimLocationID
  , CustomerID
  , CustomerFullName
  , CustomerFirstName
  , CustomerLastName
  , CustomerGender
)
	SELECT 
  L.DimLocationID
  , CU.CustomerID
  , CONCAT('CU.FirstName ', 'CU.LastName') AS FullName
  , CU.FirstName AS CustomerFirstName
  , CU.LastName As CustomerLastName
  , CU.Gender AS CustomerGender
	FROM STAGE_Customer AS CU
    JOIN DIM_LOCATION AS L ON CU.Address = L.Address


SELECT * FROM Dim_Customer;





// ------------------------------------------------------------------------------------------- Load Dim_Channel


--Check that table is clear
SELECT * FROM Dim_Channel;

--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Channel(
   DimChannelID INT IDENTITY(1,1) CONSTRAINT PK_ChannelID PRIMARY KEY NOT NULL
  , ChannelID INTEGER NOT NULL
  , ChannelCategoryID INTEGER NOT NULL
  , ChannelName VARCHAR(255) NOT NULL
  , ChannelCategory VARCHAR(255) NOT NULL
  );
  

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.

DROP TABLE Dim_Channel

--Load unknown members
INSERT INTO Dim_Channel
(
   DimChannelID
  , ChannelID
  , ChannelCategoryID
  , ChannelName 
  , ChannelCategory
)
VALUES
( 
     -1
    ,-1
    ,-1
    ,'Unknown' 
    ,'Unknown'
);

SELECT * FROM Dim_Channel;

--Load characters
INSERT INTO Dim_Channel
(
   DimChannelID
  , ChannelID
  , ChannelCategoryID
  , ChannelName
  , ChannelCategory
)
	SELECT C.ChannelID AS DimChannelID
  , C.ChannelID
  , CC.ChannelCategoryID
  , C.Channel AS ChannelName
  , CC.ChannelCategory
	FROM STAGE_Channel AS C
    JOIN STAGE_Channel_Category AS CC ON C.ChannelCategoryID = CC.ChannelCategoryID


SELECT * FROM Dim_Channel;









// ------------------------------------------------------------------------------------------- Load Dim_Location


--Check that table is clear
SELECT * FROM Dim_Location;

--CREATE TABLE
CREATE OR REPLACE TABLE Dim_Location(
     DimLocationID INT IDENTITY(1,1) CONSTRAINT PK_LocationID PRIMARY KEY NOT NULL
  , Address VARCHAR(255) NOT NULL
  , City VARCHAR(255) NOT NULL
  , PostalCode VARCHAR(255) NOT NULL
  , State_Province VARCHAR(255) NOT NULL
  , Country VARCHAR(255) NOT NULL
  ); 
  

--does the table look like you want it? If not, modify the code and 
--re-create it or drop and re-create via the web interface.

DROP TABLE Dim_Location

--Load unknown members
INSERT INTO Dim_Location
(
     DimLocationID
  , Address
  , City
  , PostalCode
  , State_Province
  , Country
)
VALUES
( 
     -1
    ,'Unknown' 
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
    ,'Unknown'
);

SELECT * FROM Dim_Location;

--Load characters
INSERT INTO Dim_Location
(
  Address
  , City
  , PostalCode
  , State_Province
  , Country
)
	SELECT 
  Address
  , City
  , PostalCode
  , StateProvince As State_Province
  , Country
	FROM STAGE_RESELLER -- FROM STAGE_STORE-- FROM STAGE_CUSTOMER 

-- Which Tables am I taking it from?

SELECT * FROM Dim_Location;















