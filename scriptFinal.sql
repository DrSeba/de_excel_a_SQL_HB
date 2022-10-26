DROP SCHEMA IF EXISTS hospital;
CREATE SCHEMA IF NOT EXISTS hospital;
USE hospital;

CREATE TABLE IF NOT EXISTS proveedores
(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(60) NOT NULL,
direccion VARCHAR(100) NOT NULL,
telefono INT NOT NULL,
mail VARCHAR(60) NOT NULL DEFAULT 'Pedir mail'
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS insumos
(
id INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('oncologicos', 'aynes', 'internacion', 'descartables','alto costo') NOT NULL,
marca VARCHAR(60) DEFAULT NULL,
mg VARCHAR(60) NOT NULL,
presentacion VARCHAR(60) NOT NULL,
stock INT NOT NULL,
precio INT NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS proveedores_insumos
(
ins_id INT NOT NULL,
prov_id INT NOT NULL,
PRIMARY KEY(ins_id, prov_id),
FOREIGN KEY (ins_id) REFERENCES hospital.insumos(id),
FOREIGN KEY (prov_id) REFERENCES hospital.proveedores(id)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS medicamentos
(
id INT AUTO_INCREMENT PRIMARY KEY,
tipo ENUM('fisiologica', 'dextrosa', 'ringer', 'agua') NOT NULL,
marca VARCHAR(60) NOT NULL,
lote VARCHAR(60) NOT NULL,
vencimiento VARCHAR(100),
stock INT NOT NULL,
costo INT NOT NULL
) ENGINE=INNODB; 

CREATE TABLE IF NOT EXISTS materiales_oncologicos
(
ins_id INT NOT NULL,
medic_id INT NOT NULL,
cantidad INT NOT NULL,
PRIMARY KEY (ins_id, medic_id),
FOREIGN KEY (ins_id) REFERENCES hospital.insumos(id),
FOREIGN KEY (medic_id) REFERENCES hospital.medicamentos(id)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS pacientes
(
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(45) NOT NULL,
apellido VARCHAR(45) NOT NULL,
direccion VARCHAR(200) DEFAULT NULL,
telefono INT NOT NULL,
mail VARCHAR(60) NOT NULL DEFAULT 'Pedir mail'
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS direcciones_envio
(
id INT AUTO_INCREMENT PRIMARY KEY,
paciente INT NOT NULL,
direccion VARCHAR(200) NOT NULL,
localidad VARCHAR(60) NOT NULL,
provincia VARCHAR(30) NOT NULL,
FOREIGN KEY (paciente) REFERENCES hospital.pacientes(id)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS hospital.pedidos
(
id INT AUTO_INCREMENT PRIMARY KEY,
paciente INT NOT NULL,
medic INT NOT NULL,
cantidad INT NOT NULL,
precio INT NOT NULL,
fecha DATE NOT NULL,
dir_envio INT NOT NULL,
FOREIGN KEY (paciente) REFERENCES hospital.pacientes(id),
FOREIGN KEY (medic) REFERENCES hospital.medicamentos(id),
FOREIGN KEY (dir_envio) REFERENCES hospital.direcciones_envio(id));

USE hospital;
DELIMITER //
START TRANSACTION;
INSERT INTO proveedores VALUES
(NULL,'Suizo Argentina','Monroe 801 CABA','57776400','suizoargentina@gmail.com'),
(NULL,'Scienza','Av Juan De Garay 437 CABA','55547890','scienzaargentina@drogueria.com'),
(NULL,'City Pharma Group','Av Forest 762 CABA','45516317','citypharmagroup@citypharmagroup.com.ar'),
(NULL,'City Pharma Group','Av Del Libertador CABA','45512448','citypharmagroup@citypharmagroup.com.ar'),
(NULL,'Medifarm','Pedriel 1574 CABA','55547999','medifarm@gmail.com'),
(NULL,'Medicare S.R.L','Ladines 2462 CABA','47229822','medicar@info.com.ar'),
(NULL,'Beiro','Av Francisco Berio 3642 CABA','45010687','DEFAULT'),
(NULL,'Cipres','Av Albarellos 2568 CABA','45734009','drogueriacripres@gmail.com'),
(NULL,'Farmacia La Sante Caseros','Av Caseros 1902 CABA','43046813','DEFAULT'),
(NULL,'Farmacia La Sante Rivadavia','Av Rivadavia 5892 CABA','44313107','DEFAULT');
// DELIMITER ;

COMMIT;

DELIMITER //
START TRANSACTION;
INSERT INTO insumos VALUES
(NULL,'oncologicos','Avastin','100','vial','30','1000'),
(NULL,'oncologicos','Avastin','400','vial','20','10000'),
(NULL,'oncologicos','Bevax','100','vial','10','800'),
(NULL,'oncologicos','Bevax','400','vial','30','8000'),
(NULL,'oncologicos','Blocamicina','15','vial','30','1000'),
(NULL,'oncologicos','Paclitaxel Glenmark','30','vial','20','1200'),
(NULL,'oncologicos','Paclitaxel Glenamrk','100','vial','30','2000'),
(NULL,'oncologicos','Paclitaxel Glenmark','150','vial','20','3000'),
(NULL,'oncologicos','Paclitaxel Glenamrk','300','vial','10','5000'),
(NULL,'oncologicos','Erbitux','100','vial','10','50000'),
(NULL,'oncologicos','Erbitux','500','vial','10','100000'),
(NULL,'oncologicos','Azacitidina Kemex','100','vial','50','1200'),
(NULL,'oncologicos','Carboplatino Varifarma','150','vial','100','1000'),
(NULL,'oncologicos','Carboplatino Varifarma','450','vial','100','2200'),
(NULL,'oncologicos','Eriolan','15','vial','20','1000'),
(NULL,'oncologicos','Oxaliplatino Microsules','10','vial','50','200'),
(NULL,'oncologicos','Oxaliplatino Microsules','50','vial','20','1000'),
(NULL,'oncologicos','Oxaliplatino Microsules','100','vial','10','2000'),
(NULL,'oncologicos','Paclitaxel Microsules','30','vial','10','2000'),
(NULL,'oncologicos','Paclitaxel Microsules','100','vial','10','3000'),
(NULL,'oncologicos','Paclitaxel Microsules','150','vial','10','4500'),
(NULL,'aynes','Ibupirac x10','400','comprimidos','100','200'),
(NULL,'aynes','Ibupirac x30','400','comprimidos','50','500'),
(NULL,'aynes','Ibupirac x10','400','capsulas','100','300'),
(NULL,'aynes','Ibupirac x30','400','capsulas','50','600'),
(NULL,'aynes','Ibupirac x10','600','comprimidos','50','400'),
(NULL,'aynes','Ibupirac x30','600','comprimidos','50','500'),
(NULL,'aynes','Ibupirac x10','600','capsulas','50','500'),
(NULL,'aynes','Ibupirac x30','600','capsulas','50','500'),
(NULL,'aynes','Ibupirac x10','800','comprimidos','50','500'),
(NULL,'aynes','Ibupirac x30','800','comprimidos','50','1200'),
(NULL,'aynes','Diclofenac Bago','25','comprimidos','100','100'),
(NULL,'aynes','Diclofenac Bago','50','comprimidos','100','200'),
(NULL,'aynes','Diclofenac Bago','75','comprimidos','100','300'),
(NULL,'aynes','Bayaspirina','100','efervecente','120','120'),
(NULL,'aynes','Bayaspirina','125','efervecente','120','200'),
(NULL,'aynes','Aspirinetas','100','grageas','120','200'),
(NULL,'aynes','Aspirinetas','100','comprimidos','50','200');
// DELIMITER ;

COMMIT;

DELIMITER //
START TRANSACTION;
INSERT INTO proveedores_insumos VALUES
('1','1'),
('2','1'),
('3','1'),
('4','2'),
('5','2'),
('6','3'),
('7','3'),
('8','4'),
('9','5'),
('10','5'),
('11','5'),
('12','1'),
('13','1'),
('14','2'),
('15','2'),
('16','1'),
('17','1'),
('18','3'),
('19','2'),
('20','1'),
('21','1'),
('22','1'),
('23','2'),
('24','2'),
('25','3'),
('26','3'),
('27','1'),
('28','5'),
('29','6'),
('30','8'),
('31','7'),
('32','10'),
('33','8'),
('34','9'),
('35','7'),
('36','8'),
('37','10');
// DELIMITER ;

COMMIT;

DELIMITER //
START TRANSACTION ;
INSERT INTO medicamentos VALUES
('1','fisiologica','Jayor 100 ML','2021230','1024','120','45'),
('2','fisiologica','Jayor 250 ML','2021230','1024','300','50'),
('3','fisiologica','Rivero 100 ML','5L2021230','1024','155','60'),
('4','fisiologica','Rivero  250 ML','5L2021231','10242','50','60'),
('5','fisiologica','Braun  100 ML','18872','1024','100','70'),
('6','fisiologica','Braun  250ML','18019','1024','120','80'),
('7','dextrosa','Jayor 5%','2021230','1024','120','45'),
('8','dextrosa','Rivero  5%','5L2021230','1024','155','60'),
('9','dextrosa','Braun 5%','18873','1024','100','70'),
('10','dextrosa','Jayor 10%','2021231','1024','120','45'),
('11','dextrosa','Rivero 10%','5L2021231','1024','155','60'),
('12','dextrosa','Braun 10%','18873','1024','100','70'),
('13','dextrosa','Braun 50%','18873','1024','100','70'),
('14','ringer','Jayor','21230','1024','250','60'),
('15','ringer','Jayor','21231','1024','250','60'),
('16','agua','Jayor 5 ML','202','1024','300','5'),
('17','agua','Rivero 10 ML','5L2021230','1024','155','10'),
('18','agua','Jayor 100 ML','2021231','1024','300','100'),
('19','agua','Jayor 250 ML','20212','1024','300','250'),
('20','agua','Jayor 500 ML','20213','1024','300','500'),
('21','agua','Jayor 1000 ML','20214','1024','300','1000');
// DELIMITER ;

COMMIT;

DELIMITER //
START TRANSACTION ;
INSERT INTO materiales_oncologicos VALUES
('4','1','1'),
('12','1','1'),
('24','1','1'),
('29','1','1'),
('5','2','1'),
('13','2','1'),
('23','2','1'),
('29','2','1'),
('6','3','1'),
('17','3','1'),
('26','3','1'),
('30','3','1'),
('7','4','1'),
('16','4','1'),
('26','4','1'),
('30','4','1'),
('9','5','1'),
('14','5','1'),
('22','5','1'),
('34','5','1'),
('11','6','1'),
('15','6','1'),
('22','6','1'),
('34','6','1'),
('8','7','1'),
('18','7','1'),
('21','7','1'),
('36','7','1'),
('8','8','1'),
('19','8','1'),
('25','8','1'),
('36','8','1'),
('8','9','1'),
('18','9','1'),
('21','9','1'),
('36','9','1'),
('8','10','1'),
('20','10','1'),
('25','10','1'),
('37','10','1'),
('1','11','1'),
('28','11','1'),
('31','11','1'),
('1','12','1'),
('28','12','1'),
('31','12','1'),
('1','13','1'),
('28','13','1'),
('35','13','1'),
('2','14','1'),
('27','14','1'),
('32','14','1'),
('3','15','1'),
('27','15','1'),
('33','15','1'),
('3','16','1'),
('28','16','1'),
('35','16','1'),
('1','17','1'),
('28','17','1'),
('31','17','1'),
('2','18','1'),
('28','18','1'),
('31','18','1'),
('3','19','1'),
('21','19','1'),
('35','19','1'),
('3','20','1'),
('21','20','1'),
('33','20','1');

DELIMITER //
START TRANSACTION ;
INSERT INTO pacientes VALUES
(NULL,'Juan','Perez','Boyaca 555, CABA','1152889655','juanperez@gmail.com'),
(NULL,'Jose','Ceballos','Caracas 2155, CABA','1187923355','joseceballos@mail.com'),
(NULL,'Carla','Farias','Av Segurola 2322 1°B, CABA','1155224855','carlafarias@gmail.com'),
(NULL,'Carolina','Gomez','Av Hipolito Yirigoyen 522, Lanus, GBA','1166128799','gomezcarolina33@gmail.com'),
(NULL,'Norberto','Carrizo','Av Mitre 2251 5°A, Avellaneda, GBA','1165442525','carrizonorberto@mail.com'),
(NULL,'Paula','Carrasco','Av Nazca 859, CABA','1144558484','carrascop@gmail.com'),
(NULL,'Jorge','Gonzalez','Serrano 755, CABA','1154883255', DEFAULT),
(NULL,'Jonathan','Garcia','Av Libertador 5233 11°C, CABA','1154552300','garciajonathan11@gmail.com'),
(NULL,'Cinthia','Morales','Av Callao 202, CABA','1189655145', DEFAULT),
(NULL,'Debora','Caruso','Carlos Calvo 3255 4°A, CABA','1144887784','deboracar@gmail.com');
// DELIMITER ;

COMMIT;

DELIMITER //
START TRANSACTION ;
INSERT INTO direcciones_envio VALUES
(NULL,'1','Av Eva Peron 2155','CABA','Buenos Aires'),
(NULL,'1','Av 25 de Mayo 522','San Rafael','Mendoza'),
(NULL,'2','Av Jujuy 5221','Resistencia','Chaco'),
(NULL,'2','Av 9 de Julio 521','Rosario','Santa Fe'),
(NULL,'2','Carlos Casares 422','Villa Maria','Cordoba'),
(NULL,'3','Gral Cesar Diaz 5524','CABA','Buenos Aires'),
(NULL,'4','Ceballos 252','Lujan','Buenos Aires'),
(NULL,'4','Quitana 5050','Moreno','Buenos Aires'),
(NULL,'5','Bufano 722','CABA','Buenos Aires'),
(NULL,'5','Peru 2666','Salta','Salta'),
(NULL,'5','Av del Campo 526','Rosario','Santa Fe'),
(NULL,'6','Lima 888','CABA','Buenos Aires');
// DELIMITER ;

COMMIT;

DELIMITER //
START TRANSACTION ;
INSERT INTO pedidos VALUES
(NULL,'1','2','10','500000','2022/01/22','2'),
(NULL,'5','3','5','300000','2022/01/25','10'),
(NULL,'5','13','20','800000','2022/01/25','10'),
(NULL,'4','5','40','3200000','2022/01/30','8'),
(NULL,'1','17','7','140000','2022/02/05','2'),
(NULL,'3','19','2','200000', '2022/02/15','6'),
(NULL,'4','9','10','300000','2022/02/17','7'),
(NULL,'4','14','5','300000', '2022/02/17','7'),
(NULL,'1','1','8','360000','2022/02/25','1'),
(NULL,'5','4','10','600000','2022/02/26','11'),
(NULL,'5','6','8','640000','2022/02/26','11'),
(NULL,'6','1','20','900000', '2022/03/02','12'),
(NULL,'2','7','15','525000','2022/03/10','4');
// DELIMITER ;

COMMIT;

CREATE OR REPLACE VIEW costo_medic_paciente
AS SELECT SUM(ins.precio) precio, medic.id id_medicamento
FROM insumos ins
INNER JOIN materiales_oncologicos mo ON ins.id = mo.ins_id
INNER JOIN medicamentos medic ON medic.id = mo.medic_id
GROUP BY medic.id;

# Vista para saber el valor total de las ventas del hospital, en que cantidad de pedidos y que cantidad de medicamentos
CREATE OR REPLACE VIEW total_ventas
AS SELECT SUM(cantidad) cantidad_medicamentos, COUNT(id) cantidad_pedidos, SUM(precio) total
FROM pedidos;

CREATE TABLE IF NOT EXISTS movimientos_pedidos
(id_mov INT PRIMARY KEY AUTO_INCREMENT,
fecha_mov DATE NOT NULL,
hora_mov TIME NOT NULL,
usuario_mov VARCHAR(50) NOT NULL,
id_ped INT NOT NULL,
paciente_precio VARCHAR(65) NOT NULL
);

/* Trigger #1: Guarda información de fecha y usuario que realizo el movimiento 
y el id, cliente y precio del pedido sobre el cual se realizo 
cuando hacemos un INSERT en la tabla pedidos*/

CREATE TRIGGER `ingreso_nuevo_pedido`
AFTER INSERT ON `pedidos`
FOR EACH ROW
INSERT INTO `movimientos_pedidos` (id_mov, fecha_mov, hora_mov, usuario_mov, id_ped, paciente_precio)
VALUES (NULL, CURDATE(), CURTIME(), USER(), NEW.id, 
		CONCAT('Se ingreso un nuevo pedido del paciente ', NEW.paciente, 
        ' con el precio de ', NEW.precio));
        

        
/* Trigger #2: Guarda información de fecha y usuario que realizo el movimiento 
y el id, cliente y precio del pedido sobre el cual se realizo 
cuando hacemos un DELETE en la tabla pedidos*/



CREATE TRIGGER `borrar_pedido`
BEFORE DELETE ON `pedidos`
FOR EACH ROW
INSERT INTO `movimientos_pedidos` (id_mov, fecha_mov, hora_mov, usuario_mov, id_ped, paciente_precio)
VALUES (NULL, CURDATE(), CURTIME(), USER(), OLD.id, 
		CONCAT('Se borro un pedido del cliente ', OLD.paciente, 
        ' con el precio de ', OLD.precio));

/* Funcion para calcular cuantos dias pasaron desde el ultimo pedido que hizo un paciente
mediante su id */
DELIMITER $$
CREATE FUNCTION `cantidad_dias_ult_pedido`(id INT) 
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE fecha1 DATE;
    DECLARE fecha2 DATE;
    DECLARE resultado INT;
	SET fecha1 = (SELECT ped.fecha
	FROM pedidos ped
	WHERE paciente = id
	ORDER BY fecha DESC
	LIMIT 1);
    SET fecha2 = (SELECT CURDATE() FROM DUAL);
    SET resultado = (DATEDIFF(fecha2,fecha1));
RETURN resultado;
END
$$
DELIMITER ;

# Funcion para calcular cantidad de pedidos entre 2 fechas que ingrese el usuario
DELIMITER $$
CREATE FUNCTION `cant_pedidos_por_fecha`(fecha1 DATE, fecha2 DATE) 
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE resultado INT;
	SET resultado = (SELECT COUNT(id)
	FROM pedidos
	WHERE fecha BETWEEN fecha1 AND fecha2);
RETURN resultado;
END
$$
DELIMITER ;

# Vista para saber el valor total de la venta de medicacion
CREATE OR REPLACE VIEW total_ventas
AS SELECT SUM(cantidad) pacientes, COUNT(id) cantidad_pedidos, SUM(precio) total
FROM pedidos;

# Vista para saber cual es el promedio de ventas y en que cantidad de pedidos
CREATE OR REPLACE VIEW promedio_ventas
AS SELECT AVG(precio) promedio_venta, COUNT(id) total_pedidos
FROM pedidos;

# SP para ingresar un nuevo insumo:
DELIMITER //
CREATE PROCEDURE nuevo_insumo 
(IN tipo ENUM('oncologicos', 'aynes', 'internacion','descartables','alto costo'),
IN marca VARCHAR(60),
IN mg VARCHAR(60),
IN presentacion VARCHAR(60),
IN stock INT,
IN precio INT)
BEGIN
	INSERT INTO insumos VALUES
    (null, tipo, marca, mg, presentacion, stock, precio);
END					
//
DELIMITER ; 

# Ejemplos:

CALL nuevo_insumo ('oncologicos', 'Gemcitabina', '200', 'vial', '50', '5000');
CALL nuevo_insumo ('alto costo', 'Soliris', '100', 'vial', '10', '500000');
CALL nuevo_insumo ('descartables', 'Jeringas descartables', '20', 'ml', '200', '50');

# SP para ordenar la tabla; cuenta con 2 parametros.
# Primer parametro: Hay 7 formas para ordenar la tabla;
# por id: 1
# por tipo: 2
# por marca: 3
# por mg: 4
# por presentacion: 5
# por stock: 6
# por precio: 7
# Segundo parametro: 
#Ordenar de forma Ascendente: 1 (Menor a Mayor)
#Ordenar de forma Descendente: 2 (Mayor a Menor) 

DELIMITER //
CREATE PROCEDURE sp_insumos (IN campo INT, IN orden INT)
BEGIN
    SELECT * 
    FROM insumos
    ORDER BY
    CASE WHEN campo = 1 AND orden = 1 THEN id END,
    CASE WHEN campo = 1 AND orden = 2 THEN id END DESC,
    CASE WHEN campo = 2 AND orden = 1 THEN tipo END,
	CASE WHEN campo = 2 AND orden = 2 THEN tipo END DESC,
	CASE WHEN campo = 3 AND orden = 1 THEN marca END,
	CASE WHEN campo = 3 AND orden = 2 THEN marca END DESC,
	CASE WHEN campo = 4 AND orden = 1 THEN mg END,
	CASE WHEN campo = 4 AND orden = 2 THEN mg END DESC,
	CASE WHEN campo = 5 AND orden = 1 THEN presentacion END,
	CASE WHEN campo = 5 AND orden = 2 THEN presentacion END DESC,
	CASE WHEN campo = 6 AND orden = 1 THEN stock END,
	CASE WHEN campo = 6 AND orden = 2 THEN stock END DESC,
    CASE WHEN campo = 7 AND orden = 1 THEN precio END,
	CASE WHEN campo = 7 AND orden = 2 THEN precio END DESC;
END
//
DELIMITER ;

#EJEMPLO:
CALL sp_insumos(7,2);