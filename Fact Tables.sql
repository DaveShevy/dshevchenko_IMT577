----------------------------------------------- Product Fact Table
-- Insert values from Professors Model Fact Table
CREATE OR REPLACE TABLE Fact_ProductSalesTarget(
    DimProductID INTEGER CONSTRAINT FK_DimFactProductID FOREIGN KEY REFERENCES Dim_Product (DimProductID)
   ,DimTargetDateID NUMBER(9) CONSTRAINT FK_DimFactProductTargetDate FOREIGN KEY REFERENCES Dim_Date (DATE_PKEY)
   ,ProductTargetSalesQuantity DECIMAL (16,6)
);

-- Re-Enter values to Insert INTO
INSERT INTO Fact_ProductSalesTarget
(
    DimProductID
   ,DimTargetDateID
   ,ProductTargetSalesQuantity
)

-- Select DISTINCT Values you want to insert from necessary tables, FROM Table
SELECT DISTINCT Dim_Product.DimProductID, Dim_Date.DATE_PKEY, Stage_Target_Data_Product.SalesQuantityTarget
FROM Stage_Target_Data_Product
INNER JOIN Dim_Product ON Dim_Product.DimProductID = Stage_Target_Data_Product.ProductID
LEFT OUTER JOIN Dim_Date ON Dim_Date.Year = Stage_Target_Data_Product.Year


---------------------------------------------- Fact_SRC Sales Target 

-- Insert values from Professors Model Fact Table
CREATE OR REPLACE TABLE Fact_SRCSalesTarget( 
    DimStoreID INTEGER CONSTRAINT FK_DimFactStoreID FOREIGN KEY REFERENCES Dim_Store (DimstoreID)
   ,DimTargetDateID NUMBER(9) CONSTRAINT FK_DimFactProductTargetDate FOREIGN KEY REFERENCES Dim_Date (DATE_PKEY)
   ,DIMRESELLERID INTEGER CONSTRAINT FK_DIMFACTRESELLERID FOREIGN KEY REFERENCES DIM_RESELLER (DIMRESELLERID)
   ,DIMCHANNELID INTEGER CONSTRAINT FK_DIMFACTCHANNELID FOREIGN KEY REFERENCES DIM_CHANNEL (DimCHANNELID)
   ,SALESTARGETAMOUNT INTEGER
);


-- Re-Enter values for Insert INTO Statement
INSERT INTO Fact_SRCSalesTarget
(
   DimStoreID
   ,DimResellerID
   ,DimChannelID
   --,DimTargetDateID
   ,SalesTargetAmount
)


SELECT Dim_Store.DimStoreID, Dim_Reseller.DimResellerID, Dim_Channel.DimChannelID, STAGE_TARGET_DATA.TARGETSALESAMOUNT --Dim_Date.DATE,
FROM STAGE_TARGET_DATA 
INNER JOIN Dim_Channel ON Dim_Channel.ChannelName = STAGE_TARGET_DATA.ChannelName
LEFT OUTER JOIN Dim_Store ON Dim_Store.StoreName = STAGE_TARGET_DATA.TargetName
LEFT OUTER JOIN Dim_Reseller ON Dim_Reseller.ResellerName = STAGE_TARGET_DATA.TargetName
LEFT OUTER JOIN Dim_Date ON Dim_Date.DATE = STAGE_TARGET_DATA.YEAR


--- 

CREATE OR REPLACE TABLE Fact_SalesActual(
   DimProductID INTEGER CONSTRAINT FK_DimFactProductID FOREIGN KEY REFERENCES Dim_Product (DimProductID)
   ,DimStoreID INTEGER CONSTRAINT FK_DimFactStoreID FOREIGN KEY REFERENCES Dim_Store (DimstoreID)
   ,DIMRESELLERID INTEGER CONSTRAINT FK_DIMFACTRESELLERID FOREIGN KEY REFERENCES DIM_RESELLER (DIMRESELLERID)
   ,DIMCUSTOMERID INTEGER CONSTRAINT FK_DIMFACTCUSTOMERID FOREIGN KEY REFERENCES DIM_Customer (DimCustomerID)
   ,DIMCHANNELID INTEGER CONSTRAINT FK_DIMFACTCHANNELID FOREIGN KEY REFERENCES DIM_CHANNEL (DimCHANNELID)
   --,DIMSALEDATEID INTEGER CONSTRAINT FK_DIMFACTSALEDATEID FOREIGN KEY REFERENCES DIM_SaleDateID ()
   ,DIMLocationID INTEGER CONSTRAINT FK_DIMFACTLOCATIONID FOREIGN KEY REFERENCES DIM_Location (DimLocationID)
   ,SalesHeaderID INTEGER
   ,SalesDetailID INTEGER
   ,SalesAmount INTEGER
   ,SalesQuantity INTEGER
   ,SaleUnitPrice INTEGER
   ,SaleExtendedCost INTEGER
   ,SaleTotalProfit INTEGER
);

INSERT INTO Fact_SalesActual
(
   ,DimProductID 
   ,DimStoreID 
   ,DIMRESELLERID 
   ,DIMCUSTOMERID 
   ,DIMCHANNELID 
   ,DIMSALEDATEID 
   ,DIMLocationID  
   ,SalesHeaderID 
   ,SalesDetailID 
   ,SalesAmount 
   ,SalesQuantity 
   ,SaleUnitPrice 
   ,SaleExtendedCost 
   ,SaleTotalProfit 
);

--- Still trying to figure out SELECT Statement