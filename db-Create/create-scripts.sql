CREATE DATABASE blog_management;
USE blog_management;

CREATE TABLE Users (
     user_id INT AUTO_INCREMENT PRIMARY KEY,
     username VARCHAR(50) NOT NULL UNIQUE,
     email VARCHAR(100) NOT NULL UNIQUE,
     user_pw VARCHAR(100) NOT NULL,
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Categories (
     category_id INT AUTO_INCREMENT PRIMARY KEY,
     category_name VARCHAR(50) NOT NULL UNIQUE,
     category_descr VARCHAR(MAX),
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

CREATE TABLE Posts (
     post_id INT AUTO_INCREMENT PRIMARY KEY,
     user_id INT,
     category_id INT,
     title VARCHAR(255) NOT NULL,
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     FOREIGN KEY (user_id) REFERENCES Users(user_id),
     FOREIGN KEY (category_id) REFERENCES Categories(category_id)
)

CREATE TABLE Comments (
     comment_id INT AUTO_INCREMENT PRIMARY KEY,
     post_id INT,
     user_id INT,
     comment_context VARCHAR(MAX),
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     FOREIGN KEY (user_id) REFERENCES Users(user_id),
     FOREIGN KEY (category_id) REFERENCES Categories(category_id)
)

CREATE TABLE Tags (
     tag_id INT AUTO_INCREMENT PRIMARY KEY,
     tag_name VARCHAR(50) NOT NULL,
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

CREATE TABLE PostTags (
     post_id INT,
     tag_id INT,
     PRIMARY KEY (post_id, tag_id),
     FOREIGN KEY (post_id) REFERENCES Posts(post_id),
     FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
)

