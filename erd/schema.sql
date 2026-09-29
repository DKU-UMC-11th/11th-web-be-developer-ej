CREATE TABLE `member` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `social_provider` VARCHAR(20) NOT NULL,
    `social_id` VARCHAR(255) NOT NULL,
    `nickname` VARCHAR(50) NOT NULL,
    `deleted_at` DATETIME NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_member_social` (`social_provider`, `social_id`)
);

CREATE TABLE `region` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_region_name` (`name`)
);

CREATE TABLE `food_category` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_food_category_name` (`name`)
);

CREATE TABLE `store` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `region_id` BIGINT NOT NULL,
    `food_category_id` BIGINT NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_store_region`
        FOREIGN KEY (`region_id`) REFERENCES `region` (`id`),
    CONSTRAINT `fk_store_food_category`
        FOREIGN KEY (`food_category_id`) REFERENCES `food_category` (`id`)
);

CREATE TABLE `mission` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `store_id` BIGINT NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_mission_store`
        FOREIGN KEY (`store_id`) REFERENCES `store` (`id`)
);

CREATE TABLE `member_mission` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `member_id` BIGINT NOT NULL,
    `mission_id` BIGINT NOT NULL,
    `status` ENUM('IN_PROGRESS', 'COMPLETED') NOT NULL,
    `started_at` DATETIME NOT NULL,
    `completed_at` DATETIME NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_member_mission` (`member_id`, `mission_id`),
    CONSTRAINT `fk_member_mission_member`
        FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
    CONSTRAINT `fk_member_mission_mission`
        FOREIGN KEY (`mission_id`) REFERENCES `mission` (`id`)
);
