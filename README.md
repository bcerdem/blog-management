# GitHub

```markdown
# Blog Management System - MySQL Database Design

This document provides a detailed design of the MySQL database schema for a Blog Management System. It includes the structure for managing users, posts, comments, categories, and tags, as well as the relationships between these entities.

## Table of Contents

- [Database Schema](#database-schema)
  - [Users Table](#users-table)
  - [Categories Table](#categories-table)
  - [Posts Table](#posts-table)
  - [Comments Table](#comments-table)
  - [Tags Table](#tags-table)
  - [PostTags Table](#posttags-table)
- [Stored Procedures, Functions, and Triggers](#stored-procedures-functions-and-triggers)
- [Creating the Database and Tables](#creating-the-database-and-tables)

## Database Schema

### Users Table

The `Users` table stores information about the users of the blog management system.

```sql
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

```

### Categories Table

The `Categories` table stores the different categories for blog posts.

```sql

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

```

### Posts Table

The `Posts` table stores the blog posts.

```sql

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

```

### Comments Table

The `Comments` table stores comments on the blog posts.

```sql

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

```

### Tags Table

The `Tags` table stores tags that can be associated with blog posts.

```sql

CREATE TABLE Tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

```

### PostTags Table

The `PostTags` table establishes a many-to-many relationship between `Posts` and `Tags`.

```sql

CREATE TABLE PostTags (
    post_id INT,
    tag_id INT,
    PRIMARY KEY (post_id, tag_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
);

```

## Stored Procedures, Functions, and Triggers

### Stored Procedures

### Create a Post

```sql

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

```

### Functions

### Get Post Count by User

```sql

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

```

### Triggers

### Before Post Update

```sql

DELIMITER $$

CREATE TRIGGER BeforePostUpdate
BEFORE UPDATE ON Posts
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

DELIMITER ;

```

## Creating the Database and Tables

1. **Create the Database:**
    
    ```sql
    
    CREATE DATABASE blog_management;
    USE blog_management;
    
    ```
    
2. **Create the Tables:**
    - Create the `Users` table.
    - Create the `Categories` table.
    - Create the `Posts` table.
    - Create the `Comments` table.
    - Create the `Tags` table.
    - Create the `PostTags` table.
3. **Create the Stored Procedures, Functions, and Triggers:**
    - Create the `CreatePost` stored procedure.
    - Create the `GetPostCountByUser` function.
    - Create the `BeforePostUpdate` trigger.