--Returns the result in US format 2018-04-15 (YYYY-MM-DD)
SELECT [dbo].[GetStringToDate] ('15 04 18','dd mm yy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('15 04 2018','dd mm yyyy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('15 04 18','dd mm yy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('15 Apr 2018','dd mmm yyyy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('15.04.2018','dd.mm.yyyy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('15/04/18','dd/mm/yy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('15/04/2018','dd/mm/yyyy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('15-04-2018','dd-mm-yyyy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('15-Apr-2018','dd-mmm-yy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('04 15 18','mm dd yy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('04 15 2018','mm dd yyyy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('04/15/18','mm/dd/yy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('04/15/2018','mm/dd/yyyy') AS ConvertedDate
SELECT [dbo].[GetStringToDate] ('2018-04-15','yyyy-mm-dd') AS ConvertedDate

--SELECT * FROM [dbo].[DateFormatMaster]
--SELECT * FROM [dbo].[MonthFormatMaster]