# ĐỒ ÁN CUỐI KỲ 
# LẬP TRÌNH ỨNG DỤNG QUẢN LÝ 1 KHÓA 2015
# NHÓM 15

# Thông tin các thành viên của nhóm:
# MSSV : 1560454

# MSSV : 1560468

# MSSV : 1560480

# MSSV : 1560485

I.Đề tài: Ứng dụng Quản lý Thư viện trường

II.Mô tả bài toán

Trường Đại học ABC có nhu cầu xây dựng một ứng dụng để quản lý thư viện trường sắp được đưa vào hoạt động trong thời gian tới.
Trường hiện đang quản lý một lượng lớn hệ thống tài liệu như tài liệu khoa học (sách chuyên ngành, tạp chí chuyên ngành),
sách giáo trình, sách học ngoại ngữ, sách kỹ năng – đời sống, truyện và các loại đa phương tiện như CD, DVD, … 
Thư viện được phân chia thành nhiều khu vực theo lĩnh vực. Thư viện trường sẽ cung cấp dịch vụ cho ba loại độc giả: sinh viên, 
giảng viên/cán bộ và khách vãng lai. 
Tất cả đối tượng đều phải đăng ký độc giả của thư viện để được sử dụng các dịch vụ của thư viện. 
Độc giả có thể mượn tài liệu với số lượng và số ngày mượn tối đa tùy vào loại độc giả. 
Một số tài liệu đặc biệt cũng chỉ dành cho giảng viên/cán bộ trường. 
Ngoài ra, một số tài liệu hiếm cũng không được phép mượn về. 
Nếu độc giả trả sách không đúng hạn thì sẽ chịu một số hình thức từ cảnh cáo, đóng phạt và không được phép tiếp tục sử dụng 
dịch vụ. Khi có nguồn tài liệu mới, thư viện sẽ lập danh sách tài liệu được nhập cho mỗi đợt nhập.

III. Danh sách chức năng
A. Nhóm chức năng quản lý CRUD độc giả

1. Đăng ký độc giả

- Các thông tin cá nhân: Họ và tên, CMND, Ngày sinh, Số điện thoại, Địa chỉ email, Địa chỉ.

- Loại độc giả, gồm 3 loại: sinh viên, giảng viên/cán bộ và khách vãng lai (có thể bổ sung loại độc giả mới trong tương lại).
Mỗi loại độc giả bao gồm các thông tin sau: Phí thường niên, Số sách mượn tối đa, Số ngày mượn tối đa, Mượn được tài liệu đặc biệt.

o Nếu sinh viên đăng ký thì sẽ cần thêm MSSV

o Nếu giảng viên/cán bộ đăng ký thì sẽ cần thêm MSCB

- Sau khi hoàn tất việc đăng ký thì độc giả sẽ được cấp một mã độc giả duy nhất.

2. Tìm kiếm độc giả:

- Theo 3 tiêu chí: Mã độc giả, CMND/MSSV/MSCB, Họ và tên

- Kết quả hiển thị việc tìm kiếm:

STT, Mã độc giả, Họ và tên, CMND, Loại độc giả, Số sách đang mượn, Số sách quá hạn.

- Có thể thực hiện chức năng Xem hết mà không cần tìm kiếm

- Đối với kết quả việc tìm kiếm, người dùng có thể thực hiện:

o Xem chi tiết thông tin độc giả

o Lập phiếu mượn sách

o Lập phiếu trả sách

o Lập phiếu cảnh cáo

3. Xem/Chỉnh sửa chi tiết thông tin độc giả

- Người dùng chỉ xem được thông tin chi tiết của độc giả nhưng không được chỉnh sửa.

- Người dùng nhấp vào nút Chỉnh sửa thì ứng dụng mới cho phép chỉnh sửa. Sau khi chỉnh sửa xong sẽ nhập chọn nút Lưu để lưu sự thay đổi.

- Lưu ý: Mã độc giả sẽ không thể chỉnh sửa.

4. Xóa độc giả

- Khi nhấn chọn nút Xóa trên bảng dữ liệu trả lời, hệ thống cần phải xác nhận lại với người dùng.

B. Nhóm chức năng CRUD quản lý tài liệu

1. Tiếp nhận tài liệu mới

2. Tìm kiếm tài liệu

- Tìm kiếm cơ bản

- Tìm kiếm nâng cao: tìm kết hợp nhiều tiêu chí

- Xem hết danh sách tài liệu

- Xem danh sách tài liệu theo loại/lĩnh vực

- Đối với kết quả việc tìm kiếm, người dùng có thể thực hiện:

o Xem chi tiết thông tin tài liệu

o Lập phiếu mượn / Thêm vào phiếu mượn

o Yêu cầu tài liệu mới

3. Xem/Chỉnh sửa chi tiết thông tin tài liệu

- Người dùng chỉ xem được thông tin chi tiết của tài liệu nhưng không được chỉnh sửa.

- Người dùng nhấp vào nút Chỉnh sửa thì ứng dụng mới cho phép chỉnh sửa. Sau khi chỉnh sửa xong sẽ nhập chọn nút Lưu để lưu sự thay đổi.

- Lưu ý: Mã tài liệu sẽ không thể chỉnh sửa.

4. Xóa tài liệu

- Khi nhấn chọn nút Xóa trên bảng dữ liệu trả lời, hệ thống cần phải xác nhận lại với người dùng.

C. Nhóm chức năng CRUD quản lý mượn – trả tài liệu

1. Quản lý phiếu mượn

a) Lập phiếu mượn:

- Thông tin phiếu mượn gồm có: mã phiếu mượn, độc giả, ngày lập phiếu, chi tiết tài liệu mượn (thông tin tài liệu mượn, hạn chót trả).

- Khi lập phiếu, thủ thư sẽ in biên nhận cho độc giả với thông tin phiếu mượn

b) Tìm kiếm phiếu mượn:

- Tìm theo mã phiếu mượn, mã độc giả

- Xem danh sách các phiếu mượn quá hạn

- Xem danh sách tất cả phiếu mượn (chưa trả)

- Đối với kết quả tìm kiếm, người dùng có thể xem chi tiết, xóa hoặc gọi trực tiếp chức năng Lập phiếu trả

c) Xem chi tiết, cập nhật, xóa

2. Quản lý phiếu trả

a) Lập phiếu trả:

- Thông tin phiếu trả gồm: mã phiếu trả, ngày lập phiếu, chi tiết phiếu trả (tài liệu trả, phiếu mượn).

- Khi lập phiếu, thủ thư sẽ in biên nhận cho độc giả với thông tin phiếu trả

b) Tìm kiếm phiếu trả

- Tìm theo mã phiếu trả, mã phiếu mượn, mã độc giả

- Xem danh sách tất cả phiếu trả

- Đối với kết quả tìm kiếm, người dùng có thể xem chi tiết, xóa

c) Xem chi tiết, cập nhật, xóa

D. Thay đổi qui định
