set serverout on;

SELECT * FROM PRODUCTOS;
UPDATE productos SET existencias_num = 0;

UPDATE productos SET existencias_min = 5;


ALTER TABLE proveedores ADD CONSTRAINT check_comp 
   CHECK (cif IS NOT NULL OR nombre IS NOT NULL);
   
ALTER TABLE proveedores ADD (calculada AS (nvl(cif,nombre)));

DECLARE

BEGIN
CASE
    WHEN b IS NULL THEN dbms_output.put_line('unknown');
    WHEN b THEN dbms_output.put_line('yes');
    WHEN NOT b THEN dbms_output.put_line('no');
    ELSE NULL;
  END CASE;
END;
   
   
INSERT INTO proveedores (ID,cif,nombre) VALUES (4,'','a');

select * from proveedores;