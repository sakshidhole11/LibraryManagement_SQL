CREATE DATABASE LibraryManagement;

USE LibraryManagement;

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publisher VARCHAR(255),
    year_of_publication YEAR,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Members(
   member_id int primary key auto_increment,
   name varchar(200) not null,
   email varchar(255) unique not null,
   phone varchar(15),
   membership_date date not null
); 
   

CREATE TABLE IssuedBooks (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);   
   
/* inserting data */

/*Categories  table*/
INSERT INTO Categories (category_name) values ('Fiction'),('Non-Fiction'),('Science'),('History'), 
('Mystery'),('Fantasy'),('Biography'),('Technology'),('Philosophy');


/*Books  table*/
INSERT INTO Books (title, author, publisher, year_of_publication, category_id)
values
('The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', 1925, 1),
('A Brief History of Time', 'Stephen Hawking', 'Bantam Books', 1988, 3),
('1984', 'George Orwell', 'Secker & Warburg', 1949, 1),
('The Da Vinci Code', 'Dan Brown', 'Doubleday', 2003, 1),
('The Hobbit', 'J.R.R. Tolkien', 'Houghton Mifflin', 1937, 2),
('Steve Jobs', 'Walter Isaacson', 'Simon & Schuster', 2011, 3),
('Clean Code', 'Robert C. Martin', 'Prentice Hall', 2008, 4),
('Meditations', 'Marcus Aurelius', 'Harvard University Press',2004,5);
   
/*Members table*/
INSERT INTO Members (name, email, phone, membership_date)
VALUES 
('John Doe', 'johndoe@example.com', '1234567890', '2024-01-01'),
('Jane Smith', 'janesmith@example.com', '0987654321', '2024-02-01'),
('Alice Johnson', 'alice.johnson@example.com', '555-0101', '2024-03-15'),
('Bob Brown', 'bob.brown@example.com', '555-0102', '2024-04-10'),
('Charlie Davis', 'charlie.davis@example.com', '555-0103', '2024-05-20'),
('Diana Evans', 'diana.evans@example.com', '555-0104', '2024-06-25');

/*IssuedBooks table*/
INSERT INTO IssuedBooks (book_id, member_id, issue_date, due_date) VALUES 
(1, 1, '2024-08-01', '2024-08-15'),
(2, 2, '2024-08-05', '2024-08-20'),
(1, 1, '2024-08-01', '2024-08-15'),
(2, 2, '2024-08-05', '2024-08-20'),
(3, 3, '2024-08-10', '2024-08-24'),
(4, 4, '2024-08-15', '2024-08-30'),
(5, 1, '2024-08-20', '2024-09-05');

show tables;


/*SQL Queries for Operations
Here are some common queries for accessing data from LibraryManagement*/

/*describe Books*/
describe Books;
select * from Books;

/*1. Search for a Book by Title*/
SELECT * FROM Books WHERE title LIKE '%Hobbit%';
SELECT * FROM Books WHERE title LIKE '%Great Gatsby%';

/*2 Issue a Book to a Member*/
INSERT INTO IssuedBooks (book_id, member_id, issue_date, due_date)
VALUES (3, 1, '2024-08-10', '2024-08-24');
INSERT INTO IssuedBooks (book_id, member_id, issue_date, due_date)
VALUES (6, 5, '2024-08-10', '2024-05-12');

/*3 Return a Book*/
Update IssuedBooks
set return_date = '2024-04-25'
where issue_id = 5;
UPDATE IssuedBooks
SET return_date = '2024-08-15'
WHERE issue_id = 1;

select * from IssuedBooks;

/* 4. List Overdue Books */
SELECT B.title, M.name, I.due_date
FROM IssuedBooks I
JOIN Books B ON I.book_id = B.book_id
JOIN Members M ON I.member_id = M.member_id
WHERE I.due_date < CURDATE() AND I.return_date IS NULL;

/*Or*/
SELECT B.title, M.name, I.due_date , I.issue_date, I.return_date
FROM IssuedBooks I
JOIN Books B ON I.book_id = B.book_id
JOIN Members M ON I.member_id = M.member_id
WHERE I.return_date IS NULL;





