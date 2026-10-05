# 📦 Zepto Inventory & Pricing Analysis

## 📌 Project Overview

This project focuses on analyzing Zepto's product inventory, stock availability, pricing, and discount patterns using **Excel, SQL Server, and Power BI**.

The objective was to transform raw inventory data into meaningful business insights and build an interactive Power BI dashboard that helps identify stock availability issues, category-level trends, inventory distribution, and pricing patterns.

---

## 🎯 Business Objective

The analysis was performed to answer key business questions such as:

- How many products are available in the dataset?
- How much total inventory is available?
- Which categories have the highest number of products?
- Which categories have the highest out-of-stock rates?
- Which products have the highest inventory?
- What is the average discount across categories?
- Which categories offer the highest discounts?
- What is the estimated inventory value by category?
- How does MRP compare with discounted selling price?
- How is inventory distributed across different weight bands?

---

## 📊 Dataset

The original dataset contained:

- **3,732 rows**
- **9 columns**

### Columns

| Column | Description |
|---|---|
| `Category` | Product category |
| `name` | Product name |
| `mrp` | Maximum Retail Price |
| `discountPercent` | Discount percentage |
| `availableQuantity` | Available inventory quantity |
| `discountedSellingPrice` | Selling price after discount |
| `weightInGms` | Product weight in grams |
| `outOfStock` | Stock availability status |
| `quantity` | Product quantity |

---

## 🧹 Data Cleaning & Preparation

The initial dataset was reviewed in **Excel** before performing the analysis.

### Data cleaning steps performed:

- Checked the dataset for missing/null values.
- No missing values were found.
- Identified **2 duplicate rows**.
- Removed the duplicate rows.
- Converted the dataset into an Excel Table for easier handling.
- Verified the final data before importing it into SQL Server.
- Saved the cleaned dataset as CSV for SQL Server import.

### Final Dataset

After removing duplicates:

**3,730 rows × 9 columns**

---

## 🛠️ Tools & Technologies

- **Microsoft Excel** – Data inspection and cleaning
- **SQL Server** – Data storage and business analysis
- **Power BI** – Interactive dashboard and data visualization

---

## 🗄️ SQL Server Analysis

The cleaned dataset was imported into **SQL Server** for further analysis.

I created SQL queries to analyze:

### Inventory Analysis
- Total number of products
- Total available inventory
- Products by category
- Highest inventory products
- Low-stock products
- Inventory contribution by category
- Estimated inventory value

### Stock Analysis
- Available vs out-of-stock products
- Overall out-of-stock rate
- Out-of-stock products by category
- Category-wise out-of-stock rate
- Stock-level classification
- Category ranking based on inventory

### Pricing & Discount Analysis
- Average MRP by category
- Average selling price by category
- Average price reduction
- Average discount percentage
- Products with high discounts
- Highest discount categories
- Products with MRP above the overall average

### Advanced Analysis
- High-discount and low-inventory products
- High-inventory and low-discount products
- Estimated inventory value
- Category ranking using window functions
- Product ranking within categories
- Inventory contribution percentage
- Discount analysis across different price ranges
- Highest average discount among in-stock products

---

## 📈 Power BI Dashboard

The final analysis was visualized using an interactive Power BI dashboard.

### Dashboard KPIs

- **Total Products**
- **Total Inventory**
- **Average Discount**
- **Out-of-Stock Rate**

### Dashboard Visualizations

- Product Distribution by Weight
- Out-of-Stock Rate by Weight Band
- Out-of-Stock Rate by Category
- Top 5 Categories by Products
- Average MRP vs Selling Price by Category
- Category and Stock Status filters

---

## 🔍 Key Insights

The dashboard helps identify:

- Categories with relatively high out-of-stock rates.
- Categories contributing significantly to total inventory.
- Differences between MRP and actual selling price.
- Distribution of products across different weight bands.
- Categories with higher average discount percentages.
- Products with high discounts but relatively low inventory.
- Inventory and pricing patterns across product categories.

---

## 🔄 Project Workflow

```text
Raw Dataset
     ↓
Excel
     ↓
Data Cleaning
     ↓
Duplicate Removal
     ↓
CSV Conversion
     ↓
SQL Server
     ↓
SQL Business Analysis
     ↓
Power BI
     ↓
Interactive Dashboard
