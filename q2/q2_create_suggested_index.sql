CREATE NONCLUSTERED INDEX IX_MonthMunicipalityParishActiveEnergy
ON [Energy].[MonthlyConsumption] ([Month], [Municipality]) 
INCLUDE ([Parish], [ActiveEnergy])

CREATE NONCLUSTERED INDEX IX_MonthMunicipalityActiveEnergy
ON [Energy].[MonthlyConsumption] ([Month], [Municipality]) 
INCLUDE ([ActiveEnergy])