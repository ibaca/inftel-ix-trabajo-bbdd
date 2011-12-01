-- clean up
DELETE presupuestos;
DELETE pedidos;
DELETE ofertas;
DELETE proveedores;
DELETE productos;
DELETE departamentos;

-- departamentos internos
INSERT INTO departamentos VALUES (1001,'direccion',departamento_tipos('interno'),'123 321 001');
INSERT INTO departamentos VALUES (1002,'administracion',departamento_tipos('interno'),'123 321 002');
INSERT INTO departamentos VALUES (1003,'logistica',departamento_tipos('interno'),'123 321 003');
INSERT INTO departamentos VALUES (1004,'mantenimiento',departamento_tipos('interno'),'123 321 004');
INSERT INTO departamentos VALUES (1005,'almacen',departamento_tipos('interno'),'123 321 005');
-- departamentos venta al publico
INSERT INTO departamentos VALUES (2001,'alimentacion',departamento_tipos('publico'),'223 321 001');
INSERT INTO departamentos VALUES (2002,'electrodomesticos',departamento_tipos('publico'),'223 321 002');
INSERT INTO departamentos VALUES (2003,'mobiliario',departamento_tipos('publico'),'223 321 003');
INSERT INTO departamentos VALUES (2004,'jugeteria',departamento_tipos('publico'),'223 321 004');
-- departamentos mixtos
INSERT INTO departamentos VALUES (3001,'informatica',departamento_tipos('interno','publico'),'123 321 000');
INSERT INTO departamentos VALUES (3002,'limpieza',departamento_tipos('interno','publico'),'123 321 000');
-- select * from departamentos, table(departamentos.tipo);

-- presupuestos
INSERT INTO presupuestos VALUES ('2001', '2008', '100','110','190');
INSERT INTO presupuestos VALUES ('2001', '2009', '150','140','250');
INSERT INTO presupuestos VALUES ('2001', '2010', '200','220','320');
INSERT INTO presupuestos (departamento_id,ejercicio) VALUES ('2001', '2011');
INSERT INTO presupuestos (departamento_id,ejercicio,estimado,gasto_acumulado) VALUES ('2002', '2010', '100','120');
INSERT INTO presupuestos (departamento_id,ejercicio,estimado,gasto_acumulado) VALUES ('2003', '2010', '250','260');
INSERT INTO presupuestos (departamento_id,ejercicio,estimado,gasto_acumulado) VALUES ('2004', '2010', '650','600');
INSERT INTO presupuestos (departamento_id,ejercicio,estimado,gasto_acumulado) VALUES ('3001', '2009', '450','400');
INSERT INTO presupuestos (departamento_id,ejercicio,estimado,gasto_acumulado) VALUES ('3001', '2010', '500','500');
-- select * from presupuestos;

-- productos                                                                                                                                                      ( ID            ,nombre      ,descripcion      ,pvp  ,existencias_num, existencias_min ,existencias_max ,stock_num ,stock_min ,stock_max ,departamento_id) 
INSERT INTO productos ( ID, nombre, descripcion, pvp, existencias_num, existencias_min, existencias_max, stock_num, stock_min, stock_max, departamento_id) VALUES ('0001367000001','CocaCola'  ,'Cocacola 33cl'  ,'01' ,'30'           ,'4'              ,'80'            ,'200'     ,'50'      ,'300'     ,2001);
INSERT INTO productos ( ID, nombre, descripcion, pvp, existencias_num, existencias_min, existencias_max, stock_num, stock_min, stock_max, departamento_id) VALUES ('0001367000005','Lejia'     ,'Lejia 5l'       ,'02' ,'25'           ,'8'              ,'30'            ,'100'     ,'10'      ,'200'     ,3002);
INSERT INTO productos ( ID, nombre, descripcion, pvp, existencias_num, existencias_min, existencias_max, stock_num, stock_min, stock_max, departamento_id) VALUES ('0001367000007','Silla'     ,'Silla Ordenador','20' ,'05'           ,'2'              ,'10'            ,'050'     ,'10'      ,'100'     ,2003);
INSERT INTO productos ( ID, nombre, descripcion, pvp, existencias_num, existencias_min, existencias_max, stock_num, stock_min, stock_max, departamento_id) VALUES ('0001367000008','Scalextric','Escalextric GT' ,'70' ,'03'           ,'2'              ,'10'            ,'050'     ,'10'      ,'100'     ,2004);
INSERT INTO productos ( ID, nombre, descripcion, pvp, existencias_num, existencias_min, existencias_max, stock_num, stock_min, stock_max, departamento_id) VALUES ('0001367000009','RAM'       ,'2GB RAM'        ,'50' ,'05'           ,'2'              ,'10'            ,'050'     ,'10'      ,'100'     ,3001);
-- select * from productos;

-- proveedores
INSERT INTO proveedores ( ID, cif, nombre, telefono, direccion) VALUES ('1', 'B13450901', 'Repartos Ignacio', '952102371', 'Pol. Santa Inés 27');
INSERT INTO proveedores ( ID, cif, nombre, telefono, direccion) VALUES ('2', 'B13450902', 'Repartos Juan Antonio', '952102375', 'Pol. Santa Barbara 45');
INSERT INTO proveedores ( ID, cif, nombre, telefono, direccion) VALUES ('3', 'B13450903', 'Repartos Jesús', '952102377', 'Pol. Santa Colonia 19');
INSERT INTO proveedores ( ID, cif, nombre, telefono, direccion) VALUES ('4', 'B13450904', 'Repartos Málaga', '952102378', 'Pol. San Manuel 8');
-- select * from proveedores;

-- ofertas
INSERT INTO ofertas (proveedor_id, producto_id, precio, minimo, paquete, tardanza) VALUES (1, 1367000001, 0.23,'1000','100',5);
INSERT INTO ofertas (proveedor_id, producto_id, precio, minimo, paquete, tardanza) VALUES (1, 1367000001, 0.20,'5000','100',10);
INSERT INTO ofertas (proveedor_id, producto_id, precio, minimo, paquete, tardanza) VALUES (2, 1367000001, 0.36,'500','50',1);
INSERT INTO ofertas (proveedor_id, producto_id, precio, minimo, paquete, tardanza) VALUES (3, 1367000001, 0.15,'10000','1000',25);
INSERT INTO ofertas (proveedor_id, producto_id, precio, minimo, paquete, tardanza) VALUES (1, 1367000008,   50,'10','1','2');
INSERT INTO ofertas (proveedor_id, producto_id, precio, minimo, paquete, tardanza) VALUES (2, 1367000008,   40,'20','2','4');
INSERT INTO ofertas (proveedor_id, producto_id, precio, minimo, paquete, tardanza) VALUES (3, 1367000008,   37,'25','5','5');
INSERT INTO ofertas (proveedor_id, producto_id, precio, minimo, paquete, tardanza) VALUES (4, 1367000008,   30,'50','5','10');
-- select * from ofertas;
