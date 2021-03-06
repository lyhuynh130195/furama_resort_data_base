-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
use furama_resort;
select*
from khach_hang
where (year(now())-year(ngay_sinh)) between 18 and 50 and dia_chi in("Da Nang","Quang Tri");
/* 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần.
 Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng.
  Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.*/
  
  select kh.id_khach_hang,kh.ho_ten ,COUNT(hd.id_khach_hang) as total
  from  hop_dong as hd  join  khach_hang as kh
  on kh.id_khach_hang = hd.id_khach_hang
  where kh.id_loai_kh=(select id_loai_kh from loai_khach where ten_loai_khach ="Diamond")
  group by kh.id_khach_hang
  having COUNT(hd.id_khach_hang)
  order by total asc;
  
  
  