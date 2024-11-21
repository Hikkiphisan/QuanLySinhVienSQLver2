CREATE DATABASE QuanLySinhVien;

USE QuanLySinhVien;

CREATE TABLE QuanLySinhVien.Class(
                                     ClassID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                     ClassName VARCHAR(60) NOT NULL,
                                     StartDate DATETIME NOT NULL,
                                     Status BIT
);

CREATE TABLE Student(

                        StudentId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

                        StudentName VARCHAR(30) NOT NULL,

                        Address VARCHAR(50),

                        Phone VARCHAR(20),

                        Status BIT,

                        ClassId INT NOT NULL,

                        FOREIGN KEY (ClassId) REFERENCES Class (ClassID)

);

CREATE TABLE Subject(

                        SubId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

                        SubName VARCHAR(30) NOT NULL,

                        Credit TINYINT NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),

                        Status BIT DEFAULT 1

)

CREATE TABLE Mark(

                     MarkId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

                     SubId INT NOT NULL,

                     StudentId INT NOT NULL,

                     Mark FLOAT DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),

                     ExamTimes TINYINT DEFAULT 1,

                     UNIQUE (SubId, StudentId),

                     FOREIGN KEY (SubId) REFERENCES Subject (SubId),

                     FOREIGN KEY (StudentId) REFERENCES Student (StudentId)

);



INSERT INTO Class (ClassName, StartDate, Status)
VALUES
    ('Class A', '2024-09-01 08:00:00', 1),
    ('Class B', '2024-09-01 09:00:00', 1),
    ('Class C', '2024-09-01 10:00:00', 0);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES
    ('Nguyen Van A', '123 Nguyen Trai, Hanoi', '0123456789', 1, 1),
    ('Tran Thi B', '456 Le Duan, Hanoi', '0987654321', 1, 2),
    ('Pham Thi C', '789 Ba Trieu, Hanoi', '0112233445', 0, 3);


INSERT INTO Subject (SubName, Credit, Status)
VALUES
    ('Mathematics', 3, 1),
    ('Physics', 4, 1),
    ('Chemistry', 3, 1);


INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES
    (1, 1, 85, 1),
    (1, 2, 92, 1),
    (2, 1, 78, 2),
    (2, 3, 88, 1),
    (3, 2, 76, 2);



-- Kiểm tra bảng Class
SELECT * FROM Class;

-- Kiểm tra bảng Student
SELECT * FROM Student;
-- Kiểm tra bảng Mark
SELECT * FROM Mark;
-- Kiểm tra bảng Subject
SELECT * FROM Subject;

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần

SELECT Cl.StudentId, CL.StudentName, Cl.Address, Cl.Phone, AVG(M.Mark) AS "Điểm trung bình"
From Mark M
         INNER JOIN Student Cl ON Cl.StudentID = M.StudentID
Group By Cl.StudentId, CL.StudentName, Cl.Phone
Order by AVG(M.Mark) DESC;
















-- Hiển thị tất cả thông tin môn học có điểm thi cao nhất
SELECT M.SubID,M.Mark,Sub.SubName
FROM Subject Sub
         INNER JOIN Mark M ON Sub.SubID = M.SubID
Where mark = (SELECT MAX(Mark) FROM Mark);


SELECT *
FROM Mark
WHERE Mark = (SELECT MAX(Mark) FROM Mark);


--  Hiển thị tất các môn học có số tín chỉ cao nhất
SELECT *
FROM SUBJECT
where credit = (SELECT MAX(Credit) FROM subject);









SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL
       (SELECT AVG(Mark)
        FROM Mark
        GROUP BY Mark.StudentId);


SELECT S.StudentId,S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) > 82;












Select S.StudentID, S.StudentName, AVG(M.Mark) AS "Điểm trung bình của mỗi học viên"
from Student S
         inner join  Mark M ON S.StudentID = M.StudentID
group by S.StudentID,S.StudentName; -- Những dữ liệu ghi vào đây phải trùng dữ lệu với nhau mới nhóm được








INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES
    ('Le Thi D', '321 Hoang Hoa Tham, Hanoi', '0123456782', 1, 1),
    ('Nguyen Thi E', '654 Ba Trieu, Hanoi', '0934876543', 1, 2),
    ('Vu Minh F', '987 Xo Viet Nghe Tinh, Hanoi', '0123654879', 1, 3);

INSERT INTO Subject (SubName, Credit, Status)
VALUES
    ('Biology', 3, 1),
    ('History', 4, 1),
    ('Computer Science', 3, 1);



INSERT INTO Student (StudentId, StudentName, Address, Phone, Status, ClassId)
VALUES
    (1, 'Nguyen Van A', '123 Nguyen Trai, Hanoi', '0123456789', 1, 1),
    (2, 'Tran Thi B', '456 Le Duan, Hanoi', '0987654321', 1, 2),
    (3, 'Pham Thi C', '789 Ba Trieu, Hanoi', '0112233445', 0, 3),
    (4, 'Le Thi D', '123 Nguyen Trai, Hanoi', '0123456780', 1, 1),
    (5, 'Nguyen Thi E', '456 Le Duan, Hanoi', '0987654322', 1, 2),
    (6, 'Pham Thi F', '789 Ba Trieu, Hanoi', '0112233446', 1, 2),
    (7, 'Nguyen Thi G', '123 Nguyen Trai, Hanoi', '0123456781', 1, 1),
    (8, 'Tran Thi H', '101 Kim Ma, Hanoi', '0123456782', 1, 3),
    (9, 'Le Thi I', '101 Kim Ma, Hanoi', '0123456783', 1, 3),
    (10, 'Le Thi D', '321 Hoang Hoa Tham, Hanoi', '0123456782', 1, 1);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES
    ('Le Thi G', '123 Le Duan, Hanoi', '0123456782', 1, 1),
    ('Nguyen Thi H', '456 Tran Phu, Hanoi', '0934876543', 1, 2),
    ('Pham Minh I', '789 Hang Bai, Hanoi', '0123654879', 1, 3);
-- Chèn thêm điểm thi cho sinh viên 1 và môn SubId = 1 (Mathematics), lần thi thứ 2
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES
    (1, 1, 90, 2);  -- Sinh viên 1 thi lại môn Mathematics

-- Chèn thêm điểm thi cho sinh viên 2 và môn SubId = 2 (Physics), lần thi thứ 2
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES
    (2, 2, 85, 2);  -- Sinh viên 2 thi lại môn Physics

-- Chèn thêm điểm thi cho sinh viên 3 và môn SubId = 3 (Chemistry), lần thi thứ 2
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES
    (3, 3, 82, 2);  -- Sinh viên 3 thi lại môn Chemistry



INSERT INTO Subject (SubName, Credit, Status)
VALUES
    ('Biology', 3, 1),
    ('History', 4, 1),
    ('Computer Science', 3, 1);

-- Thêm dữ liệu vào bảng Student
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES
    ('Le Thi D', '123 Nguyen Trai, Hanoi', '0123456780', 1, 1),
    ('Nguyen Thi E', '456 Le Duan, Hanoi', '0987654322', 1, 2),
    ('Pham Thi F', '789 Ba Trieu, Hanoi', '0112233446', 1, 2),
    ('Nguyen Thi G', '123 Nguyen Trai, Hanoi', '0123456781', 1, 1),
    ('Tran Thi H', '101 Kim Ma, Hanoi', '0123456782', 1, 3),
    ('Le Thi I', '101 Kim Ma, Hanoi', '0123456783', 1, 3);

-- Kiểm tra bảng Student
SELECT * FROM Student;

INSERT INTO center (name) VALUES
                              ('Center 1'),
                              ('Center 2'),
                              ('Center 3');



INSERT INTO Classver2 (name, center_id) VALUES
                                            ('Class 1', 1),
                                            ('Class 2', 1),
                                            ('Class 3', 2),
                                            ('Class 4', 3);

INSERT INTO Studentver2 (name, address, email, age, class_id) VALUES
                                                                  ('John Doe', '123 Main St', 'john.doe@example.com', 20, 1),
                                                                  ('Jane Smith', '456 Elm St', 'jane.smith@example.com', 22, 1),
                                                                  ('Alice Johnson', '789 Oak St', 'alice.johnson@example.com', 19, 2),
                                                                  ('Bob Brown', '321 Pine St', 'bob.brown@example.com', 21, 3),
                                                                  ('Charlie Davis', '654 Cedar St', 'charlie.davis@example.com', 23, 4);

ALTER TABLE Studentver2 DROP FOREIGN KEY studentver2_ibfk_1;

ALTER TABLE Studentver2
    ADD CONSTRAINT fk_class_id
        FOREIGN KEY (class_id)
            REFERENCES Classver2(id);

Create table Center(
                       id int primary key auto_increment,
                       name varchar(50)
);


create table Classver2(
                          id int primary key auto_increment,
                          name varchar(50),
                          center_id int,
                          foreign key (center_id) references Center(id)
);

create table Studentver2(
                            id int auto_increment,
                            name varchar(50) not null,
                            address varchar(50),
                            email varchar(50) unique,
                            age int,
                            class_id int,
                            primary key (id),
                            check (age<150),
                            foreign key(class_id) references Classver2(id)
);

SELECT * FROM StudentVer2;
SELECT * FROM ClassVer2;
SELECT * FROM Center;

select LENGTH(name)
from Center
;









select address, count(*)
from StudentVer2
group by address
having count(*) > 1
order by address

select AVG(age) As "Trung bình"
from StudentVer2

insert into Classver2(name, center_id) values ('C0924g1',1);
insert into Classver2(name, center_id) values ('C0924g1',1);
insert into Classver2(name, center_id) values ('C0924g1',2);






Select Address, count(StudentID) AS "Số lượng học viên by ID"
from Student
group by Address;

Select Address, count(StudentName) AS "Số lượng học viên by Name"
from Student
group by Address

-- Đếm số lượng học viên có tên trong bảng Student (nếu có bất kỳ bản ghi nào có NULL trong cột StudentName, chúng sẽ không được tính vào tổng số).