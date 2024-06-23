drop DATABASE shopapp;
create DATABASE shopapp;
use shopapp;

CREATE TABLE users(
	id INT PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(100) DEFAULT '',
    phone_number VARCHAR(10) NOT NULL,
    address VARCHAR(200) DEFAULT '',
    password VARCHAR(100) NOT NULL DEFAULT '',
    created_at DATETIME,
    updated_at DATETIME,
    is_active TINYINT(1) DEFAULT 1,
    date_of_birth DATE,
    facebook_account_id INT DEFAULT 0,
    google_account_id INT DEFAULT 0
);
ALTER TABLE users ADD COLUMN role_id int;

CREATE TABLE roles(
	id int PRIMARY KEY,
    name varchar(20) NOT null
);

ALTER TABLE users ADD FOREIGN KEY (role_id) REFERENCES roles(id);

CREATE TABLE tokens(
	id INT PRIMARY KEY AUTO_INCREMENT,
    token varchar(255) UNIQUE NOT NUll,
    token_type varchar(50) not null,
    expiration_date DATETIME,
    revoked TINYINT(1) NOT NULL,
    expired TINYINT(1) NOT NULL,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE social_accounts(
	id int PRIMARY KEY AUTO_INCREMENT,
    provider varchar(20) NOT null,
    provider_id varchar(50) NOT null,
    email varchar(150) NOT null,
    name varchar(100) NOT null,
    user_id int,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE catogories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) not null DEFAULT ''
);
CREATE TABLE products(
	id int PRIMARY KEY AUTO_INCREMENT,
    name varchar(350),
    price float not null CHECK (price >= 0),
   	thumbnail varchar(300) DEFAULT '',
    description LONGTEXT,
    created_at DATETIME,
    updated_at DATETIME,
    category_id int,
    FOREIGN KEY (category_id) REFERENCES catogories(id)
);
CREATE TABLE orders(
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id int,
	FOREIGN KEY (user_id) REFERENCES users(id),
    fullname varchar(100) not null,
    email varchar(100) not null,
    phone_number varchar(20) NOT null,
    address varchar(200) not null,
    note varchar(100) DEFAULT '',
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status varchar(20),
    total_money float CHECK(total_money >= 0)
);
ALTER TABLE orders ADD COLUMN shipping_method VARCHAR(100);
ALTER TABLE orders ADD COLUMN shipping_address VARCHAR(200);
ALTER TABLE orders ADD COLUMN shipping_date DATE;
ALTER TABLE orders ADD COLUMN tracking_number VARCHAR(100);
ALTER TABLE orders ADD COLUMN payment_method VARCHAR(100);

ALTER TABLE orders ADD COLUMN active TINYINT(1);
ALTER TABLE orders MODIFY COLUMN status ENUM ('pending', 'processing', 'shipped', 'delivered', 'cancelled');

CREATE TABLE order_details(
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_id int,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    product_id int,
    FOREIGN KEY (product_id) REFERENCES products(id),
    price float CHECK(price >= 0),
    number_of_product int CHECK(number_of_product > 0),
    total_money float CHECK(total_money >=0 ),
    color varchar(20) DEFAULT ''
);
CREATE TABLE product_images(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT fk_product_images_product_id
        FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE,
    image_url varchar(300)
)
use shopapp;
-- Step 1: Disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Step 2: Run the update statement
UPDATE products
SET thumbnail = (
    SELECT image_url
    FROM product_images
    WHERE products.id = product_images.product_id
    LIMIT 1
);

-- Step 3: Re-enable safe update mode
SET SQL_SAFE_UPDATES = 1;
