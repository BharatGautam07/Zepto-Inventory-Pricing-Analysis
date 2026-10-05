-- Null Values
SELECT * FROM zepto_inventory
WHERE name IS NULL
OR Category IS NULL
OR mrp IS NULL
OR discountPercent IS NULL
OR availableQuantity IS NULL
OR discountedSellingPrice IS NULL
OR weightInGms IS NULL
OR outOfStock IS NULL
OR quantity IS NULL;

-- Different Product Category
SELECT DISTINCT Category
FROM Zepto_Inventory
ORDER BY Category;

-- Products in stock vs out of stock
SELECT 
	outofStock,
	COUNT(*)
FROM zepto_inventory
GROUP BY outOfStock;

-- Product names presents multiple time
SELECT 
	name, 
	COUNT(*) AS number_of_products
FROM zepto_inventory
GROUP BY name
HAVING COUNT(*) >1
ORDER BY COUNT(*) DESC;

-- Data Cleaning
-- Products with price = 0
SELECT * FROM zepto_inventory
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto_inventory
WHERE mrp  = 0;

UPDATE zepto_inventory
SET mrp = mrp/100.0,
	discountedSellingPrice = discountedSellingPrice/100.0;

-- 1.What is the total number of products in the dataset?
SELECT 
	COUNT(DISTINCT name) 
FROM zepto_inventory;

-- 2.What is the total available inventory quantity?
SELECT 
	SUM(availableQuantity) AS Total_Availabe_Quantity
FROM zepto_inventory;

-- 3.How many unique product categories are there?
SELECT 
	COUNT(DISTINCT Category)
FROM zepto_inventory;

-- 4.How many products are available in each category?
SELECT 
	Category, 
	COUNT(Name) AS Total_Products
FROM zepto_inventory
GROUP BY Category;

-- 5.How many products are currently out of stock and how many are available?
SELECT 
	SUM(CASE WHEN OutOfStock = 1 THEN 1 END) AS  Out_Of_Stock,
	SUM(CASE WHEN OutofStock = 0 THEN 1 END) AS Available_Stock
FROM zepto_inventory;

-- 6.What percentage of products are out of stock?
SELECT 
	ROUND(
		SUM(CASE WHEN OutOfStock = 1 THEN 1 END) * 100 / COUNT(*),2) AS Out_of_Stock_Rate
FROM zepto_inventory;

-- 7.How many out-of-stock products are there in each category?
SELECT
	Category,
	COUNT(OutofStock) AS Out_of_stock
FROM zepto_inventory
WHERE outOfStock = 1
GROUP BY Category;

-- 8.Which categories have the highest out-of-stock rate?
SELECT 
	Category, 
	COUNT(*) AS Total_Products,
    SUM(CASE WHEN OutofStock = 1 THEN 1 ELSE 0 END) AS Out_of_Stock,
       CAST(
           SUM(CASE WHEN OutofStock = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Out_of_Stock_Rate
FROM zepto_inventory
GROUP BY Category
ORDER BY Out_of_Stock_Rate DESC;

-- 9.Which products have the highest available inventory quantity?
SELECT 
	Name, 
	SUM(AvailableQuantity) AS Total_Available_Quantity
FROM zepto_inventory
GROUP BY Name
ORDER BY Total_Available_Quantity DESC;

-- 10.Which products are currently low in stock (available quantity ≤ 10)?
SELECT 
	Name,
	AvailableQuantity
FROM zepto_inventory
WHERE AvailableQuantity <= 10;	

-- 11.What is the average MRP for each product category?
SELECT
	Category, 
	AVG(mrp) AS Avg_Mrp
FROM zepto_inventory
GROUP BY Category;

-- 12.What is the average selling price for each product category?
SELECT 
	Category,
	AVG(DiscountedSellingPrice) AS Avg_selling_price
FROM zepto_inventory
GROUP BY Category;

-- 13.Which products have the highest MRP?
SELECT 
	Name, 
	mrp 
FROM zepto_inventory
ORDER BY mrp DESC;

-- 14.What is the average price difference between MRP and discounted selling price?
SELECT 
	AVG(mrp) AS Avg_mrp, AVG(discountedSellingPrice) AS Avg_discounted_Price,
	AVG(mrp - discountedSellingPrice) AS Price_difference
FROM zepto_inventory;

-- 15.What is the average price reduction from MRP to discounted selling price by category?
SELECT 
	Category, 
	AVG(mrp - discountedSellingPrice) AS Avg_Price_Reduction
FROM zepto_inventory
GROUP BY Category;

-- 16.What is the average discount percentage for each category?
SELECT 
	Category,
	AVG(discountPercent) AS Avg_discount_rate
FROM zepto_inventory
GROUP BY Category;

-- 17.How many products have a discount greater than 30%?
SELECT 
	Name,
	discountPercent
FROM zepto_inventory
WHERE discountPercent > 30;

-- 18.Which category offers the highest average discount?
SELECT 
	Category,
	AVG(discountPercent) Avg_discount_rate
FROM zepto_inventory
GROUP BY Category
ORDER BY Avg_discount_rate DESC;

-- 19.What are the top 10 products with the highest discount percentage?
SELECT
	Name,
	discountPercent
FROM zepto_inventory
ORDER BY discountPercent DESC;

-- 20.Which products have an MRP higher than the overall average MRP?
SELECT
	Name, 
	mrp
FROM zepto_inventory
WHERE mrp > (SELECT AVG(mrp) FROM Zepto_Inventory);

-- 21.Which products have a high discount percentage but low available inventory?
SELECT 
	Name, 
	discountPercent, 
	AvailableQuantity
FROM zepto_inventory
WHERE discountPercent > 30 AND AvailableQuantity < 3;

-- 22.Which products have high inventory levels but relatively low discount percentages?
SELECT 
	Name, 
	AvailableQuantity,
	discountPercent
FROM zepto_inventory
WHERE availableQuantity > 5 AND discountPercent < 10;

-- 23.What is the estimated inventory value for each category based on available quantity and discounted selling price?
SELECT
    Category,
    SUM(availableQuantity * discountedSellingPrice) AS estimatedInventoryValue
FROM zepto_inventory
GROUP BY Category;

-- 24.Which category has the highest estimated inventory value?
SELECT
    Category,
    SUM(availableQuantity * discountedSellingPrice) AS estimatedInventoryValue,
	RANK() OVER(ORDER BY SUM(availableQuantity * discountedSellingPrice) DESC) AS inventoryRank
FROM zepto_inventory
GROUP BY Category;

-- 25.How can products be classified into different stock levels based on their available quantity?
SELECT 
	Name,
	SUM(availableQuantity) AS Available_Quantity,
	CASE
		WHEN SUM(availableQuantity) > 25 THEN 'HighStock'
		WHEN SUM(availableQuantity) BETWEEN 10 AND 25 THEN 'MediumStock'
		WHEN SUM(availableQuantity) BETWEEN 1 AND 10 THEN 'LowStock'
		ELSE 'OutofStock'
	END AS productClassification
FROM zepto_inventory
GROUP BY Name
ORDER BY 2 DESC;

-- 26.What percentage of the total available inventory does each category contribute?

SELECT
    category,
    SUM(availableQuantity) AS category_inventory,
    ROUND(SUM(availableQuantity) * 100.0 /
    SUM(SUM(availableQuantity)) OVER (),2) AS inventory_percentage
FROM zepto_inventory
GROUP BY category
ORDER BY inventory_percentage DESC;

-- 27.What is the ranking of categories based on total available inventory quantity?
SELECT
	Category,
	SUM(availableQuantity) AS Total_inventory,
	DENSE_RANK() OVER(ORDER BY SUM(availableQuantity) DESC)
FROM zepto_inventory
GROUP BY Category;

-- 28.Which products rank highest within each category based on discounted selling price?
SELECT 
	Category,
	Name,
	discountedSellingPrice,
	RANK() OVER(PARTITION BY Category ORDER BY discountedsellingPrice DESC)
FROM zepto_inventory;


-- 29.What is the average discount percentage across different price ranges?
SELECT
    CASE
		WHEN mrp <= 500 THEN '10-500'
        WHEN mrp <= 1000 THEN '501-1000'
        WHEN mrp <= 2000 THEN '1001-2000'
        ELSE '2000+'
    END AS price_range,
    ROUND(AVG(discountPercent), 2) AS avg_discount_percentage
FROM zepto_inventory
GROUP BY
    CASE
		WHEN mrp <= 500 THEN '10-500'
        WHEN mrp <= 1000 THEN '501-1000'
        WHEN mrp <= 2000 THEN '1001-2000'
        ELSE '2000+'
    END
ORDER BY MIN(mrp);

-- 30.Which category has the highest average discount percentage among products that are currently in stock?
SELECT TOP 1
    Category,
    AVG(discountPercent) AS Avg_Discount
FROM zepto_inventory
WHERE OutOfStock = 0
GROUP BY Category
ORDER BY Avg_Discount DESC;