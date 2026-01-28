-- 1. Product Catalog (The Master List)
CREATE TABLE items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(255) NOT NULL,
    item_price DECIMAL(10, 2) NOT NULL
);

-- 2. Customer Registry
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL
);

-- 3. Order Headers (General info about the sale)
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT
);

-- 4. Order Item Lines (The specific products in each order)
CREATE TABLE order_item_line (
    order_id INT,
    item_id INT,
    -- We include these to lock in the price/name at the time of purchase
    item_name VARCHAR(255), 
    item_price DECIMAL(10, 2),
    
    PRIMARY KEY (order_id, item_id),
    
    -- Link to the Order (if the order is deleted, these lines go with it)
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    
    -- Link to the Item (RESTRICT prevents deleting a product if it was ever sold)
    FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE RESTRICT
);