/* CREATE database FuramaResort;
use FuramaResort;
Create table vi_tri(
ma_vi_tri INT PRIMARY KEY,
ten_vi_tri VARCHAR(45)
);
Create table nhan_vien(
ma_nhan_vien INT PRIMARY KEY,
ho_ten VARCHAR(45),
ngay_sinh DATE,
so_cmnd VARCHAR(45),
luong DOUBLE,
so_dien_thoai VARCHAR(45),
email VARCHAR(45),
dia_chi VARCHAR(45),
ma_vi_tri INT,
ma_trinh_do INT,
ma_bo_phan INT
);

CREATE table khach_hang(
ma_khach_hang INT PRIMARY KEY,
ma_loai_khach INT,
ho_ten VARCHAR(45),
ngay_sinh DATE,
gioi_tinh BIT(1),
so_cmnd VARCHAR(45),
so_dien_thoai VARCHAR(45),
email VARCHAR (45),
dia_chi VARCHAR(45)
);
CREATE TABLE loai_khach(
ma_loai_khach INT PRIMARY KEY,
ten_loai_khach VARCHAR(45)
);
CREATE TABLE trinh_do(
ma_trinh_do INT PRIMARY KEY,
ten_trinh_do VARCHAR(45)
);
CREATE TABLE bo_phan(
ma_bo_phan INT PRIMARY KEY,
ten_bo_phan VARCHAR(45)
);
CREATE TABLE hop_dong_chi_tiet(
ma_hop_dong_chi_tiet INT PRIMARY KEY,
ma_hop_dong INT,
ma_dich_vu_di_kem INT,
so_luong INT
);
CREATE TABLE hop_dong(
ma_hop_dong INT PRIMARY KEY,
ngay_lam_hop_dong DATETIME,
ngay_ket_thuc DATETIME,
ten_dat_coc DOUBLE,
ma_nhan_vien INT,
ma_khach_hang INT,
ma_dich_vu  INT
);
CREATE TABLE kieu_thue(
ma_kieu_thue INT PRIMARY KEY,
ten_kieu_thue VARCHAR(45)
);
CREATE TABLE loai_dich_vu(
ma_loai_dich_vu INT PRIMARY KEY,
ten_loai_dich_vu VARCHAR(45)
);
CREATE TABLE dich_vu_di_kem(
ma_dich_vu_di_kem INT PRIMARY KEY,
ten_dich_vu_di_kem VARCHAR(45),
gia DOUBLE,
don_vi VARCHAR(45),
trang_thai VARCHAR(45)
);
CREATE TABLE dich_vu(
ma_dich_vu INT PRIMARY KEY,
ten_dich_vu VARCHAR(45),
dien_tich INT,
chi_phi_thue DOUBLE,
so_nguoi_toi_da INT,
ma_kieu_thue INT,
ma_loai_dich_vu INT,
tieu_chuan_phong VARCHAR(45),
mo_ta_tien_nghi_khac VARCHAR(45),
dien_tich_ho_boi VARCHAR(45),
so_tang INT
);
AlTER TABLE nhan_vien ADD FOREIGN KEY(ma_vi_tri) REFERENCES vi_tri(ma_vi_tri);
AlTER TABLE nhan_vien ADD FOREIGN KEY(ma_trinh_do) REFERENCES trinh_do(ma_trinh_do);
AlTER TABLE nhan_vien ADD FOREIGN KEY(ma_bo_phan) REFERENCES bo_phan(ma_bo_phan);

AlTER TABLE khach_hang ADD FOREIGN KEY(ma_loai_khach) REFERENCES loai_khach(ma_loai_khach);

AlTER TABLE hop_dong_chi_tiet ADD FOREIGN KEY(ma_hop_dong) REFERENCES hop_dong(ma_hop_dong);
AlTER TABLE hop_dong_chi_tiet ADD FOREIGN KEY(ma_dich_vu_di_kem) REFERENCES dich_vu_di_kem(ma_dich_vu_di_kem);

AlTER TABLE hop_dong ADD FOREIGN KEY(ma_nhan_vien) REFERENCES nhan_vien(ma_nhan_vien);
AlTER TABLE hop_dong ADD FOREIGN KEY(ma_khach_hang) REFERENCES khach_hang(ma_khach_hang);
AlTER TABLE hop_dong ADD FOREIGN KEY(ma_dich_vu) REFERENCES dich_vu(ma_dich_vu);

AlTER TABLE dich_vu ADD FOREIGN KEY(ma_kieu_thue) REFERENCES kieu_thue(ma_kieu_thue);
AlTER TABLE dich_vu ADD FOREIGN KEY(ma_loai_dich_vu) REFERENCES loai_dich_vu(ma_loai_dich_vu);
*/
/*CAU2*/
SELECT * FROM nhan_vien WHERE nhan_vien.ho_ten LIKE 'H%' or 'T%' or 'K%';

/*CAU3*/
SELECT * FROM khach_hang WHERE (YEAR(CURDATE()) -YEAR(ngay_sinh)) >= 18 and (YEAR(CURDATE()) -YEAR(ngay_sinh)) <= 50
and dia_chi = 'DA NANG' or 'QUANG NAM'; 

/*CAU4*/
SELECT kh.ho_ten, COUNT(kh.ho_ten) as TenKhachHang FROM khach_hang kh INNER JOIN loai_khach lk on kh.ma_loai_khach= lk.ma_loai_khach
INNER JOIN hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang WHERE lk.ten_loai_khach ='DIAMOND'
group by kh.ho_ten ;

/*CAU5*/
SELECT kh.ma_khach_hang, kh.ho_ten, hd.ma_hop_dong,
dv.ten_dich_vu, hd.ngay_lam_hop_dong, hd.ngay_ket_thuc,
dv.chi_phi_thue + hdct.so_luong* dvdk.gia AS TONGTIEN
FROM khach_hang kh INNER JOIN hop_dong hd
on kh.ma_khach_hang = hd.ma_khach_hang INNER JOIN dich_vu dv on dv.ma_dich_vu = hd.ma_dich_vu
INNER JOIN hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.ma_hop_dong
INNER JOIN dich_vu_di_kem  dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem;

/*CAU6*/
SELECT dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.chi_phi_thue,
ldv.ten_loai_dich_vu FROM dich_vu dv INNER JOIN loai_dich_vu ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
INNER JOIN hop_dong hd on hd.ma_dich_vu = dv.ma_dich_vu WHERE MONTH(hd.ngay_lam_hop_dong) != 1 and MONTH(hd.ngay_lam_hop_dong)  != 2 and MONTH(hd.ngay_lam_hop_dong)  != 3;

/*CAU7*/
SELECT dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.chi_phi_thue,
ldv.ten_loai_dich_vu FROM dich_vu dv INNER JOIN loai_dich_vu ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
INNER JOIN hop_dong hd on hd.ma_dich_vu = dv.ma_dich_vu
WHERE year(hd.ngay_lam_hop_dong) = 2020 and year(hd.ngay_lam_hop_dong) = 2021;

/*CAU8*/
SELECT ho_ten FROM khach_hang 
WHERE ho_ten = ho_ten;

/*CAU9*/
SELECT hd.ngay_lam_hop_dong ,count(kh.khach_hang) as soluongkhachhang from khach_hang kh inner join hop_dong hd
on kh.ma_khach_hang = hd.ma_khach_hang
group by(kh.khach_hang);

/*CAU10*/
SELECT SUM(hdct.so_luong) as SoLuonDichVuDiKem, ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem
FROM hop_dong hd INNER JOIN hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.hop_dong_chi_tiet
INNER JOIN dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem 
GROUP BY hd.ma_hop_dong;
/*CAU11*/
SELECT dvdk.ten_dich_vu_di_kem
FROM hop_dong hd INNER JOIN hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.hop_dong_chi_tiet
INNER JOIN dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem 
INNER JOIN khach_hang kh on kh.ma_khach_hang = hd.ma_khach_hang
WHERE kh.dia_chi="VINH " OR "QUANG NGAI";
; 
/*CAU12*/
SELECT hd.ma_hop_dong, kh.ho_ten, kh.ho_ten, kh.so_dien_thoai, dv.ten_dich_vu
FROM hop_dong hd INNER JOIN khach_hang kh
on hd.ma_khach_hang = hd.ma_khach_hang  INNER JOIN dich_vu dv on hd.ma_dich_vu = dv.ma_dich_vu;
/*CAU13*/
SELECT ten_dich_vu_di_kem FROM dich_vu_di_kem  ORDER BY so_luong LIMIT 1;
/*CAU14*/
SELECT dvdk.ten_dich_vu_di_kem
FROM hop_dong hd INNER JOIN hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.hop_dong_chi_tiet
INNER JOIN dich_vu_di_kem dvdk on dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem 
INNER JOIN khach_hang kh on kh.ma_khach_hang = hd.ma_khach_hang
WHERE kh.dia_chi="VINH " OR "QUANG NGAI";
/*CAU15*/
SELECT hd.ma_hop_dong, kh.ho_ten, kh.ho_ten, kh.so_dien_thoai, dv.ten_dich_vu
FROM hop_dong hd INNER JOIN khach_hang kh
on hd.ma_khach_hang = hd.ma_khach_hang  INNER JOIN dich_vu dv on hd.ma_dich_vu = dv.ma_dich_vu;
/*CAU16*/
SELECT dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.chi_phi_thue,
ldv.ten_loai_dich_vu FROM dich_vu dv INNER JOIN loai_dich_vu ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
INNER JOIN hop_dong hd on hd.ma_dich_vu = dv.ma_dich_vu WHERE MONTH(hd.ngay_lam_hop_dong) != 1 and MONTH(hd.ngay_lam_hop_dong)  != 2 and MONTH(hd.ngay_lam_hop_dong)  != 3;
/*CAU17*/
SELECT kh.ho_ten, COUNT(kh.ho_ten) as TenKhachHang FROM khach_hang kh INNER JOIN loai_khach lk on kh.ma_loai_khach= lk.ma_loai_khach
INNER JOIN hop_dong hd on hd.ma_khach_hang = kh.ma_khach_hang WHERE lk.ten_loai_khach ='DIAMOND'
group by kh.ho_ten ;

/*CAU18*/
SELECT dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.chi_phi_thue,
ldv.ten_loai_dich_vu FROM dich_vu dv INNER JOIN loai_dich_vu ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
INNER JOIN hop_dong hd on hd.ma_dich_vu = dv.ma_dich_vu
WHERE year(hd.ngay_lam_hop_dong) = 2020 and year(hd.ngay_lam_hop_dong) = 2021;

/*CAU19*/
UPDATE dich_vu_di_kem 
set gia = gia*10;
/*CAU20*/
SELECT * FROM nhan_vien;
SELECT * FROM khach_hang;

 