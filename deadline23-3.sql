/*cau 21*/
create view v_nhan_vien AS
select * from  nhan_vien nv inner join hop_dong hd 
on nv.ma_nhan_vien = hd.ma_nhan_vien where nv.dia_chi="Hai Chau" and 
hd.ngay_lam_hop_dong="12/12/2019";

/*cau 22*/
update v_nhan_vien
SET dia_chi ="Lien Chieu"
where ma_nhan_vien = ma_nhan_vien;

/*cau 23*/

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_xoa_khach_hang $$
CREATE PROCEDURE sp_xoa_khach_hang(INOUT makhachhang INT)
BEGIN
  delete from khach_hang where ma_khach_hang = makhachhang;
  select * from khach_hang;
END; $$

SET @makhachhang = 1;
CALL sp_xoa_khach_hang(@makhachhang);

/*cau 24*/
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_them_moi_hop_dong $$
CREATE procedure sp_them_moi_hop_dong(IN ma_hop_dong INT, IN ngay_lam_hop_dong datetime , IN ngay_ket_thuc datetime, IN ma_nhan_vien INT, IN ma_khach_hang INT, IN ma_dich_vu INT)
BEGIN
IF (ma_hop_dong NOT IN (SELECT * FROM hop_dong) AND  ma_nhan_vien IN(SELECT * FROM nhan_vien) AND ma_khach_hang IN(SELECT * FROM khach_hang) AND ma_dich_vu IN(SELECT * FROM dich_vu)) 
    then INSERT INTO hop_dong(ma_hop_dong ,ngay_lam_hop_dong ,ngay_ket_thuc)  values(ma_hop_dong ,ngay_lam_hop_dong ,ngay_ket_thuc);
END IF;
END;$$
CALL sp_them_moi_hop_dong();

/*cau 25*/
delimiter // 
create trigger tr_xoa_hop_dong 
	after delete
    on hop_dong for each row 
begin
	DECLARE so_hop_dong int ;
    DECLARE `error` varchar(50) ;
    set so_hop_dong = (select count(hd.ma_hop_dong) from (select * from hop_dong) as hd );
    set `error` = (select concat('so hop dong con lai la: ', so_hop_dong));
    -- SIGNAL SQLSTATE '00000' SET MESSAGE_TEXT = `error`;
    SELECT `error` AS LOG INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/log.txt';
end ; //
delimiter ;

delete from hop_dong
where hop_dong.ma_hop_dong = 5;
drop trigger tr_xoa_hop_dong
// delimiter ;

/*cau 26*/
delimiter // 
create trigger tr_cap_nhat_hop_dong
after update 
on hop_dong for each row
begin
DECLARE `error` varchar(50) ;
declare BrandDay datetime;
set BrandDay = (SELECT DATEDIFF(day, ngay_ket_thuc, ngay_lam_hop_dong));
if(BrandDay >=2) then 
    set `error` = (select concat('Ngay lam hop dong hop le: ',BrandDay ));
END IF;
end;//
delimiter ;
update  hop_dong
set ngay_lam_hop_dong = "12/12/2002"
, ngay_ket_thuc = "10/12/2002"
where ma_hop_dong ='2'
drop trigger tr_xoa_hop_dong
// delimiter ;
/*cau 27*/

/*cau 28*/
