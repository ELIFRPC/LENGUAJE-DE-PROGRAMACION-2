USE [master]
GO
/****** Object:  Database [Unicop]    Script Date: 06/08/2025 07:24:07 a. m. ******/
CREATE DATABASE [Unicop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Unicop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Unicop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Unicop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Unicop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Unicop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Unicop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Unicop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Unicop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Unicop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Unicop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Unicop] SET ARITHABORT OFF 
GO
ALTER DATABASE [Unicop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Unicop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Unicop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Unicop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Unicop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Unicop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Unicop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Unicop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Unicop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Unicop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Unicop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Unicop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Unicop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Unicop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Unicop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Unicop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Unicop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Unicop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Unicop] SET  MULTI_USER 
GO
ALTER DATABASE [Unicop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Unicop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Unicop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Unicop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Unicop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Unicop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Unicop] SET QUERY_STORE = ON
GO
ALTER DATABASE [Unicop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Unicop]
GO
/****** Object:  Table [dbo].[centro_de_trabajo]    Script Date: 06/08/2025 07:24:07 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[centro_de_trabajo](
	[Num_centro] [varchar](5) NOT NULL,
	[Nombre_de_centro] [varchar](40) NOT NULL,
	[ciudad] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Num_centro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Directivos]    Script Date: 06/08/2025 07:24:07 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Directivos](
	[Num_empleado] [int] NOT NULL,
	[Num_de_centro] [varchar](5) NULL,
	[prestaciones] [varchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[Num_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 06/08/2025 07:24:07 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[Num_empleado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](40) NOT NULL,
	[Apellido_Paterno] [varchar](40) NOT NULL,
	[Apellido_Materno] [varchar](40) NOT NULL,
	[Fecha_de_Nacimiento] [date] NULL,
	[Num_Centro_trabajo] [varchar](5) NOT NULL,
	[Num_Puesto] [varchar](5) NOT NULL,
	[RFC]  AS (upper(((substring([Apellido_Paterno],(1),(1))+isnull(substring([Apellido_Paterno],patindex('%[AEIOUaeiou]%',substring([Apellido_Paterno],(2),len([Apellido_Paterno])))+(1),(1)),''))+isnull(substring([Apellido_Materno],(1),(1)),'x'))+substring([Nombre],(1),(1)))+format([Fecha_de_Nacimiento],'yyMMdd')),
PRIMARY KEY CLUSTERED 
(
	[Num_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Puestos]    Script Date: 06/08/2025 07:24:07 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Puestos](
	[Num_puesto] [varchar](5) NOT NULL,
	[puesto] [varchar](40) NOT NULL,
	[descripcion] [varchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[Num_puesto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[centro_de_trabajo] ([Num_centro], [Nombre_de_centro], [ciudad]) VALUES (N'GDL1', N'tienda normalistas', N'guadalajara')
INSERT [dbo].[centro_de_trabajo] ([Num_centro], [Nombre_de_centro], [ciudad]) VALUES (N'GDL10', N'tienda monraz', N'guadalajara')
INSERT [dbo].[centro_de_trabajo] ([Num_centro], [Nombre_de_centro], [ciudad]) VALUES (N'GDL2', N'tienda estadio', N'guadalajara')
INSERT [dbo].[centro_de_trabajo] ([Num_centro], [Nombre_de_centro], [ciudad]) VALUES (N'GDL3', N'tienda vallarta', N'zapopan')
INSERT [dbo].[centro_de_trabajo] ([Num_centro], [Nombre_de_centro], [ciudad]) VALUES (N'GDL4', N'tienda aviacion', N'zapopan')
INSERT [dbo].[centro_de_trabajo] ([Num_centro], [Nombre_de_centro], [ciudad]) VALUES (N'GDL5', N'tienda santa rosalia', N'tlaquepaque')
INSERT [dbo].[centro_de_trabajo] ([Num_centro], [Nombre_de_centro], [ciudad]) VALUES (N'GDL6', N'tienda santa margarita', N'guadalajara')
INSERT [dbo].[centro_de_trabajo] ([Num_centro], [Nombre_de_centro], [ciudad]) VALUES (N'GDL7', N'tienda el retiro', N'guadalajara')
INSERT [dbo].[centro_de_trabajo] ([Num_centro], [Nombre_de_centro], [ciudad]) VALUES (N'GDL8', N'tienda 7 colinas', N'guadalajara')
INSERT [dbo].[centro_de_trabajo] ([Num_centro], [Nombre_de_centro], [ciudad]) VALUES (N'GDL9', N'tienda la mesa', N'zapopan')
GO
INSERT [dbo].[Directivos] ([Num_empleado], [Num_de_centro], [prestaciones]) VALUES (6, N'GDL1', N'1')
INSERT [dbo].[Directivos] ([Num_empleado], [Num_de_centro], [prestaciones]) VALUES (7, N'GDL1', N'0')
INSERT [dbo].[Directivos] ([Num_empleado], [Num_de_centro], [prestaciones]) VALUES (10, N'GDL2', N'1')
INSERT [dbo].[Directivos] ([Num_empleado], [Num_de_centro], [prestaciones]) VALUES (13, N'GDL3', N'1')
INSERT [dbo].[Directivos] ([Num_empleado], [Num_de_centro], [prestaciones]) VALUES (19, N'GDL3', N'0')
GO
SET IDENTITY_INSERT [dbo].[Empleados] ON 

INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (6, N'CARMEN', N'LARRINUA', N'PEREZ', CAST(N'1973-07-16' AS Date), N'GDL1', N'GERE1')
INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (7, N'JESUS ALEJANDRO', N'VAZQUEZ', N'ROMERO', CAST(N'1989-06-15' AS Date), N'GDL1', N'BOSS1')
INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (8, N'LIZETH', N'RIVERA', N'PULIDO', CAST(N'2003-02-15' AS Date), N'GDL1', N'SEMI1')
INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (9, N'ANDRES', N'CRUZ', N'PULIDO', CAST(N'1996-08-06' AS Date), N'GDL1', N'ONE01')
INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (10, N'CHRISTIAN', N'RIVERA', N'PULIDO', CAST(N'1997-02-13' AS Date), N'GDL2', N'BOSS1')
INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (11, N'NERA', N'RIVERA', N'LARRINUA', CAST(N'2005-05-01' AS Date), N'GDL2', N'SEMI1')
INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (12, N'BRANDON', N'NOLASCO', N'MARTINEZ', CAST(N'1999-06-15' AS Date), N'GDL2', N'ONE01')
INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (13, N'EFRAIN', N'RIVERA', N'SANDOVAL', CAST(N'1967-04-07' AS Date), N'GDL3', N'BOSS1')
INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (14, N'MARIA EVA', N'PULIDO', N'VARGAS', CAST(N'1973-11-15' AS Date), N'GDL3', N'SEMI1')
INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (15, N'MARIA PAZ', N'VARGAS', N'VELIS', CAST(N'1950-02-21' AS Date), N'GDL3', N'ONE01')
INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (18, N'JUAN', N'PEREZ', N'MARTINEZ', CAST(N'2001-05-17' AS Date), N'GDL3', N'BOSS1')
INSERT [dbo].[Empleados] ([Num_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Fecha_de_Nacimiento], [Num_Centro_trabajo], [Num_Puesto]) VALUES (19, N'JUAN', N'PEREZ', N'MARTINEZ', CAST(N'2001-05-17' AS Date), N'GDL3', N'BOSS1')
SET IDENTITY_INSERT [dbo].[Empleados] OFF
GO
INSERT [dbo].[Puestos] ([Num_puesto], [puesto], [descripcion]) VALUES (N'BOSS1', N'GERENTES DE SUCURSALES', N'EL GERENTE ENCARGADO DE PLANIFICAR ORGANIZAR, LAS ACTIVIDADES DE LAS SUCURSALES')
INSERT [dbo].[Puestos] ([Num_puesto], [puesto], [descripcion]) VALUES (N'GERE1', N'CEO DE LA EMPRESA', N'ENCARGADO DE EL MANEJO TOTAL DE TODA LA COMPAÑIA')
INSERT [dbo].[Puestos] ([Num_puesto], [puesto], [descripcion]) VALUES (N'ONE01', N'EMPLEADO GENERAL', N'ENCARGADO DE EJECUTAR LOS PROCESOS DE Y DE LA EXPERIENCIA DEL CLIENTE')
INSERT [dbo].[Puestos] ([Num_puesto], [puesto], [descripcion]) VALUES (N'SEMI1', N'JEFE DE AREAS', N'ENCARGADO DE SUPERVISAR LA EJECUCION DE LOS PROCESOS CON LOS EMPLEADOS BASE')
GO
ALTER TABLE [dbo].[Directivos]  WITH CHECK ADD  CONSTRAINT [FK_Directivo_Centro] FOREIGN KEY([Num_de_centro])
REFERENCES [dbo].[centro_de_trabajo] ([Num_centro])
GO
ALTER TABLE [dbo].[Directivos] CHECK CONSTRAINT [FK_Directivo_Centro]
GO
ALTER TABLE [dbo].[Directivos]  WITH CHECK ADD  CONSTRAINT [FK_Directivo_Empleado] FOREIGN KEY([Num_empleado])
REFERENCES [dbo].[Empleados] ([Num_empleado])
GO
ALTER TABLE [dbo].[Directivos] CHECK CONSTRAINT [FK_Directivo_Empleado]
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_CentroTrabajo] FOREIGN KEY([Num_Centro_trabajo])
REFERENCES [dbo].[centro_de_trabajo] ([Num_centro])
GO
ALTER TABLE [dbo].[Empleados] CHECK CONSTRAINT [FK_Empleado_CentroTrabajo]
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD  CONSTRAINT [FK_Empleado_Puesto] FOREIGN KEY([Num_Puesto])
REFERENCES [dbo].[Puestos] ([Num_puesto])
GO
ALTER TABLE [dbo].[Empleados] CHECK CONSTRAINT [FK_Empleado_Puesto]
GO
USE [master]
GO
ALTER DATABASE [Unicop] SET  READ_WRITE 
GO
