﻿/****** Object:  Table [dbo].[MonthFormatMaster]    Script Date: 11/20/2018 1:59:43 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MonthFormatMaster]') AND type in (N'U'))
DROP TABLE [dbo].[MonthFormatMaster]
GO
/****** Object:  Table [dbo].[DateFormatMaster]    Script Date: 11/20/2018 1:59:43 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateFormatMaster]') AND type in (N'U'))
DROP TABLE [dbo].[DateFormatMaster]
GO
/****** Object:  UserDefinedFunction [dbo].[GetStringToDate]    Script Date: 11/20/2018 1:59:43 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetStringToDate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetStringToDate]
GO
/****** Object:  UserDefinedFunction [dbo].[GetStringToDate]    Script Date: 11/20/2018 1:59:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetStringToDate]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[GetStringToDate]
   ( 
    @P_DateString VARCHAR(50),
    @P_InputDateFormat VARCHAR(50)
    )  
RETURNS DATE
BEGIN
/*
Example
SET @P_DateString =''03/01/18''
SET @P_InputDateFormat = ''dd/mm/yy''
*/
DECLARE @V_DateStartPosition INT
DECLARE @V_DateLength INT
DECLARE @V_MonthStartPosition INT
DECLARE @V_MonthLength INT
DECLARE @V_YearStartPosition INT
DECLARE @V_YearLength INT
DECLARE @V_Month INT
DECLARE @V_MonthName VARCHAR(9)
DECLARE @V_Date INT
DECLARE @V_Year VARCHAR(4)
DECLARE @V_ReturnDate DATE

SELECT 
    @V_DateStartPosition = DateStartPosition,
    @V_DateLength = DateLength,
	@V_MonthStartPosition = MonthStartPosition,
	@V_MonthLength = MonthLength,
	@V_YearStartPosition = YearStartPosition,
	@V_YearLength =  YearLength
FROM [DateFormatMaster] 
WHERE [DateFormat] = @P_InputDateFormat

SELECT @V_Date = SUBSTRING(@P_DateString,@V_DateStartPosition,@V_DateLength)
SELECT @V_MonthName = SUBSTRING(@P_DateString,@V_MonthStartPosition,@V_MonthLength)
SELECT @V_Year = SUBSTRING(@P_DateString,@V_YearStartPosition,@V_YearLength)

SELECT @V_Month = [MonthNumber] FROM [dbo].[MonthFormatMaster] WHERE [MonthName] = @V_MonthName

IF LEN(@V_YEAR) = 2
BEGIN
  IF @V_YEAR <> 00
     SET @V_YEAR = CAST((''20''+@V_YEAR) AS INT)
  ELSE
     SET @V_YEAR = CAST((''19''+@V_YEAR) AS INT)
END

SET @V_ReturnDate =
    CONVERT(
            DATETIME,
			CAST(@V_Month AS VARCHAR(2))+''/''+
			CAST(@V_Date AS VARCHAR(2))+''/''+
			CAST(@V_Year AS VARCHAR(4)), 
			101
			) -- mm/dd/yy U.S.
RETURN @V_ReturnDate
END' 
END

GO
/****** Object:  Table [dbo].[DateFormatMaster]    Script Date: 11/20/2018 1:59:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DateFormatMaster]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DateFormatMaster](
	[DateFormat] [nvarchar](50) NOT NULL,
	[SampleDate] [varchar](50) NULL,
	[DateStartPosition] [int] NULL,
	[DateLength] [int] NULL,
	[MonthStartPosition] [int] NULL,
	[MonthLength] [int] NULL,
	[YearStartPosition] [int] NULL,
	[YearLength] [int] NULL,
 CONSTRAINT [PK_DateFormatMaster] PRIMARY KEY CLUSTERED 
(
	[DateFormat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MonthFormatMaster]    Script Date: 11/20/2018 1:59:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MonthFormatMaster]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MonthFormatMaster](
	[MonthNumber] [int] NOT NULL,
	[MonthName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_MonthFormatMaster] PRIMARY KEY CLUSTERED 
(
	[MonthNumber] ASC,
	[MonthName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'dd mm yy', N'15 12 18', 1, 2, 4, 2, 7, 2)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'dd mm yyyy', N'15 12 2018', 1, 2, 4, 2, 7, 4)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'dd mmm yy', N'15 Dec 18', 1, 2, 4, 3, 8, 2)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'dd mmmm yyyy', N'15 December 2018', 1, 2, 4, 3, 8, 4)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'dd.mm.yyyy', N'15.12.2018', 1, 2, 4, 2, 7, 4)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'dd/mm/yy', N'15/12/18', 1, 2, 4, 2, 7, 2)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'dd/mm/yyyy', N'15/12/2018', 1, 2, 4, 2, 7, 4)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'dd-mmm-yy', N'15-Dec-18', 1, 2, 4, 3, 8, 2)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'dd-mm-yyyy', N'15-12-2018', 1, 2, 4, 2, 7, 4)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'mm dd yy', N'12 15 18', 4, 2, 1, 2, 7, 2)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'mm dd yyyy', N'12 15 2018', 4, 2, 1, 2, 7, 4)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'mm/dd/yy', N'12/15/18', 4, 2, 1, 2, 7, 2)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'mm/dd/yyyy', N'12/15/2018', 4, 2, 1, 2, 7, 4)
INSERT [dbo].[DateFormatMaster] ([DateFormat], [SampleDate], [DateStartPosition], [DateLength], [MonthStartPosition], [MonthLength], [YearStartPosition], [YearLength]) VALUES (N'yyyy-mm-dd', N'2018-12-15', 9, 2, 6, 2, 1, 4)
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (1, N'01')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (1, N'1')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (1, N'Jan')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (1, N'January')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (2, N'02')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (2, N'2')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (2, N'Feb')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (2, N'February')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (3, N'03')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (3, N'3')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (3, N'Mar')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (3, N'March')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (4, N'04')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (4, N'4')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (4, N'Apr')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (4, N'April')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (5, N'05')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (5, N'5')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (5, N'May')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (6, N'06')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (6, N'Jun')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (6, N'June')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (7, N'07')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (7, N'7')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (7, N'Jul')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (7, N'July')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (8, N'08')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (8, N'8')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (8, N'Aug')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (8, N'August')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (9, N'09')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (9, N'9')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (9, N'Sep')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (9, N'September')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (10, N'10')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (10, N'Oct')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (10, N'October')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (11, N'11')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (11, N'Nov')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (11, N'November')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (12, N'12')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (12, N'Dec')
INSERT [dbo].[MonthFormatMaster] ([MonthNumber], [MonthName]) VALUES (12, N'December')
