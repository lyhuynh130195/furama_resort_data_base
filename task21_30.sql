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

create unique index IX_KHACHHANG on khach_hang(id_khach_hang);
explain select * from khach_hang;

# 24.	Tạo Non-Clustered Index có tên là IX_SoDT_DiaChi trên các cột SODIENTHOAI và DIACHI trên bảng KHACH HANG
# và kiểm tra tính hiệu quả tìm kiếm sau khi tạo Index.

alter table khach_hang add index IX_SoDT_DiaChi(sdt,dia_chi);
explain select * from khach_hang
        where khach_hang.ho_ten='Le Van Minh';

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
create procedure sp_2(in id_hd int,in id_nv1 int,in id_kh int,in id_dv int,in ngay_hd datetime,in ngay_kt datetime,
in tien_coc1 int,in tien_ung1 int)
begin
    if(id_hd not in(select hop_dong.id_hop_dong from hop_dong)) then
insert into hop_dong values (id_hd,id_nv1,id_kh,id_dv,ngay_hd,ngay_kt,tien_coc1,tien_ung1);
end if;
end //
delimiter ;

/*27.Tạo triggers có tên Tr_1 Xóa bản ghi trong bảng HopDong thì hiển thị tổng số lượng bản ghi còn lại có trong bảng
 HopDong ra giao diện console của database*/
 delimiter //
drop trigger if exists tr_1 //
create trigger tr_1
    after delete
    on hop_dong for each row
    begin
        set @s=(select count(id_hop_dong)  as so_hop_dong_con_lai from hop_dong);
    end//
delimiter ;

SET FOREIGN_KEY_CHECKS=OFF;
delete from hop_dong
    where id_hop_dong=10;
select @s as so_hop_dong_con_lai;
SET FOREIGN_KEY_CHECKS=ON;

# 28.	Tạo triggers có tên Tr_2 Khi cập nhật Ngày kết thúc hợp đồng, cần kiểm tra xem thời gian cập nhật có phù hợp hay không,
# với quy tắc sau: Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày.
# Nếu dữ liệu hợp lệ thì cho phép cập nhật, nếu dữ liệu không hợp lệ thì in ra thông báo “Ngày kết thúc hợp đồng
# phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày” trên console của database
delimiter //
drop trigger if exists tr_2//
create trigger tr_2
    after update
    on hop_dong for each row
    begin
        if datediff(new.ngay_ket_thuc,old.ngay_lam_hd)<2 then
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ngày kết thúc hợp đồngphải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày';
        end if;
    end //
delimiter ;

update hop_dong
    set ngay_ket_thuc='2021-04-07'
where id_hop_dong=8;



# 29.	Tạo user function thực hiện yêu cầu sau:
# a.	Tạo user function func_1: Đếm các dịch vụ đã được sử dụng với Tổng tiền là > 2.000.000 VNĐ.

create temporary table tong_tien_dich_vu
select dv.id_dich_vu as id_dich_vu,dv.ten_dv as ten_dich_vu,sum(dv.chi_phi_thue+hdct.so_luong*dvdk.gia_dvdk) as tong_tien
from dich_vu dv join hop_dong hd on dv.id_dich_vu = hd.id_dich_vu
                join hop_dong_chi_tiet hdct on hd.id_hop_dong = hdct.id_hop_dong
                join dich_vu_di_kem dvdk on dvdk.id_dvdk = hdct.id_dvdk
group by hd.id_dich_vu
having sum(dv.chi_phi_thue+hdct.so_luong*dvdk.gia_dvdk)>1000;
drop table tong_tien_dich_vu;


delimiter //
create function  func_1()
returns int
    deterministic
begin
declare count int;
set count=(select count(tong_tien) from tong_tien_dich_vu
  group by tong_tien_dich_vu.id_dich_vu);
return count;
end //
delimiter ;

select furama_resort.func_1() as so_lan_dich_vu;
drop function func_1;

# b.	Tạo user function Func_2: Tính khoảng thời gian dài nhất tính từ lúc bắt đầu làm hợp đồng đến lúc kết thúc hợp đồng
# mà Khách hàng đã thực hiện thuê dịch vụ (lưu ý chỉ xét các khoảng thời gian dựa vào từng lần làm hợp đồng thuê dịch vụ,
# không xét trên toàn bộ các lần làm hợp đồng). Mã của Khách hàng được truyền vào như là 1 tham số của function này.
create temporary table thoi_gian_hop_dong
select kh.id_khach_hang as id_khach_hang, datediff(ngay_ket_thuc,ngay_lam_hd) as thoi_gian_hop_dong2
    from khach_hang kh join hop_dong hd on kh.id_khach_hang = hd.id_khach_hang
group by hd.id_khach_hang;

delimiter //
create function func_2 (id_khach_hang int)
    returns int
    deterministic
begin
    declare thoi_gian int;
    set thoi_gian =(select max(thoi_gian_hop_dong2) from thoi_gian_hop_dong);
    return thoi_gian;
end;
// delimiter ;
select furama_resort.func_2(4);


# 30.	Tạo Stored procedure Sp_3 để tìm các dịch vụ được thuê bởi khách hàng với loại dịch vụ là “Room” từ đầu năm 2015
# đến hết năm 2021 để xóa thông tin của các dịch vụ đó (tức là xóa các bảng ghi trong bảng DichVu) và xóa những HopDong
# sử dụng dịch vụ liên quan (tức là phải xóa những bản gi trong bảng HopDong) và những bản liên quan khác.
create temporary table dich_vu_room
select dv.id_dich_vu,hd.id_hop_dong,hdct.id_hdct
    from dich_vu dv join hop_dong hd on dv.id_dich_vu = hd.id_dich_vu
join loai_dich_vu ldv on ldv.id_loai_dv = dv.id_loai_dv
join hop_dong_chi_tiet hdct on hd.id_hop_dong = hdct.id_hop_dong
where ldv.ten_dv='room' and year(hd.ngay_lam_hd) between '2014' and '2022';

delimiter //
create procedure sp_3()
begin
delete from hop_dong_chi_tiet where id_hdct in(select id_hdct from dich_vu_room);
delete from hop_dong where id_hop_dong in(select  id_hop_dong from dich_vu_room);
delete from dich_vu where id_dich_vu in(select id_dich_vu from dich_vu_room);
end //
delimiter ;