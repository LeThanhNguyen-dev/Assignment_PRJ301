-- Tạo cơ sở dữ liệu
CREATE DATABASE PerfumeNhungChuBeDan;
GO
USE PerfumeNhungChuBeDan;
GO

-- Bảng Category
CREATE TABLE Category (
    categoryId INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE
);

-- Bảng Product
CREATE TABLE Product (
    productId   INT IDENTITY(1,1) PRIMARY KEY,
    name        NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX),
    image       NVARCHAR(255),  -- Hình ảnh chính
    price       DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    categoryId  INT NOT NULL,
    FOREIGN KEY (categoryId) REFERENCES Category(categoryId)
);

-- Bảng Customer
CREATE TABLE Customer (
    customerId INT IDENTITY(1,1) PRIMARY KEY,
    username   VARCHAR(50) UNIQUE NOT NULL,
    password   VARCHAR(255) NOT NULL,
    name       NVARCHAR(100) NOT NULL,
    phone      VARCHAR(15) NOT NULL,
    email      VARCHAR(100) UNIQUE NOT NULL,
    address    NVARCHAR(255) NOT NULL
);

-- Bảng Voucher
CREATE TABLE Voucher (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Thêm id làm khóa chính
    code VARCHAR(50) NOT NULL UNIQUE,  -- code là UNIQUE thay vì PRIMARY KEY
    discount DECIMAL(5,2) NOT NULL CHECK (discount >= 0 AND discount <= 100),  -- Đổi tên từ discountPercentage thành discount
    expiry_date DATE NOT NULL  -- Thêm expiry_date
);

-- Bảng Order
CREATE TABLE [Order] (
    orderId        INT IDENTITY(1,1) PRIMARY KEY,
    customerId     INT NOT NULL,
    orderDate      DATETIME DEFAULT GETDATE(),
    totalAmount    DECIMAL(10,2) NOT NULL,
    status         NVARCHAR(20) DEFAULT 'Processing' CHECK (status IN ('Processing', 'Completed', 'Failed')),
    shippingAddress NVARCHAR(255) NOT NULL,
    voucherCode    VARCHAR(50),  -- Mã voucher (nếu có)
    FOREIGN KEY (customerId) REFERENCES Customer(customerId),
    FOREIGN KEY (voucherCode) REFERENCES Voucher(code)  -- Khóa ngoại trỏ đến code thay vì id
);

-- Bảng OrderDetail
CREATE TABLE OrderDetail (
    orderDetailId INT IDENTITY(1,1) PRIMARY KEY,
    orderId       INT NOT NULL,
    productId     INT NOT NULL,
    quantity      INT NOT NULL CHECK (quantity > 0),
    unitPrice     DECIMAL(10,2) NOT NULL,
    subtotal      DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orderId) REFERENCES [Order](orderId),
    FOREIGN KEY (productId) REFERENCES Product(productId)
);

-- Bảng Cart
CREATE TABLE Cart (
    customerId INT NOT NULL,
    productId  INT NOT NULL,
    quantity   INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (customerId, productId),
    FOREIGN KEY (customerId) REFERENCES Customer(customerId),
    FOREIGN KEY (productId) REFERENCES Product(productId)
);

-- Bảng ProductDetail
CREATE TABLE ProductDetail (
    productId    INT PRIMARY KEY,
    stock        INT NOT NULL CHECK (stock >= 0),
    brand        NVARCHAR(100),
    material     NVARCHAR(100),
    weight       DECIMAL(10,2),
    dimensions   NVARCHAR(50),
    FOREIGN KEY (productId) REFERENCES Product(productId)
);

-- Bảng ProductImages
CREATE TABLE ProductImages (
    imageId     INT IDENTITY(1,1) PRIMARY KEY,
    productId   INT NOT NULL,
    imageUrl    NVARCHAR(255) NOT NULL,
    FOREIGN KEY (productId) REFERENCES Product(productId)
);

-- Bảng Admin
CREATE TABLE Admin (
    id       INT IDENTITY(1,1) PRIMARY KEY,
    name     NVARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Chèn dữ liệu mẫu

-- Bảng Category
INSERT INTO Category (name)
VALUES 
    ('Men'), 
    ('Women'), 
    ('Kid');

-- Bảng Product
INSERT INTO Product (name, description, image, price, categoryId)
VALUES 
    -- Men
    ('Creed Aventus', 'A luxurious fragrance with bold and captivating notes.', 'img/man1.jpg', 350.00, 1),
    ('Dior Sauvage', 'A fresh and wild scent, with notes of citrus and woody spice.', 'img/man2.jpg', 150.00, 1),
    ('Tom Ford Noir', 'A sophisticated fragrance, with spicy and woody undertones.', 'img/man3.jpg', 200.00, 1),
    ('Chanel Bleu de Chanel', 'A powerful, fresh fragrance with citrus, wood, and ocean notes.', 'img/man4.jpg', 180.00, 1),
    ('Paco Rabanne Invictus', 'A bold scent with fresh aquatic and patchouli notes.', 'img/man5.jpg', 130.00, 1),
    ('Yves Saint Laurent La Nuit de l''Homme', 'A seductive fragrance with spicy and lavender hints.', 'img/man6.jpg', 140.00, 1),
    ('Versace Eros', 'A sensual and bold scent with vanilla and woody notes.', 'img/man7.jpg', 170.00, 1),
    ('Acqua di Gio Profumo Giorgio Armani', 'A fresh, aquatic fragrance with hints of wood and sea.', 'img/man8.jpg', 160.00, 1),
    ('Burberry London', 'A warm fragrance with tobacco and spice undertones.', 'img/man9.jpg', 120.00, 1),
    ('Jean Paul Gaultier Le Male', 'A sweet fragrance with lavender, mint, and vanilla notes.', 'img/man10.jpg', 140.00, 1),
    
    -- Women
    ('Chanel No. 5', 'The iconic fragrance with elegant floral notes.', 'img/woman1.jpg', 250.00, 2),
    ('Dior J''adore', 'A captivating blend of jasmine, rose, and orange blossom.', 'img/woman2.jpg', 180.00, 2),
    ('Yves Saint Laurent Black Opium', 'A strong, seductive fragrance with coffee, jasmine, and vanilla.', 'img/woman3.jpg', 220.00, 2),
    ('Lancôme La Vie Est Belle', 'A fresh floral fragrance with iris, jasmine, and pear notes.', 'img/woman4.jpg', 150.00, 2),
    ('Gucci Bloom', 'A refreshing fragrance with jasmine, camellia, and tuberose.', 'img/woman5.jpg', 190.00, 2),
    ('Chloe Nomade', 'A free-spirited fragrance with peach, jasmine, and oakmoss.', 'img/woman6.jpg', 210.00, 2),
    ('Tom Ford Velvet Orchid', 'A rich fragrance with jasmine, vanilla, and wood.', 'img/woman7.jpg', 230.00, 2),
    ('Viktor & Rolf Flowerbomb', 'A sweet fragrance with rose, jasmine, and vanilla notes.', 'img/woman8.jpg', 200.00, 2),
    ('Carolina Herrera Good Girl', 'A bold fragrance with cocoa, vanilla, and jasmine hints.', 'img/woman9.jpg', 240.00, 2),
    ('Prada Candy', 'A sweet and sensual fragrance with caramel and vanilla.', 'img/woman10.jpg', 160.00, 2),

    -- Kids
    ('Disney Princess', 'A gentle, fresh fragrance for little girls.', 'img/kid1.jpg', 25.00, 3),
    ('Kiddy Scents', 'A sweet, fruity scent for kids.', 'img/kid2.jpg', 20.00, 3),
    ('Baby Touch by Burberry', 'A soft, floral scent for babies with a fresh touch.', 'img/kid3.jpg', 30.00, 3),
    ('Hello Kitty Fragrance', 'A cute and sweet fragrance for children.', 'img/kid4.jpg', 22.00, 3),
    ('Lavender Baby Cologne', 'A soothing lavender fragrance for babies.', 'img/kid5.jpg', 18.00, 3),
    ('Little Angel', 'A delicate fragrance with soft floral notes for children.', 'img/kid6.jpg', 15.00, 3),
    ('Tommy Girl', 'A fresh, lively fragrance for kids.', 'img/kid7.jpg', 20.00, 3),
    ('Baby Powder by Johnson', 'A calming and gentle powdery scent for babies.', 'img/kid8.jpg', 25.00, 3),
    ('Fruit Twist by Love', 'A fruity, sweet fragrance for young children.', 'img/kid9.jpg', 18.00, 3),
    ('Jelly Bean Kids', 'A sweet and playful fragrance perfect for kids.', 'img/kid10.jpg', 12.00, 3);

-- Bảng ProductDetail
INSERT INTO ProductDetail (productId, stock, brand, material, weight, dimensions)
VALUES 
    (1, 50, 'Creed', 'Eau de Parfum', 100, '10x5x5 cm'),
    (2, 100, 'Dior', 'Eau de Toilette', 120, '12x6x6 cm'),
    (3, 70, 'Tom Ford', 'Eau de Parfum', 150, '15x7x7 cm'),
    (4, 120, 'Chanel', 'Eau de Parfum', 130, '10x5x5 cm'),
    (5, 80, 'Paco Rabanne', 'Eau de Toilette', 140, '11x5x5 cm'),
    (6, 60, 'YSL', 'Eau de Parfum', 110, '10x5x4 cm'),
    (7, 90, 'Versace', 'Eau de Parfum', 125, '12x5x6 cm'),
    (8, 110, 'Giorgio Armani', 'Eau de Parfum', 115, '10x6x5 cm'),
    (9, 150, 'Burberry', 'Eau de Toilette', 105, '9x4x4 cm'),
    (10, 100, 'Jean Paul Gaultier', 'Eau de Toilette', 130, '10x5x5 cm'),
    (11, 80, 'Chanel', 'Eau de Parfum', 100, '10x5x5 cm'),
    (12, 90, 'Dior', 'Eau de Toilette', 120, '12x6x6 cm'),
    (13, 100, 'YSL', 'Eau de Parfum', 150, '15x7x7 cm'),
    (14, 70, 'Lancôme', 'Eau de Parfum', 130, '10x5x5 cm'),
    (15, 80, 'Gucci', 'Eau de Parfum', 125, '12x5x6 cm'),
    (16, 60, 'Chloe', 'Eau de Parfum', 110, '10x5x4 cm'),
    (17, 75, 'Tom Ford', 'Eau de Parfum', 135, '12x6x6 cm'),
    (18, 110, 'Viktor & Rolf', 'Eau de Parfum', 140, '12x5x5 cm'),
    (19, 120, 'Carolina Herrera', 'Eau de Parfum', 150, '15x7x7 cm'),
    (20, 130, 'Prada', 'Eau de Parfum', 110, '10x5x5 cm');

-- Bảng ProductImages
INSERT INTO ProductImages (productId, imageUrl)
VALUES 
    (1, 'img/man1_1.jpg'),
    (1, 'img/man1_2.jpg'),
    (2, 'img/man2_1.jpg'),
    (2, 'img/man2_2.jpg'),
    (10, 'img/kid2_1.jpg');

-- Bảng Customer (Dữ liệu ban đầu + 20 khách hàng mới)
INSERT INTO Customer (username, password, name, phone, email, address)
VALUES 
    -- Dữ liệu ban đầu
    ('john_doe', 'hashedpassword123', 'John Doe', '0123456789', 'john@example.com', '123 Main St'),
    ('jane_smith', 'securepass456', 'Jane Smith', '0987654321', 'jane@example.com', '456 Elm St'),
    -- 20 khách hàng mới
    ('alice_wong', 'pass1234', 'Alice Wong', '0912345678', 'alice.wong@example.com', '789 Pine St'),
    ('bob_jones', 'secure789', 'Bob Jones', '0923456789', 'bob.jones@example.com', '321 Oak Ave'),
    ('clara_lee', 'clara2023', 'Clara Lee', '0934567890', 'clara.lee@example.com', '654 Maple Rd'),
    ('david_kim', 'davidpass', 'David Kim', '0945678901', 'david.kim@example.com', '987 Cedar Ln'),
    ('emma_nguyen', 'emma567', 'Emma Nguyen', '0956789012', 'emma.nguyen@example.com', '147 Birch St'),
    ('frank_chen', 'frank123', 'Frank Chen', '0967890123', 'frank.chen@example.com', '258 Spruce Dr'),
    ('grace_park', 'gracepass', 'Grace Park', '0978901234', 'grace.park@example.com', '369 Willow Ct'),
    ('henry_tran', 'henry789', 'Henry Tran', '0989012345', 'henry.tran@example.com', '741 Elm St'),
    ('isabella_yu', 'isa2023', 'Isabella Yu', '0990123456', 'isabella.yu@example.com', '852 Pine Ave'),
    ('james_ho', 'jamespass', 'James Ho', '0901234567', 'james.ho@example.com', '963 Oak Rd'),
    ('kelly_pham', 'kelly456', 'Kelly Pham', '0913456789', 'kelly.pham@example.com', '159 Maple Ln'),
    ('leo_wu', 'leopass123', 'Leo Wu', '0924567890', 'leo.wu@example.com', '357 Cedar St'),
    ('mia_cao', 'mia2023', 'Mia Cao', '0935678901', 'mia.cao@example.com', '468 Birch Dr'),
    ('nsn', '123', 'Nguyen Sinh Nhat', '0946789012', 'nsn251tp@gmail.com', '579 Spruce Ct'),
    ('olivia_lu', 'oliviapass', 'Olivia Lu', '0957890123', 'olivia.lu@example.com', '681 Willow St'),
    ('peter_ngo', 'peter123', 'Peter Ngo', '0968901234', 'peter.ngo@example.com', '792 Elm Ave'),
    ('quinn_bui', 'quinn456', 'Quinn Bui', '0979012345', 'quinn.bui@example.com', '813 Pine Rd'),
    ('rose_dang', 'rose2023', 'Rose Dang', '0980123456', 'rose.dang@example.com', '924 Oak Ln'),
    ('sam_vo', 'sampass789', 'Sam Vo', '0991234567', 'sam.vo@example.com', '135 Cedar Dr'),
    ('tina_ly', 'tina123', 'Tina Ly', '0902345678', 'tina.ly@example.com', '246 Birch St');

-- Bảng Voucher
INSERT INTO Voucher (code, discount, expiry_date)
VALUES 
    ('SALE10', 10.00, '2025-12-31'), 
    ('WELCOME15', 15.00, '2025-06-30'),
    ('NONE', 0.00, '2025-12-31');

-- Bảng Order (Dữ liệu ban đầu + 20 đơn hàng mới)
INSERT INTO [Order] (customerId, totalAmount, status, shippingAddress, voucherCode)
VALUES 
    -- Dữ liệu ban đầu
    (1, 500.00, 'Processing', '123 Main St', 'SALE10'),
    (2, 750.00, 'Completed', '456 Elm St', NULL),
    (1, 120.00, 'Failed', '123 Main St', 'WELCOME15'),
    (2, 200.00, 'Processing', '456 Elm St', NULL),
    (1, 650.00, 'Completed', '123 Main St', 'SALE10'),
    (2, 300.00, 'Failed', '456 Elm St', NULL),
    (1, 500.00, 'Processing', '123 Main St', 'WELCOME15'),
    (2, 150.00, 'Completed', '456 Elm St', NULL),
    (1, 100.00, 'Processing', '123 Main St', 'SALE10'),
    (2, 450.00, 'Failed', '456 Elm St', NULL),
    -- 20 đơn hàng mới
    (3, 550.00, 'Processing', '789 Pine St', 'SALE10'),          -- Alice Wong
    (4, 780.00, 'Completed', '321 Oak Ave', 'WELCOME15'),         -- Bob Jones
    (5, 320.00, 'Failed', '654 Maple Rd', NULL),                  -- Clara Lee
    (6, 900.00, 'Processing', '987 Cedar Ln', 'SALE10'),          -- David Kim
    (7, 250.00, 'Completed', '147 Birch St', 'NONE'),             -- Emma Nguyen
    (8, 670.00, 'Processing', '258 Spruce Dr', 'WELCOME15'),      -- Frank Chen
    (9, 400.00, 'Failed', '369 Willow Ct', NULL),                 -- Grace Park
    (10, 850.00, 'Completed', '741 Elm St', 'SALE10'),            -- Henry Tran
    (11, 300.00, 'Processing', '852 Pine Ave', 'NONE'),           -- Isabella Yu
    (12, 720.00, 'Failed', '963 Oak Rd', 'WELCOME15'),            -- James Ho
    (13, 480.00, 'Completed', '159 Maple Ln', NULL),              -- Kelly Pham
    (14, 950.00, 'Processing', '357 Cedar St', 'SALE10'),         -- Leo Wu
    (15, 200.00, 'Failed', '468 Birch Dr', 'NONE'),               -- Mia Cao
    (16, 630.00, 'Completed', '579 Spruce Ct', 'WELCOME15'),      -- Nathan Do
    (17, 370.00, 'Processing', '681 Willow St', NULL),            -- Olivia Lu
    (18, 820.00, 'Completed', '792 Elm Ave', 'SALE10'),           -- Peter Ngo
    (19, 450.00, 'Failed', '813 Pine Rd', 'NONE'),                -- Quinn Bui
    (20, 700.00, 'Processing', '924 Oak Ln', 'WELCOME15'),        -- Rose Dang
    (1, 290.00, 'Completed', '123 Main St', NULL),                -- John Doe
    (2, 510.00, 'Processing', '456 Elm St', 'SALE10');            -- Jane Smith

-- Bảng OrderDetail (Dữ liệu ban đầu + 20 chi tiết đơn hàng mới)
INSERT INTO OrderDetail (orderId, productId, quantity, unitPrice, subtotal)
VALUES 
    -- Dữ liệu ban đầu
    (1, 1, 2, 350.00, 700.00),
    (1, 2, 1, 150.00, 150.00),
    (2, 5, 3, 130.00, 390.00),
    -- 20 chi tiết đơn hàng mới
    (11, 1, 1, 350.00, 350.00),    -- Order 11 (Alice Wong) - Creed Aventus
    (11, 2, 1, 150.00, 150.00),    -- Thêm Dior Sauvage
    (12, 5, 3, 130.00, 390.00),    -- Order 12 (Bob Jones) - Paco Rabanne Invictus
    (13, 11, 1, 250.00, 250.00),   -- Order 13 (Clara Lee) - Chanel No. 5
    (14, 13, 2, 220.00, 440.00),   -- Order 14 (David Kim) - YSL Black Opium
    (15, 17, 1, 230.00, 230.00),   -- Order 15 (Emma Nguyen) - Tom Ford Velvet Orchid
    (16, 3, 2, 200.00, 400.00),    -- Order 16 (Frank Chen) - Tom Ford Noir
    (17, 7, 1, 170.00, 170.00),    -- Order 17 (Grace Park) - Versace Eros
    (18, 9, 3, 120.00, 360.00),    -- Order 18 (Henry Tran) - Burberry London
    (19, 12, 1, 180.00, 180.00),   -- Order 19 (Isabella Yu) - Dior J'adore
    (20, 15, 2, 190.00, 380.00),   -- Order 20 (James Ho) - Gucci Bloom
    (21, 19, 1, 240.00, 240.00),   -- Order 21 (Kelly Pham) - Carolina Herrera Good Girl
    (22, 4, 2, 180.00, 360.00),    -- Order 22 (Leo Wu) - Chanel Bleu de Chanel
    (23, 20, 1, 160.00, 160.00),   -- Order 23 (Mia Cao) - Prada Candy
    (24, 6, 2, 140.00, 280.00),    -- Order 24 (Nathan Do) - YSL La Nuit de l'Homme
    (25, 10, 1, 140.00, 140.00),   -- Order 25 (Olivia Lu) - Jean Paul Gaultier Le Male
    (26, 14, 2, 150.00, 300.00),   -- Order 26 (Peter Ngo) - Lancôme La Vie Est Belle
    (27, 18, 1, 200.00, 200.00),   -- Order 27 (Quinn Bui) - Viktor & Rolf Flowerbomb
    (28, 16, 2, 210.00, 420.00),   -- Order 28 (Rose Dang) - Chloe Nomade
    (29, 8, 1, 160.00, 160.00);    -- Order 29 (John Doe) - Acqua di Gio Profumo

-- Bảng Admin
INSERT INTO Admin (name, username, password)
VALUES 
    ('Admin1', 'admin1', 'adminpass1'), 
    ('Admin2', 'admin2', 'adminpass2');

-- Bảng Cart
INSERT INTO Cart (customerId, productId, quantity)
VALUES 
    (1, 3, 1), 
    (2, 6, 2),
	(16, 2, 1),
	(16, 3, 9);