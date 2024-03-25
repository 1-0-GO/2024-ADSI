CREATE VIEW Energy.vMonthlyConsumptionByLocation WITH SCHEMABINDING AS 
SELECT [DistrictMunicipalityParishCode],
		 [District],
		 [Municipality],
		 [Parish],
		 SUM([ActiveEnergy]) AS [ActiveEnergy],
		 COUNT_BIG(*) AS Counting
	 FROM [Energy].[MonthlyConsumption]
	 GROUP BY [DistrictMunicipalityParishCode],
		 [District],
		 [Municipality],
		 [Parish]; 

CREATE UNIQUE CLUSTERED INDEX IX_MonthlyConsumptionByLocation 
ON Energy.vMonthlyConsumptionByLocation (DistrictMunicipalityParishCode, District, Municipality, Parish);


CREATE VIEW Energy.vNumberContractsByLocation WITH SCHEMABINDING AS 
SELECT [DistrictMunicipalityParishCode],
		 [District],
		 [Municipality],
		 [Parish],
		SUM([NumberContracts]) AS [NumberContracts],
		COUNT_BIG(*) AS Counting
	 FROM [Energy].[ActiveContracts]
	 GROUP BY [DistrictMunicipalityParishCode],
		 [District],
		 [Municipality],
		 [Parish];

CREATE UNIQUE CLUSTERED INDEX IX_NumberContractsByLocation 
ON Energy.vNumberContractsByLocation (DistrictMunicipalityParishCode, District, Municipality, Parish);