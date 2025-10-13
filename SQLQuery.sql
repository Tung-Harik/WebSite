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
	[password] NVARCHAR(50) NOT NULL,
	fullname NVARCHAR(50),
	DiaChi NVARCHAR(50) NOT NULL,
	SDT NVARCHAR(50) NOT NULL,
	roleID INT,
	email NVARCHAR(50),
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


INSERT INTO Role VALUES (1, N'Admin');
INSERT INTO Users(username, [password], fullname, DiaChi, SDT, roleID, email)
VALUES ('admin', '123456', N'Lê Nghĩa Tình', N'Thủ Đức', N'0943512459', 1, 'nghiatinh2002@gmail.com');

ALTER TABLE dbo.Users ALTER COLUMN password VARCHAR(255) NOT NULL;