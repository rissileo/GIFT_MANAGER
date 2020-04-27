USE [master]
GO
/****** Object:  Database [GM]    Script Date: 24/09/2019 17:54:58 ******/
CREATE DATABASE [GM] ON  PRIMARY 
( NAME = N'study', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.TINCDEV\MSSQL\DATA\GM.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'study_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.TINCDEV\MSSQL\DATA\GM_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GM] SET ARITHABORT OFF 
GO
ALTER DATABASE [GM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GM] SET RECOVERY FULL 
GO
ALTER DATABASE [GM] SET  MULTI_USER 
GO
ALTER DATABASE [GM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GM] SET DB_CHAINING OFF 
GO
USE [GM]
GO
/****** Object:  Table [dbo].[tb_backlog]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_backlog](
	[id_backlog] [int] IDENTITY(1,1) NOT NULL,
	[id_pedido] [int] NULL,
	[id_material] [int] NULL,
	[qtd_nao_atendida] [int] NULL,
	[dt_insert] [datetime] NULL,
	[id_user_insert] [int] NULL,
	[dt_ultalt] [datetime] NULL,
	[id_user_ult_alt] [int] NULL,
	[id_causa_backlog] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_causa_backlog]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_causa_backlog](
	[id_causa_backlog] [int] IDENTITY(1,1) NOT NULL,
	[cod_causa_backlog] [int] NULL,
	[dc_causa_backlog] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_cliente]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_cliente](
	[id_cliente] [int] IDENTITY(1,1) NOT NULL,
	[cod_cliente] [varchar](100) NULL,
	[razao_social] [varchar](100) NULL,
	[fl_ativo] [int] NULL,
	[dt_insert] [datetime] NULL,
	[id_user_insert] [int] NULL,
	[dt_ultalt] [datetime] NULL,
	[id_user_ult_alt] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_estoque_material]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_estoque_material](
	[id_estoque] [int] IDENTITY(1,1) NOT NULL,
	[id_material] [int] NULL,
	[qtd] [int] NULL,
	[dt_insert] [datetime] NULL,
	[id_user_insert] [int] NULL,
	[dt_ultalt] [datetime] NULL,
	[id_user_ult_alt] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_login]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_login](
	[id_login] [int] IDENTITY(1,1) NOT NULL,
	[dc_login] [varchar](50) NULL,
	[dc_senha] [varbinary](max) NULL,
	[fl_ativo] [int] NULL,
	[email] [varchar](50) NULL,
	[email_equipe] [varchar](50) NULL,
	[dt_insert] [datetime] NULL,
	[id_user_insert] [int] NULL,
	[dt_ultalt] [datetime] NULL,
	[id_user_ult_alt] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_material]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_material](
	[id_material] [int] IDENTITY(1,1) NOT NULL,
	[cod_material] [int] NOT NULL,
	[dc_material] [varchar](100) NULL,
	[fl_ativo] [int] NULL,
	[dt_insert] [datetime] NULL,
	[id_user_insert] [int] NULL,
	[dt_ultalt] [datetime] NULL,
	[id_user_ult_alt] [int] NULL,
	[pic_base64] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_pedido]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_pedido](
	[id_pedido] [int] IDENTITY(1,1) NOT NULL,
	[cod_pedido] [varchar](50) NULL,
	[id_cliente] [int] NULL,
	[dt_insert] [datetime] NULL,
	[id_user_insert] [int] NULL,
	[dt_ultalt] [datetime] NULL,
	[id_user_ult_alt] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_pedido_finalizado]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_pedido_finalizado](
	[id_pedido_finalizado] [int] IDENTITY(1,1) NOT NULL,
	[id_pedido] [int] NULL,
	[id_cliente] [int] NULL,
	[dt_insert] [datetime] NULL,
	[id_user_insert] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_pedido_material]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_pedido_material](
	[id_pedido_material] [int] IDENTITY(1,1) NOT NULL,
	[id_pedido] [int] NULL,
	[id_material] [int] NULL,
	[qtd_solicitada] [int] NULL,
	[qtd_atendida] [int] NULL,
	[dt_insert] [datetime] NULL,
	[id_user_insert] [int] NULL,
	[dt_ultalt] [datetime] NULL,
	[id_user_ult_alt] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tb_backlog] ON 
GO
INSERT [dbo].[tb_backlog] ([id_backlog], [id_pedido], [id_material], [qtd_nao_atendida], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt], [id_causa_backlog]) VALUES (1, 1, 1, 2, CAST(N'2019-09-24T17:55:17.620' AS DateTime), 1, NULL, NULL, 3)
GO
SET IDENTITY_INSERT [dbo].[tb_backlog] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_causa_backlog] ON 
GO
INSERT [dbo].[tb_causa_backlog] ([id_causa_backlog], [cod_causa_backlog], [dc_causa_backlog]) VALUES (1, 1, N'LIMITE DIÁRIO DE EXCEDIDO')
GO
INSERT [dbo].[tb_causa_backlog] ([id_causa_backlog], [cod_causa_backlog], [dc_causa_backlog]) VALUES (2, 2, N'SALDO INSUFICIENTE')
GO
INSERT [dbo].[tb_causa_backlog] ([id_causa_backlog], [cod_causa_backlog], [dc_causa_backlog]) VALUES (3, 3, N'ATENDIDO PARCIALMENTE')
GO
SET IDENTITY_INSERT [dbo].[tb_causa_backlog] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_cliente] ON 
GO
INSERT [dbo].[tb_cliente] ([id_cliente], [cod_cliente], [razao_social], [fl_ativo], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (1, N'000000001', N'CLIENTE 000001', 1, CAST(N'2019-09-19T17:03:50.440' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[tb_cliente] ([id_cliente], [cod_cliente], [razao_social], [fl_ativo], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (2, N'000000002', N'CLIENTE 000002', 1, CAST(N'2019-09-19T17:03:50.440' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[tb_cliente] ([id_cliente], [cod_cliente], [razao_social], [fl_ativo], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (3, N'000000003', N'CLIENTE 000003', 1, CAST(N'2019-09-19T17:03:50.443' AS DateTime), 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[tb_cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_estoque_material] ON 
GO
INSERT [dbo].[tb_estoque_material] ([id_estoque], [id_material], [qtd], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (1, 1, 9, CAST(N'2019-09-19T17:03:50.447' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[tb_estoque_material] ([id_estoque], [id_material], [qtd], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (2, 2, 10, CAST(N'2019-09-19T17:03:50.450' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[tb_estoque_material] ([id_estoque], [id_material], [qtd], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (3, 3, 10, CAST(N'2019-09-19T17:03:50.450' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[tb_estoque_material] ([id_estoque], [id_material], [qtd], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (4, 4, 10, CAST(N'2019-09-19T17:03:50.450' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[tb_estoque_material] ([id_estoque], [id_material], [qtd], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (5, 5, 10, CAST(N'2019-09-19T17:03:50.450' AS DateTime), 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[tb_estoque_material] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_login] ON 
GO
INSERT [dbo].[tb_login] ([id_login], [dc_login], [dc_senha], [fl_ativo], [email], [email_equipe], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (1, N'admin', 0x5BBFF69E89C7D10BAF1B3807F27A81DF, 1, N'rissileo@gmail.com', N'rissileo@gmail.com', CAST(N'2019-09-19T17:03:50.453' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[tb_login] ([id_login], [dc_login], [dc_senha], [fl_ativo], [email], [email_equipe], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (2, N'mickey.mouse', 0x5BBFF69E89C7D10BAF1B3807F27A81DF, 1, N'rissileo@gmail.com', N'rissileo@gmail.com', CAST(N'2019-09-19T17:03:50.453' AS DateTime), 1, NULL, NULL)
GO
INSERT [dbo].[tb_login] ([id_login], [dc_login], [dc_senha], [fl_ativo], [email], [email_equipe], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (3, N'duck.donald', 0x5BBFF69E89C7D10BAF1B3807F27A81DF, 1, N'rissileo@gmail.com', N'rissileo@gmail.com', CAST(N'2019-09-19T17:03:50.453' AS DateTime), 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[tb_login] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_material] ON 
GO
INSERT [dbo].[tb_material] ([id_material], [cod_material], [dc_material], [fl_ativo], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt], [pic_base64]) VALUES (1, 1, N'CATALOGO DE PRODUTOS', 1, CAST(N'2019-09-19T17:03:50.443' AS DateTime), 1, NULL, NULL, N'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAgAAAAIACAMAAADDpiTIAAAAA3NCSVQICAjb4U/gAAAACXBIWXMAAHovAAB6LwEf/fvJAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAGBQTFRF////11pKykg5wDorzk09zsmu0Mux11pK19K72WZW23Ji3Hpq3YR03trF3tvF39vG4JWF4N3I4t/L46ub5eLP58Ky5+TS6Mu76ebV6ufV6ufW6+fW6+fX7OnY7OnZ7erac0uNxgAAAAN0Uk5TADhkpzbdZAAAA6xJREFUeNrt3DEOgkAURVGEMUaDtu5/dTYWGkNBguAGtHEwn8FztvBu/eoqR93MIu343iZvwoq/JgABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAArCKA9lW4rgBzpULokAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEggA/6Ls4kgHjdPc4gAASAABAAAkAACAABIAAEgAAQAAJAAAgAASCA+e3bOI0AFhBA4BN0LQAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEggPndLnFcxCzAFGgUAAJAAAgAASAABIAAEAACQAAIAAEgAASAAH4iNYEEEO94jiMABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABPDW41q6XgA5nkPpRgEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAhAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAhAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAWJkX2fmHsvees3MAAAAASUVORK5CYII=')
GO
INSERT [dbo].[tb_material] ([id_material], [cod_material], [dc_material], [fl_ativo], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt], [pic_base64]) VALUES (2, 2, N'CANETA', 1, CAST(N'2019-09-19T17:03:50.447' AS DateTime), 1, NULL, NULL, N'data:image/png;base64,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')
GO
INSERT [dbo].[tb_material] ([id_material], [cod_material], [dc_material], [fl_ativo], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt], [pic_base64]) VALUES (3, 3, N'CAMISA HLX', 1, CAST(N'2019-09-19T17:03:50.447' AS DateTime), 1, NULL, NULL, NULL)
GO
INSERT [dbo].[tb_material] ([id_material], [cod_material], [dc_material], [fl_ativo], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt], [pic_base64]) VALUES (4, 4, N'CAMISA LS', 1, CAST(N'2019-09-19T17:03:50.447' AS DateTime), 1, NULL, NULL, NULL)
GO
INSERT [dbo].[tb_material] ([id_material], [cod_material], [dc_material], [fl_ativo], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt], [pic_base64]) VALUES (5, 5, N'SQUEEZE', 1, CAST(N'2019-09-19T17:03:50.447' AS DateTime), 1, NULL, NULL, N'data:image/png;base64,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')
GO
SET IDENTITY_INSERT [dbo].[tb_material] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_pedido] ON 
GO
INSERT [dbo].[tb_pedido] ([id_pedido], [cod_pedido], [id_cliente], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (1, N'00000001', 1, CAST(N'2019-09-24T17:55:11.700' AS DateTime), 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[tb_pedido] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_pedido_finalizado] ON 
GO
INSERT [dbo].[tb_pedido_finalizado] ([id_pedido_finalizado], [id_pedido], [id_cliente], [dt_insert], [id_user_insert]) VALUES (1, 3, 2, CAST(N'2019-09-24T13:39:18.220' AS DateTime), 1)
GO
INSERT [dbo].[tb_pedido_finalizado] ([id_pedido_finalizado], [id_pedido], [id_cliente], [dt_insert], [id_user_insert]) VALUES (2, 3, 2, CAST(N'2019-09-24T13:47:45.623' AS DateTime), 1)
GO
INSERT [dbo].[tb_pedido_finalizado] ([id_pedido_finalizado], [id_pedido], [id_cliente], [dt_insert], [id_user_insert]) VALUES (3, 9, 1, CAST(N'2019-09-24T14:20:42.350' AS DateTime), 1)
GO
INSERT [dbo].[tb_pedido_finalizado] ([id_pedido_finalizado], [id_pedido], [id_cliente], [dt_insert], [id_user_insert]) VALUES (4, 14, 3, CAST(N'2019-09-24T14:50:33.247' AS DateTime), 1)
GO
INSERT [dbo].[tb_pedido_finalizado] ([id_pedido_finalizado], [id_pedido], [id_cliente], [dt_insert], [id_user_insert]) VALUES (5, 15, 2, CAST(N'2019-09-24T16:17:28.300' AS DateTime), 1)
GO
INSERT [dbo].[tb_pedido_finalizado] ([id_pedido_finalizado], [id_pedido], [id_cliente], [dt_insert], [id_user_insert]) VALUES (6, 17, 2, CAST(N'2019-09-24T17:50:53.617' AS DateTime), 1)
GO
INSERT [dbo].[tb_pedido_finalizado] ([id_pedido_finalizado], [id_pedido], [id_cliente], [dt_insert], [id_user_insert]) VALUES (7, 1, 1, CAST(N'2019-09-24T17:55:21.960' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[tb_pedido_finalizado] OFF
GO
SET IDENTITY_INSERT [dbo].[tb_pedido_material] ON 
GO
INSERT [dbo].[tb_pedido_material] ([id_pedido_material], [id_pedido], [id_material], [qtd_solicitada], [qtd_atendida], [dt_insert], [id_user_insert], [dt_ultalt], [id_user_ult_alt]) VALUES (1, 1, 1, 3, 1, CAST(N'2019-09-24T17:55:17.620' AS DateTime), 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[tb_pedido_material] OFF
GO
/****** Object:  Index [UQ__tb_mater__22A98BCB8E09DDA1]    Script Date: 24/09/2019 17:54:58 ******/
ALTER TABLE [dbo].[tb_material] ADD UNIQUE NONCLUSTERED 
(
	[cod_material] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_add_material_estoque]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_add_material_estoque]
as
begin
	update tb_estoque_material 
	set qtd = 10
	--where id_material = @idmaterial

	exec [sp_notifica_reposicao]
end 
GO
/****** Object:  StoredProcedure [dbo].[sp_autentica_usuario]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_autentica_usuario](
@login varchar(50),
@dc_senha varchar(100)
)
as begin

	declare @ncount int
	declare @idlogin int
	declare @dclogin varchar(50)

	select @ncount = count(*), @idlogin = id_login, @dclogin = dc_login 
	from tb_login
	where dc_login = rtrim(ltrim(@login))
	and dc_senha = hashbytes('md5', @dc_senha)
	and fl_ativo = 1
	group by id_login, dc_login

	if @ncount > 0
	begin
		select 100 as retorno, @idlogin as idlogin, @dclogin as dclogin, 'Success.' as retornomsg
	end
	else
	begin
		select 98 as retorno, 'Login/senha não conferem.' as retornomsg
	end 

end
GO
/****** Object:  StoredProcedure [dbo].[sp_cancela_pedido]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_cancela_pedido](
	@idpedido int
)
as
begin

	declare @ncount int
	declare @idMaterial int
	declare @Qtd int

	select @ncount = count(*)
	from tb_pedido_finalizado
	where id_pedido = @idpedido


	if @ncount > 0
	begin
		select 98 as retorno, 'NAO E POSSIVEL CANCELAR PEDIDO FINALIZADO.' as retornomsg
	end
	else
	begin

		DECLARE mat_cursor CURSOR FOR 
		select id_material, qtd_atendida from tb_pedido_material where id_pedido = @idpedido

		OPEN mat_cursor

		FETCH NEXT FROM mat_cursor   
		INTO @idMaterial, @Qtd
	
		WHILE @@FETCH_STATUS = 0  
		BEGIN  
			--print(convert(varchar(50), @idMaterial))
			--print(convert(varchar(50), @Qtd))

			update tb_estoque_material set qtd = qtd +  @Qtd
			where id_material = @idMaterial

			FETCH NEXT FROM mat_cursor   
			INTO @idMaterial, @Qtd
		END   
		CLOSE mat_cursor;  
		DEALLOCATE mat_cursor; 

		delete from tb_pedido where id_pedido = @idpedido
		delete from tb_pedido_material where id_pedido = @idpedido
		delete from tb_backlog  where id_pedido = @idpedido 

		select 100 as retorno, 'PEDIDO CANCELADO COM SUCESSO.' as retornomsg
	end

end 


GO
/****** Object:  StoredProcedure [dbo].[sp_finaliza_pedido]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_finaliza_pedido](
	@idpedido int
)
as
begin

	declare @idcliente int
	declare @idusuario int
	declare @ncount int
	declare @mailuser varchar(50)
	declare @mailequipe varchar(50)

	select  @idcliente = id_cliente,
			@idusuario = id_user_insert
			from tb_pedido
			where id_pedido = @idpedido

	select @ncount = count(*)
	from tb_pedido_finalizado
	where id_pedido = @idpedido

	if @ncount = 0
	begin
		insert into tb_pedido_finalizado
		(id_pedido,		id_cliente,		dt_insert,		id_user_insert)
		values
		(@idpedido,		@idcliente,		getdate(),		@idusuario)

		select @mailuser = email, @mailequipe = email_equipe from tb_login where id_login = @idusuario

		select 100 as retorno, 'PEDIDO FINALIZADO COM SUCESSO.' as retornomsg, @mailuser as mailuser, @mailequipe as mailequipe
	end
	else
	begin
		select 98 as retorno, 'PEDIDO JA CANCELADO ANTERIORMENTE.' as retornomsg
	end

end 


GO
/****** Object:  StoredProcedure [dbo].[sp_insere_backlog]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_insere_backlog](
@idpedido int,
@idmaterial int,
@qtd int,
@idusuario int,
@idcausa int
)
as
begin
		insert into tb_backlog
		(id_pedido,				id_material,		 qtd_nao_atendida,
		 dt_insert,			
		 id_user_insert,		dt_ultalt,   		 id_user_ult_alt,	
		 id_causa_backlog)
		 values
		(@idpedido,				@idmaterial,		 @qtd,
		 getdate(),
		 @idusuario,			null,				 null,
		 @idcausa)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_insere_pedido]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_insere_pedido] (
@idpedido int, 
@idMaterial int, 
@qtdSolicitada int, 
@qtdAtendida int, 
@idusuario int)
as
begin

		insert into tb_pedido_material
		(id_pedido,			id_material,		qtd_solicitada,		 qtd_atendida,   
			dt_insert,		    id_user_insert,		dt_ultalt, 		    
			id_user_ult_alt)
		values
		(@idpedido,			@idmaterial,		@qtdSolicitada,		 @qtdAtendida,
			getdate(),			@idusuario,			null,      			
			null)

		--ATUALIZA SALDO
		update tb_estoque_material
		set qtd = qtd - @qtdAtendida
		where id_material = @idMaterial

		return 0
end
GO
/****** Object:  StoredProcedure [dbo].[sp_notifica_reposicao]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_notifica_reposicao]
as
begin

	declare @idUsers int
	declare @mailUser varchar(100)
	
	DECLARE users_cursor CURSOR FOR 
	select distinct id_user_insert from tb_backlog
	where convert(date, dt_insert) = convert(date, getdate() - 1)

	OPEN users_cursor
	
	FETCH NEXT FROM users_cursor   
	INTO @idUsers

	WHILE @@FETCH_STATUS = 0  
	BEGIN  

		select @mailUser = email from tb_login where id_login = @idUsers

		EXEC msdb.dbo.[sp_send_dbmail] 
		@profile_name = 'GIFT_MANAGER'
		, @recipients = @mailUser
		, @subject = 'REPOSICAO DE MATERIAL'
		, @body = 'MATERIAIS CABARAM DE SER REPOSTOS'
		, @body_format = 'HTML' ;

		FETCH NEXT FROM users_cursor   
		INTO @idUsers
	END   
	CLOSE users_cursor;  
	DEALLOCATE users_cursor; 
	--select id_user_insert from tb_backlog

end 
GO
/****** Object:  StoredProcedure [dbo].[sp_pedido]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_pedido](
	@idcliente int,
	@idusuario int
)
as
begin

	declare @codpedido varchar(50)
	
	insert into tb_pedido(
	cod_pedido,			id_cliente,			dt_insert,
	id_user_insert,		dt_ultalt,			id_user_ult_alt
	)
	values
	(
	'',					@idcliente,			GETDATE(),
	@idusuario,			null,				null
	)

	if SCOPE_IDENTITY() is null 
	begin 
	set @codpedido = '00000001'
	end
	else
	begin
	set @codpedido = convert(varchar(50),REPLICATE('0', 8 - LEN(convert(varchar(50),SCOPE_IDENTITY()))) + convert(varchar(50),SCOPE_IDENTITY()))
	end

	--print @codpedido

	update tb_pedido set cod_pedido = convert(varchar(50), @codpedido)
	where id_pedido = coalesce(SCOPE_IDENTITY(), '00000001')

	select 100 as retorno, 'PEDIDO CRIADO COM SUCESSO.' as retornomsg

end 


GO
/****** Object:  StoredProcedure [dbo].[sp_pedido_material]    Script Date: 24/09/2019 17:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_pedido_material](
	@idpedido int,
	@idmaterial int,
	@qtdsolicitada int,
	@idusuario int
)
as
begin
	declare @ncount int
	declare @saldo int
	declare @codMaterial int
	declare @qtdNaoAtendida int
	declare @LimiteDiario int

	set @LimiteDiario = 1
	
		
	select @ncount = count(*)
	from tb_pedido_material
	where id_user_insert = @idusuario
	and id_material = @idmaterial
	and convert(date, dt_insert) = convert(date, getdate())

	if @ncount > 0 
	begin
		exec sp_insere_backlog @idpedido, @idmaterial, @qtdsolicitada, @idusuario, 2

		select 10 as retorno, (select dc_causa_backlog from tb_causa_backlog where id_causa_backlog = 2) as retornomsg;

	end
	else
	begin
		if @qtdsolicitada > @LimiteDiario
		begin

			set @qtdNaoAtendida = @qtdsolicitada - @LimiteDiario

			exec sp_insere_pedido @idpedido, @idMaterial, @qtdsolicitada, @LimiteDiario, @idusuario

			exec sp_insere_backlog @idpedido, @idmaterial, @qtdNaoAtendida, @idusuario, 3

			select 100 as retorno, (select dc_causa_backlog from tb_causa_backlog where id_causa_backlog = 3) as retornomsg;
		end
		else
		begin
			select @saldo = qtd from tb_estoque_material where id_material = @idmaterial

			if @qtdsolicitada > @saldo
			begin

				set @qtdNaoAtendida = @qtdsolicitada - @saldo

				exec sp_insere_pedido @idpedido, @idMaterial, @qtdsolicitada, @saldo, @idusuario

				exec sp_insere_backlog @idpedido, @idmaterial, @qtdNaoAtendida, @idusuario, 2

				select 11 as retorno, (select dc_causa_backlog from tb_causa_backlog where id_causa_backlog = 2) as retornomsg;
			end
			else
			begin

				exec sp_insere_pedido @idpedido, @idMaterial, @qtdsolicitada, @qtdsolicitada, @idusuario

				select 100 as retorno, 'MATERIAL ADICIONADO COM SUCESSO.' as retornomsg
			end
		end
	end
end 


GO
USE [master]
GO
ALTER DATABASE [GM] SET  READ_WRITE 
GO
