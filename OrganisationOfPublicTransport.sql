USE [master]
GO
/****** Object:  Database [OrganisationOfPublicTransport]    Script Date: 25/10/2022 22:36:25 ******/
CREATE DATABASE [OrganisationOfPublicTransport]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Organisation Of Public Transport', FILENAME = N'D:\SQL\MSSQL15.SQLEXPRESS01\MSSQL\DATA\Organisation Of Public Transport.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Organisation Of Public Transport_log', FILENAME = N'D:\SQL\MSSQL15.SQLEXPRESS01\MSSQL\DATA\Organisation Of Public Transport_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OrganisationOfPublicTransport].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET ARITHABORT OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET  MULTI_USER 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET QUERY_STORE = OFF
GO
USE [OrganisationOfPublicTransport]
GO
/****** Object:  Schema [schema_v0.1]    Script Date: 25/10/2022 22:36:25 ******/
CREATE SCHEMA [schema_v0.1]
GO
/****** Object:  Table [dbo].[Actions]    Script Date: 25/10/2022 22:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BusId] [int] NOT NULL,
	[Time] [time](7) NOT NULL,
	[Text] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Actions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminsShift]    Script Date: 25/10/2022 22:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminsShift](
	[ShiftId] [int] NOT NULL,
	[ShiftUsername] [nvarchar](50) NOT NULL,
	[Salt] [nvarchar](50) NOT NULL,
	[HashedPassword] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Administrator] PRIMARY KEY CLUSTERED 
(
	[ShiftId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BackUPBusTable]    Script Date: 25/10/2022 22:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BackUPBusTable](
	[BusId] [int] IDENTITY(1,1) NOT NULL,
	[BusName] [nvarchar](50) NOT NULL,
	[CurrentRouteId] [int] NULL,
	[CurrentTerminalId] [int] NULL,
	[Broken] [bit] NOT NULL,
	[Charging] [bit] NOT NULL,
	[Battery] [int] NOT NULL,
	[Delay] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bus]    Script Date: 25/10/2022 22:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bus](
	[BusId] [int] IDENTITY(1,1) NOT NULL,
	[BusName] [nvarchar](50) NOT NULL,
	[CurrentRouteId] [int] NULL,
	[CurrentTerminalId] [int] NULL,
	[Broken] [bit] NOT NULL,
	[Charging] [bit] NOT NULL,
	[Battery] [int] NOT NULL,
	[Delay] [int] NOT NULL,
 CONSTRAINT [PK_Bus] PRIMARY KEY CLUSTERED 
(
	[BusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BusOriginal]    Script Date: 25/10/2022 22:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusOriginal](
	[BusId] [int] IDENTITY(1,1) NOT NULL,
	[BusName] [nvarchar](50) NOT NULL,
	[CurrentRouteId] [int] NULL,
	[CurrentTerminalId] [int] NULL,
	[Broken] [bit] NOT NULL,
	[Charging] [bit] NOT NULL,
	[Battery] [int] NOT NULL,
	[Delay] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Routes]    Script Date: 25/10/2022 22:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Routes](
	[RouteId] [int] NOT NULL,
	[RouteName] [nvarchar](50) NOT NULL,
	[RouteDuration] [time](7) NOT NULL,
	[BatteryUsage] [int] NOT NULL,
	[StartTerminalId] [int] NOT NULL,
	[DestinationTerminalId] [int] NOT NULL,
	[StartIntervals] [time](7) NOT NULL,
 CONSTRAINT [PK_Routes] PRIMARY KEY CLUSTERED 
(
	[RouteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shift.Bus.Activity]    Script Date: 25/10/2022 22:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shift.Bus.Activity](
	[Id] [int] NOT NULL,
	[ShiftId] [int] NOT NULL,
	[BusId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Action] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Shift.Bus.Activity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Terminals]    Script Date: 25/10/2022 22:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Terminals](
	[Id] [int] NOT NULL,
	[TerminalName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Terminals] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Actions] ON 
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (1, 1, CAST(N'06:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (2, 16, CAST(N'06:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (3, 2, CAST(N'06:25:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (4, 31, CAST(N'06:25:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (5, 3, CAST(N'06:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (6, 17, CAST(N'06:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (7, 18, CAST(N'06:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (8, 32, CAST(N'06:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (9, 4, CAST(N'06:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (10, 19, CAST(N'06:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (11, 5, CAST(N'06:50:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (12, 33, CAST(N'06:50:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (13, 6, CAST(N'07:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (14, 20, CAST(N'07:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (15, 21, CAST(N'07:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (16, 34, CAST(N'07:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (17, 1, CAST(N'07:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (18, 16, CAST(N'07:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (19, 18, CAST(N'07:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (20, 32, CAST(N'07:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (21, 7, CAST(N'07:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (22, 1, CAST(N'07:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (23, 8, CAST(N'07:15:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (24, 18, CAST(N'07:15:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (25, 3, CAST(N'07:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (26, 17, CAST(N'07:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (27, 2, CAST(N'07:25:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (28, 31, CAST(N'07:25:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (29, 9, CAST(N'07:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (30, 3, CAST(N'07:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (31, 22, CAST(N'07:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (32, 2, CAST(N'07:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (33, 4, CAST(N'07:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (34, 19, CAST(N'07:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (35, 10, CAST(N'07:40:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (36, 35, CAST(N'07:40:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (37, 21, CAST(N'07:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (38, 34, CAST(N'07:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (39, 11, CAST(N'07:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (40, 4, CAST(N'07:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (41, 5, CAST(N'07:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (42, 33, CAST(N'07:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (43, 6, CAST(N'07:50:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (44, 20, CAST(N'07:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (45, 12, CAST(N'08:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (46, 5, CAST(N'08:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (47, 23, CAST(N'08:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (48, 6, CAST(N'08:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (49, 7, CAST(N'08:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (50, 1, CAST(N'08:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (51, 1, CAST(N'08:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (52, 13, CAST(N'08:05:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (53, 21, CAST(N'08:05:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (54, 22, CAST(N'08:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (55, 2, CAST(N'08:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (56, 2, CAST(N'08:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (57, 14, CAST(N'08:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (58, 7, CAST(N'08:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (59, 8, CAST(N'08:15:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (60, 18, CAST(N'08:15:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (61, 18, CAST(N'08:15:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (62, 9, CAST(N'08:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (63, 3, CAST(N'08:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (64, 3, CAST(N'08:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (65, 15, CAST(N'08:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (66, 9, CAST(N'08:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (67, 16, CAST(N'08:30:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (68, 8, CAST(N'08:30:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (69, 24, CAST(N'08:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (70, 22, CAST(N'08:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (71, 11, CAST(N'08:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (72, 4, CAST(N'08:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (73, 4, CAST(N'08:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (74, 10, CAST(N'08:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (75, 35, CAST(N'08:40:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (76, 23, CAST(N'08:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (77, 6, CAST(N'08:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (78, 6, CAST(N'08:40:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (79, 17, CAST(N'08:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (80, 11, CAST(N'08:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (81, 12, CAST(N'08:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (82, 5, CAST(N'08:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (83, 5, CAST(N'08:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (84, 19, CAST(N'08:55:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (85, 10, CAST(N'08:55:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (86, 20, CAST(N'09:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (87, 12, CAST(N'09:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (88, 25, CAST(N'09:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (89, 23, CAST(N'09:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (90, 13, CAST(N'09:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (91, 1, CAST(N'09:05:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (92, 21, CAST(N'09:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (93, 14, CAST(N'09:05:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (94, 7, CAST(N'09:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (95, 7, CAST(N'09:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (96, 24, CAST(N'09:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (97, 22, CAST(N'09:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (98, 1, CAST(N'09:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (99, 2, CAST(N'09:15:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (100, 2, CAST(N'09:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (101, 15, CAST(N'09:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (102, 18, CAST(N'09:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (103, 3, CAST(N'09:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (104, 9, CAST(N'09:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (105, 9, CAST(N'09:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (106, 3, CAST(N'09:20:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (107, 14, CAST(N'09:20:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (108, 18, CAST(N'09:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (109, 13, CAST(N'09:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (110, 16, CAST(N'09:30:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (111, 16, CAST(N'09:30:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (112, 8, CAST(N'09:30:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (113, 8, CAST(N'09:30:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (114, 15, CAST(N'09:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (115, 24, CAST(N'09:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (116, 17, CAST(N'09:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (117, 17, CAST(N'09:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (118, 4, CAST(N'09:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (119, 11, CAST(N'09:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (120, 11, CAST(N'09:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (121, 25, CAST(N'09:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (122, 23, CAST(N'09:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (123, 4, CAST(N'09:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (124, 6, CAST(N'09:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (125, 6, CAST(N'09:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (126, 21, CAST(N'09:45:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (127, 25, CAST(N'09:45:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (128, 20, CAST(N'09:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (129, 20, CAST(N'09:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (130, 5, CAST(N'09:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (131, 12, CAST(N'09:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (132, 12, CAST(N'09:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (133, 19, CAST(N'09:55:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (134, 19, CAST(N'09:55:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (135, 10, CAST(N'09:55:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (136, 10, CAST(N'09:55:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (137, 5, CAST(N'10:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (138, 22, CAST(N'10:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (139, 23, CAST(N'10:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (140, 36, CAST(N'10:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (141, 1, CAST(N'10:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (142, 2, CAST(N'10:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (143, 2, CAST(N'10:10:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (144, 37, CAST(N'10:10:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (145, 15, CAST(N'10:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (146, 24, CAST(N'10:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (147, 31, CAST(N'10:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (148, 7, CAST(N'10:15:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (149, 1, CAST(N'10:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (150, 3, CAST(N'10:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (151, 9, CAST(N'10:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (152, 14, CAST(N'10:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (153, 14, CAST(N'10:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (154, 18, CAST(N'10:20:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (155, 13, CAST(N'10:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (156, 13, CAST(N'10:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (157, 7, CAST(N'10:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (158, 3, CAST(N'10:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (159, 24, CAST(N'10:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (160, 15, CAST(N'10:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (161, 4, CAST(N'10:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (162, 17, CAST(N'10:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (163, 11, CAST(N'10:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (164, 6, CAST(N'10:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (165, 6, CAST(N'10:35:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (166, 18, CAST(N'10:35:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (167, 23, CAST(N'10:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (168, 23, CAST(N'10:40:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (169, 16, CAST(N'10:40:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (170, 36, CAST(N'10:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (171, 9, CAST(N'10:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (172, 4, CAST(N'10:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (173, 21, CAST(N'10:45:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (174, 21, CAST(N'10:45:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (175, 25, CAST(N'10:45:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (176, 25, CAST(N'10:45:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (177, 5, CAST(N'10:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (178, 8, CAST(N'10:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (179, 12, CAST(N'10:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (180, 22, CAST(N'10:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (181, 22, CAST(N'10:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (182, 8, CAST(N'11:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (183, 20, CAST(N'11:00:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (184, 5, CAST(N'11:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (185, 11, CAST(N'11:00:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (186, 16, CAST(N'11:00:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (187, 17, CAST(N'11:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (188, 38, CAST(N'11:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (189, 31, CAST(N'11:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (190, 31, CAST(N'11:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (191, 19, CAST(N'11:05:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (192, 1, CAST(N'11:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (193, 1, CAST(N'11:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (194, 2, CAST(N'11:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (195, 2, CAST(N'11:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (196, 37, CAST(N'11:10:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (197, 24, CAST(N'11:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (198, 24, CAST(N'11:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (199, 15, CAST(N'11:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (200, 15, CAST(N'11:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (201, 12, CAST(N'11:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (202, 10, CAST(N'11:15:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (203, 20, CAST(N'11:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (204, 7, CAST(N'11:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (205, 3, CAST(N'11:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (206, 3, CAST(N'11:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (207, 10, CAST(N'11:25:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (208, 19, CAST(N'11:25:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (209, 33, CAST(N'11:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (210, 14, CAST(N'11:30:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (211, 13, CAST(N'11:30:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (212, 7, CAST(N'11:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (213, 26, CAST(N'11:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (214, 39, CAST(N'11:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (215, 6, CAST(N'11:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (216, 6, CAST(N'11:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (217, 18, CAST(N'11:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (218, 18, CAST(N'11:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (219, 9, CAST(N'11:35:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (220, 4, CAST(N'11:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (221, 4, CAST(N'11:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (222, 17, CAST(N'11:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (223, 38, CAST(N'11:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (224, 13, CAST(N'11:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (225, 27, CAST(N'11:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (226, 8, CAST(N'11:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (227, 25, CAST(N'11:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (228, 5, CAST(N'11:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (229, 5, CAST(N'11:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (230, 14, CAST(N'11:50:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (231, 9, CAST(N'11:50:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (232, 25, CAST(N'12:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (233, 23, CAST(N'12:00:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (234, 8, CAST(N'12:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (235, 11, CAST(N'12:00:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (236, 16, CAST(N'12:00:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (237, 28, CAST(N'12:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (238, 11, CAST(N'12:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (239, 12, CAST(N'12:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (240, 1, CAST(N'12:05:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (241, 20, CAST(N'12:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (242, 26, CAST(N'12:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (243, 22, CAST(N'12:10:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (244, 39, CAST(N'12:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (245, 1, CAST(N'12:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (246, 31, CAST(N'12:15:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (247, 12, CAST(N'12:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (248, 16, CAST(N'12:15:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (249, 17, CAST(N'12:15:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (250, 33, CAST(N'12:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (251, 33, CAST(N'12:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (252, 21, CAST(N'12:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (253, 2, CAST(N'12:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (254, 3, CAST(N'12:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (255, 7, CAST(N'12:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (256, 7, CAST(N'12:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (257, 10, CAST(N'12:25:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (258, 24, CAST(N'12:25:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (259, 19, CAST(N'12:25:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (260, 3, CAST(N'12:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (261, 15, CAST(N'12:30:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (262, 15, CAST(N'12:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (263, 29, CAST(N'12:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (264, 2, CAST(N'12:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (265, 13, CAST(N'12:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (266, 6, CAST(N'12:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (267, 27, CAST(N'12:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (268, 19, CAST(N'12:40:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (269, 10, CAST(N'12:40:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (270, 28, CAST(N'12:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (271, 11, CAST(N'12:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (272, 11, CAST(N'12:40:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (273, 20, CAST(N'12:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (274, 18, CAST(N'12:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (275, 4, CAST(N'12:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (276, 6, CAST(N'12:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (277, 14, CAST(N'12:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (278, 5, CAST(N'12:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (279, 9, CAST(N'12:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (280, 9, CAST(N'12:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (281, 25, CAST(N'12:50:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (282, 8, CAST(N'12:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (283, 8, CAST(N'12:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (284, 4, CAST(N'13:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (285, 13, CAST(N'13:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (286, 14, CAST(N'13:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (287, 21, CAST(N'13:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (288, 1, CAST(N'13:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (289, 12, CAST(N'13:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (290, 12, CAST(N'13:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (291, 5, CAST(N'13:05:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (292, 23, CAST(N'13:05:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (293, 29, CAST(N'13:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (294, 2, CAST(N'13:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (295, 18, CAST(N'13:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (296, 1, CAST(N'13:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (297, 16, CAST(N'13:15:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (298, 16, CAST(N'13:15:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (299, 17, CAST(N'13:15:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (300, 17, CAST(N'13:15:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (301, 3, CAST(N'13:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (302, 33, CAST(N'13:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (303, 7, CAST(N'13:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (304, 15, CAST(N'13:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (305, 7, CAST(N'13:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (306, 2, CAST(N'13:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (307, 15, CAST(N'13:30:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (308, 24, CAST(N'13:30:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (309, 3, CAST(N'13:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (310, 25, CAST(N'13:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (311, 20, CAST(N'13:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (312, 20, CAST(N'13:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (313, 6, CAST(N'13:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (314, 19, CAST(N'13:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (315, 19, CAST(N'13:40:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (316, 10, CAST(N'13:40:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (317, 10, CAST(N'13:40:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (318, 14, CAST(N'13:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (319, 21, CAST(N'13:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (320, 6, CAST(N'13:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (321, 11, CAST(N'13:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (322, 11, CAST(N'13:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (323, 4, CAST(N'13:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (324, 13, CAST(N'13:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (325, 13, CAST(N'13:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (326, 22, CAST(N'13:55:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (327, 14, CAST(N'13:55:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (328, 27, CAST(N'14:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (329, 9, CAST(N'14:00:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (330, 8, CAST(N'14:00:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (331, 4, CAST(N'14:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (332, 21, CAST(N'14:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (333, 26, CAST(N'14:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (334, 5, CAST(N'14:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (335, 12, CAST(N'14:05:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (336, 23, CAST(N'14:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (337, 18, CAST(N'14:05:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (338, 1, CAST(N'14:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (339, 1, CAST(N'14:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (340, 3, CAST(N'14:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (341, 25, CAST(N'14:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (342, 25, CAST(N'14:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (343, 8, CAST(N'14:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (344, 5, CAST(N'14:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (345, 7, CAST(N'14:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (346, 17, CAST(N'14:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (347, 2, CAST(N'14:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (348, 2, CAST(N'14:20:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (349, 3, CAST(N'14:20:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (350, 9, CAST(N'14:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (351, 7, CAST(N'14:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (352, 15, CAST(N'14:30:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (353, 15, CAST(N'14:30:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (354, 24, CAST(N'14:30:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (355, 30, CAST(N'14:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (356, 18, CAST(N'14:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (357, 6, CAST(N'14:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (358, 6, CAST(N'14:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (359, 16, CAST(N'14:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (360, 20, CAST(N'14:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (361, 11, CAST(N'14:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (362, 21, CAST(N'14:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (363, 26, CAST(N'14:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (364, 11, CAST(N'14:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (365, 20, CAST(N'14:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (366, 12, CAST(N'14:45:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (367, 16, CAST(N'14:45:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (368, 27, CAST(N'14:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (369, 27, CAST(N'14:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (370, 13, CAST(N'14:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (371, 4, CAST(N'14:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (372, 4, CAST(N'14:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (373, 22, CAST(N'14:55:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (374, 14, CAST(N'14:55:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (375, 14, CAST(N'14:55:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (376, 13, CAST(N'15:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (377, 19, CAST(N'15:00:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (378, 10, CAST(N'15:00:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (379, 26, CAST(N'15:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (380, 31, CAST(N'15:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (381, 19, CAST(N'15:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (382, 8, CAST(N'15:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (383, 5, CAST(N'15:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (384, 5, CAST(N'15:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (385, 10, CAST(N'15:10:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (386, 21, CAST(N'15:10:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (387, 30, CAST(N'15:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (388, 18, CAST(N'15:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (389, 18, CAST(N'15:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (390, 17, CAST(N'15:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (391, 1, CAST(N'15:15:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (392, 25, CAST(N'15:15:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (393, 8, CAST(N'15:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (394, 2, CAST(N'15:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (395, 2, CAST(N'15:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (396, 3, CAST(N'15:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (397, 3, CAST(N'15:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (398, 9, CAST(N'15:20:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (399, 7, CAST(N'15:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (400, 7, CAST(N'15:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (401, 1, CAST(N'15:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (402, 25, CAST(N'15:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (403, 32, CAST(N'15:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (404, 9, CAST(N'15:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (405, 11, CAST(N'15:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (406, 11, CAST(N'15:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (407, 6, CAST(N'15:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (408, 20, CAST(N'15:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (409, 20, CAST(N'15:35:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (410, 22, CAST(N'15:35:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (411, 31, CAST(N'15:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (412, 15, CAST(N'15:40:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (413, 19, CAST(N'15:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (414, 23, CAST(N'15:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (415, 6, CAST(N'15:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (416, 12, CAST(N'15:45:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (417, 16, CAST(N'15:45:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (418, 13, CAST(N'15:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (419, 27, CAST(N'15:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (420, 4, CAST(N'15:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (421, 26, CAST(N'15:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (422, 26, CAST(N'15:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (423, 4, CAST(N'16:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (424, 13, CAST(N'16:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (425, 16, CAST(N'16:00:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (426, 12, CAST(N'16:00:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (427, 19, CAST(N'16:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (428, 15, CAST(N'16:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (429, 17, CAST(N'16:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (430, 5, CAST(N'16:05:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (431, 8, CAST(N'16:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (432, 8, CAST(N'16:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (433, 10, CAST(N'16:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (434, 21, CAST(N'16:10:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (435, 21, CAST(N'16:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (436, 32, CAST(N'16:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (437, 9, CAST(N'16:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (438, 9, CAST(N'16:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (439, 5, CAST(N'16:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (440, 18, CAST(N'16:15:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (441, 17, CAST(N'16:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (442, 1, CAST(N'16:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (443, 25, CAST(N'16:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (444, 24, CAST(N'16:25:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (445, 10, CAST(N'16:25:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (446, 25, CAST(N'16:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (447, 14, CAST(N'16:30:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (448, 7, CAST(N'16:30:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (449, 1, CAST(N'16:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (450, 18, CAST(N'16:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (451, 28, CAST(N'16:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (452, 20, CAST(N'16:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (453, 20, CAST(N'16:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (454, 11, CAST(N'16:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (455, 22, CAST(N'16:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (456, 22, CAST(N'16:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (457, 23, CAST(N'16:35:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (458, 23, CAST(N'16:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (459, 6, CAST(N'16:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (460, 19, CAST(N'16:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (461, 15, CAST(N'16:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (462, 6, CAST(N'16:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (463, 2, CAST(N'16:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (464, 3, CAST(N'16:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (465, 2, CAST(N'16:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (466, 4, CAST(N'16:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (467, 13, CAST(N'16:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (468, 13, CAST(N'16:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (469, 3, CAST(N'16:50:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (470, 19, CAST(N'16:50:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (471, 7, CAST(N'17:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (472, 4, CAST(N'17:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (473, 16, CAST(N'17:00:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (474, 16, CAST(N'17:00:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (475, 12, CAST(N'17:00:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (476, 12, CAST(N'17:00:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (477, 11, CAST(N'17:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (478, 29, CAST(N'17:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (479, 5, CAST(N'17:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (480, 8, CAST(N'17:05:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (481, 17, CAST(N'17:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (482, 17, CAST(N'17:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (483, 18, CAST(N'17:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (484, 26, CAST(N'17:10:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (485, 28, CAST(N'17:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (486, 8, CAST(N'17:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (487, 9, CAST(N'17:15:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (488, 5, CAST(N'17:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (489, 14, CAST(N'17:15:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (490, 18, CAST(N'17:15:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (491, 25, CAST(N'17:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (492, 25, CAST(N'17:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (493, 1, CAST(N'17:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (494, 1, CAST(N'17:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (495, 24, CAST(N'17:25:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (496, 24, CAST(N'17:25:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (497, 10, CAST(N'17:25:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (498, 10, CAST(N'17:25:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (499, 26, CAST(N'17:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (500, 9, CAST(N'17:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (501, 15, CAST(N'17:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (502, 30, CAST(N'17:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (503, 6, CAST(N'17:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (504, 6, CAST(N'17:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (505, 20, CAST(N'17:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (506, 2, CAST(N'17:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (507, 2, CAST(N'17:40:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (508, 21, CAST(N'17:40:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (509, 31, CAST(N'17:40:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (510, 11, CAST(N'17:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (511, 29, CAST(N'17:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (512, 21, CAST(N'17:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (513, 22, CAST(N'17:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (514, 23, CAST(N'17:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (515, 20, CAST(N'17:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (516, 3, CAST(N'17:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (517, 13, CAST(N'17:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (518, 19, CAST(N'17:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (519, 19, CAST(N'17:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (520, 7, CAST(N'17:50:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (521, 4, CAST(N'17:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (522, 4, CAST(N'17:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (523, 13, CAST(N'18:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (524, 3, CAST(N'18:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (525, 27, CAST(N'18:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (526, 7, CAST(N'18:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (527, 8, CAST(N'18:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (528, 17, CAST(N'18:05:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (529, 5, CAST(N'18:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (530, 5, CAST(N'18:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (531, 17, CAST(N'18:05:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (532, 11, CAST(N'18:05:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (533, 15, CAST(N'18:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (534, 30, CAST(N'18:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (535, 22, CAST(N'18:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (536, 8, CAST(N'18:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (537, 14, CAST(N'18:15:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (538, 18, CAST(N'18:15:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (539, 18, CAST(N'18:15:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (540, 26, CAST(N'18:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (541, 16, CAST(N'18:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (542, 12, CAST(N'18:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (543, 25, CAST(N'18:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (544, 1, CAST(N'18:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (545, 9, CAST(N'18:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (546, 1, CAST(N'18:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (547, 25, CAST(N'18:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (548, 9, CAST(N'18:30:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (549, 14, CAST(N'18:30:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (550, 26, CAST(N'18:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (551, 15, CAST(N'18:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (552, 21, CAST(N'18:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (553, 20, CAST(N'18:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (554, 2, CAST(N'18:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (555, 2, CAST(N'18:40:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (556, 31, CAST(N'18:40:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (557, 31, CAST(N'18:40:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (558, 27, CAST(N'18:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (559, 7, CAST(N'18:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (560, 7, CAST(N'18:40:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (561, 12, CAST(N'18:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (562, 24, CAST(N'18:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (563, 10, CAST(N'18:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (564, 6, CAST(N'18:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (565, 6, CAST(N'18:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (566, 13, CAST(N'18:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (567, 3, CAST(N'18:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (568, 3, CAST(N'18:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (569, 10, CAST(N'18:55:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (570, 16, CAST(N'18:55:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (571, 20, CAST(N'19:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (572, 4, CAST(N'19:00:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (573, 13, CAST(N'19:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (574, 21, CAST(N'19:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (575, 23, CAST(N'19:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (576, 17, CAST(N'19:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (577, 5, CAST(N'19:05:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (578, 11, CAST(N'19:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (579, 22, CAST(N'19:05:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (580, 8, CAST(N'19:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (581, 8, CAST(N'19:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (582, 26, CAST(N'19:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (583, 19, CAST(N'19:10:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (584, 15, CAST(N'19:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (585, 15, CAST(N'19:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (586, 4, CAST(N'19:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (587, 17, CAST(N'19:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (588, 1, CAST(N'19:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (589, 18, CAST(N'19:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (590, 25, CAST(N'19:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (591, 5, CAST(N'19:20:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (592, 22, CAST(N'19:20:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (593, 11, CAST(N'19:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (594, 1, CAST(N'19:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (595, 9, CAST(N'19:30:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (596, 9, CAST(N'19:30:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (597, 14, CAST(N'19:30:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (598, 14, CAST(N'19:30:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (599, 28, CAST(N'19:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (600, 24, CAST(N'19:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (601, 12, CAST(N'19:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (602, 6, CAST(N'19:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (603, 21, CAST(N'19:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (604, 23, CAST(N'19:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (605, 6, CAST(N'19:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (606, 31, CAST(N'19:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (607, 7, CAST(N'19:45:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (608, 7, CAST(N'19:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (609, 18, CAST(N'19:45:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (610, 21, CAST(N'19:45:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (611, 20, CAST(N'19:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (612, 20, CAST(N'19:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (613, 2, CAST(N'19:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (614, 3, CAST(N'19:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (615, 13, CAST(N'19:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (616, 13, CAST(N'19:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (617, 10, CAST(N'19:55:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (618, 16, CAST(N'19:55:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (619, 3, CAST(N'20:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (620, 12, CAST(N'20:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (621, 23, CAST(N'20:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (622, 2, CAST(N'20:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (623, 4, CAST(N'20:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (624, 17, CAST(N'20:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (625, 17, CAST(N'20:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (626, 16, CAST(N'20:10:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (627, 10, CAST(N'20:10:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (628, 28, CAST(N'20:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (629, 28, CAST(N'20:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (630, 24, CAST(N'20:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (631, 19, CAST(N'20:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (632, 8, CAST(N'20:15:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (633, 4, CAST(N'20:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (634, 5, CAST(N'20:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (635, 22, CAST(N'20:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (636, 22, CAST(N'20:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (637, 11, CAST(N'20:20:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (638, 11, CAST(N'20:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (639, 1, CAST(N'20:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (640, 1, CAST(N'20:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (641, 8, CAST(N'20:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (642, 15, CAST(N'20:30:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (643, 5, CAST(N'20:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (644, 15, CAST(N'20:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (645, 26, CAST(N'20:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (646, 6, CAST(N'20:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (647, 6, CAST(N'20:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (648, 7, CAST(N'20:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (649, 7, CAST(N'20:35:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (650, 27, CAST(N'20:35:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (651, 23, CAST(N'20:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (652, 9, CAST(N'20:40:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (653, 2, CAST(N'20:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (654, 25, CAST(N'20:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (655, 2, CAST(N'20:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (656, 18, CAST(N'20:45:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (657, 21, CAST(N'20:45:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (658, 21, CAST(N'20:45:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (659, 3, CAST(N'20:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (660, 14, CAST(N'20:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (661, 20, CAST(N'20:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (662, 13, CAST(N'20:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (663, 12, CAST(N'20:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (664, 12, CAST(N'20:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (665, 13, CAST(N'21:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (666, 3, CAST(N'21:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (667, 14, CAST(N'21:00:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (668, 9, CAST(N'21:00:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (669, 20, CAST(N'21:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (670, 18, CAST(N'21:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (671, 19, CAST(N'21:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (672, 17, CAST(N'21:05:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (673, 4, CAST(N'21:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (674, 4, CAST(N'21:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (675, 16, CAST(N'21:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (676, 16, CAST(N'21:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (677, 10, CAST(N'21:10:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (678, 10, CAST(N'21:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (679, 15, CAST(N'21:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (680, 26, CAST(N'21:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (681, 26, CAST(N'21:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (682, 17, CAST(N'21:15:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (683, 19, CAST(N'21:15:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (684, 8, CAST(N'21:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (685, 5, CAST(N'21:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (686, 5, CAST(N'21:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (687, 31, CAST(N'21:25:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (688, 28, CAST(N'21:25:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (689, 15, CAST(N'21:25:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (690, 35, CAST(N'21:30:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (691, 22, CAST(N'21:30:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (692, 1, CAST(N'21:30:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (693, 8, CAST(N'21:30:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (694, 24, CAST(N'21:30:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (695, 23, CAST(N'21:30:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (696, 7, CAST(N'21:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (697, 7, CAST(N'21:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (698, 6, CAST(N'21:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (699, 27, CAST(N'21:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (700, 25, CAST(N'21:35:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (701, 25, CAST(N'21:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (702, 2, CAST(N'21:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (703, 2, CAST(N'21:35:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (704, 20, CAST(N'21:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (705, 18, CAST(N'21:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (706, 18, CAST(N'21:40:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (707, 1, CAST(N'21:45:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (708, 6, CAST(N'21:45:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (709, 13, CAST(N'21:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (710, 12, CAST(N'21:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (711, 3, CAST(N'21:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (712, 3, CAST(N'21:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (713, 12, CAST(N'21:50:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (714, 20, CAST(N'21:50:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (715, 22, CAST(N'22:00:00' AS Time), N'start 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (716, 11, CAST(N'22:00:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (717, 13, CAST(N'22:00:00' AS Time), N'start 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (718, 14, CAST(N'22:00:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (719, 9, CAST(N'22:00:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (720, 29, CAST(N'22:00:00' AS Time), N'start 5')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (721, 11, CAST(N'22:00:00' AS Time), N'start 6')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (722, 17, CAST(N'22:05:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (723, 4, CAST(N'22:05:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (724, 19, CAST(N'22:05:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (725, 19, CAST(N'22:05:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (726, 24, CAST(N'22:10:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (727, 23, CAST(N'22:10:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (728, 23, CAST(N'22:10:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (729, 4, CAST(N'22:15:00' AS Time), N'start 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (730, 14, CAST(N'22:15:00' AS Time), N'start 4')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (731, 35, CAST(N'22:20:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (732, 35, CAST(N'22:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (733, 21, CAST(N'22:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (734, 5, CAST(N'22:20:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (735, 8, CAST(N'22:20:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (736, 8, CAST(N'22:20:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (737, 31, CAST(N'22:25:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (738, 15, CAST(N'22:25:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (739, 15, CAST(N'22:25:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (740, 1, CAST(N'22:35:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (741, 16, CAST(N'22:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (742, 10, CAST(N'22:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (743, 26, CAST(N'22:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (744, 7, CAST(N'22:35:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (745, 6, CAST(N'22:35:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (746, 29, CAST(N'22:40:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (747, 29, CAST(N'22:40:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (748, 2, CAST(N'22:40:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (749, 11, CAST(N'22:40:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (750, 12, CAST(N'22:50:00' AS Time), N'arrival 2')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (751, 25, CAST(N'22:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (752, 18, CAST(N'22:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (753, 3, CAST(N'22:50:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (754, 20, CAST(N'22:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (755, 22, CAST(N'22:50:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (756, 13, CAST(N'22:50:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (757, 13, CAST(N'22:50:00' AS Time), N'charge')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (758, 4, CAST(N'23:15:00' AS Time), N'arrival 3')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (759, 19, CAST(N'23:15:00' AS Time), N'stop charging')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (760, 14, CAST(N'23:15:00' AS Time), N'arrival 1')
GO
INSERT [dbo].[Actions] ([Id], [BusId], [Time], [Text]) VALUES (761, 14, CAST(N'23:15:00' AS Time), N'charge')
GO
SET IDENTITY_INSERT [dbo].[Actions] OFF
GO
INSERT [dbo].[AdminsShift] ([ShiftId], [ShiftUsername], [Salt], [HashedPassword]) VALUES (1, N'Shift1', N'213213', N'sHCBRyHIdPNq3bOXbxbzpQ==')
GO
INSERT [dbo].[AdminsShift] ([ShiftId], [ShiftUsername], [Salt], [HashedPassword]) VALUES (2, N'Shift2', N'123213', N'oK0kVMoVbc+51T3o3IXltw==')
GO
SET IDENTITY_INSERT [dbo].[BackUPBusTable] ON 
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (1, N'bus1', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (2, N'bus2', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (3, N'bus3', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (4, N'bus4', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (5, N'bus5', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (6, N'bus6', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (7, N'bus7', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (8, N'bus8', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (9, N'bus9', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (10, N'bus10', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (11, N'bus11', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (12, N'bus12', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (13, N'bus13', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (14, N'bus14', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (15, N'bus15', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (16, N'bus16', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (17, N'bus17', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (18, N'bus18', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (19, N'bus19', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (20, N'bus20', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (21, N'bus21', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (22, N'bus22', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (23, N'bus23', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (24, N'bus24', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (25, N'bus25', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (26, N'bus26', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (27, N'bus27', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (28, N'bus28', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (29, N'bus29', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (30, N'bus30', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (31, N'bus31', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (32, N'bus32', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (33, N'bus33', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (34, N'bus34', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (35, N'bus35', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (36, N'bus36', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (37, N'bus37', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (38, N'bus38', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (39, N'bus39', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (40, N'bus40', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (41, N'bus41', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (42, N'bus42', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (43, N'bus43', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (44, N'bus44', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BackUPBusTable] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (45, N'bus45', NULL, 3, 0, 0, 100, 0)
GO
SET IDENTITY_INSERT [dbo].[BackUPBusTable] OFF
GO
SET IDENTITY_INSERT [dbo].[Bus] ON 
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (1, N'bus1', NULL, 2, 0, 0, 70, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (2, N'bus2', NULL, 1, 0, 1, 35, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (3, N'bus3', NULL, 1, 0, 1, 40, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (4, N'bus4', 3, NULL, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (5, N'bus5', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (6, N'bus6', NULL, 1, 0, 0, 70, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (7, N'bus7', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (8, N'bus8', NULL, 1, 0, 1, 40, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (9, N'bus9', NULL, 1, 0, 0, 60, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (10, N'bus10', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (11, N'bus11', 6, NULL, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (12, N'bus12', 3, NULL, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (13, N'bus13', 2, NULL, 0, 0, 70, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (14, N'bus14', 4, NULL, 0, 0, 60, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (15, N'bus15', NULL, 1, 0, 1, 35, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (16, N'bus16', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (17, N'bus17', NULL, 2, 0, 0, 70, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (18, N'bus18', NULL, 2, 0, 1, 35, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (19, N'bus19', NULL, 1, 0, 1, 40, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (20, N'bus20', 4, NULL, 0, 0, 75, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (21, N'bus21', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (22, N'bus22', 1, NULL, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (23, N'bus23', NULL, 2, 0, 1, 25, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (24, N'bus24', NULL, 3, 0, 0, 50, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (25, N'bus25', NULL, 3, 0, 1, 30, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (26, N'bus26', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (27, N'bus27', NULL, 1, 0, 0, 45, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (28, N'bus28', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (29, N'bus29', 5, NULL, 0, 0, 50, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (30, N'bus30', NULL, 2, 0, 0, 50, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (31, N'bus31', NULL, 3, 0, 0, 60, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (32, N'bus32', NULL, 3, 0, 0, 50, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (33, N'bus33', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (34, N'bus34', NULL, 2, 0, 0, 75, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (35, N'bus35', NULL, 2, 0, 1, 30, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (36, N'bus36', NULL, 2, 0, 0, 75, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (37, N'bus37', NULL, 1, 0, 0, 60, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (38, N'bus38', NULL, 2, 0, 0, 75, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (39, N'bus39', NULL, 2, 0, 0, 75, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (40, N'bus40', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (41, N'bus41', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (42, N'bus42', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (43, N'bus43', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (44, N'bus44', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (45, N'bus45', NULL, 3, 0, 0, 100, 0)
GO
SET IDENTITY_INSERT [dbo].[Bus] OFF
GO
SET IDENTITY_INSERT [dbo].[BusOriginal] ON 
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (1, N'bus1', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (2, N'bus2', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (3, N'bus3', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (4, N'bus4', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (5, N'bus5', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (6, N'bus6', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (7, N'bus7', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (8, N'bus8', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (9, N'bus9', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (10, N'bus10', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (11, N'bus11', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (12, N'bus12', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (13, N'bus13', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (14, N'bus14', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (15, N'bus15', NULL, 1, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (16, N'bus16', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (17, N'bus17', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (18, N'bus18', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (19, N'bus19', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (20, N'bus20', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (21, N'bus21', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (22, N'bus22', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (23, N'bus23', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (24, N'bus24', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (25, N'bus25', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (26, N'bus26', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (27, N'bus27', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (28, N'bus28', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (29, N'bus29', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (30, N'bus30', NULL, 2, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (31, N'bus31', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (32, N'bus32', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (33, N'bus33', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (34, N'bus34', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (35, N'bus35', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (36, N'bus36', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (37, N'bus37', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (38, N'bus38', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (39, N'bus39', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (40, N'bus40', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (41, N'bus41', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (42, N'bus42', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (43, N'bus43', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (44, N'bus44', NULL, 3, 0, 0, 100, 0)
GO
INSERT [dbo].[BusOriginal] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (45, N'bus45', NULL, 3, 0, 0, 100, 0)
GO
SET IDENTITY_INSERT [dbo].[BusOriginal] OFF
GO
INSERT [dbo].[Routes] ([RouteId], [RouteName], [RouteDuration], [BatteryUsage], [StartTerminalId], [DestinationTerminalId], [StartIntervals]) VALUES (1, N'1_TO_2', CAST(N'00:50:00' AS Time), 30, 1, 2, CAST(N'00:15:00' AS Time))
GO
INSERT [dbo].[Routes] ([RouteId], [RouteName], [RouteDuration], [BatteryUsage], [StartTerminalId], [DestinationTerminalId], [StartIntervals]) VALUES (2, N'2_TO_1', CAST(N'00:50:00' AS Time), 30, 2, 1, CAST(N'00:15:00' AS Time))
GO
INSERT [dbo].[Routes] ([RouteId], [RouteName], [RouteDuration], [BatteryUsage], [StartTerminalId], [DestinationTerminalId], [StartIntervals]) VALUES (3, N'1_TO_3', CAST(N'01:00:00' AS Time), 40, 1, 3, CAST(N'00:25:00' AS Time))
GO
INSERT [dbo].[Routes] ([RouteId], [RouteName], [RouteDuration], [BatteryUsage], [StartTerminalId], [DestinationTerminalId], [StartIntervals]) VALUES (4, N'3_TO_1', CAST(N'01:00:00' AS Time), 40, 3, 1, CAST(N'00:25:00' AS Time))
GO
INSERT [dbo].[Routes] ([RouteId], [RouteName], [RouteDuration], [BatteryUsage], [StartTerminalId], [DestinationTerminalId], [StartIntervals]) VALUES (5, N'2_TO_3', CAST(N'00:40:00' AS Time), 25, 2, 3, CAST(N'00:30:00' AS Time))
GO
INSERT [dbo].[Routes] ([RouteId], [RouteName], [RouteDuration], [BatteryUsage], [StartTerminalId], [DestinationTerminalId], [StartIntervals]) VALUES (6, N'3_TO_2', CAST(N'00:40:00' AS Time), 25, 3, 2, CAST(N'00:30:00' AS Time))
GO
INSERT [dbo].[Terminals] ([Id], [TerminalName]) VALUES (1, N'terminal1')
GO
INSERT [dbo].[Terminals] ([Id], [TerminalName]) VALUES (2, N'terminal2')
GO
INSERT [dbo].[Terminals] ([Id], [TerminalName]) VALUES (3, N'terminal3')
GO
ALTER TABLE [dbo].[Actions]  WITH NOCHECK ADD  CONSTRAINT [FK_Actions_Bus] FOREIGN KEY([BusId])
REFERENCES [dbo].[Bus] ([BusId])
GO
ALTER TABLE [dbo].[Actions] CHECK CONSTRAINT [FK_Actions_Bus]
GO
ALTER TABLE [dbo].[Bus]  WITH CHECK ADD  CONSTRAINT [FK_Bus_Routes] FOREIGN KEY([CurrentRouteId])
REFERENCES [dbo].[Routes] ([RouteId])
GO
ALTER TABLE [dbo].[Bus] CHECK CONSTRAINT [FK_Bus_Routes]
GO
ALTER TABLE [dbo].[Bus]  WITH CHECK ADD  CONSTRAINT [FK_Bus_Terminals] FOREIGN KEY([CurrentTerminalId])
REFERENCES [dbo].[Terminals] ([Id])
GO
ALTER TABLE [dbo].[Bus] CHECK CONSTRAINT [FK_Bus_Terminals]
GO
ALTER TABLE [dbo].[Routes]  WITH CHECK ADD  CONSTRAINT [FK_Routes_Terminals] FOREIGN KEY([DestinationTerminalId])
REFERENCES [dbo].[Terminals] ([Id])
GO
ALTER TABLE [dbo].[Routes] CHECK CONSTRAINT [FK_Routes_Terminals]
GO
ALTER TABLE [dbo].[Shift.Bus.Activity]  WITH CHECK ADD  CONSTRAINT [FK_Administrator activity_Administrator] FOREIGN KEY([ShiftId])
REFERENCES [dbo].[AdminsShift] ([ShiftId])
GO
ALTER TABLE [dbo].[Shift.Bus.Activity] CHECK CONSTRAINT [FK_Administrator activity_Administrator]
GO
ALTER TABLE [dbo].[Shift.Bus.Activity]  WITH CHECK ADD  CONSTRAINT [FK_Shift.Bus.Activity_Bus] FOREIGN KEY([BusId])
REFERENCES [dbo].[Bus] ([BusId])
GO
ALTER TABLE [dbo].[Shift.Bus.Activity] CHECK CONSTRAINT [FK_Shift.Bus.Activity_Bus]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Might use Change Data Capture' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AdminsShift'
GO
USE [master]
GO
ALTER DATABASE [OrganisationOfPublicTransport] SET  READ_WRITE 
GO
