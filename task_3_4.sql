-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
use furama_resort;
select*
from khach_hang
where ngay_sinh between "1971-01-01" and "2003-01-01" and dia_chi in("Da Nang","Quang Tri");
/* 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần.
 Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng.
  Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.*/
  
  select kh.id_khach_hang,kh.ho_ten ,COUNT(kh.id_khach_hang) as total
  from  khach_hang as kh join hop_dong as hd
  on kh.id_khach_hang = hd.id_khach_hang
  where kh.id_loai_kh=(select id_loai_kh from loai_khach where ten_loai_khach ="Diamond")
  group by kh.id_khach_hang
  having COUNT(kh.id_khach_hang)
  order by total asc;
  
  
  