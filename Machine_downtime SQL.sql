-- FIRST MOMENT BUSINESS DECISION - MEASURE OF CENTRAL TENDENCY
-- MEAN

SELECT AVG(Hydraulic_Pressure) FROM MD;
SELECT AVG(Coolant_Pressure) FROM MD;
SELECT AVG(Air_System_Pressure) FROM MD;
SELECT AVG(Coolant_Temperature) FROM MD;
SELECT AVG(Hydraulic_Oil_Temperature) FROM MD;
SELECT AVG(Spindle_Bearing_Temperature) FROM MD;
SELECT AVG(Spindle_Vibration) FROM MD;
SELECT AVG(Tool_Vibration) FROM MD;
SELECT AVG(Spindle_Speed) FROM MD;
SELECT AVG(Voltage) FROM MD;
SELECT AVG(Torque) FROM MD;
SELECT AVG(Cutting) FROM MD;

--MEDIAN
SELECT Hydraulic_Pressure AS MEDIAN 
FROM (
	SELECT Hydraulic_Pressure, ROW_NUMBER() OVER(ORDER BY(Hydraulic_Pressure)) AS ROW_NUM,
COUNT(*) OVER() AS TOTAL_COUNT
FROM MD) AS SUBQUERY
WHERE ROW_NUM = (TOTAL_COUNT+1)/2 or ROW_NUM = (TOTAL_COUNT+2)/2; 

SELECT Coolant_Pressure AS MEDIAN
FROM (
SELECT Coolant_Pressure,ROW_NUMBER() OVER(ORDER BY (Coolant_Pressure)) AS ROW_NUM,
COUNT(*) OVER() AS TOTAL_COUNT
FROM MD) AS SUBQUERY
WHERE ROW_NUM = (TOTAL_COUNT+1)/2 or ROW_NUM = (TOTAL_COUNT+2)/2;

SELECT Air_System_Pressure AS MEDIAN
FROM (
SELECT Air_System_Pressure, ROW_NUMBER() OVER(ORDER BY(Air_System_Pressure)) AS ROW_NUM,
COUNT(*) OVER() AS TOTAL_COUNT
FROM MD) AS SUBQUERY
WHERE ROW_NUM = (TOTAL_COUNT+1)/2 or ROW_NUM = (TOTAL_COUNT+2)/2;

SELECT Coolant_Temperature AS MEDIAN
FROM (
SELECT Coolant_Temperature,ROW_NUMBER() OVER(ORDER BY(Coolant_Temperature)) AS ROW_NUM,
COUNT(*) OVER() AS TOTAL_COUNT
FROM MD) AS SUBQUERY
WHERE ROW_NUM = (TOTAL_COUNT+1)/2 or ROW_NUM = (TOTAL_COUNT+2)/2;

SELECT Hydraulic_Oil_Temperature AS MEDIAN
FROM (
SELECT Hydraulic_Oil_Temperature,ROW_NUMBER() OVER(ORDER BY(Hydraulic_Oil_Temperature)) AS ROW_NUM,
COUNT(*) OVER() AS TOTAL_COUNT
FROM MD) AS SUBQUERY
WHERE ROW_NUM = (TOTAL_COUNT+1)/2 or ROW_NUM = (TOTAL_COUNT+2)/2;

SELECT Spindle_Bearing_Temperature AS MEDIAN
FROM (
SELECT Spindle_Bearing_Temperature(°C)",ROW_NUMBER() OVER(ORDER BY(Spindle_Bearing_Temperature)) AS ROW_NUM,
COUNT(*) OVER() AS TOTAL_COUNT
FROM MD) AS SUBQUERY
WHERE ROW_NUM = (TOTAL_COUNT+1)/2 or ROW_NUM = (TOTAL_COUNT+2)/2;

SELECT Spindle_Vibration AS MEDIAN
FROM (
SELECT Spindle_Vibration,ROW_NUMBER() OVER(ORDER BY(Spindle_Vibration)) AS ROW_NUM,
COUNT(*) OVER() AS TOTAL_COUNT
FROM MD) AS SUBQUERY
WHERE ROW_NUM = (TOTAL_COUNT+1)/2;

SELECT Tool_Vibration AS MEDIAN
FROM (
SELECT Tool_Vibration,ROW_NUMBER() OVER(ORDER BY(Tool_Vibration)) AS ROW_NUM,
COUNT(*) OVER() AS TOTAL_COUNT
FROM MD) AS SUBQUERY
WHERE ROW_NUM = (TOTAL_COUNT+1)/2 or ROW_NUM = (TOTAL_COUNT+2)/2;

--Alternative method to calculate median
select percentile_cont(0.5) within group (order by Voltage) as median from md;
select percentile_cont(0.5) within group (order by Spindle_Speed) as median from md;

SELECT Torque AS MEDIAN
FROM (
SELECT Torque,ROW_NUMBER() OVER(ORDER BY(Torque)) AS ROW_NUM,
COUNT(*) OVER() AS TOTAL_COUNT
FROM MD) AS SUBQUERY
WHERE ROW_NUM = (TOTAL_COUNT+1)/2 or ROW_NUM = (TOTAL_COUNT+2)/2;

SELECT Cutting AS MEDIAN
FROM (
SELECT Cutting,ROW_NUMBER() OVER(ORDER BY(Cutting)) AS ROW_NUM,
COUNT(*) OVER() AS TOTAL_COUNT
FROM MD) AS SUBQUERY
WHERE ROW_NUM = (TOTAL_COUNT+1)/2 or ROW_NUM = (TOTAL_COUNT+2)/2;

--MODE
SELECT Date, COUNT(*) FROM MD GROUP BY Date ORDER BY Date DESC LIMIT 1;
SELECT Machine_ID, COUNT(*) FROM MD GROUP BY Machine_ID ORDER BY Machine_ID DESC LIMIT 1;
SELECT Assembly_Line_No, COUNT(*) FROM MD GROUP BY Assembly_Line_No ORDER BY Assembly_Line_No DESC LIMIT 1;
SELECT Downtime, COUNT(*) as count FROM MD GROUP BY Downtime ORDER BY count desc LIMIT 1;

--SECOND MOMENT BUSINESS DECISION - MEASURE OF DISPERSION
--VARIANCE
-- SELECT VARIANCE(Date) FROM MD; - VARIANCE(TEXT) DOEAS NOT EXIST
SELECT VARIANCE(Hydraulic_Pressure) FROM MD;
SELECT VARIANCE(Coolant_Pressure) FROM MD;
SELECT VARIANCE(Air_System_Pressure) FROM MD;
SELECT VARIANCE(Coolant_Temperature) FROM MD;
SELECT VARIANCE(Hydraulic_Oil_Temperature) FROM MD;
SELECT VARIANCE(Spindle_Bearing_Temperature) FROM MD;
SELECT VARIANCE(Spindle_Vibration) FROM MD;
SELECT VARIANCE(Tool_Vibration() FROM MD;
SELECT VARIANCE(Spindle_Speed) FROM MD;
SELECT VARIANCE(Voltage) FROM MD;
SELECT VARIANCE(Torque) FROM MD;
SELECT VARIANCE(Cutting) FROM MD;

-- STANDARD DEVIATION
SELECT STDDEV(Hydraulic_Pressure) FROM MD;
SELECT STDDEV(Coolant_Pressure) FROM MD;
SELECT STDDEV(Air_System_Pressure) FROM MD;
SELECT STDDEV(Coolant_Temperature) FROM MD;
SELECT STDDEV(Hydraulic_Oil_Temperature) FROM MD;
SELECT STDDEV(Spindle_Bearing_Temperature) FROM MD;
SELECT STDDEV(Spindle_Vibration) FROM MD;
SELECT STDDEV(Tool_Vibration) FROM MD;
SELECT STDDEV(Spindle_Speed) FROM MD;
SELECT STDDEV(Voltage) FROM MD;
SELECT STDDEV(Torque) FROM MD;
SELECT STDDEV(Cutting) FROM MD;

--RANGE
SELECT MAX(Hydraulic_Pressure)-MIN(Hydraulic_Pressure) FROM MD;
SELECT MAX(Coolant_Pressure)-MIN(Coolant_Pressure) FROM MD;
SELECT MAX(Air_System_Pressure)-MIN(Air_System_Pressure) FROM MD;
SELECT MAX(Coolant_Temperature)-MIN(Coolant_Temperature) FROM MD;
SELECT MAX(Hydraulic_Oil_Temperature)-MIN(Hydraulic_Oil_Temperature) FROM MD;
SELECT MAX(Spindle_Bearing_Temperature)-MIN(Spindle_Bearing_Temperature) FROM MD;
SELECT MAX(Spindle_Vibration)-MIN(Spindle_Vibration) FROM MD;
SELECT MAX(Tool_Vibration)-MIN(Tool_Vibration) FROM MD;
SELECT MAX(Spindle_Speed)-MIN(Spindle_Speed) FROM MD;
SELECT MAX(Voltage)-MIN(Voltage) FROM MD;
SELECT MAX(Torque)-MIN(Torque) FROM MD;
SELECT MAX(Cutting)-MIN(Cutting) FROM MD;

--THIRD MOMENT BUSINESS DECISION - MEASURE OF ASYMMETRY
SELECT
(SUM(POWER(Hydraulic_Pressure-(SELECT AVG(Hydraulic_Pressure) FROM MD),3))/
	(COUNT(*)* POWER((SELECT STDDEV("Hydraulic_Pressure) FROM MD),3))
	)AS SKEWNESS FROM MD;
	
SELECT (
SUM(POWER(Coolant_Pressure-(SELECT AVG(Coolant_Pressure)FROM MD),3))/
	(COUNT(*)* POWER((SELECT STDDEV("Coolant_Pressure) FROM MD),3))
	) AS SKEWNESS FROM MD;
	
SELECT (
SUM(POWER(Air_System_Pressure-(SELECT AVG(Air_System_Pressure) FROM MD),3))/
	(COUNT(*)* POWER((SELECT STDDEV(Air_System_Pressure) FROM MD),3))
	 ) AS SKEWNESS FROM MD;
	 
SELECT (
SUM(POWER(Coolant_Temperature-(SELECT AVG(Coolant_Temperature) FROM MD),3))/
(COUNT(*)* POWER((SELECT STDDEV(Coolant_Temperature) FROM MD),3))
	) AS SKEWNESS FROM MD;

SELECT (
SUM(POWER(Hydraulic_Oil_Temperature-(SELECT AVG(Hydraulic_Oil_Temperature) FROM MD),3))/
(COUNT(*)* POWER((SELECT STDDEV(Hydraulic_Oil_Temperature) FROM MD),3))
	) AS SKEWNESS FROM MD;
	
SELECT (
SUM(POWER(Spindle_Bearing_Temperature-(SELECT AVG(Spindle_Bearing_Temperature) FROM MD),3))/
(COUNT(*)* POWER((SELECT STDDEV("Spindle_Bearing_Temperature(°C)") FROM MD),3))
	) AS SKEWNESS FROM MD;

SELECT (
SUM(POWER(Spindle_Vibration-(SELECT AVG(Spindle_Vibration) FROM MD),3))/
(COUNT(*)* POWER((SELECT STDDEV(Spindle_Vibration) FROM MD),3))
	) AS SKEWNESS FROM MD;
	
SELECT (
SUM(POWER(Tool_Vibration-(SELECT AVG(Tool_Vibration) FROM MD),3))/
(COUNT(*)* POWER((SELECT STDDEV(Tool_Vibration) FROM MD),3))
	) AS SKEWNESS FROM MD;
	
SELECT (
SUM(POWER(Spindle_Speed-(SELECT AVG(Spindle_Speed) FROM MD),3))/
(COUNT(*)* POWER((SELECT STDDEV(Spindle_Speed) FROM MD),3))
	) AS SKEWNESS FROM MD;
	
SELECT (
SUM(POWER(Voltage-(SELECT AVG(Voltage) FROM MD),3))/
(COUNT(*)* POWER((SELECT STDDEV(Voltage) FROM MD),3))
	) AS SKEWNESS FROM MD;
	
SELECT (
SUM(POWER(Torque-(SELECT AVG(Torque) FROM MD),3))/
(COUNT(*)* POWER((SELECT STDDEV(Torque) FROM MD),3))
	) AS SKEWNESS FROM MD;
	
SELECT (
SUM(POWER(Cutting-(SELECT AVG(Cutting) FROM MD),3))/
(COUNT(*)* POWER((SELECT STDDEV(Cutting) FROM MD),3))
	) AS SKEWNESS FROM MD;
	
--FOURTH MOMENT BUSINESS DECISION - MEASURE OF PEAKEDNESS

SELECT ((
SUM(POWER(Hydraulic_Pressure-(SELECT AVG(Hydraulic_Pressure)FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Hydraulic_Pressure)FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;
	   
SELECT ((
SUM(POWER(Coolant_Pressure-(SELECT AVG(Coolant_Pressure)FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Coolant_Pressure)FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;
	   
SELECT ((
SUM(POWER(Air_System_Pressure-(SELECT AVG(Air_System_Pressure)FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Air_System_Pressure)FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;
	   
SELECT ((
SUM(POWER(Coolant_Temperature-(SELECT AVG(Coolant_Temperature)FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Coolant_Temperature)FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;
	   
SELECT ((
SUM(POWER(Hydraulic_Oil_Temperature-(SELECT AVG(Hydraulic_Oil_Temperature)FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Hydraulic_Oil_Temperature)FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;
	   
SELECT ((
SUM(POWER(Spindle_Bearing_Temperature-(SELECT AVG(Spindle_Bearing_Temperature)FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Spindle_Bearing_Temperature)FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;
	   
SELECT ((
SUM(POWER(Spindle_Vibration-(SELECT AVG(Spindle_Vibration)FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Spindle_Vibration)FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;
	   
SELECT ((
SUM(POWER(Tool_Vibration-(SELECT AVG(Tool_Vibration)FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Tool_Vibration)FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;
	   
SELECT ((
SUM(POWER(Spindle_Speed-(SELECT AVG(Spindle_Speed)FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Spindle_Speed)FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;
	   
SELECT ((
SUM(POWER(Voltage-(SELECT AVG(Voltage) FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Voltage) FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;
	   
SELECT ((
SUM(POWER(Torque-(SELECT AVG(Torque)FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Torque)FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;
	   
SELECT ((
SUM(POWER(Cutting-(SELECT AVG(Cutting)FROM MD),4))/
	(COUNT(*)* POWER((SELECT STDDEV(Cutting)FROM MD),4)))-3
	   )AS KURTOSIS FROM MD;

--BI VARIENT ANALYSIS
SELECT CORR(Coolant_Pressure,Coolant_Temperature) FROM MD;
--SELECT CORR(Date,Coolant_Pressure) FROM MD; --ERROR:  function corr(text, double precision) does not exist
--SELECT CORR(Hydraulic_Pressure,Downtime)FROM MD;
SELECT CORR(Spindle_Speed,Voltage) FROM MD;
SELECT CORR(Voltage,Torque) FROM MD;
SELECT CORR(Spindle_Speed,Torque) FROM MD;
SELECT CORR(Hydraulic_Pressure,Hydraulic_Oil_Temperature) FROM MD;
SELECT CORR(Hydraulic_Pressure,Coolant_Pressure) FROM MD;
SELECT CORR(Air_System_Pressure,Hydraulic_Pressure) FROM MD;

--DATA CLEANING
--RENAMING COLUMN NAMES
ALTER TABLE MD RENAME "Date" TO Date;
ALTER TABLE MD RENAME "Machine_ID" TO Machine_ID;
ALTER TABLE MD RENAME "Assembly_Line_No" TO Assembly_Line_No;
ALTER TABLE MD RENAME "Hydraulic_Pressure(bar)" TO Hydraulic_Pressure;
ALTER TABLE MD RENAME "Coolant_Pressure(bar)" TO Coolant_Pressure;
ALTER TABLE MD RENAME "Air_System_Pressure(bar)" TO Air_System_Pressure;
ALTER TABLE MD RENAME "Coolant_Temperature" TO Coolant_temperature;
ALTER TABLE MD RENAME "Hydraulic_Oil_Temperature(°C)" TO Hydraulic_Oil_Temperature;
ALTER TABLE MD RENAME "Spindle_Bearing_Temperature(°C)" TO Spindle_Bearing_Temperature;
ALTER TABLE MD RENAME "Spindle_Vibration(µm)" TO Spindle_Vibration;
ALTER TABLE MD RENAME "Tool_Vibration(µm)" TO Tool_Vibration;
ALTER TABLE MD RENAME "Spindle_Speed(RPM)" TO Spindle_Speed;
ALTER TABLE MD RENAME "Voltage(volts)" TO Voltage;
ALTER TABLE MD RENAME "Torque(Nm)" TO Torque;
ALTER TABLE MD RENAME "Cutting(kN)" TO Cutting;
ALTER TABLE MD RENAME "Downtime" TO Downtime;

--MISSING VALUES
SELECT COUNT(*) FROM MD WHERE Date ISNULL;
SELECT COUNT(*) FROM MD WHERE Machine_ID ISNULL;
SELECT COUNT(*) FROM MD WHERE Assembly_Line_No ISNULL;
SELECT COUNT(*) FROM MD WHERE hydraulic_pressure ISNULL;
SELECT COUNT(*) FROM MD WHERE coolant_pressure ISNULL;
SELECT COUNT(*) FROM MD WHERE air_system_pressure ISNULL;
SELECT COUNT(*) FROM MD WHERE Coolant_Temperature ISNULL;
SELECT COUNT(*) FROM MD WHERE hydraulic_oil_temperature ISNULL;
SELECT COUNT(*) FROM MD WHERE spindle_bearing_temperature ISNULL;
SELECT COUNT(*) FROM MD WHERE spindle_vibration ISNULL;
SELECT COUNT(*) FROM MD WHERE tool_vibration ISNULL;
SELECT COUNT(*) FROM MD WHERE spindle_speed ISNULL;
SELECT COUNT(*) FROM MD WHERE voltage ISNULL;
SELECT COUNT(*) FROM MD WHERE torque ISNULL;
SELECT COUNT(*) FROM MD WHERE cutting ISNULL;
SELECT COUNT(*) FROM MD WHERE Downtime ISNULL;

-- HANDLING DUPLICATES
--IDENTIFY DUPLICATES USING CTID (DEFAULT UNIQUE COLUMN)
SELECT MAX(CTID) FROM MD GROUP BY hydraulic_pressure,coolant_pressure,torque,spindle_speed,"Downtime" HAVING COUNT(*) >1;
--There are no duplicates

--DELETING DUPLICATES
DELETE FROM MD WHERE CTID NOT IN (SELECT MAX(CTID) FROM MD GROUP BY "Downtime" HAVING COUNT(*) >1);

--ALTERNATIVE METHOD USING BACKUP TABLE BY DROPPING ORIGINAL TABLE
CREATE TABLE MPBACKUP AS SELECT DISTINCT * FROM MD;
SELECT * FROM MPBACKUP;
DROP TABLE MD;
ALTER TABLE MPBACKUP RENAME TO MD;

--ALTERNATIVE METHOD USING BACKUP TABLE BY WITHOUT DROPPING ORIGINAL TABLE
CREATE TABLE MPBACKUP AS SELECT DISTINCT * FROM MD;
SELECT * FROM MPBACKUP;
TRUNCATE TABLE MD;
INSERT INTO MD SELECT * FROM MPBACKUP;

--- MEAN IMPUTATION
UPDATE MD SET CUTTING = (
						SELECT AVG(CUTTING) FROM MD WHERE CUTTING IS NOT NULL) 
						WHERE CUTTING IS NULL;
--MEDIAN IMPUTATION
update md set Voltage = (select percentile_cont(0.5) within group (order by Voltage) from md) where Voltage is null;
update md set spindle_speed = (select percentile_cont(0.5) within group (order by Spindle_Speed) from md) where spindle_speed is null;
update md set hydraulic_pressure = (
	select percentile_cont(0.5) within group (order by hydraulic_pressure) from md
	) where hydraulic_pressure is null;			

--MODE IMPUTATION
update md set downtime = (select downtime from (
select downtime,count(*) as freq from md group by downtime order by freq desc limit 1) as subquery) where downtime is null;

-- FORWARD FILL				
SELECT spindle_bearing_temperature,COALESCE(
    spindle_bearing_temperature, LAG(spindle_bearing_temperature) OVER (ORDER BY spindle_bearing_temperature )
  ) AS forward_filled_value FROM md;

-- BACKWARD FILL
SELECT spindle_speed,COALESCE(
   spindle_speed , Lead(spindle_speed) OVER (ORDER BY spindle_speed)
  ) AS backward_filled_value FROM md;
				
--OUTLIER DETECTION				
WITH RANKED_DATA AS (SELECT SPINDLE_SPEED,PERCENT_RANK() OVER (ORDER BY SPINDLE_SPEED) AS PERCENT_RANK FROM MD)
				SELECT SPINDLE_SPEED FROM RANKED_DATA WHERE PERCENT_RANK < 0.05 OR PERCENT_RANK >0.95;
				
WITH RANKED_DATA AS (SELECT tool_vibration,PERCENT_RANK() OVER (ORDER BY TOOL_VIBRATION) AS PERCENT_RANK FROM MD)
				SELECT TOOL_VIBRATION FROM RANKED_DATA WHERE PERCENT_RANK < 0.05 OR PERCENT_RANK > 0.95;
				
-- rectify outliers
WITH percentiles AS (
    SELECT
        PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY tool_vibration) AS percentile_05,
        PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY tool_vibration) AS percentile_95
    FROM md
)
UPDATE md
SET tool_vibration = 
    CASE 
        WHEN tool_vibration < (SELECT percentile_05 FROM percentiles) THEN (SELECT percentile_05 FROM percentiles)
        WHEN tool_vibration > (SELECT percentile_95 FROM percentiles) THEN (SELECT percentile_95 FROM percentiles)
        ELSE tool_vibration
    END;

select * from md;

-- DISCRETISATION / BINARISATION
alter table md alter column coolant_temperature type text;
UPDATE MD
SET COOLANT_TEMPERATURE =
    CASE 
        WHEN COOLANT_TEMPERATURE::FLOAT < 5 THEN 'LOW'
        WHEN COOLANT_TEMPERATURE::FLOAT > 35 THEN 'HIGH'
        ELSE 'MEDIUM'
    END;

-- LABEL ENCODING
select downtime , case
				when downtime = 'Machine_Failure' then 1
				else 0
				end
				from md;

--DUMMY VARIABLES/ BINARY
select downtime , case
				when downtime = 'Machine_Failure' then 1 else 0 end as failure,
				case
				when downtime = 'no_machine_failure' then 1 else 0 end as nofailure
				from md;

--Yeo-Johnson Transformation on a numeric column
UPDATE md
SET hydraulic_oil_temperature = 
    CASE
        WHEN hydraulic_oil_temperature >= 0
            THEN (POWER(hydraulic_oil_temperature + 1, 0.5) - 1)/0.5
        WHEN hydraulic_oil_temperature < 0
            THEN (- (POWER(ABS(hydraulic_oil_temperature) + 1, 0.5) - 1))/0.5
    END;

--  Box-Cox Transformation on a numeric column
UPDATE md
SET air_system_pressure =
    CASE
        WHEN air_system_pressure > 0
            THEN (POWER(air_system_pressure, 0.5) - 1) / 0.5
        WHEN air_system_pressure = 0
            THEN LN(1)
    END;

--  sqrt transformation
update md set coolant_pressure = sqrt(coolant_pressure);

-- NORMALISATION
create table machine_downtime as 
				select date,machine_id,assembly_line_no,(hydraulic_pressure-(select min(hydraulic_pressure) from md)/(select max(hydraulic_pressure) from md)-(select min(hydraulic_pressure) from md)) 
				as hydraulic_pressure,
(coolant_pressure-(select min(coolant_pressure) from md)/(select max(coolant_pressure) from md)-(select min(coolant_pressure) from md)) 
				as coolant_pressure,
(air_system_pressure-(select min(air_system_pressure) from md)/(select max(air_system_pressure) from md)-(select min(air_system_pressure) from md)) 
				as air_system_pressure,
coolant_temperature,
(hydraulic_oil_temperature-(select min(hydraulic_oil_temperature) from md)/(select max(hydraulic_oil_temperature) from md)-(select min(hydraulic_oil_temperature) from md)) 
				as hydraulic_oil_temperature,				
(spindle_bearing_temperature-(select min(spindle_bearing_temperature) from md)/(select max(spindle_bearing_temperature) from md)-(select min(spindle_bearing_temperature) from md)) 
				as spindle_bearing_temperature,
(spindle_vibration-(select min(spindle_vibration) from md)/(select max(spindle_vibration) from md)-(select min(spindle_vibration) from md)) 
				as spindle_vibration,
(tool_vibration-(select min(tool_vibration) from md)/(select max(tool_vibration) from md)-(select min(tool_vibration) from md)) 
				as tool_vibration,
(spindle_speed-(select min(spindle_speed) from md)/(select max(spindle_speed) from md)-(select min(spindle_speed) from md)) 
				as spindle_speed,
(voltage-(select min(voltage) from md)/(select max(voltage) from md)-(select min(voltage) from md)) 
				as voltage,
(torque-(select min(torque) from md)/(select max(torque) from md)-(select min(torque) from md)) 
				as torque,
(cutting-(select min(cutting) from md)/(select max(cutting) from md)-(select min(cutting) from md)) 
				as cutting,	downtime
from md;
				
select * from machine_downtime;

