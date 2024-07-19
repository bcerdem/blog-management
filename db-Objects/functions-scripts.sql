-- Functions

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

