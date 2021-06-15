-- 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K”
--  và có tối đa 15 ký tự.

use furama_resort;
select * 
from nhan_vien
where (substring_index(ten_nv," ", -1) like "H%" 
or substring_index(ten_nv," ", -1) like "T%"  or 
substring_index(ten_nv," ", -1) like "K%" )
 and character_length(ten_nv) <=15;
