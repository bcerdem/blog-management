-- Stored Procedures


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

