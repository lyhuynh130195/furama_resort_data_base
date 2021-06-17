/*9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021
  thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.*/

  use furama_resort;
select month(hd.ngay_lam_hd),count(id_hop_dong)
from khach_hang join hop_dong hd on khach_hang.id_khach_hang = hd.id_khach_hang
where year(hd.ngay_lam_hd)='2021'
group by month(hd.ngay_lam_hd);

#     10.	Hiển thị thông tin tương ứng với từng Hợp đồng thì đã sử dụng bao nhiêu Dịch vụ đi kèm.
#      Kết quả hiển thị bao gồm IDHopDong, NgayLamHopDong, NgayKetthuc, TienDatCoc, SoLuongDichVuDiKem
#     (được tính dựa trên việc count các IDHopDongChiTiet).

select hd.id_hop_dong,hd.ngay_lam_hd,hd.ngay_ket_thuc,hd.tien_coc,count(hdct.id_hdct) as so_luong_dvdk
from hop_dong hd join hop_dong_chi_tiet hdct on hd.id_hop_dong = hdct.id_hop_dong
join dich_vu_di_kem dvdk on dvdk.id_dvdk = hdct.id_dvdk
group by hd.id_hop_dong;

# 11.	Hiển thị thông tin các Dịch vụ đi kèm đã được sử dụng bởi những Khách hàng có TenLoaiKhachHang là “Diamond”
# và có địa chỉ là “Vinh” hoặc “Quảng Ngãi”.

select dvdk.*
from khach_hang kh join loai_khach lk on lk.id_loai_kh = kh.id_loai_kh
join hop_dong hd on kh.id_khach_hang = hd.id_khach_hang
join hop_dong_chi_tiet hdct on hd.id_hop_dong = hdct.id_hop_dong
join dich_vu_di_kem dvdk on dvdk.id_dvdk = hdct.id_dvdk
join loai_khach l on l.id_loai_kh = kh.id_loai_kh
where l.ten_loai_khach='Diamond';

# 12.	Hiển thị thông tin IDHopDong, TenNhanVien, TenKhachHang, SoDienThoaiKhachHang, TenDichVu, SoLuongDichVuDikem
# (được tính dựa trên tổng Hợp đồng chi tiết), TienDatCoc của tất cả các dịch vụ đã từng được khách hàng đặt vào quý 1 (3 tháng đầu năm 2021)
# tiếp tục được khách hàng đặt vào quý 2 năm 2021
 select hd.id_hop_dong,nv.ten_nv,kh.ho_ten,kh.sdt,dv.ten_dv,count(hdct.id_hop_dong) as so_luong_dvdk,sum(hd.tien_coc) as tien_coc
from hop_dong hd join nhan_vien nv on nv.id_nv = hd.id_nv
join khach_hang kh on hd.id_khach_hang = kh.id_khach_hang
join dich_vu dv on dv.id_dich_vu = hd.id_dich_vu
join dich_vu d on d.id_dich_vu = hd.id_dich_vu
join hop_dong_chi_tiet hdct on hd.id_hop_dong = hdct.id_hop_dong
where hd.ngay_lam_hd between '2020-31-12' and '2021-04-01'  and
      hd.ngay_lam_hd   between '2021-31-03' and '2021-07-01'
group by dv.id_dich_vu;


# 13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
# (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).

select dvdk.id_dvdk,dvdk.ten_dvdk,sum(hdct.so_luong)  tong_so_luong
from khach_hang kh join hop_dong hd on kh.id_khach_hang = hd.id_khach_hang
join hop_dong_chi_tiet hdct on hd.id_hop_dong = hdct.id_hop_dong
join dich_vu_di_kem dvdk on dvdk.id_dvdk = hdct.id_dvdk
group by dvdk.id_dvdk;

#     14.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. Thông tin hiển thị bao gồm
#     IDHopDong, TenLoaiDichVu, TenDichVuDiKem, SoLanSuDung.

select hd.id_hop_dong,ldv.ten_dv,dvdk.ten_dvdk,sum(hdct.so_luong) as so_lan_dung
from hop_dong hd join hop_dong_chi_tiet hdct on hd.id_hop_dong = hdct.id_hop_dong
join dich_vu_di_kem dvdk on dvdk.id_dvdk = hdct.id_dvdk
join dich_vu dv on dv.id_dich_vu = hd.id_dich_vu
join loai_dich_vu ldv on ldv.id_loai_dv = dv.id_loai_dv
group by dvdk.id_dvdk
having sum((hdct.so_luong))=1;

# 15.	Hiển thi thông tin của tất cả nhân viên bao gồm IDNhanVien, HoTen, TrinhDo, TenBoPhan, SoDienThoai,
# DiaChi mới chỉ lập được tối đa 3 hợp đồng trong năm 2020
select nv.id_nv,nv.ten_nv,td.ten_trinh_do,bp.ten_bo_phan,nv.sdt,nv.dia_chi,count(hd.id_nv) as so_lan_ky_hop_dong
from nhan_vien nv left join hop_dong hd on nv.id_nv = hd.id_nv
 join bo_phan bp on bp.id_bo_phan = nv.id_bo_phan
 join trinh_do td on td.id_trinh_do = nv.id_trinh_do
where hd.ngay_lam_hd between '2019-12-31' and '2021-01-01'
group by nv.id_nv
having count(hd.id_nv) between 1 and 3;

# 16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2018 đến tháng 6 năm 2021.
delete from nhan_vien
where id_nv not in (select nhan_vien.id_nv from nhan_vien join hop_dong hd on nhan_vien.id_nv = hd.id_nv
    where hd.ngay_lam_hd  between '2017-12-31'and '2021-05-31');

# 17.	Cập nhật thông tin những khách hàng có TenLoaiKhachHang từ  Platinium lên Diamond, chỉ cập nhật những khách hàng
# đã từng đặt phòng với tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.

#
# 18.	Xóa những khách hàng có hợp đồng trước năm 2020 (chú ý ràngbuộc giữa các bảng).
#
# 19.	Cập nhật giá cho các Dịch vụ đi kèm được sử dụng trên 3 lần trong năm 2021 lên gấp đôi.
#
# 20.	Hiển thị thông tin của tất cả các Nhân viên và Khách hàng có trong hệ thống, thông tin hiển thị bao gồm
# ID (IDNhanVien, IDKhachHang), HoTen, Email, SoDienThoai, NgaySinh, DiaChi.
