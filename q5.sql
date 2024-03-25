USE ProjectDB;
GO
SELECT [Parish], [Year], SUM([ActiveEnergy]) AS [Ac]
FROM [Energy].[MonthlyConsumption] 
WHERE [Municipality] = 'Lisboa'
 AND [Month] = '06'
GROUP BY [Parish], [Year]
ORDER BY [Parish], [Year];
GO

USE ProjectDB;
GO
SELECT [Energy].[DistrictMunicipalityParishCode],
	[Energy].[District],
	[Energy].[Municipality],
	[Energy].[Parish],
	[Energy].[ActiveEnergy],
	[Contracts].[NumberContracts],
	[Energy].[ActiveEnergy] / [Contracts].[NumberContracts] AS EnergyPerContract
FROM 
	(
	SELECT [DistrictMunicipalityParishCode],
		 [District],
		 [Municipality],
		 [Parish],
		 SUM([ActiveEnergy]) AS [ActiveEnergy]
	 FROM [Energy].[MonthlyConsumption]
	 GROUP BY [DistrictMunicipalityParishCode],
		 [District],
		 [Municipality],
		 [Parish]
	) AS [Energy],
	(
	 SELECT [DistrictMunicipalityParishCode],
		 [District],
		 [Municipality],
		 [Parish],
		SUM([NumberContracts]) AS [NumberContracts]
	 FROM [Energy].[ActiveContracts]
	 GROUP BY [DistrictMunicipalityParishCode],
		 [District],
		 [Municipality],
		 [Parish]
	) AS [Contracts]
WHERE [Energy].[DistrictMunicipalityParishCode] =
	[Contracts].[DistrictMunicipalityParishCode]
ORDER BY [Energy].[District],
	 [Energy].[Municipality],
	 [Energy].[Parish];
GO
