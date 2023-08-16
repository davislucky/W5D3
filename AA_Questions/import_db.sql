PRAGMA foreign_keys = ON;
DROP TABLE users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body BLOB,

    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body BLOB NOT NULL,
    parent_reply_id INTEGER, 

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,

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