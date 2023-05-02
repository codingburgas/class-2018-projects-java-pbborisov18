USE [master]
GO
/****** Object:  Database [OrganisationOfPublicTransport]    Script Date: 25/10/2022 22:43:09 ******/
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
/****** Object:  Schema [schema_v0.1]    Script Date: 25/10/2022 22:43:09 ******/
CREATE SCHEMA [schema_v0.1]
GO
/****** Object:  Table [dbo].[Actions]    Script Date: 25/10/2022 22:43:09 ******/
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
/****** Object:  Table [dbo].[AdminsShift]    Script Date: 25/10/2022 22:43:09 ******/
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
/****** Object:  Table [dbo].[Bus]    Script Date: 25/10/2022 22:43:09 ******/
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
/****** Object:  Table [dbo].[BusOriginal]    Script Date: 25/10/2022 22:43:09 ******/
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
/****** Object:  Table [dbo].[Routes]    Script Date: 25/10/2022 22:43:09 ******/
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
/****** Object:  Table [dbo].[Shift.Bus.Activity]    Script Date: 25/10/2022 22:43:09 ******/
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
/****** Object:  Table [dbo].[Terminals]    Script Date: 25/10/2022 22:43:09 ******/
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
INSERT [dbo].[AdminsShift] ([ShiftId], [ShiftUsername], [Salt], [HashedPassword]) VALUES (1, N'Shift1', N'213213', N'sHCBRyHIdPNq3bOXbxbzpQ==')
GO
INSERT [dbo].[AdminsShift] ([ShiftId], [ShiftUsername], [Salt], [HashedPassword]) VALUES (2, N'Shift2', N'123213', N'oK0kVMoVbc+51T3o3IXltw==')
GO
SET IDENTITY_INSERT [dbo].[Bus] ON 
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (1, N'bus1', NULL, 2, 0, 0, 70, 0)
GO
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (2, N'bus2', NULL, 1, 0, 0, 100, 0)
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
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (11, N'bus11', NULL, 2, 0, 0, 75, 0)
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
INSERT [dbo].[Bus] ([BusId], [BusName], [CurrentRouteId], [CurrentTerminalId], [Broken], [Charging], [Battery], [Delay]) VALUES (29, N'bus29', NULL, 3, 0, 1, 25, 0)
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
