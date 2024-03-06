-- get insight into table
SELECT 
	top(100) * 
FROM Energy.MonthlyConsumption;

-- check all different years in Energy.MonthlyConsumption
SELECT DISTINCT
	Year
FROM Energy.MonthlyConsumption;

-- create the partition function (year <= 2020, year > 2020 AND year <= 2021, year > 2021 AND year <= 2022, year > 2022)
CREATE PARTITION FUNCTION
    MonthlyConsumption_PartitionByYear
	(INT)
AS RANGE LEFT FOR VALUES (2020, 2021, 2022);

-- create the partitions scheme on the primary filegroup
CREATE PARTITION SCHEME 
	PartScheme_MonthlyConsumption
AS PARTITION
	MonthlyConsumption_PartitionByYear 
ALL TO 
	( [PRIMARY] );

CREATE UNIQUE CLUSTERED INDEX PK_MonthlyConsumption ON Energy.MonthlyConsumption 
(Year, Month, VoltageLevel, DistrictMunicipalityParishCode)
WITH (DROP_EXISTING = ON) 
ON PartScheme_MonthlyConsumption(Year)

-- Number of records per partition
SELECT 
	p.partition_number AS partition_number,
	f.name AS file_group, 
	p.rows AS row_count
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'MonthlyConsumption'
ORDER BY partition_number;




