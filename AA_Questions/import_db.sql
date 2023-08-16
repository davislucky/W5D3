PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT
);

-- DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body BLOB,
    user_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body BLOB NOT NULL,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER, 

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

-- DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('Bob', 'Dylan'),
    ('Paulo', 'Bocanegra'),
    ('Davis', 'Lucky'),
    ('Swathi', 'B');


INSERT INTO
    questions (title, body, user_id)
VALUES
    ('DSA', 'What is LSUCache??', (SELECT id FROM users WHERE fname = 'Swathi')),
    ('SQL', 'What is a correlated query?', (SELECT id FROM users WHERE fname = 'Davis'));

INSERT INTO
    question_follows (user_id, question_id)
VALUES
    (4, 1),
    (3, 2);

INSERT INTO
    replies (body, user_id, question_id)
VALUES
    ('something abt dSA', 1, 1);

INSERT INTO
    replies (body, user_id, question_id, parent_reply_id)
VALUES
    ('something else abt dSA from paulo', 2, 1, 1);

INSERT INTO
    replies (body, user_id, question_id, parent_reply_id)
VALUES
    ('reply to child reply', 2, 1, 2);



INSERT INTO
    question_likes (user_id, question_id)
VALUES
    (1, 1);
