CREATE OR REPLACE PROCEDURE inicia_compra (caja IN cajas.id%TYPE) AS
/* Declaraciones locales */
DECLARE
venta ventas.id%TYPE;
BEGIN
  /* Sentencias */
  SELECT 
  
EXCEPTION
/* Errores */
END inicia_compra;
/

CREATE SEQUENCE ventas_id_SEQ 
    NOCACHE 
    ORDER ;
/

CREATE OR REPLACE TRIGGER ventas_id_TRG 
BEFORE INSERT ON ventas 
FOR EACH ROW 
BEGIN 
  SELECT ventas_id_SEQ.NEXTVAL INTO :NEW.id FROM DUAL; 
  SELECT CURRENT_DATE INTO :NEW.fecha_hora FROM DUAL;
END;
/

show err;