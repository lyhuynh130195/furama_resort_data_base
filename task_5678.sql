/*5.	Hiển thị IDKhachHang, HoTen, TenLoaiKhach, IDHopDong, TenDichVu, NgayLamHopDong, NgayKetThuc, TongTien
 (Với TongTien được tính theo công thức như sau: ChiPhiThue + SoLuong*Gia, với SoLuong và Giá là từ bảng DichVuDiKem)
 cho tất cả các Khách hàng đã từng đặt phỏng. 
(Những Khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
*/

use furama_resort;
select kh.id_khach_hang,kh.ho_ten,lk.ten_loai_khach,hd.id_hop_dong,dv.ten_dv,hd.ngay_lam_hd,hd.ngay_ket_thuc,
(dv.chi_phi_thue+dvdk.don_vi*dvdk.gia_dvdk) as tong_tien
from khach_hang as kh join loai_khach as lk on kh.id_loai_kh = lk.id_loai_kh
left join hop_dong as hd on hd.id_khach_hang=kh.id_khach_hang
left join dich_vu as dv on hd.id_dich_vu = dv.id_dich_vu
left join hop_dong_chi_tiet as hdct on hdct.id_hop_dong =hd.id_hop_dong
left join dich_vu_di_kem as dvdk on dvdk.id_dvdk=hdct.id_dvdk;

-- 6.	Hiển thị IDDichVu, TenDichVu, DienTich, ChiPhiThue, TenLoaiDichVu
--  của tất cả các loại Dịch vụ chưa từng được Khách hàng thực hiện đặt từ quý 1 của năm 2019 (Quý 1 là tháng 1, 2, 3)

use furama_resort;
select dv.id_dich_vu,dv.ten_dv,dv.dien_tich,dv.chi_phi_thue,ldv.ten_dv
from dich_vu as dv
inner join loai_dich_vu as ldv on dv.id_loai_dv = ldv.id_loai_dv
where id_dich_vu not in (select id_dich_vu from hop_dong where ngay_lam_hd between '2019-01-01'
 and  '2019-03-31');

-- 7.	Hiển thị thông tin IDDichVu, TenDichVu, DienTich, SoNguoiToiDa, ChiPhiThue, TenLoaiDichVu
--  của tất cả các loại dịch vụ đã từng được Khách hàng đặt phòng trong năm 2018 nhưng
--  chưa từng được Khách hàng đặt phòng  trong năm 2019.
use furama_resort;
select dv.id_dich_vu,dv.ten_dv,dv.dien_tich,dv.chi_phi_thue,ldv.ten_dv
from dich_vu as dv
inner join loai_dich_vu as ldv on dv.id_loai_dv = ldv.id_loai_dv
where id_dich_vu in (select id_dich_vu from hop_dong where ngay_lam_hd between '2017-31-12'
 and  '2019-01-01') and id_dich_vu not in (select id_dich_vu from hop_dong where ngay_lam_hd between '2018-31-12'
 and  '2020-01-01');
 
--  8.	Hiển thị thông tin HoTenKhachHang có trong hệ thống, với yêu cầu HoThenKhachHang không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên
-- cách 1
use furama_resort;
select  distinct kh.ho_ten
from khach_hang as kh;
-- cách 2
select kh.ho_ten
from khach_hang as kh
union
select kh.ho_ten
from khach_hang as kh;
-- cách 3
select kh.ho_ten
from khach_hang as kh
group by ho_ten;




