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

