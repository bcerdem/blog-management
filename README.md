# Blog Yönetim Sistemi - MySQL Veritabanı Tasarımı

Bu belge, bir Blog Yönetim Sistemi için MySQL veritabanı şemasının detaylı tasarımını sunar. Kullanıcılar, gönderiler, yorumlar, kategoriler ve etiketler gibi varlıkların yapısını ve bu varlıklar arasındaki ilişkileri içerir.

## İçindekiler

- [Veritabanı Şeması](#veritabanı-şeması)
  - [Kullanıcılar Tablosu](#kullanıcılar-tablosu)
  - [Kategoriler Tablosu](#kategoriler-tablosu)
  - [Gönderiler Tablosu](#gönderiler-tablosu)
  - [Yorumlar Tablosu](#yorumlar-tablosu)
  - [Etiketler Tablosu](#etiketler-tablosu)
  - [GönderiEtiketleri Tablosu](#gönderietiketleri-tablosu)
- [Saklı Yordamlar, Fonksiyonlar ve Tetikleyiciler](#saklı-yordamlar-fonksiyonlar-ve-tetikleyiciler)
- [Veritabanı ve Tabloların Oluşturulması](#veritabanı-ve-tabloların-oluşturulması)

## Veritabanı Şeması

### Kullanıcılar Tablosu

`Users` tablosu, blog yönetim sistemindeki kullanıcıların bilgilerini saklar.

```sql
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
Kategoriler Tablosu
Categories tablosu, blog gönderileri için farklı kategorileri saklar.

sql
Kodu kopyala
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
Gönderiler Tablosu
Posts tablosu, blog gönderilerini saklar.

sql
Kodu kopyala
CREATE TABLE Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    category_id INT,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
Yorumlar Tablosu
Comments tablosu, blog gönderilerine yapılan yorumları saklar.

sql
Kodu kopyala
CREATE TABLE Comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
Etiketler Tablosu
Tags tablosu, blog gönderileriyle ilişkilendirilebilecek etiketleri saklar.

sql
Kodu kopyala
CREATE TABLE Tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
GönderiEtiketleri Tablosu
PostTags tablosu, Posts ve Tags arasında çoktan çoğa ilişki kurar.

sql
Kodu kopyala
CREATE TABLE PostTags (
    post_id INT,
    tag_id INT,
    PRIMARY KEY (post_id, tag_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
);
Saklı Yordamlar, Fonksiyonlar ve Tetikleyiciler
Saklı Yordamlar
Gönderi Oluşturma
sql
Kodu kopyala
DELIMITER $$

CREATE PROCEDURE CreatePost (
    IN user_id INT,
    IN category_id INT,
    IN title VARCHAR(255),
    IN content TEXT
)
BEGIN
    INSERT INTO Posts (user_id, category_id, title, content) VALUES (user_id, category_id, title, content);
END$$

DELIMITER ;
Fonksiyonlar
Kullanıcıya Göre Gönderi Sayısını Getir
sql
Kodu kopyala
DELIMITER $$

CREATE FUNCTION GetPostCountByUser(user_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE post_count INT;
    SELECT COUNT(*) INTO post_count FROM Posts WHERE user_id = user_id;
    RETURN post_count;
END$$

DELIMITER ;
Tetikleyiciler
Gönderi Güncellemeden Önce
sql
Kodu kopyala
DELIMITER $$

CREATE TRIGGER BeforePostUpdate
BEFORE UPDATE ON Posts
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

DELIMITER ;
Veritabanı ve Tabloların Oluşturulması
Veritabanını Oluşturma:

sql
Kodu kopyala
CREATE DATABASE blog_management;
USE blog_management;
Tabloları Oluşturma:

Users tablosunu oluşturun.
Categories tablosunu oluşturun.
Posts tablosunu oluşturun.
Comments tablosunu oluşturun.
Tags tablosunu oluşturun.
PostTags tablosunu oluşturun.
Saklı Yordamlar, Fonksiyonlar ve Tetikleyicileri Oluşturma:

CreatePost saklı yordamını oluşturun.
GetPostCountByUser fonksiyonunu oluşturun.
BeforePostUpdate tetikleyicisini oluşturun.
