

/****** Object:  Database [PB-v1]    Script Date: 12/3/2020 5:24:56 PM ******/
CREATE DATABASE [PB-v1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PB-v1', FILENAME = N'C:\MSSQL_Data\PB-v1.mdf' , SIZE = 20480000KB , MAXSIZE = 20480000KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PB-v1_log', FILENAME = N'C:\MSSQL_Data\PB-v1_log.ldf' , SIZE = 20480000KB , MAXSIZE = 30720000KB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PB-v1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [PB-v1] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [PB-v1] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [PB-v1] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [PB-v1] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [PB-v1] SET ARITHABORT OFF 
GO

ALTER DATABASE [PB-v1] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [PB-v1] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [PB-v1] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [PB-v1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [PB-v1] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [PB-v1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [PB-v1] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [PB-v1] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [PB-v1] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [PB-v1] SET  DISABLE_BROKER 
GO

ALTER DATABASE [PB-v1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [PB-v1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [PB-v1] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [PB-v1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [PB-v1] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [PB-v1] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [PB-v1] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [PB-v1] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [PB-v1] SET  MULTI_USER 
GO

ALTER DATABASE [PB-v1] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [PB-v1] SET DB_CHAINING OFF 
GO

ALTER DATABASE [PB-v1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [PB-v1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [PB-v1] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [PB-v1] SET QUERY_STORE = OFF
GO

ALTER DATABASE [PB-v1] SET  READ_WRITE 
GO


/****** Criar Stage  ******/

use PB-v1

CREATE TABLE [dbo].[DM_IES_Stage](
	[NU_ANO_CENSO] [varchar](50) NOT NULL,
	[CO_IES] [varchar](50) NOT NULL,
	[NO_IES] [varchar](100) NOT NULL,
	[SG_IES] [varchar](50) NULL,
	[CO_MUNICIPIO] [varchar](50) NOT NULL
) ON [PRIMARY]
GO


CREATE TABLE dbo.DM_Municipio_Stage (
UF_COD VARCHAR(50) NOT NULL,
UF VARCHAR(100) NOT NULL,
MESORREGIAOGEOGRAFICA_COD VARCHAR(50) NOT NULL,
MESORREGIAOGEOGRAFICA VARCHAR(100) NOT NULL,
MICRORREGIAOGEOGRAFICA_COD VARCHAR(50) NOT NULL,
MICRORREGIAOGEOGRAFICA VARCHAR(100) NOT NULL,
MUNICIPIO_COD_COMPLETO VARCHAR(50) NOT NULL,
MUNICIPIO_COD VARCHAR(50) NOT NULL,
MUNICIPIO VARCHAR(100) NOT NULL)

go

CREATE TABLE [dbo].[DM_CURSO_Stage](
	[NU_ANO_CENSO] [varchar](50) NULL,
	[CO_IES] [varchar](50) NULL,
	[CO_MUNICIPIO] [varchar](50) NULL,
	[CO_CURSO] [varchar](50) NULL,
	[NO_CURSO] [varchar](300) NULL,
	[TP_SITUACAO] [varchar](50) NULL,
	[TP_GRAU_ACADEMICO] [varchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[DM_ALUNO_Stage](
	[NU_ANO_CENSO] [varchar](50) NOT NULL,
	[CO_IES] [varchar](50) NOT NULL,
	[CO_CURSO] [varchar](50) NOT NULL,
	[TP_MODALIDADE_ENSINO] [varchar](50) NOT NULL,
	[TP_NIVEL_ACADEMICO] [varchar](50) NOT NULL,
	[CO_ALUNO_CURSO] [varchar](50) NOT NULL,
	[TP_COR_RACA] [varchar](50) NOT NULL,
	[TP_SEXO] [varchar](50) NOT NULL,
	[NU_IDADE] [varchar](50) NOT NULL,
	[TP_NACIONALIDADE] [varchar](50) NOT NULL,
	[CO_PAIS_ORIGEM] [varchar](50) NOT NULL,
	[CO_MUNICIPIO_NASCIMENTO] [varchar](50) NOT NULL,
	[IN_DEFICIENCIA] [varchar](50) NOT NULL,
	[TP_SITUACAO] [varchar](50) NOT NULL,
	[IN_FINANCIAMENTO_ESTUDANTIL] [varchar](50) NULL,
	[IN_APOIO_SOCIAL] [varchar](50) NULL,
	[IN_ATIVIDADE_EXTRACURRICULAR] [varchar](50) NULL,
	[TP_ESCOLA_CONCLUSAO_ENS_MEDIO] [varchar](50) NULL,
	[IN_MOBILIDADE_ACADEMICA] [varchar](50) NULL,
	[TP_MOBILIDADE_ACADEMICA] [varchar](50) NULL,
	[TP_MOBILIDADE_ACADEMICA_INTERN] [varchar](50) NULL,
	[CO_PAIS_DESTINO] [varchar](50) NULL,
	[IN_MATRICULADO] [varchar](50) NOT NULL,
	[IN_CONCLUINTE] [varchar](50) NOT NULL,
	[IN_INGRESSANTE] [varchar](50) NOT NULL
) ON [PRIMARY]
GO







/*******Modelo Dimensional*********/

/*************************
 DimAno
**************************/

CREATE TABLE dbo.DimAno (
AnoCenso smallint not null primary key)
go

INSERT dbo.DimAno VALUES (2017)
INSERT dbo.DimAno VALUES (2018)

go

/**************************
 DimMunicipio
***************************/
CREATE TABLE dbo.Dim_MUNICIPIO (
DIMMUNICIPIO_ID INT IDENTITY PRIMARY KEY, -- MUNICIPIO_COD_COMPLETO
DIMMUNICIPIO_APP INT NOT NULL, -- MUNICIPIO_COD
MUNICIPIO VARCHAR(100) NOT NULL,
UF_APP INT NOT NULL, -- UF_COD
UF VARCHAR(100) NOT NULL,
REGIAO VARCHAR(100) NOT NULL,
MESORREGIAOGEOGRAFICA_APP INT NOT NULL, -- MESORREGIAOGEOGRAFICA_COD
MESORREGIAOGEOGRAFICA VARCHAR(100) NOT NULL,
MICRORREGIAOGEOGRAFICA_APP INT NOT NULL, -- MICRORREGIAOGEOGRAFICA_COD
MICRORREGIAOGEOGRAFICA VARCHAR(100) NOT NULL)

go

/**************************
 DimIES
***************************/
--DROP TABLE Dim_INSTITUICAOENSINO
CREATE TABLE Dim_INSTITUICAOENSINO
(
INSTITUICAOENSINO_ID INT IDENTITY (1,1), --CO_IES
INSTITUICAOENSINO_APP INT NOT NULL, --CO_IES_APP
NU_ANO_CENSO smallint not null ,
NO_INSTITUICAOENSINO varchar(300) not null,
SG_INSTITUICAOENSINO VARCHAR(50) NOT NULL,
CATEGORIA_ADMINISTRATIVA varchar(50) NOT NULL,
CO_MUNICIPIO INT NOT NULL,
PRIMARY KEY (INSTITUICAOENSINO_ID)
)

go


/**************************
 DimAluno
***************************/
--DROP TABLE Dim_ALUNO
CREATE TABLE [dbo].[Dim_ALUNO](
	[ALUNO_ID] [int] IDENTITY(1,1) NOT NULL,
	[NU_ANO_CENSO] [smallint] NOT NULL,
	[CO_INSTITUICAOENSINO] [varchar](50) NOT NULL,
	[CO_CURSO] [varchar](50) NOT NULL,
	[MODALIDADE_ENSINO] [varchar](50) NOT NULL,
	[ALUNO_ID_APP] [varchar](50) NOT NULL,
	[COR_RACA] [varchar](50) NOT NULL,
	[SEXO] [varchar](50) NOT NULL,
	[NU_IDADE] [varchar](50) NOT NULL,
	[NACIONALIDADE] [varchar](50) NOT NULL,
	[MUNICIPIO_NASCIMENTO] [varchar](50) NOT NULL,
	[DEFICIENCIA] [varchar](50) NOT NULL,
	[SITUACAO] [varchar](50) NOT NULL,
	[FINANCIAMENTO_ESTUDANTIL] [varchar](50) NOT NULL,
	[ATIVIDADE_EXTRACURRICULAR] [varchar](50) NOT NULL,
	[ESCOLA_CONCLUSAO_ENS_MEDIO] [varchar](50) NOT NULL,
	[IN_MOBILIDADE_ACADEMICA] [varchar](50) NOT NULL,
	[TP_MOBILIDADE_ACADEMICA] [varchar](50) NOT NULL,
	[MOBILIDADE_ACADEMICA_INTERN] [varchar](50) NOT NULL,
	[PAIS_INTERCAMBIO] [varchar](100) NOT NULL,
	[IN_MATRICULADO] [varchar](50) NOT NULL,
	[IN_CONCLUINTE] [varchar](50) NOT NULL,
	[IN_INGRESSANTE] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ALUNO_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



/**************************
 DimCurso
***************************/
--drop table Dim_CURSO
--select * from Dim_CURSO
CREATE TABLE Dim_CURSO
(
CURSO_ID INT IDENTITY (1,1),
CURSO_APP INT NOT NULL, --CO_CURSO
CURSO_NOME VARCHAR(300) NOT NULL,
CO_MUNICIPIO INT NOT NULL,
CO_INSTITUICAOENSINO INT NOT NULL,
NU_ANO_CENSO smallINT NOT NULL,
SITUACAO varchar(50) NOT NULL,
GRAU_ACADEMICO varchar(50) NOT NULL

PRIMARY KEY (CURSO_ID)
)

GO

/********************************************
Fato Aluno
********************************************/


CREATE TABLE FATOSALUNO (
ALUNOID INT NOT NULL,
IES_ID INT NOT NULL,
CURSO_ID INT NOT NULL,
MUNICIPIO_ID INT NOT NULL,
NU_ANO_CENSO SMALLINT NOT NULL,
QTDALUNOS INT NOT NULL
--PRIMARY KEY (ALUNOID)
)

GO



ALTER TABLE FatosTeste ADD CONSTRAINT fk_Fatosteste_Dimaluno
FOREIGN KEY (alunoID) REFERENCES Dim_aluno(aluno_ID)
go

ALTER TABLE FatosTeste ADD CONSTRAINT fk_Fatosteste_DimIES
FOREIGN KEY (IES_ID) REFERENCES Dim_instituicaoensino(instituicaoensino_ID)
go

ALTER TABLE FatosTeste ADD CONSTRAINT fk_Fatosteste_Dimcurso
FOREIGN KEY (curso_ID) REFERENCES Dim_curso(curso_ID)
go

ALTER TABLE FatosTeste ADD CONSTRAINT fk_Fatosteste_Dimmunicipio
FOREIGN KEY (municipio_ID) REFERENCES Dimmunicipio(dimmunicipio_ID)
go

ALTER TABLE FatosTeste ADD CONSTRAINT fk_Fatosteste_Dimano
FOREIGN KEY (nu_ano_censo) REFERENCES Dimano(nu_ano_censo)
go

