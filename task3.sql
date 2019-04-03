-- SQL для создания таблиц в БД.

DROP TABLE IF EXISTS contacts_channels_tokens;
DROP TABLE IF EXISTS contacts_channels;
DROP TABLE IF EXISTS channels;
DROP TABLE IF EXISTS contacts_groups;
DROP TABLE IF EXISTS groups;
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS users;

CREATE TABLE IF NOT EXISTS users (
    id int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    login varchar(128) NOT NULL,
    name varchar(128) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS contacts (
    id int(11) UNSIGNED AUTO_INCREMENT,
    user_id int(11) UNSIGNED NOT NULL,
    name varchar(128) NOT NULL,
    phone varchar(128) NOT NULL,
    email varchar(128) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS groups (
    id int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id int(11) UNSIGNED NOT NULL,
    name varchar(128) null,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS contacts_groups (
    contact_id int(11) UNSIGNED NOT NULL,
    group_id int(11) UNSIGNED NOT NULL,
    PRIMARY KEY (contact_id, group_id),
    FOREIGN KEY (contact_id) REFERENCES contacts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (group_id) REFERENCES groups(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS channels (
	id int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	name varchar(128) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS contacts_channels (
	contact_id int(11) UNSIGNED NOT NULL,
	channel_id int(11) UNSIGNED NOT NULL,
	PRIMARY KEY (contact_id, channel_id),
    FOREIGN KEY (contact_id) REFERENCES contacts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS contacts_channels_tokens (
	id int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	contact_id int(11) UNSIGNED NOT NULL,
	channel_id int(11) UNSIGNED NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (contact_id) REFERENCES contacts(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- SQL - запросы, решение задачи.

-- Добавление/удаление/изменение контакта.
INSERT INTO contacts(login, name, phone, email)
VALUES ('holly', 'Саша Покалов', '89781188838', 'bill@mail.com');

DELETE FROM contacts
WHERE id = '3';

UPDATE contacts
SET phone = '89781188838'
WHERE id = '3';

-- Добавление/удаление/изменение контакта в группу.
INSERT INTO contacts_groups(contact_id, group_id)
VALUES (33, 3);

DELETE FROM contacts_groups
WHERE contact_id = 111;

UPDATE contacts_groups
SET contact_id = 22
WHERE group_id = 2
AND contact_id = 3;

-- Вывод групп с подсчетом количества контактов.
SELECT groups.name, COUNT(contacts_groups.contact_id) AS number
FROM groups
  INNER JOIN contacts_groups
    ON groups.id = contacts_groups.group_id
  INNER JOIN contacts
    ON contacts_groups.contact_id = contacts.id
GROUP BY groups.name;

-- Вывод группы “Часто используемые”, где выводятся топ10 контактов, на которые рассылают сообщения
SELECT contacts.name
FROM contacts
  INNER JOIN contacts_groups
    ON contacts.id = contacts_groups.contact_id
  INNER JOIN groups
    ON contacts_groups.group_id = groups.id
WHERE contacts.user_id = 3
  AND groups.name = 'Часто используемые';

-- Поиск контактов по ФИО/номеру
SELECT name FROM contacts WHERE name LIKE 'Саша%';
SELECT name FROM contacts WHERE phone = '89781168838';

-- Выборка контактов по группе
SELECT *
FROM contacts
  INNER JOIN contacts_groups
    ON contacts.id = contacts_groups.contact_id
  INNER JOIN groups
    ON contacts_groups.group_id = groups.id
WHERE groups.name = 'Работа';