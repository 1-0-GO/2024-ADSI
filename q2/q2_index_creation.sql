-- force index
CREATE NONCLUSTERED INDEX IX_MonthParishActiveEnergy
ON [Energy].[MonthlyConsumption] ([Month]) 
INCLUDE ([Parish], [ActiveEnergy])

CREATE NONCLUSTERED INDEX IX_MunicipalityParishActiveEnergy
ON [Energy].[MonthlyConsumption] ([Municipality]) 
INCLUDE ([Parish], [ActiveEnergy])

ALTER TABLE [Energy].[MonthlyConsumption] 
DROP CONSTRAINT PK_MonthlyConsumption; 

CREATE CLUSTERED INDEX IX_ParishYear
ON [Energy].[MonthlyConsumption] ([Parish], [Year]);