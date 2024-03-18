SELECT [Parish], [Year], SUM([ActiveEnergy]) AS [Ac]
FROM [Energy].[MonthlyConsumption] 
WHERE [Municipality] = 'Lisboa'
 AND [Month] = '06'
GROUP BY [Parish], [Year]
ORDER BY [Parish], [Year]

