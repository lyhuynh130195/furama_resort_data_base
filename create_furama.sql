create database furama_resort;
use furama_resort;

create table vi_tri(
id_vi_tri int primary key,
ten_vi_tri varchar(45));

create table trinh_do(
id_trinh_do int primary key,
ten_trinh_do varchar(45));

create table bo_phan(
id_bo_phan int primary key,
ten_bo_phan varchar(45));

create table loai_khach(
id_loai_kh int primary key,
ten_loai_khach varchar(45));

create table kieu_thue(
id_kieu_thue int primary key,
ten_kieu_thue varchar(45),
gia int);

create table loai_dich_vu(
id_loai_dv int primary key,
ten_dv varchar(45));

create table dich_vu_di_kem(
id_dvdk int primary key,
ten_dvdk varchar(45) not null,
gia_dvdk int not null,
don_vi int,
status bit);

create table nhan_vien(
id_nv int primary key,
ten_nv varchar(45) not null,
id_vi_tri int,
id_bo_phan int,
id_trinh_do int,
ngay_sinh date,
so_cmnd varchar(45) not null,
luong varchar(45),
sdt varchar(45),
email varchar(45),
dia_chi varchar(45),
foreign key(id_vi_tri) references vi_tri(id_vi_tri),
foreign key(id_bo_phan) references bo_phan(id_bo_phan),
foreign key(id_trinh_do) references trinh_do(id_trinh_do));

create table khach_hang(
id_khach_hang int primary key,
ho_ten varchar(45) not null,
ngay_sinh date ,
so_cmnd varchar(45) not null,
sdt varchar(45),
email varchar(45),
dia_chi varchar(45),
id_loai_kh int,
foreign key(id_loai_kh) references loai_khach(id_loai_kh));

create table dich_vu(
id_dich_vu int primary key,
ten_dv varchar(45) not null,
dien_tich int,
so_tang int,
so_nguoi_toi_da int,
chi_phi_thue varchar(45),
id_kieu_thue int,
id_loai_dv int,
status bit,
foreign key(id_kieu_thue) references kieu_thue(id_kieu_thue),
foreign key(id_loai_dv) references loai_dich_vu(id_loai_dv));

create table hop_dong(
id_hop_dong int primary key,
id_nv int,
id_khach_hang int,
id_dich_vu int,
ngay_lam_hd date,
ngay_ket_thuc date,
tien_coc int,
tien_ung int,
foreign key(id_nv) references nhan_vien(id_nv),
foreign key(id_khach_hang) references khach_hang(id_khach_hang),
foreign key(id_dich_vu) references dich_vu(id_dich_vu)
)

create table hop_dong_chi_tiet(
id_hdct int primary key,
id_hop_dong int,
id_dvdk int,
so_luong int,
foreign key(id_hop_dong) references hop_dong(id_hop_dong),
foreign key(id_dvdk) references dich_vu_di_kem(id_dvdk));
