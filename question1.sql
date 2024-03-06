-- get insight into table
SELECT 
	top(100) * 
FROM 
	Energy.MonthlyConsumption;

-- check all different years in Energy.MonthlyConsumption
SELECT DISTINCT
	year
FROM
	Energy.MonthlyConsumption;

-- create the partition function (year <= 2020, year > 2020 AND year <= 2021, year > 2021 AND year <= 2022, year > 2022)
CREATE PARTITION FUNCTION
    MonthlyConsumption_PartitionByYear
	(INT)
AS RANGE LEFT FOR VALUES 
	(2020, 2021, 2022);

-- create the partitions scheme on the primary filegroup
CREATE PARTITION SCHEME 
	PartScheme_MonthlyConsumption
AS PARTITION
	MonthlyConsumption_PartitionByYear 
ALL TO
	( [PRIMARY] );

-- Number of records per partition
SELECT 
	$PARTITION.MonthlyConsumption_PartitionByYear(Year) AS PartitionNumber,
    COUNT(*) AS RecordCount
FROM 
	Energy.MonthlyConsumption
GROUP BY 
	$PARTITION.MonthlyConsumption_PartitionByYear(Year);




