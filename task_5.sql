/*5.	Hiển thị IDKhachHang, HoTen, TenLoaiKhach, IDHopDong, TenDichVu, NgayLamHopDong, NgayKetThuc, TongTien
 (Với TongTien được tính theo công thức như sau: ChiPhiThue + SoLuong*Gia, với SoLuong và Giá là từ bảng DichVuDiKem)
 cho tất cả các Khách hàng đã từng đặt phỏng. 
(Những Khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
*/

use furama_resort;
select*
from khach_hang as kh join loai_khach as lk on kh.id_loai_kh = lk.id_loai_kh
left join dich_vu as dv on kh.id_khach_hang = dv.id_khach_hang


