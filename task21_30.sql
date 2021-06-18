# 21.	Tạo khung nhìn có tên là V_NHANVIEN để lấy được thông tin của tất cả các nhân viên có địa chỉ là “Hải Châu”
# và đã từng lập hợp đồng cho 1 hoặc nhiều Khách hàng bất kỳ  với ngày lập hợp đồng là “2021-02-11”
use furama_resort;
create  view  v_nhan_vien as
    select nv.*
from nhan_vien nv join hop_dong hd on nv.id_nv = hd.id_nv
where nv.dia_chi='Da Nang' and hd.ngay_lam_hd ='2021-02-11';

select * from v_nhan_vien;

# 22.	Thông qua khung nhìn V_NHANVIEN thực hiện cập nhật địa chỉ thành “Nghe An” đối với tất cả các Nhân viên
# được nhìn thấy bởi khung nhìn này.

update v_nhan_vien
set dia_chi='Nghe An';

# 23.	Tạo Clustered Index có tên là IX_KHACHHANG trên bảng Khách hàng.

alter table khach_hang add index IX_KHACHHANG(ho_ten);

explain select * from khach_hang
where khach_hang.ho_ten='Le Van Minh';
# trước khi tạo chỉ mục type=all,rows=6
# sau khi tạo chỉ mục type=ref ,rows=1

# 24.	Tạo Non-Clustered Index có tên là IX_SoDT_DiaChi trên các cột SODIENTHOAI và DIACHI trên bảng KHACH HANG
# và kiểm tra tính hiệu quả tìm kiếm sau khi tạo Index.


# 25.	Tạo Store procedure Sp_1 Dùng để xóa thông tin của một Khách hàng nào đó với Id Khách hàng được truyền vào
# như là 1 tham số của Sp_1
delimiter //
create procedure sp_1(in id int)
begin
    delete from khach_hang
        where khach_hang.id_khach_hang=id;
end //

delimiter ;

call sp_1(6);

# 26.	Tạo Store procedure Sp_2 Dùng để thêm mới vào bảng HopDong với yêu cầu Sp_2 phải thực hiện kiểm tra
# tính hợp lệ của dữ liệu bổ sung, với nguyên tắc không được trùng khóa chính và
# đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.
delimiter //
create procedure sp_2(in id_hd int,in id_nv int,in id_kh int,in id_dv int,in ngay_hd datetime,in ngay_kt datetime,
in tien_coc1 int,in tien_ung1 int)
begin
insert into hop_dong values (id_hd,id_nv,id_kh,id_dv,ngay_hd,ngay_kt,tien_coc1,tien_ung1);
end //
delimiter ;

# 27.	Tạo triggers có tên Tr_1 Xóa bản ghi trong bảng HopDong thì hiển thị tổng số lượng bản ghi còn lại có trong bảng
# HopDong ra giao diện console của database
