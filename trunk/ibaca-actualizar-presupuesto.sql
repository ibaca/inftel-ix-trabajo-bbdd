--------------------------------------------------------
--  DDL for Procedure ACTUALIZAR_PRESUPUESTO 
--------------------------------------------------------
CREATE OR REPLACE PROCEDURE ACTUALIZAR_PRESUPUESTO 
(
  A_DATE IN DATE DEFAULT NULL
) AS 
CURSOR cur_departamentos IS SELECT * FROM departamentos;
p_departamento departamentos%ROWTYPE;
p_flag NUMBER;
p_year NUMBER := to_number(to_char(nvl(a_date, CURRENT_DATE),'YYYY'));
p_acumulado NUMBER;
BEGIN
  -- si a_date es null se calcula el acumulado anual reinicializando los
  -- acumulados, si es una fecha, se acumula para esa fecha
  FOR p_departamento IN cur_departamentos LOOP
    
    SELECT count(*) INTO p_flag FROM presupuestos p  
      WHERE p.departamento_id = p_departamento.ID AND p.ejercicio = p_year;
    
    IF p_flag = 0 THEN
      -- si no existe se crea
      INSERT INTO presupuestos (departamento_id, ejercicio) 
        VALUES (p_departamento.ID, p_year);
    ELSIF a_date IS NULL THEN
      -- si existe y es calculo anual se reinicia
      UPDATE presupuestos p SET p.gasto_acumulado = 0, p.ingreso_acumulado = 0
        WHERE p.departamento_id = p_departamento.ID AND p.ejercicio = p_year;
    END IF;
    
    -- se calcula el acumulado de ingresos
    IF a_date IS NULL THEN
      -- si fecha null calculo anual
      SELECT sum(l.cantidad*l.pvp) INTO p_acumulado
        FROM ventas v, venta_lista_productos l, productos p, departamentos d
        WHERE 
          -- clausulas para los joins
          v.ID = l.venta_id AND l.producto_id = p.ID AND d.ID = p.departamento_id AND
          -- filtro del departamento actual
          d.ID = p_departamento.ID AND
          -- filtro del intervalo
          v.fecha_hora BETWEEN trunc(CURRENT_DATE,'YYYY') AND add_months(trunc(CURRENT_DATE,'YYYY'),12);
      -- se actualiza el acumulado de ingresos
      IF p_acumulado IS NOT NULL THEN
        UPDATE presupuestos p SET p.ingreso_acumulado = p_acumulado
          WHERE p.departamento_id = p_departamento.ID AND p.ejercicio = p_year;
      END IF;
    ELSE
      -- si fecha no null se calcula para el dia de la fecha
      SELECT sum(l.cantidad*l.pvp) INTO p_acumulado
        FROM ventas v, venta_lista_productos l, productos p, departamentos d
        WHERE 
          -- clausulas para los joins
          v.ID = l.venta_id AND l.producto_id = p.ID AND d.ID = p.departamento_id AND
          -- filtro del departamento actual
          d.ID = p_departamento.ID AND
          -- filtro del intervalo
          v.fecha_hora BETWEEN trunc(CURRENT_DATE,'DDD') AND trunc(CURRENT_DATE+1,'DDD');
      -- se actualiza el acumulado de ingresos
      IF p_acumulado IS NOT NULL THEN
        UPDATE presupuestos p SET p.ingreso_acumulado = p.ingreso_acumulado + p_acumulado
          WHERE p.departamento_id = p_departamento.ID AND p.ejercicio = p_year;
      END IF;
    END IF;
    dbms_output.put_line('actualizado acumulado departamento:'||p_departamento.ID||' ejercicio:'||p_year||' acum.ingreso:'||nvl(p_acumulado,'ninguna venta'));
    
    -- se calcula el acumulado de gastos
    IF a_date IS NULL THEN
      -- si fecha null calculo anual
      SELECT sum(x.cantidad*o.precio) INTO p_acumulado
        FROM pedidos x, ofertas o, productos p, departamentos d
        WHERE 
          -- clausulas para los joins
          x.oferta_id = o.id AND o.producto_id = p.ID AND p.departamento_id = d.id AND
          -- filtro del departamento actual
          d.ID = p_departamento.ID AND
          -- filtro del intervalo
          x.fecha_hora BETWEEN trunc(CURRENT_DATE,'YYYY') AND add_months(trunc(CURRENT_DATE,'YYYY'),12);
      -- se actualiza el acumulado de ingresos
      IF p_acumulado IS NOT NULL THEN
        UPDATE presupuestos p SET p.ingreso_acumulado = p_acumulado
          WHERE p.departamento_id = p_departamento.ID AND p.ejercicio = p_year;
      END IF;
    ELSE
      -- si fecha no null se calcula para el dia de la fecha
      SELECT sum(x.cantidad*o.precio) INTO p_acumulado
        FROM pedidos x, ofertas o, productos p, departamentos d
        WHERE 
          -- clausulas para los joins
          x.oferta_id = o.id AND o.producto_id = p.ID AND p.departamento_id = d.id AND
          -- filtro del departamento actual
          d.ID = p_departamento.ID AND
          -- filtro del intervalo
          x.fecha_hora BETWEEN trunc(CURRENT_DATE,'DDD') AND trunc(CURRENT_DATE+1,'DDD');
      IF p_acumulado IS NOT NULL THEN
        UPDATE presupuestos p SET p.gasto_acumulado = p.gasto_acumulado + p_acumulado
          WHERE p.departamento_id = p_departamento.ID AND p.ejercicio = p_year;
      END IF;
    END IF;
    dbms_output.put_line('actualizado acumulado departamento:'||p_departamento.id||' ejercicio:'||p_year||' acum.gasto:'||nvl(p_acumulado,'ninguna venta'));
  
  END LOOP;
END ACTUALIZAR_PRESUPUESTO;
/