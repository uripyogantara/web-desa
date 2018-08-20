/*
SQLyog Ultimate v12.4.1 (64 bit)
MySQL - 10.1.30-MariaDB : Database - info_wariga
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `kalender` */

DROP TABLE IF EXISTS `kalender`;

CREATE TABLE `kalender` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tanggal` date DEFAULT NULL,
  `wuku` varchar(15) DEFAULT NULL,
  `ekawara` varchar(15) DEFAULT NULL,
  `dwiwara` varchar(15) DEFAULT NULL,
  `triwara` varchar(15) DEFAULT NULL,
  `caturwara` varchar(15) DEFAULT NULL,
  `pancawara` varchar(15) DEFAULT NULL,
  `sadwara` varchar(15) DEFAULT NULL,
  `saptawara` varchar(15) DEFAULT NULL,
  `astawara` varchar(15) DEFAULT NULL,
  `sangawara` varchar(15) DEFAULT NULL,
  `dasawara` varchar(15) DEFAULT NULL,
  `penanggal` varchar(30) DEFAULT NULL,
  `sasih` varchar(15) DEFAULT NULL,
  `tahun_saka` year(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `kalender` */

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_resets_table',1);

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_resets` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`username`,`password`,`remember_token`,`created_at`,`updated_at`) values 
(1,'Urip','uripyogantara','$2y$10$O4F0NrE2K10rxlEtNDzAX.0kNQx1lf0N4.uNCTYq3CqY/VaJNy9UG','eXnBtuhH3zK8HVJIeVwDmkJBBhID137XUkgfW2nsyZwUQVdOgCsQDIlbBlod','2018-08-12 07:17:02','2018-08-12 07:17:02');

/* Function  structure for function  `11_sangaWara` */

/*!50003 DROP FUNCTION IF EXISTS `11_sangaWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `11_sangaWara`(noWuku int) RETURNS int(11)
BEGIN
	declare sangawara int;
	
	if noWuku<=4 then
		set sangawara=1;
	else
		set sangawara=(noWuku+6)%9;
	end if;
	
	if sangawara=0 then
		set sangawara=9;
	end if;
	
	return sangawara;
    END */$$
DELIMITER ;

/* Function  structure for function  `12_dasawara` */

/*!50003 DROP FUNCTION IF EXISTS `12_dasawara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `12_dasawara`(uripPancaWara INT, uripSaptaWara INT) RETURNS int(11)
BEGIN
	declare dasawara int;
	
	set dasawara=((uripPancaWara+uripSaptaWara)%10)+1;
	return dasawara;
    END */$$
DELIMITER ;

/* Function  structure for function  `12_getNamaDasaWara` */

/*!50003 DROP FUNCTION IF EXISTS `12_getNamaDasaWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `12_getNamaDasaWara`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE nama VARCHAR(10);
	IF i=1 THEN
		SET nama='Pandita';
	ELSEIF i=2 THEN 
		SET nama='Pati';
	ELSEIF i=3 THEN 
		SET nama='Suka';
	ELSEIF i=4 THEN 
		SET nama='Duka';
	ELSEIF i=5 THEN 
		SET nama='Sri';
	ELSEIF i=6 THEN 
		SET nama='Manu';
	ELSEIF i=7 THEN 
		SET nama='Manusa';
	ELSEIF i=8 THEN
		SET nama='Raja';
	ELSEIF i=9 THEN 
		SET nama='Dewa';
	ELSEIF i=10 THEN 
		SET nama='Raksasa';
	END IF;
	RETURN nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `14_getPengalantaka` */

/*!50003 DROP FUNCTION IF EXISTS `14_getPengalantaka` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `14_getPengalantaka`(tanggal DATE,refTanggal DATE, refPenanggal INT, refNgunaratri INT) RETURNS varchar(15) CHARSET latin1
BEGIN
	DECLARE selisih INT;
	DECLARE jumlahNgunaratri INT;
	declare isPangelong varchar(15);
	declare jumlah int;
		
	SET selisih=DATEDIFF(tanggal,refTanggal);
	SET jumlahNgunaratri=FLOOR((selisih+refNgunaratri)/63);
	
	IF (selisih+refNgunaratri)%63 =0 THEN
		SET jumlahNgunaratri=jumlahNgunaratri-1;
	END IF;
	
	set jumlah=refPenanggal+selisih+jumlahNgunaratri;
	
	if FLOOR((jumlah-1)/15)%2=0 then
		return "Pangelong";
	else 
		return "Penanggal";
	end if;

    END */$$
DELIMITER ;

/* Function  structure for function  `15_getNamaSasih` */

/*!50003 DROP FUNCTION IF EXISTS `15_getNamaSasih` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `15_getNamaSasih`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE nama VARCHAR(10);
	IF i=1 THEN
		SET nama='Kasa';
	ELSEIF i=2 THEN 
		SET nama='Karo';
	ELSEIF i=3 THEN 
		SET nama='Katiga';
	ELSEIF i=4 THEN 
		SET nama='Kapat';
	ELSEIF i=5 THEN 
		SET nama='Kalima';
	ELSEIF i=6 THEN 
		SET nama='Kaenam';
	ELSEIF i=7 THEN 
		SET nama='Kapitu';
	ELSEIF i=8 THEN
		SET nama='Kawulu';
	ELSEIF i=9 THEN 
		SET nama='Kasanga';
	ELSEIF i=10 THEN 
		SET nama='Kadasa';
	ELSEIF i=11 THEN 
		SET nama='Jyestha';
	ELSEIF i=12 THEN 
		SET nama='Sradha';
	END IF;
	RETURN nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `16_getIngkel` */

/*!50003 DROP FUNCTION IF EXISTS `16_getIngkel` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `16_getIngkel`(no_wuku INT) RETURNS varchar(10) CHARSET latin1
BEGIN
	IF no_wuku=1 OR no_wuku=7 OR  no_wuku=13 OR no_wuku=19 OR no_wuku=25 THEN
		RETURN 'Wong';
	    ELSEIF no_wuku=2 OR no_wuku=8 OR  no_wuku=14 OR no_wuku=20 OR no_wuku=26 THEN
		RETURN 'Sato';
	    ELSEIF no_wuku=3 OR no_wuku=9 OR  no_wuku=15 OR no_wuku=21 OR no_wuku=27 THEN
		RETURN 'Mina';
	    ELSEIF no_wuku=4 OR no_wuku=10 OR  no_wuku=16 OR no_wuku=22 OR no_wuku=28 THEN
		RETURN 'Manuk';
	    ELSEIF no_wuku=5 OR no_wuku=11 OR  no_wuku=17 OR no_wuku=23 OR no_wuku=29 THEN
		RETURN 'Taru';
	    ELSE
		RETURN 'Buku';
	    END IF;
    END */$$
DELIMITER ;

/* Function  structure for function  `17_jejepan` */

/*!50003 DROP FUNCTION IF EXISTS `17_jejepan` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `17_jejepan`(noWuku int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE sadwara INT;
	
	SET sadwara=noWuku%6;
	
	IF sadwara=1 THEN
		return 'Mina';
	elseif sadwara=2 THEN
		RETURN 'Taru';
	ELSEIF sadwara=3 THEN
		RETURN 'Sato';
	ELSEIF sadwara=4 THEN
		RETURN 'Patra';
	ELSEIF sadwara=5 THEN
		RETURN 'Wong';
	ELSE
		RETURN 'Paksi';
	END IF;
    END */$$
DELIMITER ;

/* Function  structure for function  `10_astaWara` */

/*!50003 DROP FUNCTION IF EXISTS `10_astaWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `10_astaWara`(noWuku int) RETURNS int(11)
BEGIN
	declare astawara int;
	
	if (noWuku =71 or noWuku =72 OR noWuku =73) then
		set astawara=7;
	elseif noWuku<71 then
		set astawara= noWuku%8;
	else 
		SET astawara= (noWuku+6)%8;
	end if;
	IF astawara=0 THEN
		SET astawara=8;
	end if;
	return astawara;
    END */$$
DELIMITER ;

/* Function  structure for function  `10_getNamaAstaWara` */

/*!50003 DROP FUNCTION IF EXISTS `10_getNamaAstaWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `10_getNamaAstaWara`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE nama VARCHAR(10);
	IF i=1 THEN
		SET nama='Sri';
	ELSEIF i=2 THEN 
		SET nama='Indra';
	ELSEIF i=3 THEN 
		SET nama='Guru';
	ELSEIF i=4 THEN 
		SET nama='Yama';
	ELSEIF i=5 THEN 
		SET nama='Ludra';
	ELSEIF i=6 THEN 
		SET nama='Brahma';
	ELSEIF i=7 THEN 
		SET nama='Kala';
	ELSEIF i=8 THEN
		SET nama='Uma';
	END IF;
	RETURN nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `11_getNamaSangaWara` */

/*!50003 DROP FUNCTION IF EXISTS `11_getNamaSangaWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `11_getNamaSangaWara`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE nama VARCHAR(10);
	IF i=1 THEN
		SET nama='Dangu';
	ELSEIF i=2 THEN 
		SET nama='Jagur';
	ELSEIF i=3 THEN 
		SET nama='Gigis';
	ELSEIF i=4 THEN 
		SET nama='Nohan';
	ELSEIF i=5 THEN 
		SET nama='Ogan';
	ELSEIF i=6 THEN 
		SET nama='Erangan';
	ELSEIF i=7 THEN 
		SET nama='Urungan';
	ELSEIF i=8 THEN
		SET nama='Tulus';
	ELSEIF i=9 THEN 
		SET nama='Dadi';
	END IF;
	RETURN nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `18_getLintang` */

/*!50003 DROP FUNCTION IF EXISTS `18_getLintang` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `18_getLintang`(tanggal date, refTanggal date) RETURNS varchar(30) CHARSET latin1
BEGIN
	declare selisihHari_lintang int;
	declare lintang int;
	declare h_lintang varchar(30);
	SET selisihHari_lintang = DATEDIFF(tanggal,refTanggal);
	SET lintang = selisihHari_lintang MOD 35;
	IF lintang = 0 THEN
		SET h_lintang = 'Begong';
	ELSEIF lintang = 1 THEN
		SET h_lintang = 'Gajah';
	ELSEIF lintang = 2 THEN
		SET h_lintang = 'Kiriman';
	ELSEIF lintang = 3 THEN
		SET h_lintang = 'Perahu Sarat';
	ELSEIF lintang = 4 THEN
		SET h_lintang = 'Tiwa-tiwa';
	ELSEIF lintang = 5 THEN
		SET h_lintang = 'Sangkatikel';
	ELSEIF lintang = 6 THEN
		SET h_lintang = 'Bubu Bolong';
	ELSEIF lintang = 7 THEN
		SET h_lintang = 'Sungenge';
	ELSEIF lintang = 8 THEN
		SET h_lintang = 'Uluku';
	ELSEIF lintang = 9 THEN
		SET h_lintang = 'Pedati';
	ELSEIF lintang = 10 THEN
		SET h_lintang = 'Kuda';
	ELSEIF lintang = 11 THEN
		SET h_lintang = 'Gajah Mina';
	ELSEIF lintang = 12 THEN
		SET h_lintang = 'Bade';
	ELSEIF lintang = 13 THEN
		SET h_lintang = 'Magelut';
	ELSEIF lintang = 14 THEN
		SET h_lintang = 'Rarung Pegelangan';
	ELSEIF lintang = 15 THEN
		SET h_lintang = 'Kala Sungsang';
	ELSEIF lintang = 16 THEN
		SET h_lintang = 'Dupa';
	ELSEIF lintang = 17 THEN
		SET h_lintang = 'Asu';
	ELSEIF lintang = 18 THEN
		SET h_lintang = 'Kartika';
	ELSEIF lintang = 19 THEN
		SET h_lintang = 'Naga';
	ELSEIF lintang = 20 THEN
		SET h_lintang = 'Angsa Angrem';
	ELSEIF lintang = 21 THEN
		SET h_lintang = 'Panah';
	ELSEIF lintang = 22 THEN
		SET h_lintang = 'Patrem';
	ELSEIF lintang = 23 THEN
		SET h_lintang = 'Lembu';
	ELSEIF lintang = 24 THEN
		SET h_lintang = 'Depat';
	ELSEIF lintang = 25 THEN
		SET h_lintang = 'Tangis';
	ELSEIF lintang = 26 THEN
		SET h_lintang = 'Salah Ukur';
	ELSEIF lintang = 27 THEN
		SET h_lintang = 'Prahu Pegat';
	ELSEIF lintang = 28 THEN
		SET h_lintang = 'Puwuh Atarung';
	ELSEIF lintang = 29 THEN
		SET h_lintang = 'Lawean';
	ELSEIF lintang = 30 THEN
		SET h_lintang = 'Kelapa';
	ELSEIF lintang = 31 THEN
		SET h_lintang = 'Yuyu';
	ELSEIF lintang = 32 THEN
		SET h_lintang = 'Lumbung';
	ELSEIF lintang = 33 THEN
		SET h_lintang = 'Kumba';
	ELSEIF lintang = 34 THEN
		SET h_lintang = 'Udang';			
	END IF;
	return h_lintang;
    END */$$
DELIMITER ;

/* Function  structure for function  `19_pancasudha` */

/*!50003 DROP FUNCTION IF EXISTS `19_pancasudha` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `19_pancasudha`(pancawara int, saptawara int) RETURNS varchar(20) CHARSET latin1
BEGIN
	declare h_pancasuda varchar(20);
	IF ((saptawara = 1 && pancawara = 2) || 
		(saptawara = 4 && pancawara = 2) || 
		(saptawara = 2 && pancawara = 4) || 
		(saptawara = 6 && pancawara = 5) || 
		(saptawara = 3 && pancawara = 1) ||
		(saptawara = 7 && pancawara = 3)) THEN
		SET h_pancasuda = 'Wisesa Segara';
	ELSEIF ((saptawara = 2 && pancawara = 1) || 
		(saptawara = 5 && pancawara = 4) || 
		(saptawara = 6 && pancawara = 2) || 
		(saptawara = 7 && pancawara = 5)) THEN
		SET h_pancasuda = 'Tunggak Semi';
	ELSEIF ((saptawara = 1 && pancawara = 4) || 
		(saptawara = 3 && pancawara = 3) || 
		(saptawara = 4 && pancawara = 4) || 
		(saptawara = 5 && pancawara = 1) || 
		(saptawara = 7 && pancawara = 2)) THEN
		SET h_pancasuda = 'Satria Wibawa';
	ELSEIF ((saptawara = 1 && pancawara = 1) || 
		(saptawara = 2 && pancawara = 3) || 
		(saptawara = 3 && pancawara = 5) || 
		(saptawara = 4 && pancawara = 1) || 
		(saptawara = 6 && pancawara = 4)) THEN
		SET h_pancasuda = 'Sumur Sinaba';
	ELSEIF ((saptawara = 1 && pancawara = 3) || 
		(saptawara = 2 && pancawara = 2) || 
		(saptawara = 4 && pancawara = 3) || 
		(saptawara = 5 && pancawara = 5) || 
		(saptawara = 7 && pancawara = 1)) THEN
		SET h_pancasuda = 'Bumi Kepetak';
	ELSEIF ((saptawara = 2 && pancawara = 5) || 
		(saptawara = 3 && pancawara = 2) || 
		(saptawara = 5 && pancawara = 3) || 
		(saptawara = 6 && pancawara = 1) || 
		(saptawara = 7 && pancawara = 4)) THEN
		SET h_pancasuda = 'Satria Wirang';
	ELSEIF ((saptawara = 1 && pancawara = 5) || 
		(saptawara = 3 && pancawara = 4) || 
		(saptawara = 4 && pancawara = 5) || 
		(saptawara = 5 && pancawara = 2) || 
		(saptawara = 6 && pancawara = 3)) THEN
		SET h_pancasuda = 'Lebu Katiub Angin';
	END IF;
	return h_pancasuda;
    END */$$
DELIMITER ;

/* Function  structure for function  `1_getNoWuku` */

/*!50003 DROP FUNCTION IF EXISTS `1_getNoWuku` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `1_getNoWuku`(tanggal DATE,pivotAngkaWuku int,refTanggal date) RETURNS int(11)
BEGIN
	DECLARE bedaHari INT(11);
	DECLARE angkaWuku INT(11);
	DECLARE noWuku INT(11);
	
	SET bedaHari =DATEDIFF(tanggal,refTanggal);
	
	SET angkaWuku=(pivotAngkaWuku+bedaHari)%210;
		
	if angkaWuku<0 then 
		set angkaWuku=210+angkaWuku;
	end if;
	
	if angkaWuku=0 then
		set angkaWuku=210;
	end if;
	
	return angkaWuku;
    END */$$
DELIMITER ;

/* Function  structure for function  `22_watekMadya` */

/*!50003 DROP FUNCTION IF EXISTS `22_watekMadya` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `22_watekMadya`(urip_panca int, urip_sapta int) RETURNS varchar(10) CHARSET latin1
BEGIN
	declare madya int;
	DECLARE cekMadya INT;
	declare h_madya varchar(10);
	
	SET madya = (urip_sapta + urip_panca);
	SET cekMadya = madya MOD 5;
	IF cekMadya = 0 THEN
		SET h_madya = 'Wong';
	ELSEIF cekMadya = 1 THEN
		SET h_madya = 'Gajah';
	ELSEIF cekMadya = 2 THEN
		SET h_madya = 'Watu';
	ELSEIF cekMadya = 3 THEN
		SET h_madya = 'Buta';
	ELSEIF cekMadya = 4 THEN
		SET h_madya = 'Suku';
	END IF;
	return h_madya;
    END */$$
DELIMITER ;

/* Function  structure for function  `23_watekAlit` */

/*!50003 DROP FUNCTION IF EXISTS `23_watekAlit` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `23_watekAlit`(urip_panca INT, urip_sapta INT) RETURNS varchar(10) CHARSET latin1
BEGIN
	declare alit int;
	declare cekAlit int;
	declare h_alit varchar(10);
	SET alit = (urip_sapta + urip_panca);
	SET cekAlit = alit MOD 4;
	IF cekAlit = 0 THEN
		SET h_alit = 'Lintah';
	ELSEIF cekAlit = 1 THEN
		SET h_alit = 'Uler';
	ELSEIF cekAlit = 2 THEN
		SET h_alit = 'Gajah';
	ELSEIF cekAlit = 3 THEN
		SET h_alit = 'Lembu';
	END IF;
	return h_alit;
    END */$$
DELIMITER ;

/* Function  structure for function  `24_neptu` */

/*!50003 DROP FUNCTION IF EXISTS `24_neptu` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `24_neptu`(urip_panca INT, urip_sapta INT) RETURNS int(11)
BEGIN
	return urip_panca+urip_sapta;
    END */$$
DELIMITER ;

/* Function  structure for function  `25_ekaJalaRsi` */

/*!50003 DROP FUNCTION IF EXISTS `25_ekaJalaRsi` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `25_ekaJalaRsi`(no_wuku int, saptawara int) RETURNS varchar(20) CHARSET latin1
BEGIN
	declare ekajalarsi varchar(20);
	IF no_wuku = 1 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	END IF;
	ELSEIF no_wuku = 2 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'KAMARANAN';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'KINASIHANIN JANA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'WERDHI PUTRA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'SUKA RAHAYU';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'SIDHA KASOBAGIAN';
	    	END IF;
	    ELSEIF no_wuku = 3 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'KINASIHANIN JANA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'KINASIHANIN JANA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'RAHAYU';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'BUAT SEBET';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	END IF;
	    ELSEIF no_wuku = 4 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'LANGGENG KAYOHANAN';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'WERDHI PUTRA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'SIDHA KASOBAGIAN';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'BAGNA MAPASAH';
	    	END IF;
	    ELSEIF no_wuku = 5 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'KAMERTAAN';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'BUAT SEBET';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'LEWIH BAGIA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	END IF;
	    ELSEIF no_wuku = 6 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'BUAT MERANG';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	END IF;
	    ELSEIF no_wuku = 7 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'BUAT MERANG';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'LANGGENG KAYOHANAN';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'WERDHI PUTRA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'WERDHI PUTRA';
	    	END IF;
	    ELSEIF no_wuku = 8 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'BAHU PUTRA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'LEWIH BAGIA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'LEWIH BAGIA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'BUAT SEBET';
	    	END IF;
	    ELSEIF no_wuku = 9 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'KAMARANAN';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'PATINING AMERTA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'KASOBAGIAN';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'LEWIH BAGIA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'SUBAGIA';
	    	END IF;
	    ELSEIF no_wuku = 10 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'KINASIHANIN JANA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'BAGNA MAPASAH';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'KINASIHANIN JANA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'BAGNA MAPASAH';
	    	END IF;
	    ELSEIF no_wuku = 11 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'LEWIH BAGIA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'MANGGIH BAGIA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'PATINING AMERTA';
	    	END IF;
	    ELSEIF no_wuku = 12 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'SUKA RAHAYU';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'BUAT SEBET';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'BUAT SEBET';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'WERDHI PUTRA';
	    	END IF;
	    ELSEIF no_wuku = 13 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'BUAT SEBET';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'DAHAT KINGKING';
	    	END IF;
	    ELSEIF no_wuku = 14 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'LANGGENG KAYOHANAN';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'LEWIH BAGIA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'WERDHI PUTRA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	END IF;
	    ELSEIF no_wuku = 15 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'SIDHA KASOBAGIAN';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'BUAT SEBET';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'BUAT SEBET';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'KINASIHANIN JANA';
	    	END IF;
	    ELSEIF no_wuku = 16 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'KINASIHANIN JANA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'BUAT SEBET';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'WERDHI PUTRA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'SIDHA KASOBAGIAN';
	    	END IF;
	    ELSEIF no_wuku = 17 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'PATINING AMERTA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'PATINING AMERTA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	END IF;
	    ELSEIF no_wuku = 18 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'BUAT MERANG';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'WERDHI PUTRA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'BUAT SUKA';
	    	END IF;
	    ELSEIF no_wuku = 19 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'KAMARANAN';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'KINASIHANIN JANA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'PATINING AMERTA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'PATINING AMERTA';
	    	END IF;
	    ELSEIF no_wuku = 20 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'BUAT SEBET';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	END IF;
	    ELSEIF no_wuku = 21 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'SIDHA KASOBAGIAN';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'LANGGENG KAYOHANAN';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'WERDHI SARWA MULE';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'DAHAT KINGKING';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	END IF;
	    ELSEIF no_wuku = 22 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'BUAT SEBET';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'BUAT KINGKING';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'LEWIH BAGIA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'PATINING AMERTA';
	    	END IF;
	    ELSEIF no_wuku = 23 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'KINASIHANIN JANA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'SIDHA KASOBAGIAN';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'BUAT SUKA';
	    	END IF;
	    ELSEIF no_wuku = 24 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'LEWIH BAGIA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'LEWIH BAGIA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'DAHAT KINGKING';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'SUKA RAHAYU';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	END IF;
	    ELSEIF no_wuku = 25 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'KAMARANAN';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'SUKA RAHAYU';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'SUKA RAHAYU';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'SUKA RAHAYU';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'SIDHA KASOBAGIAN';
	    	END IF;
	    ELSEIF no_wuku = 26 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'LANGGENG KAYOHANAN';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'PATINING AMERTA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'SIDHA KASOBAGIAN';
	    	END IF;
	    ELSEIF no_wuku = 27 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'BUAT MERANG';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'PATINING AMERTA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'BUAT MERANG';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'SIDHA KASOBAGIAN';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'WERDHI PUTRA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'KINASIHANIN AMERTA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	END IF;
	    ELSEIF no_wuku = 28 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'PATINING AMERTA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'LEWIH BAGIA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'SUKA RAHAYU';
	    	END IF;
	    ELSEIF no_wuku = 29 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'BUAT LARA';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'SUKA PINANGGIH';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'PATINING AMERTA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'SIDHA KASOBAGIAN';
	    	END IF;
	    ELSEIF no_wuku = 30 THEN
	    	IF saptawara = 1 THEN SET ekajalarsi = 'LANGGENG KAYOHANAN';
	    	ELSEIF saptawara = 2 THEN SET ekajalarsi = 'BUAT SEBET';
	    	ELSEIF saptawara = 3 THEN SET ekajalarsi = 'BUAT ASTAWA';
	    	ELSEIF saptawara = 4 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 5 THEN SET ekajalarsi = 'BUAT SUKA';
	    	ELSEIF saptawara = 6 THEN SET ekajalarsi = 'TININGGALING SUKA';
	    	ELSEIF saptawara = 7 THEN SET ekajalarsi = 'MANGGIH SUKA';
	    	END IF;
	    END IF;
	    return ekajalarsi;
    END */$$
DELIMITER ;

/* Function  structure for function  `27_pratiti` */

/*!50003 DROP FUNCTION IF EXISTS `27_pratiti` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `27_pratiti`(pengalantaka int,sasih int, hari_sasih int) RETURNS varchar(20) CHARSET latin1
BEGIN
	declare pratiti varchar(20);
	IF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 2)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 3)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 4)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 5)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 6)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 7)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 10)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 11)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 12)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 6) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Jaramarana';
	
	elseIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 2)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 3)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 4)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 5)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 6)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 7)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 10)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 11)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 12)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 7) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Widnyana';
	
	elseIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 2)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 3)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 4)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 5)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 6)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 7)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 10)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 11)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 12)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 8) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Namarupa';
	
	elseIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 2)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 3)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 4)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 5)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 6)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 7)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 10)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 11)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 12)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 9) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Sadayatana';
		
	elseIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 2)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 3)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 4)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 5)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 6)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 7)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 10)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 11)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 12)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 10) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Separsa';
	
	elseIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 2)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 3)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 4)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 5)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 6)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 7)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 10)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 11)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 12)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 11) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Wedana';
		
	elseIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 2)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 3)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 4)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 5)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 6)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 7)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 10)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 11)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 12)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 12) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Tresna';
		
	elseIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 2)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 3)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 4)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 5)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 6)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 7)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 10)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 11)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 12)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 1) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Upadana';
		
	elseIF ((pengalantaka = 'Penanggal') && (sasih = 2) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 2) && (hari_sasih = 2)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 2) && (hari_sasih = 3)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 2) && (hari_sasih = 4)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 2) && (hari_sasih = 5)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 2)&& (hari_sasih = 6)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 2) && (hari_sasih = 7)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 2) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 2) && (hari_sasih = 10)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 2) && (hari_sasih = 11)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 2) && (hari_sasih = 12)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 2) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Bhawa';
		
	elseIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 2)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 3)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 4)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 5)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 6)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 7)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 10)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 11)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 12)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 3) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Jati';
		
	elseIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 2)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 3)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 4)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 5)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 6)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 7)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 10)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 11)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 12)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 4) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Jaramarana';
		
	elseIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 1 || hari_sasih = 15)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 2)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 3)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 4)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 5)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 6)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 7)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 8 || hari_sasih = 9)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 10)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 11)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 12)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Penanggal') && (sasih = 5) && (hari_sasih = 13 || hari_sasih = 14)) THEN
		SET pratiti = 'Awidya';
	
	-- PANGELONG -----------------------------
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 1)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 2)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 6)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 7)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 8)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 9)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 10)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 11)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 6) && (hari_sasih = 12)) THEN
		SET pratiti = 'Jaramarana';
	
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 1)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 2)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 6)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 7)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 8)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 9)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 10)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 11)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 7) && (hari_sasih = 12)) THEN
		SET pratiti = 'Widnyana';
	
	
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 1)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 2)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 6)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 7)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 8)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 9)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 10)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 11)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 8) && (hari_sasih = 12)) THEN
		SET pratiti = 'Namarupa';
	
	
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 1)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 2)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 6)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 7)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 8)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 9)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 10)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 11)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 9) && (hari_sasih = 12)) THEN
		SET pratiti = 'Sadayatana';
	
	
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 1)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 2)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 6)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 7)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 8)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 9)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 10)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 11)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 10) && (hari_sasih = 12)) THEN
		SET pratiti = 'Separsa';
		
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 1)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 2)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 6)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 7)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 8)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 9)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 10)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 11)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 11) && (hari_sasih = 12)) THEN
		SET pratiti = 'Wedana';
	
	
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 1)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 2)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 6)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 7)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 8)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 9)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 10)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 11)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 12) && (hari_sasih = 12)) THEN
		SET pratiti = 'Tresna';
	
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 1)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 2)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 6)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 7)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 8)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 9)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 10)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 11)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 1) && (hari_sasih = 12)) THEN
		SET pratiti = 'Upadana';
	
	
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 2) && (hari_sasih = 1)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 2) && (hari_sasih = 2)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 2) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 2) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 2) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 2)&& (hari_sasih = 6)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 2) && (hari_sasih = 7)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 2) && (hari_sasih = 8)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 2) && (hari_sasih = 9)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 2) && (hari_sasih = 10)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 2) && (hari_sasih = 11)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 2) && (hari_sasih = 12)) THEN
		SET pratiti = 'Bhawa';
	
	
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 1)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 2)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 6)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 7)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 8)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 9)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 10)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 11)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 3) && (hari_sasih = 12)) THEN
		SET pratiti = 'Jati';
	
	
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 1)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 2)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 6)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 7)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 8)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 9)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 10)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 11)) THEN
		SET pratiti = 'Awidya';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 4) && (hari_sasih = 12)) THEN
		SET pratiti = 'Jaramarana';
	
	
	elseIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 1)) THEN
		SET pratiti = 'Jaramarana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 2)) THEN
		SET pratiti = 'Jati';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 3 || hari_sasih = 13)) THEN
		SET pratiti = 'Bhawa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 4 || hari_sasih = 14)) THEN
		SET pratiti = 'Upadana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 5 || hari_sasih = 15)) THEN
		SET pratiti = 'Tresna';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 6)) THEN
		SET pratiti = 'Wedana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 7)) THEN
		SET pratiti = 'Separsa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 8)) THEN
		SET pratiti = 'Sadayatana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 9)) THEN
		SET pratiti = 'Namarupa';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 10)) THEN
		SET pratiti = 'Widnyana';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 11)) THEN
		SET pratiti = 'Saskara';
	ELSEIF ((pengalantaka = 'Pangelong') && (sasih = 5) && (hari_sasih = 12)) THEN
		SET pratiti = 'Awidya';
	END IF;
	return pratiti;
    END */$$
DELIMITER ;

/* Function  structure for function  `29_dewasa` */

/*!50003 DROP FUNCTION IF EXISTS `29_dewasa` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `29_dewasa`(dwiwara INT, triwara INT,pancawara INT, sadwara INT,saptawara INT, astawara INT,sangawara INT, dasawara INT,wuku INT, pengalantaka VARCHAR(20), sasihDay1 INT, sasihDay2 INT,no_sasih int, h_purnama VARCHAR(10), h_tilem VARCHAR(10)) RETURNS text CHARSET latin1
BEGIN
	DECLARE dewasaAyu TEXT;
	SET dewasaAyu = '';
	-- 1. AgniAgungDoyanBasmi: Selasa Purnama dengan Asta Wara Brahma
	IF ((saptawara = 3 && (astawara = 6 || h_purnama = 'Purnama'))) THEN
		-- if(!dewasa.contains(DewasaAyu.DEWASA_AGNI_AGUNG_DOYAN_BASMI))
	        -- dewasa.add(DewasaAyu.DEWASA_AGNI_AGUNG_DOYAN_BASMI);
		SET dewasaAyu = CONCAT(dewasaAyu,', ','Agni Agung Doyan Basmi');
	END IF;
	-- 2. AgniAgungPatraLimutan: Minggu dengan Asta Wara Brahma */
	IF((saptawara = 1 && astawara = 6))THEN
	       -- if(!dewasa.contains(DewasaAyu.DEWASA_AGNI_AGUNG_PATRA_LIMUTAN))
	       --     dewasa.add(DewasaAyu.DEWASA_AGNI_AGUNG_PATRA_LIMUTAN);
	       SET dewasaAyu = CONCAT(dewasaAyu,', ','Agni Agung Patra Limutan');
	END IF;
	-- 3. Amerta Akasa : Anggara Purnama
	IF (saptawara = 3 && h_purnama = 'Purnama' )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_AKASA))
	        --    dewasa.add(DewasaAyu.DEWASA_AMERTA_AKASA);
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_BHUWANA))
	        -- dewasa.add(DewasaAyu.DEWASA_AMERTA_BHUWANA);
	        SET dewasaAyu = CONCAT(dewasaAyu,', ','Amerta Akasa');
	END IF;
	
	-- 4. Amerta Bumi : Soma Wage Penanggal 1. Buda Pon Penanggal 10.
	IF (
		(saptawara = 2 && pancawara=4 && pengalantaka='Penanggal' && (sasihDay1=1 OR sasihDay2=1)) OR 
		(saptawara = 4 && pancawara=3 && pengalantaka='Penanggal' && (sasihDay1=10 OR sasihDay2=10))
	) THEN
	        SET dewasaAyu = CONCAT(dewasaAyu,', ','Amerta Bumi');
	END IF;
	
	-- 5. Amerta Bhuwana: Redite Purnama, Soma Purnama, dan Anggara Purnama???????
	IF((saptawara=1 or saptawara=2 or saptawara=3) && h_purnama = 'Purnama') THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_BHUWANA))
	        -- dewasa.add(DewasaAyu.DEWASA_AMERTA_BHUWANA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Bhuwana');
	END IF;
	-- 6. Amerta Dadi: Soma Beteng atau Purnama Kajeng 
	IF((saptawara=2 && triwara=2) || (triwara=3 && h_purnama = 'Purnama')) THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_DADI))
	        --    dewasa.add(DewasaAyu.DEWASA_AMERTA_DADI);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Dadi');
	END IF;
	-- 7. Amerta Danta
	IF( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=6 ) || (pengalantaka='Penanggal' && sasihDay2=6))) ||
	        (saptawara=2 && (h_purnama = 'Purnama' or (((pengalantaka='Penanggal' && sasihDay1=5)) || (pengalantaka='Penanggal' && sasihDay2=5))) )||
	        (saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=4) || (pengalantaka='Penanggal' && sasihDay2=4))) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && (sasihDay1=3 or sasihDay1=10)) || (pengalantaka='Penanggal' && (sasihDay2=3  OR sasihDay1=10)))) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=2) || (pengalantaka='Penanggal' && sasihDay2=2)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=1) || (pengalantaka='Penanggal' && sasihDay2=1)) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=7) || (pengalantaka='Penanggal' && sasihDay2=7)))
	 )THEN
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Danta');
	END IF;
	    
	-- 8. Amerta Dewa
	IF( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=6) || (pengalantaka='Penanggal' && sasihDay2=6) || (pengalantaka='Pangelong' && sasihDay1=6) || (pengalantaka='Pangelong' && sasihDay2=6)) ) ||
	        (saptawara=2 && ((pengalantaka='Penanggal' && sasihDay1=7 ) || (pengalantaka='Penanggal' && sasihDay2=7) || (pengalantaka='Pangelong' && sasihDay1=7) || (pengalantaka='Pangelong' && sasihDay2=7)) ) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=3 ) || (pengalantaka='Penanggal' && sasihDay2=3) || (pengalantaka='Pangelong' && sasihDay1=3) || (pengalantaka='Pangelong' && sasihDay2=3)) ) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && sasihDay1=2 ) || (pengalantaka='Penanggal' && sasihDay2=2) || (pengalantaka='Pangelong' && sasihDay1=2) || (pengalantaka='Pangelong' && sasihDay2=2)) ) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=5 ) || (pengalantaka='Penanggal' && sasihDay2=5) || (pengalantaka='Pangelong' && sasihDay1=5) || (pengalantaka='Pangelong' && sasihDay2=5)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=1 ) || (pengalantaka='Penanggal' && sasihDay2=1) || (pengalantaka='Pangelong' && sasihDay1=1) || (pengalantaka='Pangelong' && sasihDay2=1)) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=4 ) || (pengalantaka='Penanggal' && sasihDay2=4) || (pengalantaka='Pangelong' && sasihDay1=4) || (pengalantaka='Pangelong' && sasihDay2=4)) ))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_DEWA))
	        --     dewasa.add(DewasaAyu.DEWASA_AMERTA_DEWA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Dewa');
	END IF;
	
	-- 9. Amerta Dewa Jaya 
	IF (saptawara=2 && ((pengalantaka='Penanggal' && (sasihDay1=3 or sasihDay2=3) ) || (pengalantaka='Penanggal' && (sasihDay1=12 OR sasihDay2=12))))THEN
	   --     if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_DEWATA))
	     --       dewasa.add(DewasaAyu.DEWASA_AMERTA_DEWATA);
		SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Dewa Jaya');
	END IF;
	    
	-- 10. Amerta Dewata 
	IF (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=12 ) || (pengalantaka='Penanggal' && sasihDay2=12)))THEN
	   --     if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_DEWATA))
	     --       dewasa.add(DewasaAyu.DEWASA_AMERTA_DEWATA);
		SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Dewata');
	END IF;
	    
	-- 11. Amerta Gati 
	IF ((saptawara=1 && (pengalantaka='Penanggal' && (sasihDay1=6 or sasihDay1=3 or sasihDay2=6 or sasihDay2=3 ) ) ) ||
	        (saptawara=2 && (pengalantaka='Penanggal' && (sasihDay1=7 or sasihDay2=7 ))) ||
	        (saptawara=3 && pengalantaka='Penanggal' && (sasihDay1=3||sasihDay2=3)) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && (sasihDay1=2 || sasihDay1=3)) ||
	                                      (pengalantaka='Penanggal' && (sasihDay2=2 || sasihDay2=3)) )) ||
	        (saptawara=5 && (pengalantaka='Penanggal' && (sasihDay1=5 || sasihDay2=5)) ) ||
	        (saptawara=6 && (pengalantaka='Penanggal' && (sasihDay1=1 || sasihDay2=1)) ) ||
	        (saptawara=7 && pengalantaka='Penanggal' && (sasihDay1=7 or sasihDay2=7 OR sasihDay1=4 OR sasihDay2=4))
	      ) THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_GATI))
	        -- dewasa.add(DewasaAyu.DEWASA_AMERTA_GATI);
		SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Gati');
	END IF;
	
	-- 12. Amerta Kundalini 
	IF (	(saptawara=2 && wuku=24 && pengalantaka='Penanggal' &&(sasihDay1=1||sasihDay2=1||
						sasihDay1=8||sasihDay2=8))||
		(saptawara=2 && wuku=29 && pengalantaka='Penanggal' &&(sasihDay1=1||sasihDay2=1||
						sasihDay1=7||sasihDay2=7||sasihDay1=15||sasihDay2=15))||
		(saptawara=2 && wuku=8 && pengalantaka='Penanggal' &&(sasihDay1=5||sasihDay2=5))||
		(saptawara=4 && wuku=2 && pengalantaka='Penanggal' &&(sasihDay1=2||sasihDay2=2||
						sasihDay1=12||sasihDay2=12))||
		(saptawara=4 && wuku=5 && pengalantaka='Penanggal' &&(sasihDay1=2||sasihDay2=2||
						sasihDay1=10||sasihDay2=10))||
		(saptawara=4 && wuku=8 && pengalantaka='Penanggal' &&(sasihDay1=6||sasihDay2=6))||
		(saptawara=4 && wuku=9 && pengalantaka='Penanggal' &&(sasihDay1=13||sasihDay2=13))||
		(saptawara=4 && wuku=15 && pengalantaka='Penanggal' &&(sasihDay1=2||sasihDay2=2||
						sasihDay1=12||sasihDay2=12))||
		(saptawara=5 && wuku=2 && pengalantaka='Penanggal' &&(sasihDay1=10||sasihDay2=10)) ||
		(saptawara=5 && wuku=20 && pengalantaka='Penanggal' &&(sasihDay1=5||sasihDay2=5||
						sasihDay1=15||sasihDay2=15))||
		(saptawara=5 && wuku=13 && pengalantaka='Penanggal' &&(sasihDay1=1||sasihDay2=1||
						sasihDay1=11||sasihDay2=11))
	      ) THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_GATI))
	        -- dewasa.add(DewasaAyu.DEWASA_AMERTA_GATI);
		SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Kundalini');
	END IF;
	    
	-- 13. Amerta Masa
	IF ( saptawara=6 && h_purnama='Purnama')THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_MASA))
	        -- dewasa.add(DewasaAyu.DEWASA_AMERTA_MASA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Masa');
	END IF;
	    
	/*14. Amerta Murti*/
	IF (saptawara=4 && pancawara=5 &&
	       ((pengalantaka='Penanggal' && sasihDay1=12) || (pengalantaka='Penanggal' && sasihDay2=12)))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_MURTI))
	           -- dewasa.add(DewasaAyu.DEWASA_AMERTA_MURTI);
		SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Murti');
	END IF;
	    
	/*15. Amerta Pageh */
	IF (saptawara=7 && h_purnama = 'Purnama')THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_PAGEH))
	        --    dewasa.add(DewasaAyu.DEWASA_AMERTA_PAGEH);
		SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Pageh');
	END IF;
	    
	/*16. Amerta Pepageran */
	IF (saptawara=7 && (h_purnama = 'Purnama' || astawara=4))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_PEPAGERAN))
	        --    dewasa.add(DewasaAyu.DEWASA_AMERTA_PEPAGERAN);
		SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Pepageran');
	END IF;
	
	/*17. Amerta Sari */
	IF (saptawara=4 && h_purnama = 'Purnama')THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_WIJA))
	        --    dewasa.add(DewasaAyu.DEWASA_AMERTA_WIJA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Sari');
	END IF;
	    
	/*18. Amerta Wija */
	IF (saptawara=5 && h_purnama = 'Purnama')THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_WIJA))
	        --    dewasa.add(DewasaAyu.DEWASA_AMERTA_WIJA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Wija');
	END IF;
		
	-- 19. Amerta Yoga
	IF ( (saptawara=2 && (wuku=2 || wuku=5||wuku=14||wuku=17||wuku=20||wuku=23||wuku=26||wuku=29))
	        || (saptawara=5 && ((pengalantaka='Pangelong' && sasihDay1=4 ) || (pengalantaka='Pangelong' && sasihDay2=4)) )
	        || (saptawara=7 && ((pengalantaka='Pangelong' && sasihDay1=5 ) || (pengalantaka='Pangelong' && sasihDay2=5)) )
	        || ((no_sasih=10) && ((pengalantaka='Pangelong' && sasihDay1=4 ) || (pengalantaka='Pangelong' && sasihDay2=4)) )
	        || ((no_sasih=12) && ((pengalantaka='Pangelong' && sasihDay1=1 ) || (pengalantaka='Pangelong' && sasihDay2=1)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AMERTA_YOGA))
	        -- dewasa.add(DewasaAyu.DEWASA_AMERTA_YOGA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Amerta Yoga');
	END IF;
	    
	/*20. Asuajag Munggah */
	IF ( (saptawara=1 && wuku=6) ||
	        (saptawara=2 && wuku=23) ||
	        (saptawara=3 && wuku=10) ||
	        (saptawara=4 && wuku=27) ||
	        (saptawara=5 && wuku=14) ||
	        (saptawara=6 && wuku=1) ||
	        (saptawara=7 && wuku=18)
	       )THEN
	       -- if(!dewasa.contains(DewasaAyu.DEWASA_ASUAJAG_MUNGGAH))
	         --   dewasa.add(DewasaAyu.DEWASA_ASUAJAG_MUNGGAH);
		SET dewasaAyu = CONCAT(dewasaAyu, ', ','Asuajag Munggah');
	END IF;
	    
	/*21. Asuajag Turun */
	IF ( (saptawara=1 && wuku=21) ||
	        (saptawara=2 && wuku=8) ||
	        (saptawara=3 && wuku=25) ||
	        (saptawara=4 && wuku=12) ||
	        (saptawara=5 && wuku=29) ||
	        (saptawara=6 && wuku=16) ||
	        (saptawara=7 && wuku=3)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_ASUAJAG_TURUN))
	        --    dewasa.add(DewasaAyu.DEWASA_ASUAJAG_TURUN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Asuajag Turun');
	END IF;
	    
	    /*22. Asuasa*/
	IF ((saptawara=1 && wuku=3) ||
	        (saptawara=1 && wuku=15) ||
	        (saptawara=2 && wuku=14) ||
	        (saptawara=3 && wuku=7) ||
	        (saptawara=4 && wuku=24) ||
	        (saptawara=5 && wuku=11) ||
	        (saptawara=6 && wuku=28))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_ASUASA))
	        --    dewasa.add(DewasaAyu.DEWASA_ASUASA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Asuasa');
	END IF;
	
	/*23. Ayu Bhadra*/
	IF( 	(saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=3 ) || (pengalantaka='Penanggal' && sasihDay2=3)) )
		|| (saptawara=2 && ((pengalantaka='Penanggal' && (sasihDay1=7 || sasihDay1=10)) ||
	                                      (pengalantaka='Penanggal' && (sasihDay2=7 || sasihDay2=10)) ))
	        || (saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=3 ) || (pengalantaka='Penanggal' && sasihDay2=3)) )
	        || (saptawara=4 && ((pengalantaka='Penanggal' && sasihDay1=12 ) || (pengalantaka='Penanggal' && sasihDay2=12)) )
	        || (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=10 ) || (pengalantaka='Penanggal' && sasihDay2=10)) )
	        || (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=11 ) || (pengalantaka='Penanggal' && sasihDay2=11)) ))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AYU_BHADRA))
	        --    dewasa.add(DewasaAyu.DEWASA_AYU_BHADRA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Ayu Bhadra');
	 END IF;
	    
	/*24. Ayu Dana*/
	IF (saptawara=6 && h_purnama = 'Purnama')THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_AYU_DANA))
	         --   dewasa.add(DewasaAyu.DEWASA_AYU_DANA);
		SET dewasaAyu = CONCAT(dewasaAyu, ', ','Ayu Dana');
	END IF;
	    
	/*25. Ayu Nulus*/
	IF ( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=6) ||
	                                      (pengalantaka='Penanggal' && sasihDay2=6) )) ||
	        (saptawara=2 && ((pengalantaka='Penanggal' && sasihDay1=3 ) || (pengalantaka='Penanggal' && sasihDay2=3)) ) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=7 ) || (pengalantaka='Penanggal' && sasihDay2=7)) ) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && (sasihDay1=12 || sasihDay1=13)) ||
	                                              (pengalantaka='Penanggal' && (sasihDay2=12 || sasihDay2=13)) )) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=5 ) || (pengalantaka='Penanggal' && sasihDay2=5)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=1 ) || (pengalantaka='Penanggal' && sasihDay2=1)) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=5 ) || (pengalantaka='Penanggal' && sasihDay2=5)) )) THEN
	       -- if(!dewasa.contains(DewasaAyu.DEWASA_AYU_NULUS))
	       --     dewasa.add(DewasaAyu.DEWASA_AYU_NULUS);
	       SET dewasaAyu = CONCAT(dewasaAyu, ', ','Ayu Nulus');
	END IF;
	    
	/*26. Babi Munggah*/
	IF (pancawara=4 && sadwara=1)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_BABI_MUNGGAH))
	        --    dewasa.add(DewasaAyu.DEWASA_BABI_MUNGGAH);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Babi Munggah');
	END IF;
	
	/*27. Babi Turun*/
	IF ( pancawara=4 && sadwara=4)THEN
	       -- if(!dewasa.contains(DewasaAyu.DEWASA_BABI_TURUN))
	        --    dewasa.add(DewasaAyu.DEWASA_BABI_TURUN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Babi Turun');
	END IF;
	    
	/*28. Banyu Milir*/
	IF( (saptawara=1 && wuku=4) ||
	        (saptawara=2 && wuku=27) ||
	        (saptawara=4 && wuku=1) ||
	        (saptawara=6 && wuku=13)
	        )THEN
	       -- if(!dewasa.contains(DewasaAyu.DEWASA_BANYU_MILIR))
	       --     dewasa.add(DewasaAyu.DEWASA_BANYU_MILIR);
	       SET dewasaAyu = CONCAT(dewasaAyu, ', ','Banyu Milir');
	END IF;
	    
	    /*29. BanyuUrung*/
	    IF( (saptawara=1 && wuku=1) ||
	        (saptawara=2 && (wuku=1 || wuku=2 || wuku=8 ||wuku=10 || wuku=17 || wuku=18|| wuku=20 || wuku=22) ) ||
	        (saptawara=3 && (wuku=1 || wuku=5 || wuku=14 || wuku=16 || wuku=17 || wuku=18 || wuku=23 || wuku=21) ) ||
	        (saptawara=4 && (wuku=28 || wuku=5 || wuku=10 || wuku=19 ||wuku=21)) ||
	        (saptawara=5 && (wuku=5 || wuku=6 || wuku=15 || wuku=19 ||wuku=20 || wuku=22 || wuku=24)) ||
	        (saptawara=6 && (wuku=28 || wuku=29 || wuku=6 || wuku=11 ||wuku=15 || wuku=17) ) ||
	        (saptawara=7 && (wuku=4 || wuku=8 || wuku=19))
	        )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_BANYU_URUNG))
	        --    dewasa.add(DewasaAyu.DEWASA_BANYU_URUNG);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Banyu Urung');
	    END IF;
	    
	    /*30. Bojog Munggah*/
	    IF(pancawara=5 && sadwara=5)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_BOJOG_MUNGGAH))
	            -- dewasa.add(DewasaAyu.DEWASA_BOJOG_MUNGGAH);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Bojog Munggah');
	    END IF;
	    
	    /*31. Bojog Turun*/
	    IF(pancawara=5 && sadwara=2)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_BOJOG_TURUN))
	           --  dewasa.add(DewasaAyu.DEWASA_BOJOG_TURUN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Bojog Turun');
	    END IF;
	    
	    /*32. Buda Gajah*/
	    IF(saptawara=4 && pancawara=4 && h_purnama='Purnama')THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_BOJOG_TURUN))
	           --  dewasa.add(DewasaAyu.DEWASA_BOJOG_TURUN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Buda Gajah');
	    END IF;
	    
	    /*33. Buda Ireng*/
	    IF(saptawara=4 && pancawara=4 && h_tilem='Tilem')THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_BOJOG_TURUN))
	           --  dewasa.add(DewasaAyu.DEWASA_BOJOG_TURUN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Buda Ireng');
	    END IF;
	    
	    /*34. Buda Suka*/
	    IF(saptawara=4 && pancawara=5 && h_tilem='Tilem')THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_BOJOG_TURUN))
	           --  dewasa.add(DewasaAyu.DEWASA_BOJOG_TURUN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Buda Suka');
	    END IF;
	    
	    /*35. Carik Walangati*/
	    IF(wuku=1 || wuku=6 || wuku=10 || wuku=12 || wuku=24
	       || wuku=25 || wuku=27 || wuku=28 || wuku=30 || wuku=7)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_CARIK_WALANGATI))
	            -- dewasa.add(DewasaAyu.DEWASA_CARIK_WALANGATI);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Carik Walangati');
	    END IF;
	    
	    /*36. Catur Laba*/
	    IF( (saptawara=1 && pancawara=1)
		|| (saptawara=2 && pancawara=4)
		|| (saptawara=4 && pancawara=3)
		|| (saptawara=7 && pancawara=2)
	    )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_CARIK_WALANGATI))
	            -- dewasa.add(DewasaAyu.DEWASA_CARIK_WALANGATI);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Catur Laba');
	    END IF;
	    
	    /*37. Cintamanik*/
	    IF(saptawara=4 && (wuku%2=1))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_CARIK_WALANGATI))
	            -- dewasa.add(DewasaAyu.DEWASA_CARIK_WALANGATI);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Cintamanik');
	    END IF;
	    
	    /*38. Corok Kodong*/
	    IF(saptawara=5 && pancawara=5 && wuku=13)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_COROK_KODONG))
	            -- dewasa.add(DewasaAyu.DEWASA_COROK_KODONG);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Corok Kodong');
	    END IF;
	    
	    /*39. DagDig Karana*/
	    IF( (saptawara=1 && (sasihDay1=2||sasihDay2=2)) ||
	        (saptawara=2 && (sasihDay1=1||sasihDay2=1)) ||
	        (saptawara=3 && (sasihDay1=10||sasihDay2=10)) ||
	        (saptawara=4 && (sasihDay1=7||sasihDay2=7)) ||
	        (saptawara=5 && (sasihDay1=3||sasihDay2=3)) ||
	        (saptawara=7 && (sasihDay1=6||sasihDay2=6)) )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DAGDIG_KARANA))
	            -- dewasa.add(DewasaAyu.DEWASA_DAGDIG_KARANA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dagdig Karana');
	    END IF;
	    
	    /*40. Dasa Amertha*/
	    IF(saptawara=6 && pancawara=2 
	    		&& ((pengalantaka='Penanggal' && sasihDay1=10) || (pengalantaka='Penanggal' && sasihDay2=10)) )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DASA_AMERTA))
	            -- dewasa.add(DewasaAyu.DEWASA_DASA_AMERTA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dasa Amerta');
	    END IF;
	    
	    /*41. Dasa Guna*/
	    IF(saptawara=4 && (h_purnama = 'Purnama' || h_tilem = 'Tilem') )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DASA_GUNA))
	            -- dewasa.add(DewasaAyu.DEWASA_DASA_GUNA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dasa Guna');
	    END IF;
	    
	    /*42. Dauh Ayu*/
	    IF((saptawara=1 && (sasihDay1=4||sasihDay2=4 ||
	                                      sasihDay1=5||sasihDay2=5 ||
	                                      sasihDay1=6||sasihDay2=6)) ||
	       (saptawara=2 && (sasihDay1=2||sasihDay2=2 ||
	                                     sasihDay1=3||sasihDay2=3 ||
	                                     sasihDay1=5||sasihDay2=5)) ||
	       (saptawara=3 && (sasihDay1=5||sasihDay2=5 ||
					     sasihDay1=7||sasihDay2=7 ||
	                                     sasihDay1=8||sasihDay2=8)) ||
	       (saptawara=4 && (sasihDay1=4||sasihDay2=4)) ||
	       (saptawara=5 && (sasihDay1=1||sasihDay2=1 ||
	                                     sasihDay1=4||sasihDay2=4)) ||
	       (saptawara=6 && (sasihDay1=1||sasihDay2=1 ||
	                                     sasihDay1=5||sasihDay2=5 ||
	                                     sasihDay1=6||sasihDay2=6)) ||
	       (saptawara=7 && (sasihDay1=5||sasihDay2=5))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DAUH_AYU))
	            -- dewasa.add(DewasaAyu.DEWASA_DAUH_AYU);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dauh Ayu');
	    END IF;
	    
	    /*43. DermanBagia*/
	    IF(saptawara=2 && (sasihDay1=2||sasihDay2=2 ||
	                                      sasihDay1=3||sasihDay2=3 ||
	                                      sasihDay1=5||sasihDay2=5 ||
	                                      sasihDay1=12||sasihDay2=12) )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DERMAN_BAGIA))
	            -- dewasa.add(DewasaAyu.DEWASA_DERMAN_BAGIA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Derman Bagia');
	    END IF;
	    
	    /*44. Dewa Ngelayang*/
	    IF( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=6) || (pengalantaka='Penanggal' && sasihDay2=6))) ||
	        (saptawara=2 && ((pengalantaka='Penanggal' && sasihDay1=3) || (pengalantaka='Penanggal' && sasihDay2=3))) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && (sasihDay1=3 || sasihDay1=7)) ||
	                                         (pengalantaka='Penanggal' && (sasihDay2=3 || sasihDay2=7)) )) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && (sasihDay1=3 || sasihDay1=13|| sasihDay1=15)) ||
	                                         (pengalantaka='Penanggal' && (sasihDay2=3 || sasihDay2=13|| sasihDay2=15)) )) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && (sasihDay1=5)) ||
	                                         (pengalantaka='Penanggal' && (sasihDay2=5)) )) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=1) || (pengalantaka='Penanggal' && sasihDay2=1))) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=4) || (pengalantaka='Penanggal' && sasihDay2=4)))
	        
	        )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DEWA_NGELAYANG))
	           --  dewasa.add(DewasaAyu.DEWASA_DEWA_NGELAYANG);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dewa Ngelayang');
	    END IF;
	    
	    /*45. Dewa Satata*/
	    IF( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=10 ) || (pengalantaka='Penanggal' && sasihDay2=10)) ) ||
	        (saptawara=2 && ((pengalantaka='Penanggal' && sasihDay1=9 ) || (pengalantaka='Penanggal' && sasihDay2=9)) ) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=6 ) || (pengalantaka='Penanggal' && sasihDay2=6)) ) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && sasihDay1=8 ) || (pengalantaka='Penanggal' && sasihDay2=8)) ) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=7 ) || (pengalantaka='Penanggal' && sasihDay2=7)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=9 ) || (pengalantaka='Penanggal' && sasihDay2=9)) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=10 ) || (pengalantaka='Penanggal' && sasihDay2=10)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DEWA_SATATA))
	           --  dewasa.add(DewasaAyu.DEWASA_DEWA_SATATA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dewa Satata');
	    END IF;
	    
	    /*46. Dewa Werdhi*/
	    IF(saptawara=6 && pancawara=4 
	    		&& ((pengalantaka='Penanggal' && sasihDay1=10) || (pengalantaka='Penanggal' && sasihDay2=10)))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DEWA_WERDHI))
	           --  dewasa.add(DewasaAyu.DEWASA_DEWA_WERDHI);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dewa Werdhi');
	    END IF;
	    
	    
	    /*47. Dewa Mentas*/
	    IF(saptawara=5 && (pengalantaka='Penanggal' && (sasihDay1=5||sasihDay2=5||sasihDay1=15||sasihDay2=15)))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DEWA_MENTAS))
	            -- dewasa.add(DewasaAyu.DEWASA_DEWA_MENTAS);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dewa Mentas');
	    END IF;
	    
	    /*48. Dewasa Ngelayang*/
	    IF( (saptawara=1 && ((pengalantaka='Penanggal' && (sasihDay1=1 || sasihDay1=8)) ||
	                                        (pengalantaka='Penanggal' && (sasihDay2=1 || sasihDay2=8)) )) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=7 ) || (pengalantaka='Penanggal' && sasihDay2=7)) ) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && (sasihDay1=2 || sasihDay1=3)) ||
	                                      (pengalantaka='Penanggal' && (sasihDay2=2 || sasihDay2=3)) )) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=4 ) || (pengalantaka='Penanggal' && sasihDay2=4)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=6 ) || (pengalantaka='Penanggal' && sasihDay2=6)) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=5 ) || (pengalantaka='Penanggal' && sasihDay2=5)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_NGELAYANG))
	           --  dewasa.add(DewasaAyu.DEWASA_NGELAYANG);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dewasa Ngelayang');
	    END IF;
	    
	    /*49. Dewasa Tanian*/
	    IF( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=10 ) || (pengalantaka='Penanggal' && sasihDay2=10)) ) ||
	        (saptawara=2 && ((pengalantaka='Penanggal' && sasihDay1=9 ) || (pengalantaka='Penanggal' && sasihDay2=9)) ) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=6 ) || (pengalantaka='Penanggal' && sasihDay2=6)) ) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && sasihDay1=8 ) || (pengalantaka='Penanggal' && sasihDay2=8)) ) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=7 ) || (pengalantaka='Penanggal' && sasihDay2=7)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=10 ) || (pengalantaka='Penanggal' && sasihDay2=10)) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=10 ) || (pengalantaka='Penanggal' && sasihDay2=10)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_TANIAN))
	           --  dewasa.add(DewasaAyu.DEWASA_TANIAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dewasa Tanian');
	    END IF;
	    
	    
	    
	    /*50. Dina Carik */
	    IF( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=12 ) || (pengalantaka='Penanggal' && sasihDay2=12)) ) ||
		(saptawara=2 && ((pengalantaka='Penanggal' && sasihDay1=11 ) || (pengalantaka='Penanggal' && sasihDay2=11)) ) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=10 ) || (pengalantaka='Penanggal' && sasihDay2=10)) ) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && sasihDay1=9 ) || (pengalantaka='Penanggal' && sasihDay2=9)) ) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=8 ) || (pengalantaka='Penanggal' && sasihDay2=8)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=7 ) || (pengalantaka='Penanggal' && sasihDay2=7)) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=6 ) || (pengalantaka='Penanggal' && sasihDay2=6)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DINA_CARIK))
	           --  dewasa.add(DewasaAyu.DEWASA_DINA_CARIK);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dina Carik');
	    END IF;
	    
	    /*51. Dina Jaya */
	    IF( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=6 ) || (pengalantaka='Penanggal' && sasihDay2=6)) ) ||
	        (saptawara=2 && ((pengalantaka='Penanggal' && sasihDay1=5 ) || (pengalantaka='Penanggal' && sasihDay2=5)) ) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && sasihDay1=3 ) || (pengalantaka='Penanggal' && sasihDay2=3)) ) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=2 ) || (pengalantaka='Penanggal' && sasihDay2=2)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=1 ) || (pengalantaka='Penanggal' && sasihDay2=1)) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=7 ) || (pengalantaka='Penanggal' && sasihDay2=7)) )
	        )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DINA_JAYA))
	           --  dewasa.add(DewasaAyu.DEWASA_DINA_JAYA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dina Jaya');
	    END IF;
	    
	    /*52. Dina Mandi */
	    IF( (saptawara=3 && h_purnama = 'Purnama') ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=2 ) || (pengalantaka='Penanggal' && sasihDay2=2)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=14 ) || (pengalantaka='Penanggal' && sasihDay2=14)) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=3 ) || (pengalantaka='Penanggal' && sasihDay2=3)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DINA_MANDI))
	           --  dewasa.add(DewasaAyu.DEWASA_DINA_MANDI);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dina Mandi');
	    END IF;
	    
	    /*53. Dirgahayu */
	    IF( saptawara=3 && pancawara=3&& dasawara=1)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DINA_MANDI))
	           --  dewasa.add(DewasaAyu.DEWASA_DINA_MANDI);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dirgahayu');
	    END IF;
	    
	    /*54. DirghaYusa */
	    IF(saptawara=4 && pancawara=3 && 
	    		((pengalantaka='Penanggal' && sasihDay1=10) || (pengalantaka='Penanggal' && sasihDay2=10)))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_DIRGHA_YUSA))
	           --  dewasa.add(DewasaAyu.DEWASA_DIRGHA_YUSA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Dirgha Yusa');
	    END IF;
	    
	    /*55. Gagak Anungsung Pati*/
	    IF( (pengalantaka='Penanggal' && (sasihDay1=9||sasihDay2=9)) || 
		(pengalantaka='Pengelong' && (sasihDay1=1||sasihDay2=1)) || 
		(pengalantaka='Pengelong' && (sasihDay1=6||sasihDay2=6)) || 
		(pengalantaka='Pengelong' && (sasihDay1=14||sasihDay2=14)) 
	    )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_GAGAK_ANUNGSUNG_PATI))
	           --  dewasa.add(DewasaAyu.DEWASA_GAGAK_ANUNGSUNG_PATI);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Gagak Anungsung Pati');
	    END IF;
	    
	    /*56. Geheng Manyinget*/
	    IF( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=14 ) || (pengalantaka='Penanggal' && sasihDay2=14)) ) ||
	        (saptawara=2 && ((pengalantaka='Penanggal' && sasihDay1=1 ) || (pengalantaka='Penanggal' && sasihDay2=1)) ) ||
	        (saptawara=2 && ((pengalantaka='Pangelong' && sasihDay1=7 ) || (pengalantaka='Pangelong' && sasihDay2=7)) ) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && (sasihDay1=2||sasihDay1=10)) || (pengalantaka='Penanggal' && (sasihDay2=2||sasihDay2=10) )) ) ||
	        (saptawara=4 && ((pengalantaka='Pangelong' && sasihDay1=10 ) || (pengalantaka='Pangelong' && sasihDay2=10)) ) ||
	        (saptawara=5 && ((pengalantaka='Pangelong' && sasihDay1=5 ) || (pengalantaka='Pangelong' && sasihDay2=5)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=14 ) || (pengalantaka='Penanggal' && sasihDay2=14)) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && (sasihDay1=1||sasihDay1=9)) || (pengalantaka='Penanggal' && (sasihDay2=1||sasihDay2=9) )) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_GEHENG_MANYINGET))
	           --  dewasa.add(DewasaAyu.DEWASA_GEHENG_MANYINGET);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Geheng Manyinget');
	    END IF;
	    
	    /*57. Geni Agung */
	    IF( (saptawara=1 && pancawara=1 && (pengalantaka='Penanggal' && (sasihDay1=10||sasihDay2=10)) ) ||
	        (saptawara=3 && pancawara=4 && (pengalantaka='Penanggal' && (sasihDay1=8||sasihDay2=8)) ) ||
	        (saptawara=4 && pancawara=3 && (pengalantaka='Penanggal' && (sasihDay1=14||sasihDay2=14)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_GEHENG_MANYINGET))
	           --  dewasa.add(DewasaAyu.DEWASA_GEHENG_MANYINGET);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Geni Agung');
	    END IF;
	    
	    /*58. Geni Murub*/
	    IF((saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=12 ) || (pengalantaka='Penanggal' && sasihDay2=12)) ) ||
	        (saptawara=2 && ((pengalantaka='Penanggal' && (sasihDay1=11)) || (pengalantaka='Penanggal' && (sasihDay2=11) )) ) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=10 ) || (pengalantaka='Penanggal' && sasihDay2=10)) ) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && sasihDay1=9 ) || (pengalantaka='Penanggal' && sasihDay2=9)) ) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=8 ) || (pengalantaka='Penanggal' && sasihDay2=8)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && (sasihDay1=7)) || (pengalantaka='Penanggal' && (sasihDay2=7) )) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=6 ) || (pengalantaka='Penanggal' && sasihDay2=6)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_GENI_MURUB))
	           --  dewasa.add(DewasaAyu.DEWASA_GENI_MURUB);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Geni Murub');
	    END IF;
	    
	    /*59. Geni Rawana */
	    IF((pengalantaka='Penanggal' && (sasihDay1=2 || sasihDay1=4|| sasihDay1=8 || sasihDay1=11) ) ||
	       (pengalantaka='Penanggal' && (sasihDay2=2 || sasihDay2=4|| sasihDay2=8 || sasihDay2=11) ) ||
	       (pengalantaka='Pangelong' && (sasihDay1=3 || sasihDay1=4 || sasihDay1=9 || sasihDay1=13)) ||
	       (pengalantaka='Pangelong' && (sasihDay2=3 || sasihDay2=4 || sasihDay2=9 || sasihDay2=13))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_GENI_RAWANA))
	            -- dewasa.add(DewasaAyu.DEWASA_GENI_RAWANA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Geni Rawana');
	    END IF;
	    
	    /*60. Geni Rawana Jejepan */
	    IF( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=12 ) || (pengalantaka='Penanggal' && sasihDay2=12)) ) ||
	        (saptawara=2 && ((pengalantaka='Penanggal' && sasihDay1=11 ) || (pengalantaka='Penanggal' && sasihDay2=11)) ) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=10 ) || (pengalantaka='Penanggal' && sasihDay2=10)) ) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && sasihDay1=9 ) || (pengalantaka='Penanggal' && sasihDay2=9)) ) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=8 ) || (pengalantaka='Penanggal' && sasihDay2=8)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=7 ) || (pengalantaka='Penanggal' && sasihDay2=7)) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=6 ) || (pengalantaka='Penanggal' && sasihDay2=6)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_GENI_RAWANA_JEJEPAN))
	           --  dewasa.add(DewasaAyu.DEWASA_GENI_RAWANA_JEJEPAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Geni Rawana Jejepan');
	    END IF;
	    
	    /*61. Geni Rawana Rangkep */
	    IF( (saptawara=3 && pengalantaka='Penanggal' && (sasihDay1=2||sasihDay1=4||sasihDay1=8||sasihDay1=11||sasihDay2=2||sasihDay2=4||sasihDay2=8||sasihDay2=11) )  ||
	        (saptawara=3 && pengalantaka='Penanggal' && (sasihDay1=3||sasihDay1=4||sasihDay1=9||sasihDay1=13||sasihDay2=3||sasihDay2=4||sasihDay2=9||sasihDay2=13) )
	        
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_GENI_RAWANA_RANGKEP))
	            -- dewasa.add(DewasaAyu.DEWASA_GENI_RAWANA_RANGKEP);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Geni Rawana Rangkep');
	    END IF;
	    
	    /*62. Guntur Umah/Graha*/
	    IF( (saptawara=4 && wuku=2) ||
	        (saptawara=4 && wuku=5) ||
	        (saptawara=5 && wuku=14) ||
	        (saptawara=5 && wuku=18) ||
	        (saptawara=7 && wuku=20) ||
	        (saptawara=7 && wuku=26)
	        )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_GUNTUR_GRAHA))
	           --  dewasa.add(DewasaAyu.DEWASA_GUNTUR_GRAHA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Guntur Graha');
	    END IF;
	    
	    /*63. Ingkel Macan*/
	    IF(saptawara=5 && pancawara=3 && wuku=7)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_INGKEL_MACAN))
	           --  dewasa.add(DewasaAyu.DEWASA_INGKEL_MACAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Ingkel Macan');
	    END IF;
	    
	    /*64. Istri Payasan*/
	    IF(saptawara=2 && ((pengalantaka='Penanggal' && sasihDay1=8 ) || (pengalantaka='Penanggal' && sasihDay2=8)) )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_ISTRI_PAYASAN))
	            -- dewasa.add(DewasaAyu.DEWASA_ISTRI_PAYASAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Istri Payasan');
	    END IF;
	    
	    /*65. Jiwa Manganti*/
	    IF( (saptawara=2 && wuku=19) ||
	        (saptawara=5 && (wuku=2 || wuku=20) ) ||
	        (saptawara=6 && (wuku=25 || wuku=7) ) ||
	        (saptawara=7 && wuku=30)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_JIWA_MANGANTI))
	           --  dewasa.add(DewasaAyu.DEWASA_JIWA_MANGANTI);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Jiwa Manganti');
	    END IF;
	    
	    /*66. Kajeng Kipkipan*/
	    IF(saptawara=4 && (wuku=6||wuku=30) )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_JIWA_MANGANTI))
	           --  dewasa.add(DewasaAyu.DEWASA_JIWA_MANGANTI);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kajeng Kipkipan');
	    END IF;
	    
	    /*67. Kajeng Kliwon Enyitan*/
	    IF(triwara= 3 && pancawara=5 && ((pengalantaka='Penanggal' && sasihDay1<15 && sasihDay1>7) || (pengalantaka='Penanggal' && sasihDay2<15 && sasihDay2>7))  )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KAJENG_KLIWON_ENYITAN))
	            -- dewasa.add(DewasaAyu.DEWASA_KAJENG_KLIWON_ENYITAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kajeng Kliwon Enyitan');
	    END IF;
	    
	    
	    /*68. Kajeng Lulunan*/
	    IF(triwara= 3 && astawara=5 && sangawara=9)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KAJENG_LULUNAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KAJENG_LULUNAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kajeng Lulunan');
	    END IF;
	    
	    /*69. Kajeng Rendetan*/
	    IF( triwara=3 && pengalantaka='Penanggal' && (saptawara=1||saptawara=4||saptawara=7)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KAJENG_RENDETAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KAJENG_RENDETAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kajeng Rendetan');
	    END IF;
	    
	    /*70. Kajeng Susunan*/
	    IF(triwara= 3 && astawara=3 && sangawara=9)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KAJENG_SUSUNAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KAJENG_SUSUNAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kajeng Susunan');
	    END IF;
	    
	    /*71. Kajeng Uwudan*/
	    IF( triwara=3 && pengalantaka='Pangelong' && (saptawara=1||saptawara=4||saptawara=7)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KAJENG_RENDETAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KAJENG_RENDETAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kajeng Uwudan');
	    END IF;
	    
	    /*72. Kala Alap*/
	    IF(saptawara=2 && wuku=22)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_ANGIN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_ANGIN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Alap');
	    END IF;
	    
	    /*73. Kala Angin*/
	    IF(saptawara=1 && (wuku=17 || wuku=25 || wuku=28))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_ANGIN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_ANGIN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Angin');
	    END IF;
	    
	    /*74. Kala Atat*/
	    IF((saptawara=1 && wuku=22) ||
	       (saptawara=3 && wuku=30) ||
	       (saptawara=4 && wuku=19) 
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_ATAT))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_ATAT);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Atat');
	    END IF;
	    
	    /*75. Kala Awus*/
	    IF((saptawara=4 && wuku=28))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_AWUS))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_AWUS);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Awus');
	    END IF;
	    
	    /*76. Kala Bancaran*/
	    IF(	(saptawara=1 && wuku=11) ||
		(saptawara=2 && wuku=1) ||
		(saptawara=3 && (wuku=5 || wuku=11 || wuku=19)) ||
		(saptawara=5 && wuku=21) ||
		(saptawara=6 && wuku=12) ||
		(saptawara=7 && wuku=7)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_BANCARAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_BANCARAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Bancaran');
	    END IF;
	    
	    /*77. Kala Bangkung, Kala Nanggung*/
	    IF((saptawara=1 && pancawara=3) ||
	       (saptawara=2 && pancawara=2) ||
	       (saptawara=4 && pancawara=1) ||
	       (saptawara=7 && pancawara=4)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_BANGKUNG))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_BANGKUNG);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Bangkung, Kala Nanggung');
	    END IF;
	    
	    /*78. Kala Beser*/
	    IF(sadwara=1 && astawara=7)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_BESER))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_BESER);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Beser');
	    END IF;
	    
	    /*79. Kala Brahma*/
	    IF((saptawara=1 && wuku=23) ||
	       (saptawara=3 && wuku=14) ||
	       (saptawara=4 && wuku=1) ||
	       (saptawara=6 && (wuku=4 || wuku=25 || wuku=30) ) ||
	       (saptawara=7 && wuku=13)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_BRAHMA))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_BRAHMA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Brahma');
	    END IF;
	    
	    /*80. Kala Bregala*/
	    IF(saptawara=2 && wuku=2)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_BRAHMA))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_BRAHMA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Bregala');
	    END IF;
	    
	    /*81. Kala Buingrau*/
	    IF((saptawara=1 && astawara=2) ||
	       (saptawara=2 && astawara=8) ||
	       (saptawara=3 && astawara=5) ||
	       (saptawara=4 && astawara=6) ||
	       (saptawara=5 && astawara=3) ||
	       (saptawara=6 && astawara=1) ||
	       (saptawara=7 && astawara=4)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_BUINGRAU))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_BUINGRAU);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Buingrau');
	    END IF;
	    
	    /*82. Kala Cakra*/
	    IF(saptawara=7 && wuku=23)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_CAKRA))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_CAKRA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Cakra');
	    END IF;
	
	    /*83. Kala Capika*/
	    IF(saptawara=1 && wuku=18 && pengalantaka='Penanggal' && (sasihDay1=3 || sasihDay2=3))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_CAKRA))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_CAKRA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Capika');
	    END IF;
	    
	    /*84. Kala Caplokan*/
	    IF(	(saptawara=2 && (wuku=18 || wuku=9)) ||
		(saptawara=3 && wuku=19) ||
		(saptawara=4 && wuku=24) ||
		(saptawara=6 && wuku=12 ) ||
		(saptawara=7 && (wuku=9 || wuku=15 || wuku=1))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_CAPLOKAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_CAPLOKAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Caplokan');
	    END IF;
	    
	    /*85. Kala Cepitan*/
	    IF(saptawara=2 && pancawara=2 && wuku=18)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_CEPITAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_CEPITAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Cepitan');
	    END IF;
	    
	    /*86. Kala Dangastra*/
	    IF( (saptawara=1 && (wuku=4 || wuku=23)) ||
	        (saptawara=2 && (wuku=10 || wuku=29)) ||
	        (saptawara=3 && (wuku=14 || wuku=16 || wuku=18)) ||
	        (saptawara=4 && (wuku=1 || wuku=20)) ||
	        (saptawara=5 && (wuku=11)) ||
	        (saptawara=6 && (wuku=4 || wuku=11 || wuku=25 || wuku=30)) ||
	        (saptawara=7 && (wuku=13 || wuku=15 || wuku=17))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_DANGASTRA))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_DANGASTRA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Dangastra');
	    END IF;
	    
	    /*87. Kala Dangu*/
	    IF((saptawara=1 && (wuku=5 || wuku=13 || wuku=22 || wuku=27)) ||
	        (saptawara=2 && wuku=18) ||
	        (saptawara=3 && (wuku=3 || wuku=6 || wuku=11 || wuku=17)) ||
	        (saptawara=4 && (wuku=1 || wuku=9 || wuku=19 || wuku=28)) ||
	        (saptawara=5 && (wuku=7 || wuku=15 || wuku=24)) ||
	        (saptawara=6 && (wuku=11 || wuku=21 || wuku=23 || wuku=26)) ||
	        (saptawara=7 && (wuku=8 || wuku=10 || wuku=11 ||
	                                           wuku=14 || wuku=16 || wuku=20 || wuku=25 ||
	                                           wuku=29 || wuku=30))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_DANGU))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_DANGU);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Dangu');
	    END IF;
	    
	    /*88. Kala Demit*/
	    IF(saptawara=7 && wuku=3
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_DEMIT))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_DEMIT);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Demit');
	    END IF;
	    
	    /*89. Kala Empas Munggah*/
	    IF( pancawara=4 &&sadwara=3)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_EMPAS))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_EMPAS);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Empas Munggah');
	    END IF;
	    
	    /*90. Kala Empas Turun*/
	    IF( pancawara=4 &&sadwara=6)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_EMPAS))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_EMPAS);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Empas Turun');
	    END IF;
	    
	    /*91. Kala Gacokan*/
	    IF( saptawara=3 && wuku=19 )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_GACOKAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_GACOKAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Gacokan');
	    END IF;
	    
	    /*92. Kala Garuda*/
	    IF( saptawara=3 && wuku=2 )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_GARUDA))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_GARUDA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Garuda');
	    END IF;
	    
	    /*93. Kala Geger*/
	    IF( (saptawara=5||saptawara=7) && wuku=7 )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_GEGER))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_GEGER);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Geger');
	    END IF;
	    
	    /*94. Kala Gotongan*/
	    IF( (saptawara=6 && pancawara=5) ||
	        (saptawara=7 && pancawara=1) ||
	        (saptawara=1 && pancawara=2)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_GOTONGAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_GOTONGAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Gotongan');
	    END IF;
	    
	    /*95. Kala Graha*/
	    IF( (saptawara=2 && wuku=2) ||
	        (saptawara=7 && wuku=5)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_GRAHA))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_GRAHA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Graha');
	    END IF;
	    
	    /*96. Kala Gumarang Munggah*/
	    IF( pancawara=3&&sadwara=3)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_GUMARANG))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_GUMARANG);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Gumarang Munggah');
	    END IF;
	    
	    /*97. Kala Gumarang Turun*/
	    IF( pancawara=3&&sadwara=6)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_GUMARANG))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_GUMARANG);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Gumarang Turun');
	    END IF;
	    
	    /*98. Kala Guru*/
	    IF( (saptawara=4 && wuku=2)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_GURU))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_GURU);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Guru');
	    END IF;
	    
	    /*99. Kala Ingsor*/
	    IF( wuku=4 || wuku=14 || wuku=24
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_INGSOR))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_INGSOR);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Ingsor');
	    END IF;
	    
	    /*100. Kala Isinan*/
	    IF( (saptawara=2 && (wuku=11 || wuku=17) ) ||
	        (saptawara=4 && wuku=30)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_ISINAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_ISINAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Isinan');
	    END IF;
	    
	    /*101. Kala Jangkut*/
	    IF(triwara=3 && dwiwara=2)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_JANGKUT))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_JANGKUT);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Jangkut');
	    END IF;
	    
	    /*102. Kala Jengkang*/
	    IF(saptawara=1 && pancawara=1 && wuku=3)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_JENGKANG))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_JENGKANG);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Jengkang');
	    END IF;
	    
	    /*103. Kala Jengking*/
	    IF( sadwara=3 && astawara=7 )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_JENGKING))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_JENGKING);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Jengking');
	    END IF;
	    
	    /*104. Kala Katemu*/
	    IF((saptawara=1 && (wuku=1 || wuku=9 || wuku=15)) ||
	        (saptawara=2 && (wuku=3 || wuku=5 || wuku=17)) ||
	        (saptawara=3 && (wuku=11 || wuku=16 || wuku=19 || wuku=30)) ||
	        (saptawara=4 && (wuku=13 || wuku=29 || wuku=5 || wuku=7)) ||
	        (saptawara=5 && (wuku=15 || wuku=1 || wuku=9)) ||
	        (saptawara=6 && (wuku=17 || wuku=3)) ||
	        (saptawara=7 && (wuku=16 || wuku=19 || wuku=27 || wuku=5 || wuku=11))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_KATEMU))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_KATEMU);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Katemu');
	    END IF;
	    
	    /*105. Kala Keciran*/
	    IF(saptawara=4 && wuku=6)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_KECIRAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_KECIRAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Keciran');
	    END IF;
	    
	    /*106. Kala Kilang-Kilung*/
	    IF((saptawara=2 && wuku=17) ||
	       (saptawara=5 && wuku=19)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_KILANG_KILUNG))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_KILANG_KILUNG);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Kilang-Kilung');
	    END IF;
	    
	    /*107. Kala Kingkingan*/
	    IF(saptawara=5 && wuku=17)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_KECIRAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_KECIRAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Kingkingan');
	    END IF;
	    
	    /*108. Kala Klingkung*/
	    IF(saptawara=3 && wuku=1)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_KECIRAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_KECIRAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Klingkung');
	    END IF;
	    
	    
	    /*109. Kala Kutila Manik*/
	    IF(triwara=3 && pancawara=5)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_KECIRAN))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_KECIRAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Kutila Manik');
	    END IF;
	
	    /*110. Kala Kutila*/
	    IF(sadwara=2 && astawara=6)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_KUTILA))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_KUTILA);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Kutila');
	    END IF;
	    
	    /*111. Kala Luang*/
	    IF((saptawara=1 && (wuku=11 || wuku=12 || wuku=13)) ||
	        (saptawara=2 && (wuku=27)) ||
	        (saptawara=3 && (wuku=1 || wuku=10 || wuku=8
	                                         || wuku=19 || wuku=23 || wuku=30)) ||
	        (saptawara=4 && (wuku=2 || wuku=5 || wuku=6 || wuku=16
	                                      || wuku=18)) ||
	        (saptawara=5 && (wuku=28 || wuku=29))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_LUANG))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_LUANG);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Luang');
	    END IF;
	    
	    /*112. Kala Lutung Megelut*/
	    IF((saptawara=1 && wuku=3) || (saptawara=4 && wuku=10))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MACAN))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_MACAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Lutung Megelut');
	    END IF;
	    
	    /*113. Kala Lutung Megandong*/
	    IF(saptawara=5 && pancawara=5)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MACAN))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_MACAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Lutung Megandong');
	    END IF;
	    
	    /*114. Kala Macan*/
	    IF(saptawara=5 && wuku=19)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MACAN))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_MACAN);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Macan');
	    END IF;
	    
	    /*115. Kala Mangap*/
	    IF(saptawara=1 && pancawara=1)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MANGAP))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_MANGAP);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Mangap');
	    END IF;
	    
	    /*116. Kala Manguneb*/
	    IF(saptawara=5 && pancawara=14)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MANGAP))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_MANGAP);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Manguneb');
	    END IF;
	    
	    /*117. Kala Matampak*/
	    IF( (saptawara=4 && wuku=3) ||
	        (saptawara=5 && wuku=28) ||
	        (saptawara=6 && wuku=3) ||
	        (saptawara=7 && (wuku=7 || wuku=24))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MATAMPAK))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_MATAMPAK);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Matampak');
	    END IF;
	    
	    /*118. Kala Mereng*/
	    IF( (saptawara=1 && (wuku=9 || wuku=24)) ||
	        (saptawara=2 && (wuku=11 || wuku=26)) ||
	        (saptawara=3 && (wuku=13)) ||
	        (saptawara=4 && (wuku=15 || wuku=30)) ||
	        (saptawara=5 && (wuku=2 || wuku=17 || wuku=19)) ||
	        (saptawara=7 && (wuku=21))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MERENG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_MERENG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Mereng');
	    END IF;
	    
	    /*119. Kala Miled*/
	    IF(saptawara=2 && pancawara=16)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MANGAP))
	           --  dewasa.add(DewasaAyu.DEWASA_KALA_MANGAP);
	        SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Miled');
	    END IF;
	    
	    /*120. Kala Mina*/
	    IF(saptawara=6 && (wuku=8||wuku=14))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MINA))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_MINA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Mina');
	    END IF;
	    
	    /*121. Kala Mretyu*/
	    IF( (saptawara=1 && (wuku=1 || wuku=18)) ||
	        (saptawara=2 && (wuku=23)) ||
	        (saptawara=3 && (wuku=14 ||wuku=27)) ||
	        (saptawara=4 && (wuku=1)) ||
	        (saptawara=5 && (wuku=5)) ||
	        (saptawara=6 && (wuku=9)) ||
	        (saptawara=7 && (wuku=14))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MRETYU))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_MRETYU);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Mretyu');
	    END IF;
	    
	    /*122. Kala Muas*/
	    IF( (saptawara=1 && (wuku=4)) ||
	        (saptawara=2 && (wuku=27)) ||
	        (saptawara=7 && (wuku=16))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MUAS))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_MUAS);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Muas');
	    END IF;
	    
	    /*123. Kala Muncar*/
	    IF( saptawara=4 && (wuku=11))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MUAS))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_MUAS);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Muncar');
	    END IF;
	    
	    /*124. Kala Muncrat*/
	    IF(saptawara=2 && pancawara=3 && wuku=18)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MUNCRAT))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_MUNCRAT);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Muncrat');
	    END IF;
	    
	    /*125. Kala Ngadeg*/
	    IF( (saptawara=1 && (wuku=15 || wuku=17)) ||
	        (saptawara=2 && (wuku=19 || wuku=28)) ||
	        (saptawara=6 && (wuku=12 || wuku=30))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_NGADEG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_NGADEG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Ngadeg');
	    END IF;
	    
	    /*126. Kala Ngamut*/
	    IF(saptawara=2 && wuku=18)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_MUNCRAT))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_MUNCRAT);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Ngamut');
	    END IF;
	    
	    /*127. Kala Ngruda*/
	    IF( (saptawara=1 && (wuku=29)) ||
	        (saptawara=2 && (wuku=23 || wuku=10)) ||
	        (saptawara=7 && (wuku=10))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_NGERUDA))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_NGERUDA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Ngruda');
	    END IF;
	    
	    /*128. Kala Ngunya*/
	    IF( (saptawara=1 && (wuku=3))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_NGUNYA))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_NGUNYA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Ngunya');
	    END IF;
	    
	    /*129. Kala Olih*/
	    IF( (saptawara=4 && (wuku=24))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_OLIH))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_OLIH);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Olih');
	    END IF;
	    
	    /*130. Kala Pacekan*/
	    IF( (saptawara=3 && (wuku=5))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_PACEKAN))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_PACEKAN);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Pacekan');
	    END IF;
    
	    /*131. Kala Pager*/
	    IF( (saptawara=5 && (wuku=7))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_PAGER))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_PAGER);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Pager');
	    END IF;
	    
	    /*132. Kala Panyeneng*/
	    IF( (saptawara=1 && (wuku=7)) ||
	        (saptawara=6 && (wuku=30))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_PANYENENG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_PANYENENG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Panyeneng');
	    END IF;
	    
	    /*133. Kala Pati*/
	    IF( (saptawara=1 && (wuku=10||wuku=2)) ||
	        (saptawara=3 && (wuku=6 || wuku=14 || wuku=27)) ||
	        (saptawara=4 && (wuku=2 || wuku=10 || wuku=26)) ||
	        (saptawara=7 && (wuku=17))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_PATI))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_PATI);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Pati');
	    END IF;
	    
	    /*134. Kala Pati Jengkang*/
	    IF( (saptawara=5 && (sadwara=3))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_PATI_JENGKANG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_PATI_JENGKANG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Pati Jengkang');
	    END IF;
	    
	    /*135. Kala Pegat*/
	    IF( (saptawara=4 && wuku=12) ||
		(saptawara=7 && (wuku=3 || wuku=18))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_PEGAT))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_PEGAT);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Pegat');
	    END IF;
	    
	    /*136. Kala Prawani*/
	    IF( (saptawara=1 && (wuku=1)) ||
	        (saptawara=3 && (wuku=24)) ||
	        (saptawara=4 && (wuku=2)) ||
	        (saptawara=5 && (wuku=19))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_PRAWANI))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_PRAWANI);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Prawani');
	    END IF;
	    
	    /*137. Kala Raja*/
	    IF( (saptawara=5 && (wuku=29))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_RAJA))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_RAJA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Raja');
	    END IF;
	    
	    /*138. Kala Rau*/
	    IF( (saptawara=1 && (wuku=1)) ||
	        (saptawara=7 && (wuku=3 || wuku=4 || wuku=18)) ||
	        (saptawara=6 && (wuku=6))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_RAU))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_RAU);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Rau');
	    END IF;
	    
	    /*139. Kala Rebutan*/
	    IF( (saptawara=2 && (wuku=26))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_REBUTAN))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_REBUTAN);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Rebutan');
	    END IF;
	    
	    /*140. Kala Rumpuh*/
	    IF( (saptawara=1 && (wuku=18 || wuku=30)) ||
	        (saptawara=2 && (wuku=9 || wuku=20)) ||
	        (saptawara=4 && (wuku=10 || wuku=19 || wuku=25 || wuku=26 || wuku=27)) ||
	        (saptawara=5 && (wuku=13 || wuku=14 || wuku=17 || wuku=22 || wuku=24)) ||
	        (saptawara=6 && (wuku=11 || wuku=12)) ||
	        (saptawara=7 && (wuku=21 || wuku=23 || wuku=28 || wuku=29))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_RUMPUH))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_RUMPUH);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Rumpuh');
	    END IF;
	    
	    /*141. Kala Sapuhau*/
	    IF( (saptawara=2 && (wuku=3)) ||
	        (saptawara=3 && (wuku=27)) ||
	        (saptawara=4 && (wuku=28)) ||
	        (saptawara=6 && (wuku=30))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SAPUHAU))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SAPUHAU);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Sapuhau');
	    END IF;
	    
	    /*142. Kala Sarang*/
	    IF(wuku=7 || wuku=17)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SARANG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SARANG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Sarang');
	    END IF;
	    
	    /*143. Kala Siyung*/
	    IF( (saptawara=1 && (wuku=2 || wuku=21)) ||
	        (saptawara=2 && (wuku=1 || wuku=10 || wuku=25)) ||
	        (saptawara=4 && (wuku=1 || wuku=20)) ||
	        (saptawara=5 && (wuku=24 || wuku=26)) ||
	        (saptawara=6 && (wuku=28)) ||
	        (saptawara=7 && (wuku=15 || wuku=17))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SIYUNG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SIYUNG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Siyung');
	    END IF;
	    
	    /*144. Kala Sor*/
	    IF( (saptawara=1 && (wuku=3 || wuku=9 || wuku=15 || wuku=21 || wuku=27)) ||
	        (saptawara=2 && (wuku=1 || wuku=2 || wuku=8 || wuku=6 ||
	                                      wuku=11 || wuku=14 || wuku=16 || wuku=20 ||
	                                      wuku=21 || wuku=26)) ||
	        (saptawara=3 && (wuku=9 || wuku=1 || wuku=4 || wuku=7 || wuku=13
	                                         || wuku=14 || wuku=24 || wuku=25 || wuku=29)) ||
	        (saptawara=4 && (wuku=3 || wuku=8 || wuku=12 || wuku=13
	                                      || wuku=18 || wuku=23 || wuku=24 || wuku=28 || wuku=30)) ||
	        (saptawara=5 && (wuku=5 || wuku=11 || wuku=17 || wuku=23 || wuku=29)) ||
	        (saptawara=6 && (wuku=10 || wuku=8 || wuku=3 || wuku=4 || wuku=13
	                                       || wuku=16 || wuku=18 || wuku=22 || wuku=23 || wuku=28)) ||
	        (saptawara=7 && (wuku=9 || wuku=3 || wuku=15 || wuku=21 || wuku=27))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SOR))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SOR);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Sor');
	    END IF;
	    
	    /*145. Kala Sudangastra*/
	    IF( (saptawara=1 && (wuku=24)) ||
	        (saptawara=3 && (wuku=28)) ||
	        (saptawara=4 && (wuku=2 || wuku=12)) ||
	        (saptawara=5 && (wuku=19)) ||
	        (saptawara=7 && (wuku=6))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SUDANGASTRA))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SUDANGASTRA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Sudangastra');
	    END IF;
	    
	    /*146. Kala Sudukan*/
	    IF( (saptawara=1 && (wuku=12)) ||
	        (saptawara=2 && (wuku=2 || wuku=3 || wuku=22 || wuku=25)) ||
	        (saptawara=3 && (wuku=6 || wuku=8 || wuku=27)) ||
	        (saptawara=4 && (wuku=1 || wuku=20)) ||
	        (saptawara=5 && (wuku=21)) ||
	        (saptawara=6 && (wuku=5 || wuku=24 || wuku=26)) ||
	        (saptawara=7 && (wuku=14 || wuku=15 || wuku=16 || wuku=17))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SUDUKAN))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SUDUKAN);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Sudukan');
	    END IF;
	    
	    /*147. Kala Sungsang*/
	    IF(wuku=27)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SUNGSANG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SUNGSANG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Sungsang');
	    END IF;
	    
	    /*148. Kala Susulan*/
	    IF(saptawara=2 && wuku=11)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SUNGSANG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SUNGSANG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Susulan');
	    END IF;
	    
	    /*149. Kala Suwung*/
	    IF(	(saptawara=2 && wuku=2) ||
	        (saptawara=3 && (wuku=8||wuku=10)) ||
	        (saptawara=4 && (wuku=5||wuku=6||wuku=16||wuku=19)) ||
	        (saptawara=7 && (wuku=11 || wuku=13 || wuku=14))
	    )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SUNGSANG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SUNGSANG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Suwung');
	    END IF;
	    
	    /*150. Kala Tampak*/
	    IF( (saptawara=1 && (wuku=5|| wuku=13|| wuku=21|| wuku=29)) ||
	        (saptawara=2 && (wuku=3 || wuku=11 || wuku=19 || wuku=27)) ||
	        (saptawara=3 && (wuku=8 || wuku=16 || wuku=24)) ||
	        (saptawara=4 && (wuku=1 || wuku=9|| wuku=17|| wuku=25)) ||
	        (saptawara=5 && (wuku=14|| wuku=22|| wuku=30)) ||
	        (saptawara=6 && (wuku=4 || wuku=12 || wuku=20|| wuku=28)) ||
	        (saptawara=7 && (wuku=7 || wuku=15 || wuku=23))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_TUMAPEL))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_TUMAPEL);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Tampak');
	    END IF;
	    
	    /*151. Kala Temah*/
	    IF( (saptawara=1 && (wuku=14 || wuku=15 || wuku=28 || wuku=29)) ||
	        (saptawara=2 && (wuku=1||wuku=2 || wuku=5|| wuku=7  || wuku=8 || wuku=9  || wuku=13
	                                      || wuku=16 || wuku=20 || wuku=23 
	                                      || wuku=30)) ||
	        (saptawara=3 && (wuku=3 || wuku=10 || wuku=12 || wuku=17 || wuku=19)) ||
	        (saptawara=4 && (wuku=4 || wuku=11)) ||
	        (saptawara=5 && (wuku=3 || wuku=5 || wuku=10 || wuku=12 || wuku=17
	                                          || wuku=19)) ||
	        (saptawara=6 && (wuku=3 || wuku=5 || wuku=9 || wuku=13 
					      || wuku=16 || wuku=20 || wuku=23 ||wuku=30)) ||
	        (saptawara=7 && (wuku=3 || wuku=14 || wuku=15 ||  wuku=29))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_TEMAH))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_TEMAH);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Temah');
	    END IF;
	    
	    /*152. Kala Timpang*/
	    IF(	(saptawara=3 && wuku=1) ||
		(saptawara=6 && wuku=14) ||
		(saptawara=7 && wuku=2)
	    )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SUNGSANG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SUNGSANG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Timpang');
	    END IF;
	    
	    /*153. Kala Tukaran*/
	    IF(saptawara=3 && (wuku=3||wuku=8))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SUNGSANG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SUNGSANG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Tukaran');
	    END IF;
	    
	    /*154. Kala Tumapel*/
	    IF(wuku=12 && (saptawara=3||saptawara=4))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SUNGSANG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SUNGSANG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Tumapel');
	    END IF;
	    
	    /*155. Kala Tumpar*/
	    IF((saptawara=3 && wuku=13) ||
		(saptawara=4 && wuku=8)
	    )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_SUNGSANG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_SUNGSANG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Tumpar');
	    END IF;
	    
	    /*156. Kala Upa*/
	    IF(sadwara=4 && triwara=1)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_UPA))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_UPA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Upa');
	    END IF;
	    
	    /*157. Kala Was*/
	    IF(saptawara=2 && wuku=17)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_WAS))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_WAS);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Was');
	    END IF;
	    
	    /*158. Kala Wikalpa*/
	    IF(	(saptawara=2 && (wuku=22||wuku=25)) ||
		(saptawara=6 && (wuku=27||wuku=30))
	    )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_WAS))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_WAS);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Wikalpa');
	    END IF;
	    
	    /*159. Kala Wisesa*/
	    IF( sadwara=5 && astawara=3)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_WISESA))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_WISESA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Wisesa');
	    END IF;
	    
	    /*160. Kala Wong*/
	    IF( saptawara=4 && wuku=20)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALA_WONG))
	            -- dewasa.add(DewasaAyu.DEWASA_KALA_WONG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kala Wong');
	    END IF;
	    
	    /*161. Kaleburau*/
	    IF( (saptawara=1 && (wuku=2 || wuku=3 || wuku=8
	                                        || wuku=14 || wuku=27 || wuku=30) ) ||
	        (saptawara=2 && (triwara=2 || h_tilem = 'Tilem')) ||
	        (saptawara=3 && (wuku=7 || wuku=13 || wuku=22 || wuku=25 || wuku=21) ) ||
	        (saptawara=4 && (wuku=17 || wuku=29 || wuku=21) ) ||
	        (saptawara=5 && (wuku=20) ) ||
	        (saptawara=6 && (wuku=6 || wuku=28) ) ||
	        (saptawara=7 && (wuku=18 || wuku=26) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KALEBURAU))
	            -- dewasa.add(DewasaAyu.DEWASA_KALEBURAU);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kaleburau');
	    END IF;
	    
	    /*162. Kamajaya*/
	    IF(saptawara=4 && ((pengalantaka='Penanggal' && (sasihDay1=2||sasihDay1=3||sasihDay1=7)) || (pengalantaka='Penanggal' && (sasihDay2=2||sasihDay2=3||sasihDay2=7)) ) )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KAMAJAYA))
	            -- dewasa.add(DewasaAyu.DEWASA_KAMAJAYA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Kamajaya');
	    END IF;
	    
	    /*163. Karna Sula*/
	    IF( (saptawara=1 && (sasihDay1=2 || sasihDay2=2)) ||
	        (saptawara=3 && (sasihDay1=9 || sasihDay2=9)) ||
	        (saptawara=7 && (h_purnama = 'Purnama'||h_tilem = 'Tilem'))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KARNASULA))
	            -- dewasa.add(DewasaAyu.DEWASA_KARNASULA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Karna Sula');
	    END IF;
	    
	    /*164. Karnasula*/
	    IF( (saptawara=2 && (wuku=1||wuku=4||wuku=7||wuku=9)) ||
	        (saptawara=3 && (wuku=13)) ||
	        (saptawara=4 && (wuku=11)) ||
	        (saptawara=5 && (wuku=8||wuku=11)) ||
	        (saptawara=6 && (wuku=3)) ||
	        (saptawara=7 && (wuku=5||wuku=10))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_KARNASULA))
	            -- dewasa.add(DewasaAyu.DEWASA_KARNASULA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Karnasula');
	    END IF;
	    
	    /*165. Lebur Awu*/
	    IF( (saptawara=1 && astawara=2) ||
	        (saptawara=2 && astawara=8) ||
	        (saptawara=3 && astawara=5) ||
	        (saptawara=4 && astawara=6) ||
	        (saptawara=5 && astawara=3) ||
	        (saptawara=6 && astawara=1) ||
	        (saptawara=7 && astawara=4)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_LEBUR_AWU))
	            -- dewasa.add(DewasaAyu.DEWASA_LEBUR_AWU);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Lebur Awu');
	    END IF;
	    
	    /*166. Lutung Magandong*/
	    IF(saptawara=5 && (wuku=3 || wuku=8 || wuku=13 || wuku=18
	                                        || wuku=23 || wuku=28))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_LUTUNG_MAGANDONG))
	            -- dewasa.add(DewasaAyu.DEWASA_LUTUNG_MAGANDONG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Lutung Magandong');
	    END IF;
	    
	    /*167. Macekan Agung*/
	    IF( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=12 ) || (pengalantaka='Penanggal' && sasihDay2=12)) ) ||
	        (saptawara=2 && ((pengalantaka='Penanggal' && sasihDay1=11 ) || (pengalantaka='Penanggal' && sasihDay2=11)) ) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=10 ) || (pengalantaka='Penanggal' && sasihDay2=10)) ) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && sasihDay1=9 ) || (pengalantaka='Penanggal' && sasihDay2=9)) ) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=8 ) || (pengalantaka='Penanggal' && sasihDay2=8)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && (sasihDay1=5||sasihDay1=7)) ||
	                                       (pengalantaka='Penanggal' && (sasihDay2=5||sasihDay2=7))) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=6 ) || (pengalantaka='Penanggal' && sasihDay2=6)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_MACEKAN_AGUNG))
	            -- dewasa.add(DewasaAyu.DEWASA_MACEKAN_AGUNG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Macekan Agung');
	    END IF;
	    
	    /*168. Macekan Lanang*/
	    IF( (saptawara=1 && ((pengalantaka='Penanggal' && (sasihDay1=2 || sasihDay1=12)) ||
	                                       (pengalantaka='Penanggal' && (sasihDay2=2 || sasihDay2=12))) ) ||
	        (saptawara=2 && ((pengalantaka='Penanggal' && (sasihDay1=1 || sasihDay1=11)) ||
	                                       (pengalantaka='Penanggal' && (sasihDay2=1 || sasihDay2=11))) ) ||
	        (saptawara=3 && ((pengalantaka='Penanggal' && (sasihDay1=11 || sasihDay1=9)) ||
	                                       (pengalantaka='Penanggal' && (sasihDay2=11 || sasihDay2=9))) ) ||
	        (saptawara=4 && ((pengalantaka='Penanggal' && sasihDay1=9 ) || (pengalantaka='Penanggal' && sasihDay2=9)) ) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=8 ) || (pengalantaka='Penanggal' && sasihDay2=8)) ) ||
	        (saptawara=6 && ((pengalantaka='Penanggal' && (sasihDay1=5 || sasihDay1=7)) ||
	                                       (pengalantaka='Penanggal' && (sasihDay2=5 || sasihDay2=7))) ) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=6 ) || (pengalantaka='Penanggal' && sasihDay2=6)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_MACEKAN_LANANG))
	            -- dewasa.add(DewasaAyu.DEWASA_MACEKAN_LANANG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Macekan Lanang');
	    END IF;
	    
	    /*169. Macekan Wadon*/
	    IF( (saptawara=1 && ((pengalantaka='Pangelong' && sasihDay1=5 ) || (pengalantaka='Pangelong' && sasihDay2=5)) ) ||
	        (saptawara=2 && ((pengalantaka='Pangelong' && sasihDay1=11 ) || (pengalantaka='Pangelong' && sasihDay2=11)) ) ||
	        (saptawara=3 && ((pengalantaka='Pangelong' && sasihDay1=10 ) || (pengalantaka='Pangelong' && sasihDay2=10)) ) ||
	        (saptawara=4 && ((pengalantaka='Pangelong' && sasihDay1=9 ) || (pengalantaka='Pangelong' && sasihDay2=9)) ) ||
	        (saptawara=5 && ((pengalantaka='Pangelong' && sasihDay1=8 ) || (pengalantaka='Pangelong' && sasihDay2=8)) ) ||
	        (saptawara=7 && ((pengalantaka='Pangelong' && sasihDay1=13 ) || (pengalantaka='Pangelong' && sasihDay2=13)) )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_MACEKAN_WADON))
	            -- dewasa.add(DewasaAyu.DEWASA_MACEKAN_WADON);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Macekan Wadon');
	    END IF;
	    
	    /*170. MertaSula*/
	    IF(saptawara=5 && (sasihDay1=7||sasihDay2=7))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_MERTA_SULA))
	            -- dewasa.add(DewasaAyu.DEWASA_MERTA_SULA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Merta Sula');
	    END IF;
	    
	    /*171. Naga Naut*/
	    IF((sasihDay1=no_sasih)||(sasihDay2=no_sasih))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_MERTA_SULA))
	            -- dewasa.add(DewasaAyu.DEWASA_MERTA_SULA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Naga Naut');
	    END IF;
	
	    /*172. Pemacekan*/
	    IF( (saptawara=1 && (sasihDay1=12||sasihDay2=12 || sasihDay1=15||sasihDay2=15)) ||
	        (saptawara=2 && (sasihDay1=11||sasihDay2=11 || sasihDay1=15||sasihDay2=15)) ||
	        (saptawara=3 && (sasihDay1=10||sasihDay2=10 || sasihDay1=15||sasihDay2=15)) ||
	        (saptawara=4 && (sasihDay1=9||sasihDay2=9 || sasihDay1=15||sasihDay2=15)) ||
	        (saptawara=5 && (sasihDay1=8||sasihDay2=8 || sasihDay1=15||sasihDay2=15)) ||
	        (saptawara=6 && (sasihDay1=7||sasihDay2=7 || sasihDay1=15||sasihDay2=15)) ||
	        (saptawara=7 && (sasihDay1=6||sasihDay2=6 || sasihDay1=15||sasihDay2=15))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PAMACEKAN))
	            -- dewasa.add(DewasaAyu.DEWASA_PAMACEKAN);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Pamacekan');
	    END IF;
	    
	    /*173. Panca Amerta*/
	    IF(saptawara=4 && pancawara=2 && ((pengalantaka='Penanggal' && sasihDay1=5) || (pengalantaka='Penanggal' && sasihDay2=5)) )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PANCA_MERTA))
	            -- dewasa.add(DewasaAyu.DEWASA_PANCA_MERTA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Panca Amerta');
	    END IF;
	    
	    /*174. Panca Prawani*/
	    IF(sasihDay1=4||sasihDay1=8||sasihDay1=12||sasihDay2=4||sasihDay2=8||sasihDay2=12)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PANCA_MERTA))
	            -- dewasa.add(DewasaAyu.DEWASA_PANCA_MERTA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Panca Prawani');
	    END IF;
	    
	    /*175. Panca Wedhi*/
	    IF(saptawara=2 && pancawara=2 && ((pengalantaka='Penanggal' && sasihDay1=5) || (pengalantaka='Penanggal' && sasihDay2=5)) )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PANCA_WERDHI))
	            -- dewasa.add(DewasaAyu.DEWASA_PANCA_WERDHI);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Panca Werdhi');
	    END IF;
	    
	    /*176. Pati Paten*/
	    IF( (saptawara=6 && ( (sasihDay1=10||sasihDay2=10) || h_tilem = 'Tilem') )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PATIPATA))
	            -- dewasa.add(DewasaAyu.DEWASA_PATIPATA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Pati Paten');
	    END IF;
	    
	    /*177. Patra Limutan*/
	    IF(triwara=3 && h_tilem = 'Tilem')THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PATRA_LIMUTAN))
	            -- dewasa.add(DewasaAyu.DEWASA_PATRA_LIMUTAN);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Patra Limutan');
	    END IF;
	    
	    /*178. Pepedan*/
	    IF((saptawara=1 && (wuku=5||wuku=9||wuku=10||wuku=11||wuku=15||wuku=20||wuku=21||wuku=23
				||wuku=25||wuku=26||wuku=27||wuku=28||wuku=30||wuku=22)) ||
	        (saptawara=2 && (wuku=8||wuku=14||wuku=17||wuku=18||wuku=21||wuku=22||wuku=24||wuku=25
				||wuku=26||wuku=27||wuku=29)) ||
	        (saptawara=3 && (wuku=1||wuku=3||wuku=5||wuku=7||wuku=10||wuku=11||wuku=13||wuku=14
				||wuku=17||wuku=18||wuku=19||wuku=20||wuku=22||wuku=23||wuku=24||wuku=25||wuku=26||wuku=27||wuku=29||wuku=30)) ||
	        (saptawara=4 && (wuku=4||wuku=5||wuku=6||wuku=7||wuku=8||wuku=9||wuku=11||wuku=12||wuku=15||wuku=16||wuku=18||wuku=23||wuku=24
				||wuku=27||wuku=28||wuku=30)) ||
	        (saptawara=5 && (wuku=1||wuku=3||wuku=4||wuku=7||wuku=8||wuku=9||wuku=11||wuku=14||wuku=19||wuku=21||wuku=23||wuku=24||wuku=29)) ||
	        (saptawara=6 && (wuku=2||wuku=4||wuku=14||wuku=16||wuku=19||wuku=20||wuku=21||wuku=23||wuku=24||wuku=25||wuku=27||wuku=29)) ||
	        (saptawara=7 && (wuku=2||wuku=3||wuku=7||wuku=9||wuku=10||wuku=11||wuku=13||wuku=23||wuku=24||wuku=25||wuku=27||wuku=29||wuku=30))
	    )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PATRA_LIMUTAN))
	            -- dewasa.add(DewasaAyu.DEWASA_PATRA_LIMUTAN);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Pepedan');
	    END IF;
	    
	    /*179. Prabu Pendah*/
	    IF( saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=14 ) || (pengalantaka='Penanggal' && sasihDay2=14))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PRABU_PENDAH))
	            -- dewasa.add(DewasaAyu.DEWASA_PRABU_PENDAH);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Prabu Pendah');
	    END IF;
	    
	    /*180. Prangewa*/
	    IF( saptawara=3 && ((pengalantaka='Penanggal' && sasihDay1=1 ) || (pengalantaka='Penanggal' && sasihDay2=1))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PRANGEWA))
	            -- dewasa.add(DewasaAyu.DEWASA_PRANGEWA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Prangewa');
	    END IF;
	    
	    /*181. Purnama Danta*/
	    IF( (saptawara=4 && pancawara=5 && h_purnama = 'Purnama')
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PURNA_SUKA))
	            -- dewasa.add(DewasaAyu.DEWASA_PURNA_SUKA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Purna Danta');
	    END IF;
	    
	    /*182. Purna Suka*/
	    IF( (saptawara=6 && pancawara=1 && h_purnama = 'Purnama')
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PURNA_SUKA))
	            -- dewasa.add(DewasaAyu.DEWASA_PURNA_SUKA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Purna Suka');
	    END IF;
	    
	    /*183. Purwani*/
	    IF( sasihDay1=14||sasihDay2=14
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PURNA_SUKA))
	            -- dewasa.add(DewasaAyu.DEWASA_PURNA_SUKA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Purwani');
	    END IF;
	    
	    /*184. Purwanin Dina*/
	    IF( (saptawara=2 && pancawara=4) ||
	        (saptawara=3 && pancawara=5) ||
	        (saptawara=4 && pancawara=5) ||
	        (saptawara=6 && pancawara=4) ||
	        (saptawara=7 && pancawara=5)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_PURWANIN_DINA))
	            -- dewasa.add(DewasaAyu.DEWASA_PURWANIN_DINA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Purwanin Dina');
	    END IF;
	    
	    /*185. Rangda Tiga*/
	    IF(wuku=7 || wuku=8 || wuku=15 || wuku=16 || wuku=23 || wuku=24)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_RANGDA_TIGA))
	            -- dewasa.add(DewasaAyu.DEWASA_RANGDA_TIGA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Rangda Tiga');
	    END IF;
	    
	    /*186. Rarung Pagelangan*/
	    IF( saptawara=5 && (sasihDay1=6 || sasihDay2=6)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_RARUNG_PAGELANGAN))
	            -- dewasa.add(DewasaAyu.DEWASA_RARUNG_PAGELANGAN);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Rarung Pagelangan');
	    END IF;
	    
	    /*187. Ratu Magelung*/
	    IF( saptawara=4 && wuku=23
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_RATU_MAGELUNG))
	            -- dewasa.add(DewasaAyu.DEWASA_RATU_MAGELUNG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Ratu Magelung');
	    END IF;
	    
	    /*188. Ratu Mangure*/
	    IF( saptawara=5 && wuku=20 )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_RATU_MANGURE))
	            -- dewasa.add(DewasaAyu.DEWASA_RATU_MANGURE);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Ratu Mangure');
	    END IF;
	    
	    /*189. Ratu Megambahan*/
	    IF( saptawara=7 && ((pengalantaka='Pangelong' && sasihDay1=6 ) || (pengalantaka='Pangelong' && sasihDay2=6))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_RATU_MEGAMBAHAN))
	            -- dewasa.add(DewasaAyu.DEWASA_RATU_MEGAMBAHAN);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Ratu Megambahan');
	    END IF;
	    
	    /*190. Ratu Nanyingal*/
	    IF( saptawara=5 && wuku=21 )THEN
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Ratu Nanyingal');
	    END IF;
	    
	    /*191. Ratu Ngemban Putra*/
	    IF( saptawara=6 && ((pengalantaka='Penanggal' && sasihDay1=5 ) || (pengalantaka='Penanggal' && sasihDay2=5))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_RATU_NGEMBAN_PUTRA))
	            -- dewasa.add(DewasaAyu.DEWASA_RATU_NGEMBAN_PUTRA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Ratu Ngemban Putra');
	    END IF;
	    
	    /*192. Rekatadala Ayudana*/
	    IF( saptawara=1 && (sasihDay1=1 || sasihDay1=6 || sasihDay1=11 || sasihDay1=2 || sasihDay2=6 || sasihDay2=11)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_REKADATALA_AYUDANA))
	            -- dewasa.add(DewasaAyu.DEWASA_REKADATALA_AYUDANA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Rekatadala Ayudana');
	    END IF;
	    
	    /*193. Salah Wadi*/
	    IF(wuku=1 || wuku=2 || wuku=6 || wuku=10 || wuku=11 || wuku=16
	       || wuku=19 || wuku=20 || wuku=24 || wuku=25 || wuku=27 || wuku=30)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SALAH_WADI))
	            -- dewasa.add(DewasaAyu.DEWASA_SALAH_WADI);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Salah Wadi');
	    END IF;
	    
	    /*194. Sampar Wangke*/
	    IF(saptawara=2 && sadwara=2)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SAMPAR_WANGKE))
	            -- dewasa.add(DewasaAyu.DEWASA_SAMPAR_WANGKE);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Sampar Wangke');
	    END IF;
	    
	    /*195. Sampi Gumarang Munggah*/
	    IF(pancawara=3&& sadwara=4)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SAMPI_GUMARANG_MUNGGAH))
	            -- dewasa.add(DewasaAyu.DEWASA_SAMPI_GUMARANG_MUNGGAH);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Sampi Gumarang Munggah');
	    END IF;
	    
	    /*196. Sampi Gumarang Turun*/
	    IF(pancawara=3 && sadwara=1)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SAMPI_GUMARANG_TURUN))
	            -- dewasa.add(DewasaAyu.DEWASA_SAMPI_GUMARANG_TURUN);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Sampi Gumarang Turun');
	    END IF;
	    
	    /*197. Sarik Agung*/
	    IF(saptawara=4 && (wuku=25 || wuku=4 || wuku=11 || wuku=18))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SARIK_AGUNG))
	            -- dewasa.add(DewasaAyu.DEWASA_SARIK_AGUNG);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Sarik Agung');
	    END IF;
	    
	    /*198. Sarik Ketah*/
	    IF( (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=4 ) || (pengalantaka='Penanggal' && sasihDay2=4))) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=5 ) || (pengalantaka='Penanggal' && sasihDay2=5)))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SARIK_KETAH))
	            -- dewasa.add(DewasaAyu.DEWASA_SARIK_KETAH);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Sarik Ketah');
	    END IF;
	    
	    /*199. Sedana Tiba*/
	    IF( (saptawara=5 && pancawara=4 && ((pengalantaka='Penanggal' && sasihDay1=7 ) || (pengalantaka='Penanggal' && sasihDay2=7)))
	        
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SARIK_KETAH))
	            -- dewasa.add(DewasaAyu.DEWASA_SARIK_KETAH);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Sedana Tiba');
	    END IF;
	    
	    /*200. Sedana Yoga*/
	    IF( (saptawara=1 && (sasihDay1=8||sasihDay2=8 || sasihDay1=15||sasihDay2=15)) ||
	        (saptawara=2 && (sasihDay1=3||sasihDay2=3)) ||
	        (saptawara=3 && (sasihDay1=7||sasihDay2=7)) ||
	        (saptawara=4 && (sasihDay1=2||sasihDay2=2 || sasihDay1=3||sasihDay2=3)) ||
	        (saptawara=5 && (sasihDay1=4||sasihDay2=4 || sasihDay1=5||sasihDay2=5 || sasihDay1=15||sasihDay2=15)) ||
	        (saptawara=6 && (sasihDay1=1||sasihDay2=1 || sasihDay1=6||sasihDay2=6)) ||
	        (saptawara=7 && (sasihDay1=5||sasihDay2=5 || sasihDay1=15||sasihDay2=15))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SARIK_KETAH))
	            -- dewasa.add(DewasaAyu.DEWASA_SARIK_KETAH);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Sedana Yoga');
	    END IF;
	    
	    /*201. Semut Sadulur*/
	    IF( (saptawara=6 && pancawara=3) ||
	        (saptawara=7 && pancawara=4) ||
	        (saptawara=1 && pancawara=5)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SEMUT_SADULUR))
	            -- dewasa.add(DewasaAyu.DEWASA_SEMUT_SADULUR);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Semut Sadulur');
	    END IF;
	    
	    /*202. Siwa Sampurna*/
	    IF( (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=4 ) || (pengalantaka='Penanggal' && sasihDay2=4))) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=5 ) || (pengalantaka='Penanggal' && sasihDay2=5))) ||
	        (saptawara=5 && ((pengalantaka='Penanggal' && sasihDay1=10 ) || (pengalantaka='Penanggal' && sasihDay2=10)))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SIWA_SAMPURNA))
	            -- dewasa.add(DewasaAyu.DEWASA_SIWA_SAMPURNA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Siwa Sampurna');
	    END IF;
	    
	    /*203. Sri Bagia*/
	    IF( (saptawara=2 && (wuku=6||wuku=15||wuku=21)) ||
	        (saptawara=4 && wuku=4) ||
	        (saptawara=7 && (wuku=1||wuku=25))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SEMUT_SADULUR))
	            -- dewasa.add(DewasaAyu.DEWASA_SEMUT_SADULUR);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Sri Bagia');
	    END IF;
	    
	    /*204. Sri Murti*/
	    IF(sadwara=5 && astawara=1)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SRIMURTI))
	            -- dewasa.add(DewasaAyu.DEWASA_SRIMURTI);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Sri Murti');
	    END IF;
	    
	    /*205. Sri Tumpuk*/
	    IF(astawara=1)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SRIMURTI))
	            -- dewasa.add(DewasaAyu.DEWASA_SRIMURTI);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Sri Tumpuk');
	    END IF;
	    
	    /*206. Srigati*/
	    IF(	(triwara=3 && pancawara=1 && sadwara=3)||
		(triwara=3 && pancawara=1 && sadwara=6)
	    )THEN
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Srigati');
	    END IF;
	    
	    /*207. Srigati Jenek*/
	    IF( pancawara=5 && sadwara=6)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SRIGATI_JENEK))
	            -- dewasa.add(DewasaAyu.DEWASA_SRIGATI_JENEK);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Srigati Jenek');
	    END IF;
	    
	    /*208. Srigati Munggah*/
	    IF(pancawara=1 && sadwara=3)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SRIGATI_MUNGGAH))
	            -- dewasa.add(DewasaAyu.DEWASA_SRIGATI_MUNGGAH);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Srigati Munggah');
	    END IF;
	    
	    /*209. Srigati Turun*/
	    IF(pancawara=1 && sadwara=6)THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SRIGATI_TURUN))
	            -- dewasa.add(DewasaAyu.DEWASA_SRIGATI_TURUN);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Srigati Turun');
	    END IF;
	    
	    /*210. Subhacara*/
	    IF( (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=3 ) || (pengalantaka='Penanggal' && sasihDay2=3))) ||
	        (saptawara=1 && ((pengalantaka='Penanggal' && sasihDay1=15 ) || (pengalantaka='Penanggal' && sasihDay2=15))) ||
	        (saptawara=2 && pengalantaka='Penanggal' && (sasihDay1=3||sasihDay2=3)) ||
	        (saptawara=3 && pengalantaka='Penanggal' && (sasihDay1=2|| sasihDay2=2||
					sasihDay1=7||sasihDay2=7 || 
					sasihDay1=8||sasihDay2=8) ) ||
	        (saptawara=4 && pengalantaka='Penanggal' && (sasihDay1=2||sasihDay2=2 || sasihDay1=3||sasihDay2=3 ||
	                                      sasihDay1=6||sasihDay2=6 )) ||
	        (saptawara=5 && pengalantaka='Penanggal' && (sasihDay1=5||sasihDay2=5 || sasihDay1=6||sasihDay2=6)) ||
	        (saptawara=6 && pengalantaka='Penanggal' && (sasihDay1=1||sasihDay2=1 ||
					      sasihDay1=2||sasihDay2=2 || sasihDay1=3||sasihDay2=3)) ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=4 ) || (pengalantaka='Penanggal' && sasihDay2=4)))  ||
	        (saptawara=7 && ((pengalantaka='Penanggal' && sasihDay1=5 ) || (pengalantaka='Penanggal' && sasihDay2=5)))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SUBHA_CARA))
	            -- dewasa.add(DewasaAyu.DEWASA_SUBHA_CARA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Subhacara');
	    END IF;
	    
	    /*211. Swarga Menga*/
	    IF( (saptawara=3 && pancawara=3 && wuku=3
	            && ((pengalantaka='Penanggal' && sasihDay1=11 ) || (pengalantaka='Penanggal' && sasihDay2=11))) ||
	        (saptawara=5 && pancawara=2 && wuku=4)
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_SWARGA_MENGA))
	            -- dewasa.add(DewasaAyu.DEWASA_SWARGA_MENGA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Swarga Menga');
	    END IF;
	    
	    /*212. Taliwangke*/
	    IF( (saptawara=2 && (wuku=22 || wuku=23 || wuku=24|| wuku=25|| wuku=26) ) ||
	        (saptawara=3 && (wuku=1 || wuku=27 || wuku=28|| wuku=29|| wuku=30)) ||
	        (saptawara=4 && (wuku=2 || wuku=3 || wuku=4|| wuku=6)) ||
	        (saptawara=5 && (wuku=7 || wuku=8 || wuku=9|| wuku=10|| wuku=11|| wuku=17|| wuku=18|| wuku=20|| wuku=21)) ||
	        (saptawara=6 && (wuku=12|| wuku=13 || wuku=14|| wuku=15|| wuku=16)) 
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_TALI_WANGKE))
	            -- dewasa.add(DewasaAyu.DEWASA_TALI_WANGKE);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Taliwangke');
	    END IF;
	    
	    /*213. Titibuwuk*/
	    IF( (saptawara=1 && (wuku=18 || wuku=26 || wuku=27 || wuku=28 || wuku=30)) ||
		(saptawara=2 && (wuku=8 || wuku=9 || wuku=20)) ||
	        (saptawara=3 && (wuku=7 || wuku=21 || wuku=1)) ||
	        (saptawara=4 && (wuku=4 || wuku=5 || wuku=10 || wuku=15 || wuku=19
	                                      || wuku=25 || wuku=2) ) ||
	        (saptawara=5 && (wuku=6 || wuku=13 || wuku=17 || wuku=22 || wuku=24) ) ||
	        (saptawara=6 && (wuku=3 || wuku=12)) ||
	        (saptawara=7 && (wuku=16 || wuku=21 || wuku=23 || wuku=29))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_TITI_BUWUK))
	            -- dewasa.add(DewasaAyu.DEWASA_TITI_BUWUK);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Titibuwuk');
	    END IF;
	    
	     /*214. Tunut Masih*/
	    IF( (saptawara=1 && wuku=18) ||
	        (saptawara=2 && (wuku=12 || wuku=13|| wuku=27)) ||
	        (saptawara=3 && (wuku=17 || wuku=24)) ||
	        (saptawara=5 && (wuku=1) ) ||
	        (saptawara=6 && (wuku=19 || wuku=22))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_TUTUT_MASIH))
	            -- dewasa.add(DewasaAyu.DEWASA_TUTUT_MASIH);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Tunut Masih');
	    END IF;
	    
	    /*215. Tutur Mandi*/
	    IF( (saptawara=1 && wuku=26) ||
	        (saptawara=5 && (wuku=3||wuku=9||wuku=15||wuku=20||wuku=21||wuku=24) ) ||
	        (saptawara=6 && (wuku=2))||
	        (saptawara=7 && (wuku=24))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_TUTUR_MANDI))
	            -- dewasa.add(DewasaAyu.DEWASA_TUTUR_MANDI);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Tutur Mandi');
	    END IF;
	    
	    
	    /*216. Uncal Balung*/
	    IF( (wuku=12)|| (wuku=13)|| ((wuku=14&& saptawara=1) ||
		(wuku=16 &&(saptawara<5))
	    )
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_UPADANA_MERTA))
	            -- dewasa.add(DewasaAyu.DEWASA_UPADANA_MERTA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Uncal Balung');
	    END IF;
	     
	    /*217. Upadana Merta*/
	    IF( saptawara=1 && ((pengalantaka='Penanggal' && (sasihDay1=1 || sasihDay1=8 || sasihDay1=6 || sasihDay1=10)) ||
	                                       (pengalantaka='Penanggal' && (sasihDay2=1 || sasihDay2=8 || sasihDay2=6 || sasihDay2=10)))
	      )THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_UPADANA_MERTA))
	            -- dewasa.add(DewasaAyu.DEWASA_UPADANA_MERTA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Upadana Merta');
	    END IF;
	    
	    /*218. Werdi Suka*/
	    IF(saptawara=4 && pancawara=4 && ((pengalantaka='Penanggal' && sasihDay1=10) || (pengalantaka='Penanggal' && sasihDay2=10))
	        && (no_sasih=1))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_WERDHI_GUNA))
	            -- dewasa.add(DewasaAyu.DEWASA_WERDHI_GUNA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Werdi Suka');
	    END IF;
	    
	    /*219. Wisesa*/
	    IF(saptawara=4 && pancawara=2 && ((pengalantaka='Penanggal' && sasihDay1=13) || (pengalantaka='Penanggal' && sasihDay2=13))
	        && (no_sasih=1))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_WERDHI_GUNA))
	            -- dewasa.add(DewasaAyu.DEWASA_WERDHI_GUNA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Wisesa');
	    END IF;
	    
	    /*220. Wredhi Guna*/
	    IF(saptawara=4 && pancawara=4 && ((pengalantaka='Penanggal' && sasihDay1=5) || (pengalantaka='Penanggal' && sasihDay2=5))
	        && (no_sasih=1))THEN
	        -- if(!dewasa.contains(DewasaAyu.DEWASA_WERDHI_GUNA))
	            -- dewasa.add(DewasaAyu.DEWASA_WERDHI_GUNA);
                SET dewasaAyu = CONCAT(dewasaAyu, ', ','Wredhi Guna');
	    END IF;
	    
	    RETURN dewasaAyu;
    END */$$
DELIMITER ;

/* Function  structure for function  `20_pengarasan` */

/*!50003 DROP FUNCTION IF EXISTS `20_pengarasan` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `20_pengarasan`(urip_panca int, urip_sapta int) RETURNS varchar(20) CHARSET latin1
BEGIN
	declare pangarasan int;
	DECLARE cekPangarasan INT;
	declare h_pangarasan varchar(20);
	SET pangarasan = (urip_sapta + urip_panca);
	SET cekPangarasan = pangarasan MOD 10;
	IF cekPangarasan = 0 THEN
		SET h_pangarasan = 'Laku Pandita Sakti';
	ELSEIF cekPangarasan = 1 THEN
		SET h_pangarasan = 'Aras Tuding';
	ELSEIF cekPangarasan = 2 THEN
		SET h_pangarasan = 'Aras Kembang';
	ELSEIF cekPangarasan = 3 THEN
		SET h_pangarasan = 'Laku Bintang';
	ELSEIF cekPangarasan = 4 THEN
		SET h_pangarasan = 'Laku Bulan';
	ELSEIF cekPangarasan = 5 THEN
		SET h_pangarasan = 'Laku Surya';
	ELSEIF cekPangarasan = 6 THEN
		SET h_pangarasan = 'Laku Air/Toya';
	ELSEIF cekPangarasan = 7 THEN
		SET h_pangarasan = 'Laku Bumi';
	ELSEIF cekPangarasan = 8 THEN
		SET h_pangarasan = 'Laku Api';
	ELSEIF cekPangarasan = 9 THEN
		SET h_pangarasan = 'Laku Angin';			
	END IF;
	
	return h_pangarasan;
    END */$$
DELIMITER ;

/* Function  structure for function  `21_getRakam` */

/*!50003 DROP FUNCTION IF EXISTS `21_getRakam` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `21_getRakam`(pancawara INT, saptawara INT) RETURNS varchar(20) CHARSET latin1
BEGIN
	declare urip_panca_rakam int;
	DECLARE urip_sapta_rakam INT;
	declare rakam int;
	declare h_rakam varchar(20);
	
	if pancawara =1 then
		set urip_panca_rakam=2;
	elseif pancawara =2 THEN
		SET urip_panca_rakam=3;
	ELSEIF pancawara =3 THEN
		SET urip_panca_rakam=4;
	ELSEIF pancawara =4 THEN
		SET urip_panca_rakam=5;
	ELSEIF pancawara =5 THEN
		SET urip_panca_rakam=1;
	end if;
	
	if saptawara =1 then
		set urip_sapta_rakam=3;
	elseif saptawara =2 THEN
		set urip_sapta_rakam=4;
	ELSEIF saptawara =3 THEN
		set urip_sapta_rakam=5;
	ELSEIF saptawara =4 THEN
		set urip_sapta_rakam=6;
	ELSEIF saptawara =5 THEN
		SET urip_sapta_rakam=7;
	ELSEIF saptawara =6 THEN
		SET urip_sapta_rakam=1;
	ELSEIF saptawara =7 THEN
		SET urip_sapta_rakam=2;
	end if;
	
	set rakam=(urip_panca_rakam+urip_sapta_rakam) mod 6;
	
	IF rakam = 0 THEN
		SET h_rakam = 'Pati';
	ELSEIF rakam = 1 THEN
		SET h_rakam = 'Kala Tinantang';
	ELSEIF rakam = 2 THEN
		SET h_rakam = 'Demang Kandhuruwan';
	ELSEIF rakam = 3 THEN
		SET h_rakam = 'Sanggar Waringin';
	ELSEIF rakam = 4 THEN
		SET h_rakam = 'Mantri Sinaroja';
	ELSEIF rakam = 5 THEN
		SET h_rakam = 'Macan Katawan';
	END IF;
	
	return h_rakam;
    END */$$
DELIMITER ;

/* Function  structure for function  `26_zodiak` */

/*!50003 DROP FUNCTION IF EXISTS `26_zodiak` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `26_zodiak`(tanggal date) RETURNS varchar(20) CHARSET latin1
BEGIN
	declare bln int;
	declare tgl int;
	declare zodiak varchar(20);
	
	set bln=month(tanggal);
	set tgl=day(tanggal);
	IF bln = 1 THEN
		IF tgl <= 20 THEN
			SET zodiak = 'CAPRICORN';
		ELSE
			SET zodiak = 'AQUARIUS';
		END IF;
	ELSEIF bln = 2 THEN
		IF tgl <= 19 THEN
			SET zodiak = 'AQUARIUS';
		ELSE
			SET zodiak = 'PISCES';
		END IF;
	ELSEIF bln = 3 THEN
		IF tgl <= 20 THEN
			SET zodiak = 'PISCES';
		ELSE
			SET zodiak = 'ARIES';
		END IF;
	ELSEIF bln = 4 THEN
		IF tgl <= 19 THEN
			SET zodiak = 'ARIES';
		ELSE
			SET zodiak = 'TAURUS';
		END IF;
	ELSEIF bln = 5 THEN
		IF tgl <= 20 THEN
			SET zodiak = 'TAURUS';
		ELSE
			SET zodiak = 'GEMINI';
		END IF;
	ELSEIF bln = 6 THEN
		IF tgl <= 20 THEN
			SET zodiak = 'GEMINI';
		ELSE
			SET zodiak = 'CANCER';
		END IF;
	ELSEIF bln = 7 THEN
		IF tgl <= 21 THEN
			SET zodiak = 'CANCER';
		ELSE
			SET zodiak = 'LEO';
		END IF;
	ELSEIF bln = 8 THEN
		IF tgl <= 21 THEN
			SET zodiak = 'LEO';
		ELSE
			SET zodiak = 'VIRGO';
		END IF;
	ELSEIF bln = 9 THEN
		IF tgl <= 21 THEN
			SET zodiak = 'VIRGO';
		ELSE
			SET zodiak = 'LIBRA';
		END IF;
	ELSEIF bln = 10 THEN
		IF tgl <= 21 THEN
			SET zodiak = 'LIBRA';
		ELSE
			SET zodiak = 'SCORPIO';
		END IF;
	ELSEIF bln = 11 THEN
		IF tgl <= 20 THEN
			SET zodiak = 'SCORPIO';
		ELSE
			SET zodiak = 'SAGITARIUS';
		END IF;
	ELSEIF bln = 12 THEN
		IF tgl <= 21 THEN
			SET zodiak = 'SAGITARIUS';
		ELSE
			SET zodiak = 'CAPRICORN';
		END IF;
	END IF;
	return zodiak;
    END */$$
DELIMITER ;

/* Function  structure for function  `2_getNamaWuku` */

/*!50003 DROP FUNCTION IF EXISTS `2_getNamaWuku` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `2_getNamaWuku`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	declare nama varchar(10);
	if i=1 then
		set nama='Sinta';
	elseif i=2 then 
		SET nama='Landep';
	ELSEIF i=3 THEN 
		SET nama='Ukir';
	ELSEIF i=4 THEN 
		SET nama='Kulantir';
	ELSEIF i=5 THEN 
		SET nama='Tolu';
	ELSEIF i=6 THEN 
		SET nama='Gumbreg';
	ELSEIF i=7 THEN 
		SET nama='Wariga';
	ELSEIF i=8 THEN
		SET nama='Warigadean';
	ELSEIF i=9 THEN 
		SET nama='Julungwangi';
	ELSEIF i=10 THEN 
		SET nama='Sungsang';
	ELSEIF i=11 THEN 
		SET nama='Dungulan';
	ELSEIF i=12 THEN 
		SET nama='Kuningan';
	ELSEIF i=13 THEN 
		SET nama='Langkir';
	ELSEIF i=14 THEN 
		SET nama='Medangsia';
	ELSEIF i=15 THEN 
		SET nama='Pujut';
	ELSEIF i=16 THEN 
		SET nama='Pahang';
	ELSEIF i=17 THEN 
		SET nama='Krulut';
	ELSEIF i=18 THEN 
		SET nama='Mrakih';
	ELSEIF i=19 THEN 
		SET nama='Tambir';
	ELSEIF i=20 THEN 
		SET nama='Medangkungan';
	ELSEIF i=21 THEN 
		SET nama='Matal';
	ELSEIF i=22 THEN 
		SET nama='Uye';
	ELSEIF i=23 THEN 
		SET nama='Menail';
	ELSEIF i=24 THEN 
		SET nama='Prangbakat';
	ELSEIF i=25 THEN 
		SET nama='Bala';
	ELSEIF i=26 THEN 
		SET nama='Ugu';
	ELSEIF i=27 THEN 
		SET nama='Wayang';
	ELSEIF i=28 THEN 
		SET nama='Klawu';
	ELSEIF i=29 THEN 
		SET nama='Dukut';
	ELSEIF i=30 THEN 
		SET nama='Watugunung';
	end if;
	return nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `2_getWuku` */

/*!50003 DROP FUNCTION IF EXISTS `2_getWuku` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `2_getWuku`(noWuku int) RETURNS int(11)
BEGIN
	declare wuku int(11);
	
	set wuku=ceil(noWuku/7);
	return wuku;
    END */$$
DELIMITER ;

/* Function  structure for function  `3_getNamaSaptaWara` */

/*!50003 DROP FUNCTION IF EXISTS `3_getNamaSaptaWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `3_getNamaSaptaWara`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE nama VARCHAR(10);
	IF i=1 THEN
		SET nama='Redite';
	ELSEIF i=2 THEN 
		SET nama='Soma';
	ELSEIF i=3 THEN 
		SET nama='Anggara';
	ELSEIF i=4 THEN 
		SET nama='Budha';
	ELSEIF i=5 THEN 
		SET nama='Wrespati';
	ELSEIF i=6 THEN 
		SET nama='Sukra';
	ELSEIF i=7 THEN 
		SET nama='Saniscara';
	END IF;
	RETURN nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `3_getSaptawara` */

/*!50003 DROP FUNCTION IF EXISTS `3_getSaptawara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `3_getSaptawara`(tanggal date) RETURNS int(11)
BEGIN
	/*DAY OF WEEK
	| 1. Redite
	| 2. Soma
	| 3. Anggara
	| dst*/
	return dayofweek(tanggal);
    END */$$
DELIMITER ;

/* Function  structure for function  `3_getUripSaptaWara` */

/*!50003 DROP FUNCTION IF EXISTS `3_getUripSaptaWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `3_getUripSaptaWara`(saptaWara int) RETURNS int(11)
BEGIN
	declare urip int;
	if saptaWara=1 then
		set urip=5;
	elseif saptaWara=2 THEN
		SET urip=4;
	ELSEIF saptaWara=3 THEN
		SET urip=3;
	ELSEIF saptaWara=4 THEN
		SET urip=7;
	ELSEIF saptaWara=5 THEN
		SET urip=8;
	ELSEIF saptaWara=6 THEN
		SET urip=6;
	ELSEIF saptaWara=7 THEN
		SET urip=9;
	end if;
		
	return urip;
    END */$$
DELIMITER ;

/* Function  structure for function  `28_hariRaya` */

/*!50003 DROP FUNCTION IF EXISTS `28_hariRaya` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `28_hariRaya`(pancawara int,saptawara INT,wuku INT) RETURNS varchar(40) CHARSET latin1
BEGIN
	declare hari_raya varchar(40);
	IF (saptawara = 4 && pancawara = 4 && wuku = 3) THEN
		SET hari_raya = 'Hari Betara Sedana';
	ELSEIF (saptawara = 4 && pancawara = 4 && wuku = 3) THEN
		SET hari_raya = 'Hari Betari Sri';
	ELSEIF (saptawara = 7 && pancawara = 5 && wuku = 7) THEN
		SET hari_raya = 'Tumpek Uduh';
	ELSEIF (saptawara = 2 && pancawara = 2 && wuku = 8) THEN
		SET hari_raya = 'Hari Betara Brahma';
	ELSEIF (saptawara = 6 && pancawara = 1 && wuku = 8) THEN
		SET hari_raya = 'Hari Betari Sri';
	ELSEIF (saptawara = 3 && pancawara = 5 && wuku = 9) THEN
		SET hari_raya = 'Hari Anggara Kasih Julungwangi';
	ELSEIF (saptawara = 5 && pancawara = 4 && wuku = 10) THEN
		SET hari_raya = 'Hari Sugian Jawa';
	ELSEIF (saptawara = 6 && pancawara = 5 && wuku = 10) THEN
		SET hari_raya = 'Hari Sugian Bali';
	ELSEIF (saptawara = 1 && pancawara = 2 && wuku = 11) THEN
		SET hari_raya = 'Hari Penyekeban';
	ELSEIF (saptawara = 2 && pancawara = 3 && wuku = 11) THEN
		SET hari_raya = 'Hari Penyajaan';
	ELSEIF (saptawara = 3 && pancawara = 4 && wuku = 11) THEN
		SET hari_raya = 'Hari Penampahan Galungan';
	ELSEIF (saptawara = 4 && pancawara = 5 && wuku = 11) THEN
		SET hari_raya = 'Hari Raya Galungan';
	ELSEIF (saptawara = 5 && pancawara = 1 && wuku = 11) THEN
		SET hari_raya = 'Hari Umanis Galungan';
	ELSEIF (saptawara = 7 && pancawara = 3 && wuku = 11) THEN
		SET hari_raya = 'Hari Pemaridan Guru';
	ELSEIF (saptawara = 1 && pancawara = 4 && wuku = 12) THEN
		SET hari_raya = 'Ulihan';
	ELSEIF (saptawara = 2 && pancawara = 5 && wuku = 12) THEN
		SET hari_raya = 'Hari Pemacekan Agung';
	ELSEIF (saptawara = 6 && pancawara = 4 && wuku = 12) THEN
		SET hari_raya = 'Hari Penampahan Kuningan';
	ELSEIF (saptawara = 7 && pancawara = 5 && wuku = 12) THEN
		SET hari_raya = 'Hari Raya Kuningan';
	ELSEIF (saptawara = 4 && pancawara = 5 && wuku = 16) THEN
		SET hari_raya = 'Hari Pegat Wakan';
	ELSEIF (saptawara = 7 && pancawara = 5 && wuku = 17) THEN
		SET hari_raya = 'Hari Tumpek Krulut';
	ELSEIF (saptawara = 4 && pancawara = 4 && wuku = 18) THEN
		SET hari_raya = 'Hari Betara Rambut Sedana';
	ELSEIF (saptawara = 6 && pancawara = 1 && wuku = 18) THEN
		SET hari_raya = 'Betara Sri';
	ELSEIF (saptawara = 7 && pancawara = 5 && wuku = 22) THEN
		SET hari_raya = 'Hari Tumpek Kandang';
	ELSEIF (saptawara = 7 && pancawara = 5 && wuku = 27) THEN
		SET hari_raya = 'Hari Tumpek Wayang';
	ELSEIF (saptawara = 4 && pancawara = 4 && wuku = 28) THEN
		SET hari_raya = 'Hari Betara Rambut Sedana';
	ELSEIF (saptawara = 3 && pancawara = 2 && wuku = 30) THEN
		SET hari_raya = 'Betara Sri';
	ELSEIF (saptawara = 6 && pancawara = 1 && wuku = 30) THEN
		SET hari_raya = 'Hari Paid-Paidan';
	ELSEIF (saptawara = 4 && pancawara = 3 && wuku = 30) THEN
		SET hari_raya = 'Hari Urip';
	ELSEIF (saptawara = 5 && pancawara = 4 && wuku = 30) THEN
		SET hari_raya = 'Hari Penegtegan';
	ELSEIF (saptawara = 6 && pancawara = 5 && wuku = 30) THEN
		SET hari_raya = 'Hari Pangredanan';
	ELSEIF (saptawara = 7 && pancawara = 1 && wuku = 30) THEN
		SET hari_raya = 'Hari Raya Saraswati';
	ELSE
		SET hari_raya = '-';
	END IF;
	
	return hari_raya;
    END */$$
DELIMITER ;

/* Function  structure for function  `4_getNamaPancaWara` */

/*!50003 DROP FUNCTION IF EXISTS `4_getNamaPancaWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `4_getNamaPancaWara`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE nama VARCHAR(10);
	IF i=1 THEN
		SET nama='Umanis';
	ELSEIF i=2 THEN 
		SET nama='Pahing';
	ELSEIF i=3 THEN 
		SET nama='Pon';
	ELSEIF i=4 THEN 
		SET nama='Wage';
	ELSEIF i=5 THEN 
		SET nama='Kliwon';
	END IF;
	RETURN nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `4_getPancawara` */

/*!50003 DROP FUNCTION IF EXISTS `4_getPancawara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `4_getPancawara`(noWuku int) RETURNS int(11)
BEGIN
/*DAY OF WEEK
	| 1. Umanis
	| 2. Pahing
	| 3. Pon
	| 4. Wage
	| 5. Kliwon
	| dst*/
	declare noPancawara int;
	set noPancawara=(noWuku%5)+1;
	return noPancawara;
    END */$$
DELIMITER ;

/* Function  structure for function  `4_getUripPancaWara` */

/*!50003 DROP FUNCTION IF EXISTS `4_getUripPancaWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `4_getUripPancaWara`(pancaWara int) RETURNS int(11)
BEGIN
	DECLARE urip INT;
	IF pancaWara=1 THEN
		SET urip=5;
	ELSEIF pancaWara=2 THEN
		SET urip=9;
	ELSEIF pancaWara=3 THEN
		SET urip=7;
	ELSEIF pancaWara=4 THEN
		SET urip=4;
	ELSEIF pancaWara=5 THEN
		SET urip=8;
	END IF;
	return urip;
    END */$$
DELIMITER ;

/* Function  structure for function  `5_getNamaTriWara` */

/*!50003 DROP FUNCTION IF EXISTS `5_getNamaTriWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `5_getNamaTriWara`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE nama VARCHAR(10);
	IF i=1 THEN
		SET nama='Pasah';
	ELSEIF i=2 THEN 
		SET nama='Beteng';
	ELSEIF i=3 THEN 
		SET nama='Kajeng';
	end if;
	RETURN nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `5_getTriWara` */

/*!50003 DROP FUNCTION IF EXISTS `5_getTriWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `5_getTriWara`(noWuku int) RETURNS int(11)
BEGIN
/*TRI WARA
	| 1. Pasah
	| 2. Bereng
	| 3. Kajeng
	| dst*/
	declare triWara int;
	
	set triWara=noWuku%3;
	
	if triWara=0 then
		set triWara=3;
	end if;
	return triWara;
    END */$$
DELIMITER ;

/* Function  structure for function  `6_getEkaWara` */

/*!50003 DROP FUNCTION IF EXISTS `6_getEkaWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `6_getEkaWara`(uripPancaWara int, uripSaptaWara int) RETURNS int(11)
BEGIN	
	declare ekaWara int;
	set ekaWara=(uripPancaWara+uripSaptaWara)%2;
	if ekaWara=0 then
		set ekaWara=0;
	else
		set ekaWara=1;
	end if;
	return ekaWara;
    END */$$
DELIMITER ;

/* Function  structure for function  `6_getNamaEkaWara` */

/*!50003 DROP FUNCTION IF EXISTS `6_getNamaEkaWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `6_getNamaEkaWara`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE nama VARCHAR(10);
	IF i=0 THEN
		SET nama='-';
	ELSEIF i=1 THEN 
		SET nama='Luang';
	end if;
	RETURN nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `7_getDwiWara` */

/*!50003 DROP FUNCTION IF EXISTS `7_getDwiWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `7_getDwiWara`(uripPancaWara INT, uripSaptaWara INT) RETURNS int(11)
BEGIN
	DECLARE dwiWara INT;
	SET dwiWara=(uripPancaWara+uripSaptaWara)%2;
	IF dwiWara=0 THEN
		SET dwiWara=1;
	ELSE
		SET dwiWara=2;
	END IF;
	RETURN dwiWara;
    END */$$
DELIMITER ;

/* Function  structure for function  `7_getNamaDwiWara` */

/*!50003 DROP FUNCTION IF EXISTS `7_getNamaDwiWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `7_getNamaDwiWara`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE nama VARCHAR(10);
	IF i=1 THEN
		SET nama='Menga';
	ELSEIF i=2 THEN 
		SET nama='Pepet';
	END IF;
	RETURN nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `8_getCaturWara` */

/*!50003 DROP FUNCTION IF EXISTS `8_getCaturWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `8_getCaturWara`(noWuku int) RETURNS int(11)
BEGIN
	declare caturWara int;
	
	if (noWuku=71 || noWuku=72 || noWuku=73) then
		set caturWara=3;
	elseif (noWuku <71) then
		set caturWara=noWuku%4;
	else 
		set caturWara=(noWuku+2)%4;
	end if;
	
	if caturWara=0 then
		set caturWara=4;
	end if;
	
	return caturWara;
    END */$$
DELIMITER ;

/* Function  structure for function  `8_getNamaCaturWara` */

/*!50003 DROP FUNCTION IF EXISTS `8_getNamaCaturWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `8_getNamaCaturWara`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE nama VARCHAR(10);
	IF i=1 THEN
		SET nama='Sri';
	ELSEIF i=2 THEN 
		SET nama='Laba';
	ELSEIF i=3 THEN 
		SET nama='Jaya';
	ELSEIF i=4 THEN 
		SET nama='Mandala';
	END IF;
	RETURN nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `9_getNamaSadWara` */

/*!50003 DROP FUNCTION IF EXISTS `9_getNamaSadWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `9_getNamaSadWara`(i int) RETURNS varchar(10) CHARSET latin1
BEGIN
	DECLARE nama VARCHAR(10);
	IF i=1 THEN
		SET nama='Tungleh';
	ELSEIF i=2 THEN 
		SET nama='Aryang';
	ELSEIF i=3 THEN 
		SET nama='Urukung';
	ELSEIF i=4 THEN 
		SET nama='Paniron';
	ELSEIF i=5 THEN 
		SET nama='Was';
	ELSEIF i=6 THEN 
		SET nama='Maulu';
	END IF;
	RETURN nama;
    END */$$
DELIMITER ;

/* Function  structure for function  `9_getSadWara` */

/*!50003 DROP FUNCTION IF EXISTS `9_getSadWara` */;
DELIMITER $$

/*!50003 CREATE  FUNCTION `9_getSadWara`(noWuku int) RETURNS int(11)
BEGIN
/*
1. Tungleh
2. Aryang
3. Urukung
4. Paniron
5. Was
6. Mahulu
*/
	declare sadwara int;
	
	set sadwara=noWuku%6;
	
	if sadwara=0 then
		set sadwara=6;
	end if;
	
	return sadwara;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `getHariSasih` */

/*!50003 DROP PROCEDURE IF EXISTS  `getHariSasih` */;

DELIMITER $$

/*!50003 CREATE  PROCEDURE `getHariSasih`(tanggal DATE,refTanggal DATE, refPenanggal INT, refNgunaratri INT, out penanggal int, out penanggal2 int)
BEGIN
		DECLARE selisih INT;
		DECLARE jumlahNgunaratri INT;
		
		
		SET selisih=DATEDIFF(tanggal,refTanggal);
		SET jumlahNgunaratri=FLOOR((selisih+refNgunaratri)/63);
		
		IF (selisih+refNgunaratri)%63 =0 THEN
			SET jumlahNgunaratri=jumlahNgunaratri-1;
		END IF;
		
		SET penanggal=((refPenanggal+selisih+jumlahNgunaratri)%15);
		IF penanggal=0 THEN
			SET penanggal=15;
		ELSEIF penanggal<0 THEN
			SET penanggal=penanggal+15;
		END IF;
		IF (selisih+refNgunaratri)%63 =0 THEN
			SET penanggal2=penanggal+1;
		END IF;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getSasihAfter2002` */

/*!50003 DROP PROCEDURE IF EXISTS  `getSasihAfter2002` */;

DELIMITER $$

/*!50003 CREATE  PROCEDURE `getSasihAfter2002`(tanggal DATE,refTanggal DATE, refPenanggal INT, refNgunaratri INT, refSasih INT, refTahunSaka INT,out no_sasih int, out hasil_tahun int)
BEGIN
	DECLARE selisih INT;
	DECLARE jumlahNgunaratri INT;
	DECLARE jumlahNgunaratriTahun INT;
	DECLARE penambahanSasih INT;
	DECLARE penambahanTahun INT;
	DECLARE hasilSasih INT;
	DECLARE hasilTahun INT;
	DECLARE tahunMasehi YEAR;
	DECLARE isNampih BOOLEAN;
		
	DECLARE i INT;
	DECLARE i2 INT;
	SET penambahanTahun=0;
		
	SET isNampih=FALSE;
	SET selisih=DATEDIFF(tanggal,refTanggal);
	SET jumlahNgunaratri=FLOOR((selisih+refNgunaratri)/63);
		
	IF (selisih+refNgunaratri)%63 =0 THEN
		SET jumlahNgunaratri=jumlahNgunaratri-1;
	END IF;
	SET penambahanSasih= FLOOR((selisih+refPenanggal+14+jumlahNgunaratri)/30);
	SET hasilTahun=refTahunSaka;
	
	SET i=0;
	SET i2=refSasih;
	WHILE i<penambahanSasih DO
		SET i=i+1;
		SET i2=i2+1;
		SET i2=i2%12;
		
		IF i2=0 THEN
			SET i2=12;
		END IF;
		
		IF i2=10 THEN
			SET hasilTahun=hasilTahun+1;
		END IF;
			
		IF isNampih THEN
			SET isNampih=FALSE;
		ELSE
			
			IF hasilTahun%19=0 OR hasilTahun%19=6 OR hasilTahun%19=11 THEN
				IF i2=12 THEN
					SET i2=i2-1;
					SET isNampih=TRUE;
				END IF;
			ELSEIF hasilTahun%19=3 OR hasilTahun%19=8 OR hasilTahun%19=14 OR hasilTahun%19=16 THEN
				IF i2=1 THEN
					SET i2=i2-1;
					SET isNampih=TRUE;
				END IF;
			END IF;
		END IF;
	END WHILE;
	IF i2=0 THEN
		SET i2=12;
	END IF;
	set no_sasih=i2;
	set hasil_tahun=hasilTahun;
END */$$
DELIMITER ;

/* Procedure structure for procedure `getSasihBefore1992` */

/*!50003 DROP PROCEDURE IF EXISTS  `getSasihBefore1992` */;

DELIMITER $$

/*!50003 CREATE  PROCEDURE `getSasihBefore1992`(tanggal DATE,refTanggal DATE, refPenanggal INT, refNgunaratri INT, refSasih INT, refTahunSaka INT,OUT no_sasih INT, OUT hasil_tahun INT)
BEGIN
	DECLARE selisih INT;
	DECLARE jumlahNgunaratri INT;
	DECLARE jumlahNgunaratriTahun INT;
	DECLARE penambahanSasih INT;
	DECLARE penambahanTahun INT;
	DECLARE hasilSasih INT;
	DECLARE hasilTahun INT;
	DECLARE tahunMasehi YEAR;
	DECLARE isNampih BOOLEAN;
		
	DECLARE i INT;
	DECLARE i2 INT;
	SET penambahanTahun=0;
		
	SET isNampih=FALSE;
	SET selisih=DATEDIFF(tanggal,refTanggal);
	SET jumlahNgunaratri=FLOOR((selisih+refNgunaratri)/63);
		
	IF (selisih+refNgunaratri)%63 =0 THEN
		SET jumlahNgunaratri=jumlahNgunaratri-1;
	END IF;
	SET penambahanSasih= FLOOR((selisih+refPenanggal+14+jumlahNgunaratri)/30);
	SET hasilTahun=refTahunSaka;
	
	SET i=0;
	SET i2=refSasih;
	
	if penambahanSasih<0 then
		set penambahanSasih=penambahanSasih*-1;
	end if;
	
	WHILE i<penambahanSasih DO
		SET i=i+1;
		SET i2=i2-1;
		SET i2=i2%12;
		
		IF i2=0 THEN
			SET i2=12;
		END IF;
		
		IF i2=9 THEN
			SET hasilTahun=hasilTahun-1;
		END IF;
			
		IF isNampih THEN
			SET isNampih=FALSE;
		ELSE
			
			IF hasilTahun%19=0 OR hasilTahun%19=6 OR hasilTahun%19=11 THEN
				IF i2=12 THEN
					SET i2=i2+1;
					SET isNampih=TRUE;
				END IF;
			ELSEIF hasilTahun%19=3 OR hasilTahun%19=8 OR hasilTahun%19=14 OR hasilTahun%19=16 THEN
				IF i2=1 THEN
					SET i2=i2+1;
					SET isNampih=TRUE;
				END IF;
			END IF;
		END IF;
	END WHILE;
	IF i2=0 THEN
		SET i2=12;
	END IF;
	SET no_sasih=i2;
	SET hasil_tahun=hasilTahun;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `insertKalender` */

/*!50003 DROP PROCEDURE IF EXISTS  `insertKalender` */;

DELIMITER $$

/*!50003 CREATE  PROCEDURE `insertKalender`(date_start date, date_end date)
BEGIN
		declare selisih int;
		declare i int;
		declare tempDate date;
		set selisih=datediff(date_end,date_start);
		
		set i=0;
		
		while i<= selisih do
			SET tempDate = DATE_ADD(date_start,INTERVAL (i) DAY);
			-- PANGGIL STORE PROCEDURE spKalenderBali10
			CALL getKalender(tempDate);
			SET i = i + 1;
		end while;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `searchOtonan` */

/*!50003 DROP PROCEDURE IF EXISTS  `searchOtonan` */;

DELIMITER $$

/*!50003 CREATE  PROCEDURE `searchOtonan`(tanggal DATE ,tahun YEAR)
BEGIN
		DECLARE selisih INT;
		DECLARE tgl DATE;
		DECLARE bagi  INT;
		DECLARE otonan DATE;
		DECLARE otonan2 DATE;
		DECLARE tambah INT;
		SET tgl=CONCAT(tahun, '-01-01');
		SET selisih=DATEDIFF(tgl,tanggal);
		SET bagi=CEILING(selisih/210);
		SET tambah=bagi*210;
		SET otonan = DATE_ADD(tanggal,INTERVAL (tambah) DAY);
		SET otonan2 = DATE_ADD(otonan,INTERVAL (210) DAY);
		SELECT otonan AS 'tanggal',otonan2 AS 'tanggal2';
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getKalender` */

/*!50003 DROP PROCEDURE IF EXISTS  `getKalender` */;

DELIMITER $$

/*!50003 CREATE  PROCEDURE `getKalender`(tanggal date)
BEGIN
	/*
	variabel pivot
	*/
	declare refTanggal date;
	declare wuku int;
	DECLARE angkaWuku INT;
	DECLARE tahunSaka INT;
	DECLARE noSasih INT;
	DECLARE penanggal INT;
	DECLARE isPangelong boolean;
	declare noNgunaratri int;
	DECLARE isNgunaratri BOOLEAN;
		
	/*
	variabel hasil
	*/
	declare hasilAngkaWuku int;
	declare hasilWuku int;
	declare saptawara int;
	declare urip_saptawara int;
	declare pancawara int;
	declare urip_pancawara int;
	declare triwara int;
	declare ekawara int;
	declare dwiwara int;
	DECLARE caturwara INT;
	DECLARE sadwara INT;
	DECLARE astawara INT;
	DECLARE sangawara INT;
	DECLARE dasawara INT;
	declare ingkel varchar(10);
	DECLARE jejepan VARCHAR(10);
	declare lintang varchar(30);
	declare pancasudha varchar(20);
	declare pangarasan varchar(20);
	declare rakam varchar(20);
	declare watek_madya varchar(10);
	DECLARE watek_alit VARCHAR(10);
	declare neptu int;
	declare ekajalarsi varchar(20);
	DECLARE zodiak VARCHAR(20);
	declare pratiti varchar(20);
	declare hari_raya varchar(40);
	declare purnama varchar(10);
	DECLARE tilem VARCHAR(10);
	declare dewasa text;
	
	DECLARE nama_wuku VARCHAR(10);	
	declare nama_ekawara varchar(10);
	DECLARE nama_dwiwara VARCHAR(10);
	DECLARE nama_triwara VARCHAR(10);
	DECLARE nama_caturwara VARCHAR(10);
	DECLARE nama_pancawara VARCHAR(10);
	DECLARE nama_sadwara VARCHAR(10);
	DECLARE nama_saptawara VARCHAR(10);
	DECLARE nama_astawara VARCHAR(10);
	DECLARE nama_sangawara VARCHAR(10);
	DECLARE nama_dasawara VARCHAR(10);
	
	-- hari sasih 1 dan 2 untuk pengrepeta
	declare hari_sasih_1 varchar(10);
	DECLARE hari_sasih_2 VARCHAR(10);
	declare pengalantaka varchar(15);
	declare no_sasih int;
	declare hasil_sasih varchar(10);
	DECLARE hasil_tahun INT;
	
	
	IF tanggal>='2000-01-01' THEN
		set refTanggal='2000-01-01';
		SET wuku=10;
		SET angkaWuku=70;
		SET tahunSaka=1921;
		SET noSasih=7;
		SET penanggal=10;
		SET isPangelong=TRUE;
		SET noNgunaratri=46;
		SET isNgunaratri=FALSE;
	ELSEif tanggal <'1992-01-01' then
		SET refTanggal='1970-01-01';
		SET wuku=5;
		SET angkaWuku=33;
		SET tahunSaka=1891;
		SET noSasih=7;
		SET penanggal=8;
		SET isPangelong=TRUE;
		SET noNgunaratri=50;
		SET isNgunaratri=FALSE;
	else
		SET refTanggal='1992-01-01';
		SET wuku=13;
		SET angkaWuku=88;
		SET tahunSaka=1913;
		SET noSasih=7;
		SET penanggal=11;
		SET isPangelong=TRUE;
		SET noNgunaratri=22;
		SET isNgunaratri=FALSE;
	END IF;
	
	set hasilAngkaWuku=1_getNoWuku(tanggal,angkaWuku,refTanggal);
	set hasilWuku=2_getWuku(hasilAngkaWuku);
	set nama_wuku=2_getNamaWuku(hasilWuku);
	
	set saptawara=3_getSaptawara(tanggal);
	set urip_saptawara=3_getUripSaptaWara(saptawara);
	set nama_saptawara=3_getNamaSaptaWara(saptawara);
	
	set pancawara=4_getPancawara(hasilAngkaWuku);
	set urip_pancawara=4_getUripPancaWara(pancawara);
	set nama_pancawara=4_getNamaPancaWara(pancawara);
	
	set triwara=5_getTriWara(hasilAngkaWuku);
	set nama_triwara=5_getNamaTriWara(triwara);
	
	set ekawara=6_getEkaWara(urip_pancawara,urip_saptawara);
	set nama_ekawara=6_getNamaEkaWara(ekawara);
	
	set dwiwara=7_getDwiWara(urip_pancawara,urip_saptawara);
	set nama_dwiwara=7_getNamaDwiWara(dwiwara);
	
	set caturwara=8_getCaturWara(hasilAngkaWuku);
	set nama_caturwara=8_getNamaCaturWara(caturwara);
	
	set sadwara=9_getSadWara(hasilAngkaWuku);
	set nama_sadwara=9_getNamaSadWara(sadwara);
	
	set astawara=10_astaWara(hasilAngkaWuku);
	set nama_astawara=10_getNamaAstaWara(astawara);
	
	set sangawara=11_sangaWara(hasilAngkaWuku);
	set nama_sangawara=11_getNamaSangaWara(sangawara);
	
	set dasawara=12_dasawara(urip_pancawara,urip_saptawara);	
	set nama_dasawara=12_getNamaDasaWara(dasawara);
	
	call getHariSasih(tanggal,refTanggal,penanggal,noNgunaratri,hari_sasih_1,hari_sasih_2);
		
	set pengalantaka =14_getPengalantaka(tanggal,refTanggal,penanggal,noNgunaratri);
	
	set ingkel=16_getIngkel(hasilWuku);
	set jejepan=17_jejepan(hasilAngkaWuku);
	set lintang=18_getLintang(tanggal,refTanggal);
	set pancasudha=19_pancasudha(pancawara,saptawara);
	set pangarasan=20_pengarasan(urip_pancawara,urip_saptawara);
	set rakam=21_getRakam(pancawara,saptawara);
	set watek_madya=22_watekMadya(urip_pancawara,urip_saptawara);
	set watek_alit=23_watekAlit(urip_pancawara,urip_saptawara);
	set neptu=24_neptu(urip_pancawara,urip_saptawara);
	set ekajalarsi=25_ekaJalaRsi(hasilWuku,saptawara);
	set zodiak=26_zodiak(tanggal);
	set hari_raya=28_hariRaya(pancawara,saptawara,hasilWuku);
	IF tanggal>'2002-01-01'|| tanggal <'1992-01-01' THEN
		if datediff(tanggal,refTanggal)<0 then
			CALL getSasihBefore1992(tanggal,refTanggal,penanggal,noNgunaratri,noSasih,tahunSaka,no_sasih,hasil_tahun);
		else
			CALL getSasihAfter2002(tanggal,refTanggal,penanggal,noNgunaratri,noSasih,tahunSaka,no_sasih,hasil_tahun);
		end if;
	
	ELSE
		CALL getSasihBetween(tanggal,refTanggal,penanggal,noNgunaratri,noSasih,tahunSaka,no_sasih,hasil_tahun);
	END IF;
	
	set hasil_sasih=15_getNamaSasih(no_sasih);
	SET pratiti=27_pratiti(pengalantaka,no_sasih,hari_sasih_1);
	call getPurnamaTilem(pengalantaka,hari_sasih_1,hari_sasih_2,purnama,tilem);
	set dewasa=29_dewasa(dwiwara, triwara,pancawara, sadwara,saptawara, astawara,sangawara,dasawara,hasilWuku, pengalantaka, hari_sasih_1, hari_sasih_2,no_sasih,purnama,tilem);
	
	IF hari_sasih_2 IS NOT NULL THEN
		SET hari_sasih_1= CONCAT(hari_sasih_1,'/',hari_sasih_2);
	END IF;
		
	select tanggal as 'tanggal',nama_wuku as 'wuku', nama_ekawara as 'ekawara', nama_dwiwara as 'dwiwara', 
		nama_triwara as 'triwara', nama_caturwara as 'caturwara',nama_pancawara as 'pancawara', nama_sadwara as 'sadwara', 
		nama_saptawara as 'saptawara', nama_astawara as 'astawara', nama_sangawara as 'sangawara', nama_dasawara as 'dasawara',
		hari_sasih_1 as 'penanggal', pengalantaka as 'pengalantaka', hasil_sasih as 'sasih', hasil_tahun as 'tahun_saka', 
		ingkel as 'ingkel', jejepan as 'jejepan', lintang as 'lintang',pancasudha as 'pancasadha', pangarasan as 'pangarasan',
		rakam as 'rakam',watek_madya as 'watek_madya',watek_alit as 'watek_alit',neptu as 'neptu',ekajalarsi as 'eka_jala_rsi',
		zodiak as 'zodiak',pratiti as 'pratiti',purnama,tilem,hari_raya as 'hari raya',dewasa;
	
	/*
	insert into kalender values (null,tanggal,nama_wuku,nama_ekawara,nama_dwiwara,nama_triwara,nama_caturwara,nama_pancawara,nama_sadwara,nama_saptawara,nama_astawara,nama_sangawara,nama_dasawara,concat(hari_sasih_1,' ',pengalantaka),hasil_sasih,hasil_tahun);
	*/
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getPurnamaTilem` */

/*!50003 DROP PROCEDURE IF EXISTS  `getPurnamaTilem` */;

DELIMITER $$

/*!50003 CREATE  PROCEDURE `getPurnamaTilem`(pengalantaka varchar(10), sasihDay1 int, sasihDay2 int,out purnama varchar(10),out tilem varchar(10))
BEGIN
		IF (((sasihDay1 = 15) && (pengalantaka = 'Penanggal')) OR (((sasihDay2 = 15) && (pengalantaka = 'Penanggal')))) THEN
		SET purnama = 'Purnama';
		SET tilem = '-';
	ELSEIF (((sasihDay1 = 15) && (pengalantaka = 'Pangelong')) OR (((sasihDay2 = 15) && (pengalantaka = 'Pangelong')))) THEN
		SET purnama = '-';
		SET tilem = 'Tilem';
	ELSE
		SET purnama = '-';
		SET tilem = '-';
	END IF;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `getSasihBetween` */

/*!50003 DROP PROCEDURE IF EXISTS  `getSasihBetween` */;

DELIMITER $$

/*!50003 CREATE  PROCEDURE `getSasihBetween`(tanggal DATE,refTanggal DATE, refPenanggal INT, refNgunaratri INT, refSasih INT, refTahunSaka INT,OUT no_sasih INT, OUT hasil_tahun INT)
BEGIN
	DECLARE selisih INT;
	DECLARE jumlahNgunaratri INT;
	DECLARE jumlahNgunaratriTahun INT;
	DECLARE penambahanSasih INT;
	DECLARE penambahanTahun INT;
	DECLARE hasilSasih INT;
	DECLARE hasilTahun INT;
	DECLARE tahunMasehi YEAR;
	DECLARE isNampih BOOLEAN;
		
	DECLARE i INT;
	DECLARE i2 INT;
	SET penambahanTahun=0;
		
	SET isNampih=FALSE;
	SET selisih=DATEDIFF(tanggal,refTanggal);
	SET jumlahNgunaratri=FLOOR((selisih+refNgunaratri)/63);
		
	IF (selisih+refNgunaratri)%63 =0 THEN
		SET jumlahNgunaratri=jumlahNgunaratri-1;
	END IF;
	SET penambahanSasih= FLOOR((selisih+refPenanggal+14+jumlahNgunaratri)/30);
	SET hasilTahun=refTahunSaka;
	
	SET i=0;
	SET i2=refSasih;
	WHILE i<penambahanSasih DO
		SET i=i+1;
		SET i2=i2+1;
		SET i2=i2%12;
		
		IF i2=0 THEN
			SET i2=12;
		END IF;
		
		IF i2=10 THEN
			SET hasilTahun=hasilTahun+1;
		END IF;
			
		IF isNampih THEN
			SET isNampih=FALSE;
		ELSE
			
			IF hasilTahun%19=2 OR hasilTahun%19=10 THEN
				IF i2=12 THEN
					SET i2=i2-1;
					SET isNampih=TRUE;
				END IF;
			ELSEIF hasilTahun%19=4 THEN
				IF i2=4 THEN
					SET i2=i2-1;
					SET isNampih=TRUE;
				END IF;
			ELSEIF hasilTahun%19=7 THEN
				IF i2=2 THEN
					SET i2=i2-1;
					SET isNampih=TRUE;
				END IF;
			ELSEIF hasilTahun%19=13 THEN
				IF i2=11 THEN
					SET i2=i2-1;
					SET isNampih=TRUE;
				END IF;
			ELSEIF hasilTahun%19=15 THEN
				IF i2=3 THEN
					SET i2=i2-1;
					SET isNampih=TRUE;
				END IF;
			ELSEIF hasilTahun%19=18 THEN
				IF i2=1 THEN
					SET i2=i2-1;
					SET isNampih=TRUE;
				END IF;
			END IF;
		END IF;
	END WHILE;
	IF i2=0 THEN
		SET i2=12;
	END IF;
	SET no_sasih=i2;
	SET hasil_tahun=hasilTahun;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
