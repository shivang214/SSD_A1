

ALTER TABLE brandDetails
ADD PRIMARY KEY (`Brand ID`);

ALTER TABLE orderDetails
ADD PRIMARY KEY (`Order ID`);

ALTER TABLE userDetails
ADD PRIMARY KEY (`User ID`);

ALTER TABLE orderDetails 
ADD CONSTRAINT BuyerID_fk FOREIGN KEY (`Buyer ID`) REFERENCES userDetails (`User ID`);


ALTER TABLE orderDetails
ADD CONSTRAINT SellerID_fk FOREIGN KEY (`Seller ID`) REFERENCES userDetails(`User ID`);


ALTER TABLE orderDetails 
ADD CONSTRAINT BrandID_fk FOREIGN KEY (`Brand ID`) REFERENCES brandDetails(`Brand ID`);

CREATE TABLE report (
    UserID INT,
    UserName VARCHAR(50),
    Result VARCHAR(3)
);




INSERT INTO report (UserID, UserName, Result)
SELECT
    u.`User ID` AS UserID,
    u.`Name` AS UserName,
    
     CASE
        WHEN o2.`Brand ID` = u.`Favorite Laptop Brand` THEN 'Yes'
        WHEN IFNULL(seller_item_count, 0) >= 3 THEN 'Yes'
        ELSE 'No'
     END AS Result
     
FROM userDetails u

  LEFT JOIN (
      SELECT
          o2.`Seller ID`,
          o2.`Brand ID`
    
    
    
    FROM orderDetails o2
    
    JOIN (
        SELECT
            `Seller ID`,
            MIN(`Order Date`) AS SecondSaleDate
           
           
            FROM orderDetails
          GROUP BY `Seller ID`
    ) AS second_sale ON o2.`Seller ID` = second_sale.`Seller ID` 
    
    
       WHERE o2.`Order Date` = second_sale.SecondSaleDate
      ORDER BY o2.`Seller ID`
) AS o2 ON u.`User ID` = o2.`Seller ID`
LEFT JOIN (
    SELECT `Seller ID`, COUNT(*) AS seller_item_count
    FROM orderDetails
    GROUP BY `Seller ID`
) AS seller_counts ON u.`User ID` = seller_counts.`Seller ID`
ORDER BY UserID;


