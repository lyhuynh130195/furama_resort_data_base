use furama_resort;
-- Lễ tân, phục vụ, chuyên viên, giám sát, quản lý, giá đốc.
insert into vi_tri values(1,"giam doc"),(2,"quan li"),(3,"giam sat"),(4,"chuyen vien"),(5,"phuc vu"),(6,"le tan");
-- Trung cấp, Cao đẳng, Đại học và sau đại học
insert into trinh_do values(1,"Dai hoc"),(2,"Cao Dang"),(3,"Trung cap");
-- SET SQL_SAFE_UPDATES = 0;
-- Sale – Marketing, Hành Chính, Phục vụ, Quản lý.
insert into bo_phan values(1,"Sale – Marketing"),(2,"Hành Chính"),(3,"Phục vụ"),(4,"Quản lý");
-- Loại Customer bao gồm: (Diamond, Platinium, Gold, Silver, Member).
insert into loai_khach values(1,"Diamond"),(2,"Platinium"),(3,"Gold"),(4,"Silver"),(5,"Member");

insert into kieu_thue values(1,"ngay",100),(2,"tuan",500),(3,"thang",1500);

insert into loai_dich_vu values(1,"villa"),(2,"house"),(3,"room");

-- dịch vụ đi kèm như massage, karaoke, thức ăn, nước uống, thuê xe di chuyển tham quan resort.
insert into dich_vu_di_kem values(1,"massage",100,1,1),(2,"karaoke",150,1,1),(3,"thức ăn",30,1,1),
(4,"nước uống",10,1,1);

insert into nhan_vien values(1,"Nguyen Van Hai",1,1,1,"1987-12-12","187985699","1000000000","0966999666","hai@gmail.com","Da Nang");
insert into nhan_vien values(2,"Nguyen Van Tai",2,2,2,"1991-10-12","187985789","100000000","0966999555","tai@gmail.com","Da Nang");
insert into nhan_vien values(3,"Nguyen Van Kien",3,3,3,"1997-1-12","187985451","10000000","0966999321","kien@gmail.com","Da Nang");
insert into nhan_vien values(4,"Nguyen Van An",3,3,3,"1997-10-12","187985323","10000000","0966999123","an@gmail.com","Da Nang");

insert into khach_hang values(1,"Le Van Minh","1995-12-12","187599566","0999879999","minh@gmail.com","Nghe An",1);
insert into khach_hang values(2,"Nguyen Tuan Anh","1996-11-12","187599886","0999879888","anh@gmail.com","Da Nang",2);
insert into khach_hang values(3,"Le Van Luyen","1985-12-10","187599963","0999879777","luyen@gmail.com","Quang Tri",3);
insert into khach_hang values(4,"Le Bao Binh","2002-10-12","187599213","0999879666","binh@gmail.com","Da Nang",4);
insert into khach_hang values(5,"Le Van Loi","2005-1-12","187599964","0999879555","loi@gmail.com","Da Nang",5);
insert into khach_hang values(6,"Le Van Loi","2004-1-12","187599960","0999879556","loi2@gmail.com","Da Nang",1);

insert into dich_vu values(1,"villa_furama",1000,10,10,1000,1,1,1);
insert into dich_vu values(2,"house_furama",700,7,7,700,2,2,1);
insert into dich_vu values(3,"room_furama",500,10,null,500,3,3,1);


insert into hop_dong values(1,1,1,1,"2021-04-04","2021-04-11",500,100);
insert into hop_dong values(2,1,1,2,"2021-05-04","2021-05-11",400,100);
insert into hop_dong values(3,1,3,3,"2021-06-04","2021-06-11",300,100);
insert into hop_dong values(4,1,4,1,"2021-07-04","2021-07-11",500,100);
insert into hop_dong values(5,1,4,1,"2021-02-11","2019-02-12",500,100);
insert into hop_dong values(6,1,4,1,"2019-02-11","2019-02-18",500,100);
insert into hop_dong values(7,1,1,2,"2018-02-11","2018-02-18",500,100);
insert into hop_dong values(8,1,1,1,'2021-04-04','2021-05-11',400,100);


insert into hop_dong_chi_tiet values(1,1,1,1);
insert into hop_dong_chi_tiet values(2,2,2,1);
insert into hop_dong_chi_tiet values(3,3,3,1);
insert into hop_dong_chi_tiet values(4,4,1,1);
insert into hop_dong_chi_tiet values(5,5,2,1);
insert into hop_dong_chi_tiet values(6,6,3,1);
insert into hop_dong_chi_tiet values(7,7,1,1);

