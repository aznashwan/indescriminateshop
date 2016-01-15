CREATE DATABASE android CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON android.* TO 'android_user'@'' IDENTIFIED BY 'Passw0rd';
GRANT ALL PRIVILEGES ON android.* TO 'android_user'@'%' IDENTIFIED BY 'Passw0rd';

CREATE TABLE category (
    id int(11) NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE item (
    id int(11) NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    cid int(11),
    description varchar(1000),
    stock int(11) not null,
    FOREIGN KEY (cid) REFERENCES category(id)
        ON DELETE CASCADE,
    PRIMARY KEY (id)
);

CREATE TABLE class (
    id int(11) NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE cl2ca (
    id int(11) NOT NULL AUTO_INCREMENT,
    cid int(11),
    clid int(11),
    FOREIGN KEY (cid) REFERENCES category(id)
        ON DELETE CASCADE,
    FOREIGN KEY (clid) REFERENCES class(id)
        ON DELETE CASCADE,
    PRIMARY KEY (id)
);


INSERT INTO class(name) VALUES("Electronics");
INSERT INTO category(name) VALUES("Phones");
INSERT INTO cl2ca(cid, clid) VALUES(
    (SELECT id from category WHERE name='Phones'),
    (SELECT id from class WHERE name='Electronics')
);
INSERT INTO item(name, cid, description, stock) VALUES(
    "iPhone 7",
    (SELECT id from category WHERE name='Phones'),
    "iPhone is a line of smartphones designed and marketed by Apple Inc. They run Apple's iOS mobile operating system. The first generation iPhone was released on June 29, 2007; the most recent iPhone models are the iPhone 6s and iPhone 6s Plus, which were unveiled at a special event on September 9, 2015.",
    13
);
INSERT INTO item(name, cid, description, stock) VALUES(
    "Samsung Galaxy S7",
    (SELECT id from category WHERE name='Phones'),
    "Samsung Galaxy (stylized as Samsung GALAXY or SAMSUNG Galaxy) is a series of Android and Windows 10 powered mobile computing devices designed, manufactured and marketed by Samsung Electronics. The product line includes the Galaxy S series of high-end smartphones, the Galaxy Tab series of tablets, the Galaxy Note series of tablets and phablets with the added functionality of a stylus and the first version of the Galaxy Gear smartwatch, with later versions dropping the Galaxy branding.",
    10
);

INSERT INTO category(name) VALUES("Laptops");
INSERT INTO cl2ca(cid, clid) VALUES(
    (SELECT id from category WHERE name='Laptops'),
    (SELECT id from class WHERE name='Electronics')
);
INSERT INTO item(name, cid, description, stock) VALUES(
    "Lenovo ThinkPad W540",
    (SELECT id from category WHERE name='Laptops'),
    "ThinkPad is a line of laptop computers and tablets by Lenovo. The series was designed, developed, and sold by IBM until Lenovo acquired the brand in 2005.",
    5
);
INSERT INTO item(name, cid, description, stock) VALUES(
    "ASUS",
    (SELECT id from category WHERE name='Laptops'),
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean elementum faucibus dui ac sagittis. Curabitur eu eros molestie, sodales nisl at, malesuada magna.",
    5
);

INSERT INTO class(name) VALUES("Food");
INSERT INTO category(name) VALUES("Fruits");
INSERT INTO cl2ca(cid, clid) VALUES(
    (SELECT id from category WHERE name='Fruits'),
    (SELECT id from class WHERE name='Food')
);
INSERT INTO item(name, cid, description, stock) VALUES(
    "Oranges",
    (SELECT id from category WHERE name='Fruits'),
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sodales scelerisque tempus. Cras id porta augue, et vulputate purus. Proin interdum bibendum fringilla.",
    21
);
INSERT INTO item(name, cid, description, stock) VALUES(
    "Apples",
    (SELECT id from category WHERE name='Fruits'),
    "Sed in commodo nibh, ac elementum eros. Aenean a aliquam sapien, eget lacinia mi. Integer nec commodo odio. Maecenas at nunc id turpis auctor malesuada.",
    11
);
