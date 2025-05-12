-- Tạo bảng test với các cột có độ dài khác nhau
CREATE TABLE length_test (
    id SERIAL PRIMARY KEY,
    short_text VARCHAR(10),
    medium_text VARCHAR(100),
    long_text VARCHAR(1000),
    short_char CHAR(10),
    medium_char CHAR(100),
    long_char CHAR(1000)
);

-- Insert dữ liệu test
INSERT INTO length_test (short_text, medium_text, long_text, short_char, medium_char, long_char)
VALUES
    ('test', 'This is a medium length text for testing purposes', 'This is a very long text that will be used to test the performance and storage implications of using different length settings in PostgreSQL. We will use this to compare how different length settings affect the database.',
     'test', 'This is a medium length text for testing purposes', 'This is a very long text that will be used to test the performance and storage implications of using different length settings in PostgreSQL. We will use this to compare how different length settings affect the database.');

-- Kiểm tra kích thước lưu trữ
SELECT
    pg_size_pretty(pg_total_relation_size('length_test')) as total_size,
    pg_size_pretty(pg_relation_size('length_test')) as table_size,
    pg_size_pretty(pg_total_relation_size('length_test') - pg_relation_size('length_test')) as index_size;

-- Kiểm tra thời gian thực thi các truy vấn
EXPLAIN ANALYZE SELECT * FROM length_test WHERE short_text = 'test';
EXPLAIN ANALYZE SELECT * FROM length_test WHERE medium_text = 'This is a medium length text for testing purposes';
EXPLAIN ANALYZE SELECT * FROM length_test WHERE long_text = 'This is a very long text that will be used to test the performance and storage implications of using different length settings in PostgreSQL. We will use this to compare how different length settings affect the database.';

-- Kiểm tra việc cập nhật dữ liệu
EXPLAIN ANALYZE UPDATE length_test
SET short_text = 'new test',
    medium_text = 'This is a new medium length text for testing purposes',
    long_text = 'This is a new very long text that will be used to test the performance and storage implications of using different length settings in PostgreSQL. We will use this to compare how different length settings affect the database.';

-- Xóa bảng test
DROP TABLE length_test;
