/*
Course: IMT 577
Instructor: Sean Petterson
Date: 02/04/2022
Notes: Complete Views with the Final DW 
*/


-- Views for each Dim Table

CREATE VIEW CHANNEL
AS
SELECT
    DIMCHANNELID,
    CHANNELID,
    CHANNELCATEGORYID,
    CHANNELNAME,
    CHANNELCATEGORY
FROM
    DIM_CHANNEL;
    
    
CREATE VIEW CUSTOMER
AS
SELECT
    DIMCUSTOMERID,
    DIMLOCATIONID,
    CUSTOMERID,
    CUSTOMERFULLNAME,
    CUSTOMERFIRSTNAME,
    CUSTOMERLASTNAME,
    CUSTOMERGENDER
FROM DIM_CUSTOMER;   


CREATE VIEW DATE
AS
SELECT
    DATE_PKEY,
    DATE,
    FULL_DATE_DESC,
    DAY_NUM_IN_WEEK,
    DAY_NUM_IN_MONTH,
    DAY_NUM_IN_YEAR,
    DAY_NAME,
    DAY_ABBREV,
    WEEKDAY_IND,
    US_HOLIDAY_IND,
    _HOLIDAY_IND,
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
    QUARTER,
    YEARQUARTER,
    YEAR,
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
    EXPIRATION_DATE
FROM DIM_DATE

CREATE VIEW LOCATION
AS
SELECT
    DIMLOCATIONID,
    ADDRESS,
    CITY,
    POSTALCODE,
    STATE_PROVINCE,
    COUNTRY
FROM DIM_LOCATION


CREATE VIEW PRODUCT
AS
SELECT
    DIMPRODUCTID,
    PRODUCTID,
    PRODUCTTYPEID,
    PRODUCTCATEGORYID,
    PRODUCTNAME,
    PRODUCTTYPE,
    PRODUCTCATEGORY,
    PRODUCTRETAILPRICE,
    PRODUCTWHOLESALEPRICE,
    PRODUCTCOST,
    PRODUCTRETAILPROFIT,
    PRODUCTWHOLESALEUNITPROFIT,
    PRODUCTPROFITMARGINUNITPERCENT
FROM DIM_PRODUCT


CREATE VIEW RESELLER
AS
SELECT
    DIMRESELLERID,
    DIMLOCATIONID,
    RESELLERID,
    RESELLERNAME,
    CONTACTNAME,
    PHONENUMBER,
    EMAIL
FROM DIM_RESELLER

CREATE VIEW STORE
AS
SELECT
    DIMSTOREID,
    DIMLOCATIONID,
    SOURCESTOREID,
    STORENAME,
    STORENUMBER,
    STOREMANAGER
FROM DIM_STORE

CREATE VIEW PRODUCTSALESTARGET
AS
SELECT
    DIMPRODUCTID,
    DIMTARGETDATEID,
    PRODUCTTARGETSALESQUANTITY
FROM FACT_PRODUCTSALESTARGET

CREATE VIEW SALESACTUAL
AS
SELECT
    DIMPRODUCTID,
    DIMSTOREID,
    DIMRESELLERID,
    DIMCUSTOMERID,
    DIMCHANNELID,
    DIMLOCATIONID,
    SALESHEADERID,
    SALESDETAILID,
    SALESAMOUNT,
    SALESQUANTITY,
    SALEUNITPRICE,
    SALEEXTENDEDCOST,
    SALETOTALPROFIT
FROM FACT_SALESACTUAL

CREATE VIEW SRCSALESTARGET
AS
SELECT
    DIMSTOREID,
    DIMTARGETDATEID,
    DIMRESELLERID,
    DIMCHANNELID,
    SALESTARGETAMOUNT
FROM Fact_SRCSalesTarget




-----------------------------------------------------------------------------------------------------------------------------------------------------------


-- Question 1 Overall Assessment of Stores Number 5 and 8's Sales
  -- Performing compared to target? Will they meet 2021 Target?
  -- Should either store be closed?
  -- What should be done in the next year to maximize store profits?
  
CREATE OR REPLACE VIEW PERFORMANCE
AS
SELECT
    DIM_STORE.STORENUMBER,
    DIM_DATE.YEAR,
    FACT_SRCSALESTARGET.SALESTARGETAMOUNT,
    SUM(FACT_SALESACTUAL.SALESAMOUNT) AS TOTAL_SALES
FROM 
    FACT_SALESACTUAL INNER JOIN DIM_DATE ON FACT_SALESACTUAL.DIMSALEDATEID = DIM_DATE.DATE_PKEY
INNER JOIN DIM_STORE ON FACT_SALESACTUAL.DIMSTOREID = DIM_STORE.DIMSTOREID
INNER JOIN FACT_SRCSALESTARGET ON FACT_SRCSALESTARGET.DIMSTOREID = DIM_STORE.STORENUMBER AND FACT_SRCSALESTARGET.DIMTARGETDATEID = FACT_SALESACTUAL.DIMSALEDATEID
WHERE STORENUMBER IN ('5', '8')
GROUP BY DIM_STORE.STORENUMBER, DIM_DATE.YEAR, FACT_SRCSALESTARGET.SALESTARGETAMOUNT;
  
  
SELECT DIM_DATE.DAY_NUM_IN_WEEK	FROM DIM_DATE

-- Question 2: Recommend separate 2020 and 2021 bonus amounts for each store if the total bonus pool for 2020 is 
-- $500,000 and the total bonus pool for 2021 is $400,000. Base your recommendation on how well the stores are selling
-- Product Types of Men's Casual and Women's Casual.

CREATE VIEW BONUS_AMOUNT
AS
SELECT
    DIM_STORE.STORENUMBER,
    DIM_DATE.YEAR,
    DIM_PRODUCT.PRODUCTTYPE,
    SUM(FACT_SALESACTUAL.SALESQUANTITY) AS TOTAL_Quantity
FROM 
    FACT_SALESACTUAL INNER JOIN DIM_DATE ON FACT_SALESACTUAL.DIMSALEDATEID = DIM_DATE.DATE_PKEY
INNER JOIN DIM_STORE ON FACT_SALESACTUAL.DIMSTOREID = DIM_STORE.DIMSTOREID
INNER JOIN DIM_PRODUCT ON DIM_PRODUCT.DIMPRODUCTID = FACT_SALESACTUAL.DIMPRODUCTID 
WHERE PRODUCTTYPE LIKE '%Casual%' AND STORENUMBER IN ('5', '8')
GROUP BY DIM_PRODUCT.PRODUCTTYPE, DIM_STORE.STORENUMBER, DIM_DATE.YEAR;



-- Question 3: Assess Product Sales by Day of the week at stores 5 and 8. What can we learn about sale Trends?

CREATE VIEW PRODUCT_SALE_BY_DAY_OF_WEEK
AS
SELECT
    DIM_STORE.STORENUMBER,
    DIM_DATE.DAY_NUM_IN_WEEK,
    SUM(FACT_SALESACTUAL.SALESAMOUNT) AS TOTAL_SALES
FROM 
    FACT_SALESACTUAL INNER JOIN DIM_DATE ON FACT_SALESACTUAL.DIMSALEDATEID = DIM_DATE.DATE_PKEY
INNER JOIN DIM_STORE ON FACT_SALESACTUAL.DIMSTOREID = DIM_STORE.DIMSTOREID
WHERE STORENUMBER IN ('5', '8')
GROUP BY DIM_DATE.DAY_NUM_IN_WEEK, DIM_STORE.STORENUMBER;

-- Question 4: Compare the performance of all stores located in states that have more than 
-- one store to all stores that are the only store in the state. What can we learn about having more than one store in a state?








