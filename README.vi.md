# Repository Kiểm Thử Cơ Sở Dữ Liệu

Repository này chứa các test case và kịch bản kiểm thử cho PostgreSQL và MySQL. Nó được thiết kế để giúp các nhà phát triển kiểm tra các tính năng, hành vi và trường hợp đặc biệt của cơ sở dữ liệu trên các phiên bản khác nhau.

## Các Phiên Bản Cơ Sở Dữ Liệu Được Hỗ Trợ

### PostgreSQL

- 17 (Port: 5417)
- 16 (Port: 5416)

### MySQL

- 9 (Port: 3390)
- 8 (Port: 3380)

## Cấu Trúc Repository

```
.
├── tests/                    # Thư mục chứa test case
│   ├── postgresql/           # Test case cho PostgreSQL
│   │   └── length_test/      # Test cho các hàm xử lý độ dài chuỗi
│   └── mysql/                # Test case cho MySQL
│       └── length_test/      # Test cho các hàm xử lý độ dài chuỗi
├── scripts/                  # Script tiện ích
│   ├── run_containers.sh     # Script quản lý container
│   ├── run_sql.sh            # Script thực thi SQL
│   └── common.sh             # Các hàm dùng chung
├── results/                  # Kết quả và log test
├── docker-compose.yml        # Cấu hình container
├── .gitignore                # Quy tắc bỏ qua của Git
├── .cursorignore             # Quy tắc bỏ qua của Cursor IDE
└── LICENSE                   # File giấy phép MIT
```

## Cấu Hình Cơ Sở Dữ Liệu

### PostgreSQL

- Người dùng mặc định: testuser
- Mật khẩu mặc định: testpass
- Database mặc định: testdb
- Lưu trữ dữ liệu: Có (Docker volumes)

### MySQL

- Mật khẩu root: rootpass
- Người dùng mặc định: testuser
- Mật khẩu mặc định: testpass
- Database mặc định: testdb
- Lưu trữ dữ liệu: Có (Docker volumes)

## Các Loại Test

1. **Thao Tác Cơ Bản**

   - Các thao tác CRUD
   - Kiểu dữ liệu và ràng buộc
   - Index và hiệu năng
   - Truy vấn SQL cơ bản và join

2. **Tính Năng Nâng Cao**

   - Giao dịch và tính chất ACID
   - Đồng thời và khóa
   - Phân vùng và sharding
   - Stored procedure và function
   - Trigger và event

3. **Trường Hợp Đặc Biệt**
   - Xử lý lỗi và khôi phục
   - Điều kiện biên
   - Hiệu năng dưới tải
   - Kịch bản toàn vẹn dữ liệu
   - Tính năng đặc thù theo phiên bản

## Bắt Đầu

### Yêu Cầu

- Đã cài đặt Docker hoặc Podman
- Đã cài đặt Docker Compose hoặc Podman Compose
- Kiến thức cơ bản về SQL và khái niệm cơ sở dữ liệu

### Chạy Test

1. Khởi động container cơ sở dữ liệu cần thiết:

   ```bash
   # Sử dụng Docker (mặc định)
   ./scripts/run_containers.sh start postgres_17_test  # Cho PostgreSQL 17
   # hoặc
   ./scripts/run_containers.sh start mysql_9_test      # Cho MySQL 9

   # Sử dụng Podman
   CONTAINER_RUNTIME=podman ./scripts/run_containers.sh start postgres_17_test
   ```

2. Thực thi file SQL test:

   ```bash
   # Chạy test PostgreSQL
   ./scripts/run_sql.sh tests/postgresql/length_test/length_test.sql postgres 17

   # Chạy test MySQL
   ./scripts/run_sql.sh tests/mysql/length_test/length_test.sql mysql 9
   ```

   Script sẽ:

   - Thực thi file SQL trong container cơ sở dữ liệu được chỉ định
   - Lưu kết quả vào thư mục results với timestamp
   - Hiển thị kết quả trong terminal

3. Kiểm tra kết quả test:

   ```bash
   # Xem kết quả test PostgreSQL
   ls -l results/postgresql/version_17/

   # Xem kết quả test MySQL
   ls -l results/mysql/version_9/
   ```

   Kết quả test được lưu theo định dạng:

   ```
   results/
   ├── postgresql/
   │   └── version_17/
   │       └── length_test_YYYYMMDD_HHMMSS.log
   └── mysql/
       └── version_9/
           └── length_test_YYYYMMDD_HHMMSS.log
   ```

4. Dừng container khi hoàn thành:

   ```bash
   ./scripts/run_containers.sh stop postgres_17_test  # Dừng PostgreSQL 17
   # hoặc
   ./scripts/run_containers.sh stop mysql_9_test      # Dừng MySQL 9
   ```

### Quản Lý Container

Repository bao gồm script quản lý container (`scripts/run_containers.sh`) với các lệnh sau:

```bash
./scripts/run_containers.sh help    # Hiển thị trợ giúp
./scripts/run_containers.sh start   # Khởi động container
./scripts/run_containers.sh stop    # Dừng container
./scripts/run_containers.sh status  # Xem trạng thái container
./scripts/run_containers.sh logs    # Xem log container
./scripts/run_containers.sh list    # Liệt kê container có sẵn
```

## Quy Tắc Thực Hành Tốt

1. **Cô Lập Test**

   - Mỗi test phải độc lập và tự chứa
   - Dọn dẹp dữ liệu test sau khi thực thi
   - Sử dụng transaction khi phù hợp
   - Tránh phụ thuộc giữa các test

2. **Tài Liệu**

   - Tài liệu hóa điều kiện tiên quyết và cài đặt
   - Bao gồm kết quả mong đợi và trường hợp đặc biệt
   - Ghi chú hành vi đặc thù theo phiên bản
   - Tài liệu hóa kỳ vọng về hiệu năng

3. **Tương Thích Phiên Bản**

   - Test trên tất cả các phiên bản được hỗ trợ
   - Tài liệu hóa tính năng đặc thù theo phiên bản
   - Xử lý khác biệt giữa các phiên bản phù hợp
   - Duy trì tương thích ngược

4. **Bảo Mật**

   - Sử dụng mật khẩu an toàn trong môi trường production
   - Tuân thủ nguyên tắc đặc quyền tối thiểu
   - Bảo mật dữ liệu test nhạy cảm
   - Sử dụng biến môi trường cho thông tin xác thực

5. **Hiệu Năng**
   - Giám sát sử dụng tài nguyên
   - Dọn dẹp container không sử dụng
   - Sử dụng index phù hợp
   - Tối ưu hóa truy vấn test

## Đóng Góp

Khi thêm test case mới:

1. Tạo thư mục mới cho loại test nếu chưa tồn tại
2. Thêm README.md trong thư mục test giải thích:
   - Mục đích của test
   - Hành vi mong đợi
   - Điều kiện tiên quyết hoặc cài đặt cần thiết
   - Ghi chú về tương thích phiên bản
3. Bao gồm dữ liệu mẫu và kết quả mong đợi
4. Tài liệu hóa hành vi đặc thù theo phiên bản
5. Tuân theo cấu trúc thư mục đã thiết lập
6. Cập nhật README.md chính nếu cần thiết

## Xử Lý Sự Cố

Các vấn đề thường gặp và giải pháp:

1. **Container không khởi động**

   - Kiểm tra xem port có sẵn không
   - Xác minh Docker/Podman đang chạy
   - Kiểm tra log container

2. **Vấn đề kết nối cơ sở dữ liệu**

   - Xác minh container đang chạy
   - Kiểm tra ánh xạ port
   - Xác minh thông tin xác thực

3. **Test thất bại**
   - Kiểm tra tương thích phiên bản
   - Xác minh điều kiện tiên quyết
   - Xem xét log test

## Giấy Phép

Dự án này được cấp phép theo MIT License - xem file LICENSE để biết thêm chi tiết.
