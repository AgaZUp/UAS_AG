-- Tabel Barang
CREATE TABLE Barang (
    id_barang SERIAL PRIMARY KEY,
    nama_barang VARCHAR(255) NOT NULL,
    harga DECIMAL(15,2) NOT NULL,
    stok INT NOT NULL
);

-- Tabel Nota
CREATE TABLE Nota (
    id_nota SERIAL PRIMARY KEY,
    tanggal_transaksi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_pelanggan INT,
    total_harga DECIMAL(15,2) NOT NULL
);

-- Tabel Nota Detail
CREATE TABLE Nota_Detail (
    id_nota_detail SERIAL PRIMARY KEY,
    id_nota INT NOT NULL REFERENCES Nota(id_nota) ON DELETE CASCADE,
    id_barang INT NOT NULL REFERENCES Barang(id_barang) ON DELETE CASCADE,
    jumlah INT NOT NULL,
    subtotal DECIMAL(15,2) NOT NULL
);

-- Tabel Pelanggan
CREATE TABLE Pelanggan (
    id_pelanggan SERIAL PRIMARY KEY,
    nama_pelanggan VARCHAR(255) NOT NULL,
    kontak VARCHAR(50)
);

-- Tabel Pengguna (User Management)
CREATE TABLE Pengguna (
    id_pengguna SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) CHECK (role IN ('superuser', 'admin', 'user')) NOT NULL
);

-- ACID Compliance
BEGIN;
-- Contoh transaksi
INSERT INTO Nota (tanggal_transaksi, id_pelanggan, total_harga)
VALUES (CURRENT_TIMESTAMP, 1, 150000);

INSERT INTO Nota_Detail (id_nota, id_barang, jumlah, subtotal)
VALUES (1, 1, 2, 50000);

COMMIT;

-- Hak Akses
-- Hak akses untuk Superuser
CREATE ROLE superuser_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO superuser_role;

-- Hak akses untuk Admin
CREATE ROLE admin_role;
GRANT INSERT, UPDATE ON Barang, Nota, Nota_Detail TO admin_role;

-- Hak akses untuk User
CREATE ROLE user_role;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user_role;

-- Menambahkan pengguna dengan role
INSERT INTO Pengguna (username, password_hash, role) VALUES ('superadmin', 'hashed_password', 'superuser');
INSERT INTO Pengguna (username, password_hash, role) VALUES ('admin1', 'hashed_password', 'admin');
INSERT INTO Pengguna (username, password_hash, role) VALUES ('user1', 'hashed_password', 'user');


-- Insert data Barang
INSERT INTO Barang (nama_barang, harga, stok) 
VALUES ('Motherboard', 1500000, 10),
       ('RAM 32GB', 750000, 20),
       ('Processor Intel i10', 4500000, 5);

-- Insert data Pelanggan
INSERT INTO Pelanggan (nama_pelanggan, kontak) 
VALUES ('Andre Gunawan', '0895421995443');
