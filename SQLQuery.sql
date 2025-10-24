CREATE DATABASE DoAnWeb;
GO

USE DoAnWeb;
GO

CREATE TABLE Role
(
	roleID INT NOT NULL PRIMARY KEY,
	name NVARCHAR(50)
);

CREATE TABLE Users
(
	id INT PRIMARY KEY NOT NULL IDENTITY,
	username NVARCHAR(50) NOT NULL,
	[password] NVARCHAR(255) NOT NULL,
	fullname NVARCHAR(50),
	DiaChi NVARCHAR(50) NOT NULL,
	SDT NVARCHAR(50) NOT NULL,
	roleID INT,
	email NVARCHAR(50),
	reset_expiry DATETIME NULL,
	reset_code VARCHAR(10) NULL,
	CONSTRAINT FK_NguoiDung_Role FOREIGN KEY (roleID) REFERENCES Role(roleID)
);
CREATE TABLE Products
(
	id INT PRIMARY KEY NOT NULL,
	name NVARCHAR(50) NOT NULL,
	prices DECIMAL(18,2) NOT NULL CHECK (prices >= 0)
);
CREATE TABLE Invoices (
    MaHD INT IDENTITY PRIMARY KEY,             -- Mã hóa đơn tự tăng
    NgayLap DATETIME NOT NULL DEFAULT GETDATE(), -- Ngày lập hóa đơn
    NguoiDungID INT NOT NULL,                  -- Người lập hóa đơn (liên kết Users)
    SanPhamID INT NOT NULL,                    -- Sản phẩm được mua
    SoLuong INT NOT NULL CHECK (SoLuong > 0),  -- Số lượng mua
    DonGia DECIMAL(18,2) NOT NULL CHECK (DonGia >= 0), -- Giá đơn vị
    TongTien AS (SoLuong * DonGia) PERSISTED,  -- Tổng tiền tự tính
    GhiChu NVARCHAR(200),                      -- Ghi chú

    CONSTRAINT FK_Invoice_User FOREIGN KEY (NguoiDungID) REFERENCES Users(id),
    CONSTRAINT FK_Invoice_Product FOREIGN KEY (SanPhamID) REFERENCES Products(id)
);

-- Lấy DonGia từ Products.prices khi tạo/cập nhật hóa đơn
CREATE OR ALTER TRIGGER TRG_Invoices_SetDonGia
ON Invoices
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Cập nhật DonGia theo bảng Products cho các bản ghi vừa chèn/sửa
    UPDATE iv
    SET iv.DonGia = p.prices
    FROM Invoices AS iv
    JOIN inserted AS i   ON iv.MaHD = i.MaHD
    JOIN Products AS p   ON p.id = i.SanPhamID;
END;

CREATE TABLE Cart (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    is_checked_out BIT DEFAULT 0,  -- 0 = đang mua, 1 = đã thanh toán
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE CartItems (
    id INT PRIMARY KEY IDENTITY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(18,2) NOT NULL,        -- lưu giá tại thời điểm thêm vào giỏ
    FOREIGN KEY (cart_id) REFERENCES Cart(id),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

INSERT INTO Role VALUES
					(1, 'Manager'),
					(2, 'Admin'),
					(3, 'User'),
					(4, 'Seller'),
					(5, 'Shipper');
INSERT INTO Products VALUES
						(1,'Áo thể chất UTE', 120000),
						(2, 'Áo đồng phục UTE', 110000),
						(3, 'Áo khoa CLC', 140000),
						(4, 'Áo TN UTE', 160000),
						(5, 'Balo UTE', 250000),
						(6, 'Móc khóa UTE', 5000),
						(7, 'Nón UTE', 120000),
						(8, 'Ô UTE', 80000),
						(9, 'Sổ tay UTE', 30000);

