-- Active: 1742219115858@@127.0.0.1@5432@bookstore_db

-- create table for books
CREATE Table books (
    id int NOT NULL,
    title varchar(255) NOT NULL,
    Author varchar(255) NOT NULL,
    price int NOT NULL,
    stock int NOT NULL,
    published_year int NOT NULL,
    PRIMARY KEY (id)
);
-- insert dummy data for books
INSERT INTO
    books (
        id,
        title,
        Author,
        price,
        stock,
        published_year
    )
VALUES (
        1,
        'The Great Adventure',
        'John Doe',
        199,
        50,
        2015
    ),
    (
        2,
        'Mystery of the Night',
        'Jane Smith',
        249,
        100,
        2018
    ),
    (
        3,
        'Programming in Python',
        'Mark Brown',
        149,
        30,
        2020
    ),
    (
        4,
        'A Journey to Remember',
        'Emily White',
        299,
        80,
        2012
    ),
    (
        5,
        'The Secret Garden',
        'Michael Black',
        179,
        60,
        2016
    ),
    (
        6,
        'Data Science Essentials',
        'Sarah Johnson',
        349,
        120,
        2021
    ),
    (
        7,
        'The Art of War',
        'Stephen King',
        129,
        0,
        2005
    ),
    (
        8,
        'The Road Less Traveled',
        'David Lynch',
        229,
        90,
        2010
    ),
    (
        9,
        'Learning PostgreSQL',
        'James Bond',
        199,
        110,
        2019
    ),
    (
        10,
        'The Silent Witness',
        'Chris Martin',
        299,
        0,
        2022
    );

-- create table for customers
CREATE table customers (
    id int NOT NULL,
    name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    joined_date date NOT NULL,
    PRIMARY KEY (id)
)

-- insert dummy data for customers
INSERT INTO
    customers (id, name, email, joined_date)
VALUES (
        1,
        'Alice Johnson',
        'alice.johnson@example.com',
        '2022-01-15'
    ),
    (
        2,
        'Bob Smith',
        'bob.smith@example.com',
        '2021-12-10'
    ),
    (
        3,
        'Charlie Brown',
        'charlie.brown@example.com',
        '2020-09-25'
    ),
    (
        4,
        'David Williams',
        'david.williams@example.com',
        '2019-05-05'
    ),
    (
        5,
        'Emily Davis',
        'emily.davis@example.com',
        '2021-11-20'
    ),
    (
        6,
        'Frank Moore',
        'frank.moore@example.com',
        '2020-07-18'
    ),
    (
        7,
        'Grace Lee',
        'grace.lee@example.com',
        '2022-03-30'
    ),
    (
        8,
        'Henry Martin',
        'henry.martin@example.com',
        '2021-08-12'
    ),
    (
        9,
        'Ivy Thomas',
        'ivy.thomas@example.com',
        '2020-10-04'
    ),
    (
        10,
        'Jack Harris',
        'jack.harris@example.com',
        '2021-02-14'
    );

-- create table for orders
CREATE table orders (
    id int NOT NULL,
    book_id int REFERENCES "books" (id) on delete cascade,
    customer_id int REFERENCES "customers" (id) on delete cascade,
    quantity int NOT NULL,
    order_date date NOT NULL,
    PRIMARY KEY (id)
);

-- insert dummy data for orders
INSERT INTO
    orders (
        id,
        book_id,
        customer_id,
        quantity,
        order_date
    )
VALUES (1, 1, 1, 2, '2022-01-15'),
    (2, 2, 2, 1, '2021-12-10'),
    (3, 3, 2, 4, '2020-09-25'),
    (4, 4, 1, 1, '2019-05-05'),
    (5, 5, 3, 3, '2021-11-20'),

-- view column data
SELECT * from books;

SELECT * from customers;

SELECT * from orders;

-- modify column orders
ALTER TABLE orders ADD COLUMN order_date date NOT NULL;

-- 1️⃣ Find books that are out of stock.
SELECT * from books WHERE stock = 0;

-- 2️⃣ Retrieve the most expensive book in the store.
SELECT * from books ORDER BY price DESC LIMIT 1;

-- 3️⃣ Find the total number of orders placed by each customer.
SELECT customers.name as name, COUNT(orders.id) AS total_orders
FROM customers
    left join orders on customers.id = orders.customer_id
WHERE
    orders.quantity > 0
GROUP BY
    customers.id
ORDER BY total_orders DESC;

-- 4️⃣ Calculate the total revenue generated from book sales.
SELECT SUM(orders.quantity * books.price) AS total_revenue
FROM orders
    INNER JOIN books ON orders.book_id = books.id

--   5️⃣ List all customers who have placed more than one order.
SELECT customers.name as name, COUNT(orders.id) AS total_orders
FROM customers
    left join orders on customers.id = orders.customer_id
GROUP BY
    customers.id,
    customers.name
HAVING
    COUNT(orders.id) > 1;

-- 6️⃣ Find the average price of books in the store.
SELECT ROUND(AVG(books.price), 2) AS avg_book_price FROM books;

-- 7️⃣ Increase the price of all books published before 2000 by 10%.
UPDATE books SET price = price * 1.1 WHERE published_year < 2000;

-- 8️⃣ Delete customers who haven't placed any orders.
DELETE FROM customers
WHERE
    id NOT IN (
        SELECT DISTINCT
            customer_id
        FROM orders
    );