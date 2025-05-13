-- Tạo bảng test với các cột có độ dài khác nhau
CREATE TABLE length_test (
    id INT AUTO_INCREMENT PRIMARY KEY,
    short_text VARCHAR(10),
    medium_text VARCHAR(100),
    long_text VARCHAR(1000),
    short_char CHAR(10),
    medium_char CHAR(100),
    long_char TEXT
);

-- Insert dữ liệu test
INSERT INTO length_test (short_text, medium_text, long_text, short_char, medium_char, long_char)
VALUES
    ('test', 'This is a medium length text for testing purposes', 'This is a very long text that will be used to test the performance and storage implications of using different length settings in MySQL. We will use this to compare how different length settings affect the database.',
     'test', 'This is a medium length text for testing purposes', 'This is a very long text that will be used to test the performance and storage implications of using different length settings in MySQL. We will use this to compare how different length settings affect the database.');

-- Kiểm tra kích thước lưu trữ
SELECT
    table_name,
    data_length/1024/1024 as data_size_mb,
    index_length/1024/1024 as index_size_mb,
    (data_length + index_length)/1024/1024 as total_size_mb
FROM information_schema.tables
WHERE table_schema = 'testdb' AND table_name = 'length_test';

-- Kiểm tra thời gian thực thi các truy vấn
EXPLAIN SELECT * FROM length_test WHERE short_text = 'test';
EXPLAIN SELECT * FROM length_test WHERE medium_text = 'This is a medium length text for testing purposes';
EXPLAIN SELECT * FROM length_test WHERE long_text = 'This is a very long text that will be used to test the performance and storage implications of using different length settings in MySQL. We will use this to compare how different length settings affect the database.';

-- Kiểm tra việc cập nhật dữ liệu
EXPLAIN UPDATE length_test
SET short_text = 'new test',
    medium_text = 'This is a new medium length text for testing purposes',
    long_text = 'This is a new very long text that will be used to test the performance and storage implications of using different length settings in MySQL. We will use this to compare how different length settings affect the database.';

-- Xóa bảng test
DROP TABLE length_test;
