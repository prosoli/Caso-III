
/****** Object:  Table [dbo].[vpv_AllowedVoters]    Script Date: 18/06/2025 09:53:26 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_AllowedVoters](
	[idAllowerVoter] [int] IDENTITY(1,1) NOT NULL,
	[idBlindToken] [int] NOT NULL,
	[idVotingConfig] [int] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[checksum] [nvarchar](255) NULL,
 CONSTRAINT [PK_vpv_AllowedVoters] PRIMARY KEY CLUSTERED 
(
	[idAllowerVoter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_api]    Script Date: 18/06/2025 09:53:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_api](
	[idApi] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[descripcion] [text] NOT NULL,
	[base_url] [varchar](200) NOT NULL,
	[creacionDate] [datetime] NOT NULL,
	[updateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_vpv_api] PRIMARY KEY CLUSTERED 
(
	[idApi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_apiConfig]    Script Date: 18/06/2025 09:53:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_apiConfig](
	[idApiConfig] [int] NOT NULL,
	[idApi] [int] NOT NULL,
	[idApiConfigType] [int] NOT NULL,
	[value] [varchar](200) NOT NULL,
	[env] [varchar](50) NOT NULL,
	[creacionDate] [datetime] NOT NULL,
	[updateDate] [datetime] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_apiConfig] PRIMARY KEY CLUSTERED 
(
	[idApiConfig] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_apiConfigType]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_apiConfigType](
	[idApiConfigType] [int] NOT NULL,
	[name] [varchar](200) NOT NULL,
	[creacionDate] [datetime] NOT NULL,
	[updateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_vpv_apiConfigType] PRIMARY KEY CLUSTERED 
(
	[idApiConfigType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_apiEndpointMethods]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_apiEndpointMethods](
	[idEndpointMethod] [int] NOT NULL,
	[name] [varchar](10) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_vpv_apiEndpointMethods] PRIMARY KEY CLUSTERED 
(
	[idEndpointMethod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_apiEndPoints]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_apiEndPoints](
	[idEndPoint] [int] NOT NULL,
	[idApi] [int] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[path] [varchar](200) NOT NULL,
	[idEndpointMethod] [int] NOT NULL,
 CONSTRAINT [PK_vpv_apiEndPoints] PRIMARY KEY CLUSTERED 
(
	[idEndPoint] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_apiRequest]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_apiRequest](
	[id_apiRequest] [int] NOT NULL,
	[idUser] [int] NOT NULL,
	[idApi] [int] NOT NULL,
	[idEndpoint] [int] NOT NULL,
	[request_time] [timestamp] NOT NULL,
	[json_headers] [nvarchar](max) NOT NULL,
	[json_payload] [nvarchar](max) NOT NULL,
	[id_requestStatus] [int] NOT NULL,
	[creacionDate] [datetime] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_apiRequest] PRIMARY KEY CLUSTERED 
(
	[id_apiRequest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_apiRequestFiles]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_apiRequestFiles](
	[id_requestFile] [int] NOT NULL,
	[id_apiRequest] [int] NOT NULL,
	[id_mediafile] [int] NOT NULL,
 CONSTRAINT [PK_vpv_apiRequestFiles] PRIMARY KEY CLUSTERED 
(
	[id_requestFile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_apiResponse]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_apiResponse](
	[id_apiResponse] [int] NOT NULL,
	[id_apiRequest] [int] NOT NULL,
	[response_time] [timestamp] NOT NULL,
	[error_message] [text] NOT NULL,
	[json_headers] [nvarchar](max) NOT NULL,
	[json_payload] [nvarchar](max) NOT NULL,
	[id_responseStatus] [int] NOT NULL,
	[creacionDate] [datetime] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_apiResponse] PRIMARY KEY CLUSTERED 
(
	[id_apiResponse] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_apiResponseFiles]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_apiResponseFiles](
	[id_responseFile] [int] NOT NULL,
	[id_apiResponse] [int] NOT NULL,
	[id_mediafile] [int] NOT NULL,
 CONSTRAINT [PK_vpv_apiResponseFiles] PRIMARY KEY CLUSTERED 
(
	[id_responseFile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_authmethods]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_authmethods](
	[authmethodid] [int] IDENTITY(1,1) NOT NULL,
	[bioauthid] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[result] [nvarchar](100) NOT NULL,
	[precision] [decimal](5, 2) NOT NULL,
	[validate_by] [nvarchar](50) NOT NULL,
	[method] [varbinary](max) NOT NULL,
	[enable] [bit] NOT NULL,
	[created_by] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_vpv_authmethods] PRIMARY KEY CLUSTERED 
(
	[authmethodid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_availablePaymentMethodPerEntity]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_availablePaymentMethodPerEntity](
	[paymentMethodUserId] [int] IDENTITY(1,1) NOT NULL,
	[enable] [bit] NOT NULL,
	[paymentMethodId] [int] NOT NULL,
	[entityId] [int] NOT NULL,
 CONSTRAINT [PK_vpv_availablePaymentMethodPerEntity] PRIMARY KEY CLUSTERED 
(
	[paymentMethodUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_availablePaymentMethods]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_availablePaymentMethods](
	[paymentMethodId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](55) NOT NULL,
	[token] [varchar](256) NOT NULL,
	[expTokenDate] [datetime] NOT NULL,
	[maskAccount] [nvarchar](max) NULL,
	[callbackURL] [nvarchar](200) NULL,
	[configurationDetails] [nvarchar](max) NOT NULL,
	[refreshToken] [varbinary](256) NOT NULL,
	[methodId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_availablePaymentMethods] PRIMARY KEY CLUSTERED 
(
	[paymentMethodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_availablePaymentMethodsPerUser]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_availablePaymentMethodsPerUser](
	[paymentMethodUserId] [int] IDENTITY(1,1) NOT NULL,
	[enable] [bit] NOT NULL,
	[paymentMethodId] [int] NOT NULL,
	[idUser] [int] NOT NULL,
 CONSTRAINT [PK_vpv_availablePaymentMethodsPerUser] PRIMARY KEY CLUSTERED 
(
	[paymentMethodUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_azureanalysis]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_azureanalysis](
	[analysisid] [int] IDENTITY(1,1) NOT NULL,
	[docid] [int] NOT NULL,
	[modelid] [int] NOT NULL,
	[completedat] [datetime] NOT NULL,
	[duration] [int] NOT NULL,
	[result] [varchar](255) NOT NULL,
	[status] [bit] NOT NULL,
	[message] [nvarchar](250) NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_azureanalysis] PRIMARY KEY CLUSTERED 
(
	[analysisid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_azurecells]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_azurecells](
	[cellsid] [int] IDENTITY(1,1) NOT NULL,
	[tableid] [int] NULL,
	[row_index] [int] NULL,
	[column_index] [int] NULL,
	[text] [nvarchar](150) NULL,
	[confidence] [decimal](5, 4) NULL,
 CONSTRAINT [PK_vpv_azurecells] PRIMARY KEY CLUSTERED 
(
	[cellsid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_azuremodels]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_azuremodels](
	[modelid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_vpv_azuremodels] PRIMARY KEY CLUSTERED 
(
	[modelid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_azurepage]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_azurepage](
	[pageid] [int] IDENTITY(1,1) NOT NULL,
	[analysisid] [int] NOT NULL,
	[pagenumber] [int] NOT NULL,
	[width] [float] NOT NULL,
	[height] [float] NOT NULL,
	[unit] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_vpv_azurepage] PRIMARY KEY CLUSTERED 
(
	[pageid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_azuretables]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_azuretables](
	[tableid] [int] IDENTITY(1,1) NOT NULL,
	[pageid] [int] NOT NULL,
	[row_count] [nvarchar](150) NOT NULL,
	[column_count] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_vpv_azuretables] PRIMARY KEY CLUSTERED 
(
	[tableid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_balances]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_balances](
	[balanceId] [bigint] IDENTITY(1,1) NOT NULL,
	[balance] [decimal](10, 2) NOT NULL,
	[lastbalance] [decimal](10, 2) NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[checksum] [varbinary](255) NOT NULL,
	[foundId] [int] NOT NULL,
	[freezeAmount] [decimal](10, 2) NULL,
 CONSTRAINT [PK_vpv_balance] PRIMARY KEY CLUSTERED 
(
	[balanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_biometricauths]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_biometricauths](
	[bioauthid] [int] IDENTITY(1,1) NOT NULL,
	[biostatusid] [int] NOT NULL,
	[biotypeid] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[keyid] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[template] [nvarchar](100) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_biometricauths] PRIMARY KEY CLUSTERED 
(
	[bioauthid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_biorequests]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_biorequests](
	[biorequestid] [int] IDENTITY(1,1) NOT NULL,
	[bioauthid] [int] NOT NULL,
	[biotypeid] [int] NOT NULL,
	[biodata] [varbinary](max) NOT NULL,
	[returndata] [bit] NOT NULL,
	[creationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_vpv_biorequests] PRIMARY KEY CLUSTERED 
(
	[biorequestid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_bioresponses]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_bioresponses](
	[bioresponseid] [int] IDENTITY(1,1) NOT NULL,
	[bioauthid] [int] NULL,
	[match] [bit] NULL,
	[confidence] [decimal](5, 2) NULL,
	[result] [varchar](50) NULL,
	[creationDate] [datetime] NULL,
 CONSTRAINT [PK_vpv_bioresponses] PRIMARY KEY CLUSTERED 
(
	[bioresponseid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_biostatus]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_biostatus](
	[biostatusid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_biostatus] PRIMARY KEY CLUSTERED 
(
	[biostatusid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_biotypes]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_biotypes](
	[biotypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[description] [varchar](50) NULL,
 CONSTRAINT [PK_vpv_biotypes] PRIMARY KEY CLUSTERED 
(
	[biotypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_BlindTokens]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_BlindTokens](
	[idToken] [uniqueidentifier] NOT NULL,
	[used] [bit] NOT NULL,
	[creacionDate] [datetime] NOT NULL,
	[usedDate] [datetime] NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_BlindTokens] PRIMARY KEY CLUSTERED 
(
	[idToken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_bodyprocess]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_bodyprocess](
	[bodyprocessid] [int] IDENTITY(1,1) NOT NULL,
	[identitytypeid] [int] NULL,
	[processid] [int] NULL,
	[enable] [bit] NULL,
	[fecha] [datetime] NULL,
 CONSTRAINT [PK_vpv_bodyprocess] PRIMARY KEY CLUSTERED 
(
	[bodyprocessid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_Cities]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_Cities](
	[idCity] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NOT NULL,
	[enabled] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[idState] [int] NOT NULL,
 CONSTRAINT [PK_vpv_Cities] PRIMARY KEY CLUSTERED 
(
	[idCity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_ClosureTypes]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_ClosureTypes](
	[idClosureTypes] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_ClosureTypes] PRIMARY KEY CLUSTERED 
(
	[idClosureTypes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_Countries]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_Countries](
	[idCountry] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NOT NULL,
	[enabled] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_Countries] PRIMARY KEY CLUSTERED 
(
	[idCountry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_crowdfoundingProposals]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_crowdfoundingProposals](
	[crowdfoundingProposalId] [int] IDENTITY(1,1) NOT NULL,
	[statusId] [int] NOT NULL,
	[proposalId] [int] NOT NULL,
	[deleted] [bit] NOT NULL,
	[enable] [bit] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[checksum] [varbinary](255) NOT NULL,
 CONSTRAINT [PK_vpv_crowdfoundingProposals] PRIMARY KEY CLUSTERED 
(
	[crowdfoundingProposalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_currencies]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_currencies](
	[currencyId] [int] NOT NULL,
	[name] [varchar](30) NOT NULL,
	[acronym] [varchar](30) NULL,
	[symbol] [varchar](5) NULL,
 CONSTRAINT [PK_vpv_currencies] PRIMARY KEY CLUSTERED 
(
	[currencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_demographics]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_demographics](
	[demographicid] [int] IDENTITY(1,1) NOT NULL,
	[demotypeid] [int] NOT NULL,
	[demosubtypeid] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[checksum] [nvarchar](255) NULL,
 CONSTRAINT [PK_vpv_demographics] PRIMARY KEY CLUSTERED 
(
	[demographicid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_demosubtype]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_demosubtype](
	[demosubtypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_vpv_demosubtype] PRIMARY KEY CLUSTERED 
(
	[demosubtypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_demotype]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_demotype](
	[demotypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NOT NULL,
	[description] [varchar](100) NOT NULL,
 CONSTRAINT [PK_vpv_demotype] PRIMARY KEY CLUSTERED 
(
	[demotypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_devices]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_devices](
	[deviceid] [int] IDENTITY(1,1) NOT NULL,
	[bioauthid] [int] NOT NULL,
	[devicetypeid] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[creationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_vpv_devices] PRIMARY KEY CLUSTERED 
(
	[deviceid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_devicetypes]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_devicetypes](
	[devicetypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](100) NOT NULL,
 CONSTRAINT [PK_vpv_devicetypes] PRIMARY KEY CLUSTERED 
(
	[devicetypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_docincidents]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_docincidents](
	[docincidentid] [int] IDENTITY(1,1) NOT NULL,
	[analysisid] [int] NULL,
	[userid] [int] NOT NULL,
	[docid] [int] NOT NULL,
	[incidenttypeid] [int] NOT NULL,
	[description] [nvarchar](150) NOT NULL,
	[detected_by] [nvarchar](50) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[block] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_docincidents] PRIMARY KEY CLUSTERED 
(
	[docincidentid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_docinfos]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_docinfos](
	[infoid] [int] IDENTITY(1,1) NOT NULL,
	[analysisid] [int] NOT NULL,
	[pagenumber] [int] NOT NULL,
	[infotypeid] [int] NOT NULL,
	[field_value] [nvarchar](250) NOT NULL,
	[confidence] [decimal](5, 4) NOT NULL,
	[bounding] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_vpv_docinfos] PRIMARY KEY CLUSTERED 
(
	[infoid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_docs]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_docs](
	[docid] [int] IDENTITY(1,1) NOT NULL,
	[identitydocsid] [int] NOT NULL,
	[formatid] [int] NOT NULL,
	[docstypeid] [int] NOT NULL,
	[docstateid] [int] NOT NULL,
	[archive] [varbinary](max) NOT NULL,
	[filename] [nvarchar](100) NOT NULL,
	[date] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[startdate] [datetime] NOT NULL,
	[nextcheckdate] [datetime] NOT NULL,
	[semantic_category] [nvarchar](250) NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_docs] PRIMARY KEY CLUSTERED 
(
	[docid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_docstates]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_docstates](
	[docstateid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[description] [nvarchar](100) NULL,
 CONSTRAINT [PK_vpv_docstates] PRIMARY KEY CLUSTERED 
(
	[docstateid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_docstypes]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_docstypes](
	[docstypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_vpv_docstypes] PRIMARY KEY CLUSTERED 
(
	[docstypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_encryptionkeys]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_encryptionkeys](
	[keyid] [int] IDENTITY(1,1) NOT NULL,
	[userid] [int] NOT NULL,
	[key] [nvarchar](255) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[checksum] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_vpv_encryptionkeys] PRIMARY KEY CLUSTERED 
(
	[keyid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_EndOfVoting]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_EndOfVoting](
	[idEndOfVoting] [int] IDENTITY(1,1) NOT NULL,
	[idVotingConfig] [int] NOT NULL,
	[endDate] [datetime] NOT NULL,
	[idClosureTypes] [int] NOT NULL,
	[description] [varchar](250) NULL,
	[checksum] [nvarchar](250) NOT NULL,
	[enable] [bit] NOT NULL,
	[personId] [int] NOT NULL,
 CONSTRAINT [PK_vpv_EndOfVoting] PRIMARY KEY CLUSTERED 
(
	[idEndOfVoting] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_entities]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_entities](
	[entityid] [int] IDENTITY(1,1) NOT NULL,
	[entitytypeid] [int] NOT NULL,
	[entitysubtypeid] [int] NOT NULL,
	[entitiestatusdid] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[acronym] [nchar](10) NOT NULL,
	[logo_url] [nvarchar](max) NOT NULL,
	[description] [nvarchar](150) NOT NULL,
	[createdate] [datetime] NOT NULL,
	[registeredby] [nvarchar](50) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_entities] PRIMARY KEY CLUSTERED 
(
	[entityid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_entitiestatus]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_entitiestatus](
	[entitiestatusdid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_vpv_entitiestatus] PRIMARY KEY CLUSTERED 
(
	[entitiestatusdid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_entityBalance]    Script Date: 18/06/2025 09:53:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_entityBalance](
	[entityBalanceId] [bigint] IDENTITY(1,1) NOT NULL,
	[entityId] [int] NOT NULL,
	[balanceId] [bigint] NOT NULL,
	[executionDate] [datetime] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_entityBalance] PRIMARY KEY CLUSTERED 
(
	[entityBalanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_entitydescription]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_entitydescription](
	[entitydesdid] [int] IDENTITY(1,1) NOT NULL,
	[entityid] [int] NULL,
	[name] [nvarchar](65) NULL,
	[mission] [nvarchar](255) NULL,
	[vision] [nvarchar](255) NULL,
	[structure] [nvarchar](100) NULL,
	[createdate] [datetime] NULL,
	[enable] [bit] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_vpv_entitydescription] PRIMARY KEY CLUSTERED 
(
	[entitydesdid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_entitykey]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_entitykey](
	[entitykeyid] [int] IDENTITY(1,1) NOT NULL,
	[entityid] [int] NOT NULL,
	[key] [nvarchar](150) NOT NULL,
	[password] [nvarchar](150) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_entitykey] PRIMARY KEY CLUSTERED 
(
	[entitykeyid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_entityroles]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_entityroles](
	[entityrole] [int] IDENTITY(1,1) NOT NULL,
	[entitydid] [int] NOT NULL,
	[entityoptdid] [int] NOT NULL,
	[entityseloptdid] [int] NOT NULL,
	[entityroletypeid] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_entityroles] PRIMARY KEY CLUSTERED 
(
	[entityrole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_entityroletypes]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_entityroletypes](
	[entityroletypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[description] [varchar](100) NULL,
 CONSTRAINT [PK_vpv_entityroletypes] PRIMARY KEY CLUSTERED 
(
	[entityroletypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_entitysubtypes]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_entitysubtypes](
	[entitysubtypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](100) NULL,
 CONSTRAINT [PK_vpv_entitysubtypes] PRIMARY KEY CLUSTERED 
(
	[entitysubtypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_entitytypes]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_entitytypes](
	[entitytypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_vpv_entitytypes] PRIMARY KEY CLUSTERED 
(
	[entitytypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_exchangeRates]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_exchangeRates](
	[echangeRateId] [int] IDENTITY(1,1) NOT NULL,
	[startDate] [datetime] NOT NULL,
	[endDate] [datetime] NOT NULL,
	[exchangeRate] [decimal](10, 2) NOT NULL,
	[enable] [bit] NOT NULL,
	[currentExchange] [bit] NOT NULL,
	[currencyId] [int] NOT NULL,
 CONSTRAINT [PK_vpv_exchangeRates] PRIMARY KEY CLUSTERED 
(
	[echangeRateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_executionPlans]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_executionPlans](
	[executionPlanId] [int] NOT NULL,
	[tittle] [nvarchar](50) NOT NULL,
	[description] [nvarchar](200) NULL,
	[startDate] [datetime] NULL,
	[finalDate] [datetime] NULL,
	[checksum] [varbinary](255) NOT NULL,
	[idUser] [int] NOT NULL,
	[statusId] [int] NOT NULL,
	[scheduleId] [int] NOT NULL,
	[crowdfoundingProposalId] [int] NOT NULL,
	[paymentPlanId] [int] NOT NULL,
	[idTargetPopulation] [int] NOT NULL,
	[idMeasureUnit] [int] NOT NULL,
	[duracion] [int] NOT NULL,
 CONSTRAINT [PK_vpv_executionPlans] PRIMARY KEY CLUSTERED 
(
	[executionPlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_extractedinfos]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_extractedinfos](
	[extractinfoid] [bigint] IDENTITY(1,1) NOT NULL,
	[workresultid] [int] NOT NULL,
	[field_value] [nvarchar](100) NOT NULL,
	[comments] [nvarchar](100) NOT NULL,
	[error] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_extractedinfos] PRIMARY KEY CLUSTERED 
(
	[extractinfoid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_FilesPerProposal]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_FilesPerProposal](
	[fileProposalId] [int] IDENTITY(1,1) NOT NULL,
	[proposalId] [int] NOT NULL,
	[docid] [int] NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[checksum] [varbinary](255) NOT NULL,
	[proposalVersionId] [int] NULL,
	[relacion] [nvarchar](500) NULL,
 CONSTRAINT [PK_vpv_FilesPerProposal] PRIMARY KEY CLUSTERED 
(
	[fileProposalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_FilterTypes]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_FilterTypes](
	[idFilterType] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[enable] [bit] NOT NULL,
	[datatype] [varchar](30) NOT NULL,
	[referenceId] [varchar](30) NULL,
	[reference] [bit] NOT NULL,
	[demotypeid] [int] NULL,
	[demosubtypeid] [int] NULL,
	[checksum] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_vpv_FilterTypes] PRIMARY KEY CLUSTERED 
(
	[idFilterType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_formats]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_formats](
	[formatid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_vpv_formats] PRIMARY KEY CLUSTERED 
(
	[formatid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_founds]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_founds](
	[foundId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_vpv_founds] PRIMARY KEY CLUSTERED 
(
	[foundId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_GeneralResultsPerQuestion]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_GeneralResultsPerQuestion](
	[idGeneralResultsPerQuestion] [int] IDENTITY(1,1) NOT NULL,
	[idVotingConfig] [int] NOT NULL,
	[idVotingQuestions] [int] NOT NULL,
	[votesCount] [bigint] NOT NULL,
	[votesPercentage] [decimal](5, 2) NOT NULL,
	[winningOptionId] [int] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[checksum] [nvarchar](250) NOT NULL,
	[average] [decimal](5, 2) NULL,
 CONSTRAINT [PK_vpv_GeneralResultsPerQuestion] PRIMARY KEY CLUSTERED 
(
	[idGeneralResultsPerQuestion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_governmentBenefits]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_governmentBenefits](
	[governmentBenefitId] [int] IDENTITY(1,1) NOT NULL,
	[benefit] [nvarchar](100) NOT NULL,
	[enable] [bit] NOT NULL,
	[dataType] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_vpv_governmentBenefits] PRIMARY KEY CLUSTERED 
(
	[governmentBenefitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_governmentConditions]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_governmentConditions](
	[governmentConditionId] [int] IDENTITY(1,1) NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[amount] [decimal](10, 8) NULL,
	[quantity] [int] NULL,
	[checksum] [varbinary](255) NOT NULL,
	[govermentEntityId] [int] NULL,
	[governmentBenefitId] [int] NOT NULL,
	[startDate] [datetime] NOT NULL,
	[finalDate] [datetime] NOT NULL,
	[signedDate] [datetime] NOT NULL,
	[demotypeid] [int] NULL,
	[demosubtypeid] [int] NULL,
	[crowdfoundingProposalId] [int] NOT NULL,
	[access] [bit] NULL,
	[name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_vpv_governmentConditions] PRIMARY KEY CLUSTERED 
(
	[governmentConditionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_governmentEntities]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_governmentEntities](
	[govermentEntityId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[acronym] [nvarchar](10) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_governmentEntities] PRIMARY KEY CLUSTERED 
(
	[govermentEntityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_identitydocs]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_identitydocs](
	[identitydocsid] [int] IDENTITY(1,1) NOT NULL,
	[referencevalue] [int] NOT NULL,
	[referenceid] [varchar](25) NOT NULL,
	[identitytypeid] [int] NOT NULL,
	[identitystateid] [int] NOT NULL,
	[name] [nvarchar](150) NOT NULL,
	[field1] [nvarchar](250) NOT NULL,
	[field2] [nvarchar](250) NOT NULL,
	[temporary] [bit] NOT NULL,
	[creationdate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[expirationdate] [datetime] NOT NULL,
 CONSTRAINT [PK_vpv_identitydocs] PRIMARY KEY CLUSTERED 
(
	[identitydocsid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_identitystates]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_identitystates](
	[identitystateid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_vpv_identitystates] PRIMARY KEY CLUSTERED 
(
	[identitystateid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_identitytype]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_identitytype](
	[identitytypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[required] [bit] NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_identitytype] PRIMARY KEY CLUSTERED 
(
	[identitytypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_ImpactZones]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_ImpactZones](
	[idImpactZone] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](500) NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[value] [varchar](500) NULL,
	[idImpactZoneTypes] [int] NOT NULL,
	[checksum] [nvarchar](255) NULL,
 CONSTRAINT [PK_vpv_ImpactZones] PRIMARY KEY CLUSTERED 
(
	[idImpactZone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_ImpactZonesPerVoting]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_ImpactZonesPerVoting](
	[idImpactZonesPerVoting] [int] IDENTITY(1,1) NOT NULL,
	[idVotingConfig] [int] NOT NULL,
	[idImpactZones] [int] NOT NULL,
	[checksum] [nvarchar](550) NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_ImpactZonesPerVoting] PRIMARY KEY CLUSTERED 
(
	[idImpactZonesPerVoting] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_ImpactZoneTypes]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_ImpactZoneTypes](
	[idImpactZoneTypes] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](60) NOT NULL,
	[idUnitMeasure] [int] NOT NULL,
	[enable] [bit] NOT NULL,
	[checksum] [nchar](10) NULL,
 CONSTRAINT [PK_vpv_ImpactZoneTypes] PRIMARY KEY CLUSTERED 
(
	[idImpactZoneTypes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_incidenttypes]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_incidenttypes](
	[incidenttypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[severity] [nvarchar](50) NOT NULL,
	[description] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_vpv_incidenttypes] PRIMARY KEY CLUSTERED 
(
	[incidenttypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_infotypes]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_infotypes](
	[infotypeid] [int] IDENTITY(1,1) NOT NULL,
	[field_name] [nvarchar](150) NULL,
 CONSTRAINT [PK_vpv_infotypes] PRIMARY KEY CLUSTERED 
(
	[infotypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_investmentPayment]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_investmentPayment](
	[investmentPaymentId] [bigint] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[entitydid] [int] NULL,
	[sponsorGroupId] [int] NULL,
	[paymentId] [bigint] NOT NULL,
	[executionDate] [datetime] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_investmentPayment] PRIMARY KEY CLUSTERED 
(
	[investmentPaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_investorsPerProject]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_investorsPerProject](
	[investorProjectId] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NOT NULL,
	[entitydid] [int] NULL,
	[crowdfoundingProposalId] [int] NULL,
	[enable] [bit] NOT NULL,
	[sponsorAgreementId] [int] NOT NULL,
 CONSTRAINT [PK_vpv_investorsPerProject] PRIMARY KEY CLUSTERED 
(
	[investorProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_investorsReturns]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_investorsReturns](
	[investorsReturnId] [int] IDENTITY(1,1) NOT NULL,
	[proposalId] [int] NOT NULL,
	[returnedTo] [int] NOT NULL,
	[returnedBy] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[deleted] [bit] NOT NULL,
	[enable] [bit] NOT NULL,
	[paymentId] [bigint] NOT NULL,
	[projectReportId] [int] NOT NULL,
	[checksum] [varbinary](10) NOT NULL,
 CONSTRAINT [PK_vpv_investorsReturns] PRIMARY KEY CLUSTERED 
(
	[investorsReturnId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_ips]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_ips](
	[ipid] [int] IDENTITY(1,1) NOT NULL,
	[deviceid] [int] NOT NULL,
	[ip_address] [nvarchar](255) NOT NULL,
	[ip_version] [tinyint] NOT NULL,
	[mac_address] [char](17) NOT NULL,
	[enable] [bit] NOT NULL,
	[creationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_vpv_ips] PRIMARY KEY CLUSTERED 
(
	[ipid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_keyowners]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_keyowners](
	[keyownerid] [int] IDENTITY(1,1) NOT NULL,
	[entitykeyid] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[layernumber] [int] NOT NULL,
	[signbycert] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_keyowners] PRIMARY KEY CLUSTERED 
(
	[keyownerid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_languages]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_languages](
	[languageId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[culture] [nvarchar](30) NULL,
 CONSTRAINT [PK_vpv_languages] PRIMARY KEY CLUSTERED 
(
	[languageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_logs]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_logs](
	[logId] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](300) NULL,
	[postime] [timestamp] NOT NULL,
	[computer] [nvarchar](100) NULL,
	[username] [varchar](70) NOT NULL,
	[trace] [varchar](300) NULL,
	[referenceId1] [varchar](300) NULL,
	[referenceId2] [varchar](300) NULL,
	[value1] [varchar](300) NULL,
	[value2] [varchar](300) NULL,
	[chechsum] [varbinary](256) NOT NULL,
	[logSeverityId] [int] NOT NULL,
	[logSourceId] [int] NOT NULL,
	[logTypeId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_qrLogs] PRIMARY KEY CLUSTERED 
(
	[logId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_logSeverity]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_logSeverity](
	[logSeverityId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_vpv_logSeverity] PRIMARY KEY CLUSTERED 
(
	[logSeverityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_logsSources]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_logsSources](
	[logSourceId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_vpv_logsSources] PRIMARY KEY CLUSTERED 
(
	[logSourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_logTypes]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_logTypes](
	[logTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_vpv_logTypes] PRIMARY KEY CLUSTERED 
(
	[logTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_mediafileFormat]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_mediafileFormat](
	[id_mediafileFormat] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[descripcion] [varchar](150) NOT NULL,
 CONSTRAINT [PK_vpv_mediafileFormat] PRIMARY KEY CLUSTERED 
(
	[id_mediafileFormat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_mediafiles]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_mediafiles](
	[id_mediafile] [int] NOT NULL,
	[id_mediafileType] [int] NOT NULL,
	[id_mediafileFormat] [int] NOT NULL,
	[content_data] [varbinary](max) NULL,
	[content_url] [varchar](max) NULL,
	[bin] [bit] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[deleted] [bit] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_mediafiles] PRIMARY KEY CLUSTERED 
(
	[id_mediafile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_mediafileType]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_mediafileType](
	[id_mediafileType] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[descripcion] [varchar](150) NOT NULL,
 CONSTRAINT [PK_vpv_mediafileType] PRIMARY KEY CLUSTERED 
(
	[id_mediafileType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_MetricPerPlan]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_MetricPerPlan](
	[metricPlanId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idTargetPopulation] [int] NOT NULL,
	[sponsorGroupId] [int] NULL,
	[enable] [bit] NOT NULL,
	[description] [nvarchar](100) NULL,
	[statusId] [int] NOT NULL,
	[executionPlanId] [int] NOT NULL,
 CONSTRAINT [PK_vpv_MetricPerPlan] PRIMARY KEY CLUSTERED 
(
	[metricPlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_mfa]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_mfa](
	[mfaid] [int] IDENTITY(1,1) NOT NULL,
	[mfamethodid] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[configdata] [varbinary](max) NOT NULL,
	[creationdate] [datetime] NOT NULL,
	[lastupdate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_mfa] PRIMARY KEY CLUSTERED 
(
	[mfaid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_mfachallenges]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_mfachallenges](
	[mfachallengeid] [int] IDENTITY(1,1) NOT NULL,
	[mfaid] [int] NOT NULL,
	[code] [nvarchar](100) NOT NULL,
	[createdat] [datetime] NULL,
	[expiresat] [datetime] NULL,
	[consumed] [bit] NULL,
	[consumedat] [datetime] NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_mfachallenges] PRIMARY KEY CLUSTERED 
(
	[mfachallengeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_mfamethods]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_mfamethods](
	[mfamethodid] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[description] [nvarchar](100) NULL,
 CONSTRAINT [PK_vpv_mfamethods] PRIMARY KEY CLUSTERED 
(
	[mfamethodid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_mfaselect]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_mfaselect](
	[mfaselectid] [int] IDENTITY(1,1) NOT NULL,
	[mfasettingid] [int] NULL,
	[field] [nvarchar](50) NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_mfaselect] PRIMARY KEY CLUSTERED 
(
	[mfaselectid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_mfasettings]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_mfasettings](
	[mfasettingid] [int] IDENTITY(1,1) NOT NULL,
	[mfaid] [int] NULL,
	[name] [nvarchar](80) NULL,
 CONSTRAINT [PK_vpv_mfasettings] PRIMARY KEY CLUSTERED 
(
	[mfasettingid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_nationality]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_nationality](
	[nationalityid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](25) NOT NULL,
 CONSTRAINT [PK_vpv_nationality] PRIMARY KEY CLUSTERED 
(
	[nationalityid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_notificationMethods]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_notificationMethods](
	[idNotificationMethods] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](60) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[callbackurlget] [nvarchar](250) NOT NULL,
	[callbackurlpost] [nvarchar](250) NOT NULL,
	[callbackurlredirect] [nvarchar](250) NOT NULL,
	[authtoken] [nvarchar](250) NOT NULL,
	[checksum] [nvarchar](255) NULL,
 CONSTRAINT [PK_vpv_notificationMethods] PRIMARY KEY CLUSTERED 
(
	[idNotificationMethods] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_optionsQuestion]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_optionsQuestion](
	[idOptionQuestion] [int] IDENTITY(1,1) NOT NULL,
	[idOptionType] [int] NOT NULL,
	[idQuestions] [int] NOT NULL,
	[value] [varchar](500) NOT NULL,
	[description] [varchar](500) NOT NULL,
	[checksum] [nvarchar](255) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[orderby] [int] NOT NULL,
 CONSTRAINT [PK_vpv_optionsQuestion] PRIMARY KEY CLUSTERED 
(
	[idOptionQuestion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_optionTypes]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_optionTypes](
	[idOptionType] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[datatype] [varchar](30) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_optionTypes] PRIMARY KEY CLUSTERED 
(
	[idOptionType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_parameters]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_parameters](
	[parameterid] [int] IDENTITY(1,1) NOT NULL,
	[idApi] [int] NULL,
	[name] [nvarchar](50) NOT NULL,
	[configuration] [varchar](max) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_parameters] PRIMARY KEY CLUSTERED 
(
	[parameterid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_paymentMethods]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_paymentMethods](
	[methodId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[apiURL] [varchar](200) NOT NULL,
	[secretKey] [varbinary](256) NOT NULL,
	[key] [varbinary](256) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_caipi_paymentMethods] PRIMARY KEY CLUSTERED 
(
	[methodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_paymentPlans]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_paymentPlans](
	[paymentPlanId] [int] IDENTITY(1,1) NOT NULL,
	[paymentDate] [datetime] NOT NULL,
	[totalAmount] [decimal](10, 2) NOT NULL,
	[scheduleId] [int] NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[checksum] [varbinary](255) NOT NULL,
	[statusId] [int] NOT NULL,
	[idUser] [int] NOT NULL,
	[requiredCapital] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_vpv_paymentPlans] PRIMARY KEY CLUSTERED 
(
	[paymentPlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_payments]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_payments](
	[paymentId] [bigint] IDENTITY(1,1) NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[actualAmount] [decimal](10, 2) NOT NULL,
	[result] [varchar](50) NOT NULL,
	[authNumber] [nvarchar](256) NULL,
	[reference] [varchar](100) NOT NULL,
	[chargeToken] [varbinary](256) NOT NULL,
	[description] [varchar](100) NOT NULL,
	[error] [varchar](100) NOT NULL,
	[date] [datetime] NOT NULL,
	[checksum] [varbinary](256) NOT NULL,
	[paymentMethodId] [int] NOT NULL,
	[methodId] [int] NOT NULL,
	[scheduleId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_payments] PRIMARY KEY CLUSTERED 
(
	[paymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_PermissionAction]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_PermissionAction](
	[id_permissionAction] [int] NOT NULL,
	[name] [varchar](20) NOT NULL,
	[descripcion] [varchar](150) NOT NULL,
 CONSTRAINT [PK_vpv_PermissionAction] PRIMARY KEY CLUSTERED 
(
	[id_permissionAction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_PermissionResource]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_PermissionResource](
	[id_permissionResource] [int] NOT NULL,
	[name] [varchar](200) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[updatedAt] [datetime] NOT NULL,
	[enabled] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_PermissionResource] PRIMARY KEY CLUSTERED 
(
	[id_permissionResource] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_Permissions]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_Permissions](
	[id_permission] [int] NOT NULL,
	[id_permisionResource] [int] NOT NULL,
	[id_permissionAction] [int] NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[updatedAt] [datetime] NOT NULL,
	[enabled] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[checksum] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_vpv_Permissions] PRIMARY KEY CLUSTERED 
(
	[id_permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_planBalance]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_planBalance](
	[planBalanceId] [bigint] IDENTITY(1,1) NOT NULL,
	[balanceId] [bigint] NOT NULL,
	[executionPlanId] [int] NOT NULL,
	[executionDate] [datetime] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_planBalance] PRIMARY KEY CLUSTERED 
(
	[planBalanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_PlansVotes]    Script Date: 18/06/2025 09:53:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_PlansVotes](
	[planVoteId] [int] IDENTITY(1,1) NOT NULL,
	[ExecutionPlanId] [int] NOT NULL,
	[idVotingConfig] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_PopulationFilters]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_PopulationFilters](
	[idPopulationFilter] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](50) NULL,
	[idFilterType] [int] NOT NULL,
	[valueMin] [decimal](5, 2) NULL,
	[valueMax] [decimal](5, 2) NULL,
	[referenceValue] [int] NULL,
	[validation] [bit] NULL,
	[enable] [bit] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[checksum] [nvarchar](255) NOT NULL,
	[idTargetPopulation] [int] NOT NULL,
 CONSTRAINT [PK_vpv_PopulationFilters] PRIMARY KEY CLUSTERED 
(
	[idPopulationFilter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_process]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_process](
	[processid] [int] IDENTITY(1,1) NOT NULL,
	[processtypeid] [int] NOT NULL,
	[referencevalue] [int] NOT NULL,
	[referenceid] [nvarchar](25) NOT NULL,
	[parameterid] [int] NOT NULL,
	[processmethodid] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[enable] [bit] NOT NULL,
	[fecha] [datetime] NULL,
	[order] [int] NULL,
 CONSTRAINT [PK_vpv_process] PRIMARY KEY CLUSTERED 
(
	[processid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_processStatus]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_processStatus](
	[statusId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_vpv_processStatus] PRIMARY KEY CLUSTERED 
(
	[statusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_processtypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_processtypes](
	[processtypeid] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_vpv_processtypes] PRIMARY KEY CLUSTERED 
(
	[processtypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_projectReports]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_projectReports](
	[projectReportId] [int] IDENTITY(1,1) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[checksum] [varbinary](255) NOT NULL,
	[lastUpdated] [datetime] NOT NULL,
	[idUser] [int] NOT NULL,
	[totalProfit] [decimal](10, 2) NOT NULL,
	[expectedProfit] [decimal](10, 2) NOT NULL,
	[totalLoss] [decimal](10, 2) NOT NULL,
	[totalExpenses] [decimal](10, 2) NOT NULL,
	[tittle] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NULL,
	[docid] [int] NOT NULL,
	[scheduleId] [int] NOT NULL,
	[crowdfoundingProposalId] [int] NOT NULL,
	[idTargetPopulation] [int] NOT NULL,
	[relacion] [nvarchar](500) NULL,
	[availablePayment] [decimal](10, 2) NOT NULL,
	[statusId] [int] NOT NULL,
 CONSTRAINT [PK_vpv_projectReports] PRIMARY KEY CLUSTERED 
(
	[projectReportId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_proposalBalance]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_proposalBalance](
	[proposalBalanceId] [bigint] IDENTITY(1,1) NOT NULL,
	[BalanceId] [bigint] NOT NULL,
	[crowdfoundingProposalId] [int] NOT NULL,
	[executionDate] [datetime] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_proposalBalance] PRIMARY KEY CLUSTERED 
(
	[proposalBalanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_proposalComments]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_proposalComments](
	[commentId] [int] IDENTITY(1,1) NOT NULL,
	[comment] [nvarchar](500) NOT NULL,
	[madeBy] [int] NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[docid] [int] NOT NULL,
	[proposalVersionId] [int] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[statusId] [int] NOT NULL,
	[checksum] [varbinary](255) NOT NULL,
 CONSTRAINT [PK_vpv_proposalComments] PRIMARY KEY CLUSTERED 
(
	[commentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_proposalNormalViews]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_proposalNormalViews](
	[normalviewId] [int] IDENTITY(1,1) NOT NULL,
	[proposalId] [int] NOT NULL,
	[demotypeid] [int] NULL,
	[demosubtypeid] [int] NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[checksum] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_vpv_proposalNormalViews] PRIMARY KEY CLUSTERED 
(
	[normalviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_proposalRequirements]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_proposalRequirements](
	[poposalRequirementId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](50) NULL,
	[enable] [bit] NOT NULL,
	[requirementTypeId] [int] NOT NULL,
 CONSTRAINT [PK_vpv_proposalRequirements] PRIMARY KEY CLUSTERED 
(
	[poposalRequirementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_proposals]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_proposals](
	[proposalId] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NOT NULL,
	[entitydid] [int] NULL,
	[tittle] [nvarchar](100) NOT NULL,
	[description] [nvarchar](500) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[scheduleId] [int] NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[ckecksum] [varbinary](255) NOT NULL,
	[statusId] [int] NOT NULL,
	[budget] [decimal](10, 2) NULL,
	[idTargetPopulation] [int] NOT NULL,
	[proposalTypeId] [int] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[startingDate] [datetime] NOT NULL,
	[proposalTypeId_semantica] [nvarchar](50) NULL,
	[relacion] [nvarchar](500) NULL,
 CONSTRAINT [PK_vpv_proposals] PRIMARY KEY CLUSTERED 
(
	[proposalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_ProposalTracking]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_ProposalTracking](
	[projectTrackingId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[proposalId] [int] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[statusId] [int] NOT NULL,
	[docid] [int] NOT NULL,
	[tittle] [nvarchar](50) NOT NULL,
	[scheduleId] [int] NOT NULL,
	[description] [nvarchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_proposalTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_proposalTypes](
	[proposalTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](1100) NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_proposalTypes] PRIMARY KEY CLUSTERED 
(
	[proposalTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_proposalVersions]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_proposalVersions](
	[proposalVersionId] [int] IDENTITY(1,1) NOT NULL,
	[tittle] [nvarchar](100) NOT NULL,
	[content] [nvarchar](500) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[startingDate] [datetime] NOT NULL,
	[scheduleId] [int] NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[checksum] [varbinary](255) NOT NULL,
	[statusid] [int] NOT NULL,
	[budget] [decimal](10, 8) NULL,
	[lastUpdate] [datetime] NOT NULL,
	[idUser] [int] NOT NULL,
	[proposalId] [int] NOT NULL,
	[lastVersion] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_proposalVersions] PRIMARY KEY CLUSTERED 
(
	[proposalVersionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_proposalViews]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_proposalViews](
	[proposalViewId] [int] IDENTITY(1,1) NOT NULL,
	[summary] [nvarchar](2000) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[proposalId] [int] NOT NULL,
	[viewTypeId] [int] NOT NULL,
	[idTargetPopulationsVoting] [int] NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[demotypeid] [int] NOT NULL,
	[demosubtypeid] [int] NOT NULL,
	[json] [nvarchar](max) NOT NULL,
	[viewTypeId_semantica] [nvarchar](50) NULL,
	[idTargetPopulationsVoting_semantica] [nvarchar](50) NULL,
	[checksum] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_vpv_proposalViews] PRIMARY KEY CLUSTERED 
(
	[proposalViewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_proposalViewTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_proposalViewTypes](
	[viewTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_proposalViewTypes] PRIMARY KEY CLUSTERED 
(
	[viewTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_questions]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_questions](
	[idQuestion] [int] IDENTITY(1,1) NOT NULL,
	[idQuestionType] [int] NOT NULL,
	[description] [varchar](1000) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[checksum] [nvarchar](550) NULL,
 CONSTRAINT [PK_vpv_questions] PRIMARY KEY CLUSTERED 
(
	[idQuestion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_questionTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_questionTypes](
	[idQuestionType] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_questionTypes] PRIMARY KEY CLUSTERED 
(
	[idQuestionType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_reminders]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_reminders](
	[idReminder] [int] IDENTITY(1,1) NOT NULL,
	[message] [varchar](250) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[ticketId] [nvarchar](100) NOT NULL,
	[requestId] [nvarchar](100) NOT NULL,
	[successInfo] [varchar](250) NOT NULL,
	[userId] [nvarchar](100) NOT NULL,
	[idNotificationMethods] [int] NOT NULL,
	[idReminderType] [int] NOT NULL,
	[idPerson] [nvarchar](100) NOT NULL,
	[checksum] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_vpv_reminders] PRIMARY KEY CLUSTERED 
(
	[idReminder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_reminderTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_reminderTypes](
	[idReminderType] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_reminderTypes] PRIMARY KEY CLUSTERED 
(
	[idReminderType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_requests]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_requests](
	[requestid] [int] IDENTITY(1,1) NOT NULL,
	[requeststatusid] [int] NOT NULL,
	[entitydid] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[signatures] [int] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_requests] PRIMARY KEY CLUSTERED 
(
	[requestid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_requeststates]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_requeststates](
	[requeststatusid] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](50) NULL,
 CONSTRAINT [PK_vpv_requeststates] PRIMARY KEY CLUSTERED 
(
	[requeststatusid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_RequestStatus]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_RequestStatus](
	[id_requestStatus] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[enabled] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_RequestStatus] PRIMARY KEY CLUSTERED 
(
	[id_requestStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_requestvalidators]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_requestvalidators](
	[validatorid] [int] IDENTITY(1,1) NOT NULL,
	[requestid] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[keyid] [int] NOT NULL,
	[validationstatusid] [int] NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_requestvalidators] PRIMARY KEY CLUSTERED 
(
	[validatorid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_requirementTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_requirementTypes](
	[requirementTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_requirementTypes] PRIMARY KEY CLUSTERED 
(
	[requirementTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_resolutions]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_resolutions](
	[resolutionid] [int] IDENTITY(1,1) NOT NULL,
	[docincidentid] [int] NOT NULL,
	[comments] [nvarchar](250) NOT NULL,
	[actions] [nvarchar](150) NULL,
	[timestamp] [datetime] NOT NULL,
	[resolutionby] [nvarchar](150) NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_resolutions] PRIMARY KEY CLUSTERED 
(
	[resolutionid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_ResponseStatus]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_ResponseStatus](
	[id_responseStatus] [int] NOT NULL,
	[name] [nchar](10) NOT NULL,
	[enabled] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_ResponseStatus] PRIMARY KEY CLUSTERED 
(
	[id_responseStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_ResultsPerFilter]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_ResultsPerFilter](
	[idResultsPerFilter] [int] IDENTITY(1,1) NOT NULL,
	[idResultType] [int] NOT NULL,
	[idFilterType] [int] NOT NULL,
	[votesCount] [int] NOT NULL,
	[votesPercentage] [decimal](5, 2) NOT NULL,
	[checkSum] [nvarchar](250) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[idVotingConfig] [int] NOT NULL,
	[referenceId1] [int] NULL,
	[referenceId2] [int] NOT NULL,
 CONSTRAINT [PK_vpv_ResultsPerFilter] PRIMARY KEY CLUSTERED 
(
	[idResultsPerFilter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_ResultsPerOption]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_ResultsPerOption](
	[idResultsPerOption] [int] IDENTITY(1,1) NOT NULL,
	[idOptionQuestion] [int] NOT NULL,
	[idVotingQuestions] [int] NOT NULL,
	[votesCount] [bigint] NOT NULL,
	[votesPercentage] [decimal](5, 2) NOT NULL,
	[winner] [bit] NOT NULL,
	[enable] [bit] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[checksum] [nvarchar](250) NOT NULL,
	[idVotingConfig] [int] NOT NULL,
	[average] [decimal](5, 2) NULL,
 CONSTRAINT [PK_vpv_ResultsPerOption] PRIMARY KEY CLUSTERED 
(
	[idResultsPerOption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_ResultTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_ResultTypes](
	[idResultType] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](60) NOT NULL,
	[enable] [bit] NOT NULL,
	[referenceDescription] [varchar](60) NULL,
 CONSTRAINT [PK_vpv_ResultTypes] PRIMARY KEY CLUSTERED 
(
	[idResultType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_RolePermission]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_RolePermission](
	[id_role_permission] [int] NOT NULL,
	[id_role] [int] NOT NULL,
	[id_permission] [int] NOT NULL,
 CONSTRAINT [PK_vpv_RolePermission] PRIMARY KEY CLUSTERED 
(
	[id_role_permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_Roles]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_Roles](
	[id_role] [int] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[descripcion] [varchar](255) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[updateAt] [datetime] NOT NULL,
	[enabled] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_Roles] PRIMARY KEY CLUSTERED 
(
	[id_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_Rules]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_Rules](
	[idRule] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[enable] [bit] NOT NULL,
	[idVotingRuleTypes] [int] NOT NULL,
	[checksum] [nvarchar](255) NULL,
	[validation] [bit] NULL,
	[amount_percentage] [decimal](5, 2) NULL,
	[quantity] [int] NULL,
	[idVotingRuleSubType] [int] NOT NULL,
 CONSTRAINT [PK_vpv_VotingMethods] PRIMARY KEY CLUSTERED 
(
	[idRule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_scheduleDetails]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_scheduleDetails](
	[scheduleDetailId] [int] IDENTITY(1,1) NOT NULL,
	[baseDate] [datetime] NOT NULL,
	[datepart] [nvarchar](30) NOT NULL,
	[lastExecute] [datetime] NOT NULL,
	[nextExecute] [datetime] NOT NULL,
	[scheduleId] [int] NULL,
 CONSTRAINT [PK_vpv_scheduleDetails] PRIMARY KEY CLUSTERED 
(
	[scheduleDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_schedules]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_schedules](
	[scheduleId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[recurrencyType] [nvarchar](50) NOT NULL,
	[repetition] [int] NULL,
	[endType] [nvarchar](30) NULL,
	[endDate] [datetime] NOT NULL,
 CONSTRAINT [PK_vpv_schedules] PRIMARY KEY CLUSTERED 
(
	[scheduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_SearchingTags]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_SearchingTags](
	[idSearchingTags] [int] IDENTITY(1,1) NOT NULL,
	[name] [nchar](10) NOT NULL,
	[idTargetPopulations] [int] NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_SearchingTags] PRIMARY KEY CLUSTERED 
(
	[idSearchingTags] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_selectoptions]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_selectoptions](
	[entityseloptdid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[description] [varchar](100) NOT NULL,
 CONSTRAINT [PK_vpv_selectoptions] PRIMARY KEY CLUSTERED 
(
	[entityseloptdid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_sponsorAgreements]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_sponsorAgreements](
	[sponsorAgreementId] [int] IDENTITY(1,1) NOT NULL,
	[enable] [bit] NOT NULL,
	[checksum] [varbinary](255) NOT NULL,
	[startDate] [datetime] NOT NULL,
	[finalDate] [datetime] NOT NULL,
	[signedDate] [datetime] NOT NULL,
	[deleted] [bit] NOT NULL,
	[currencyId] [int] NOT NULL,
	[scheduleId] [int] NOT NULL,
	[noReward] [bit] NULL,
	[percentage] [decimal](10, 8) NULL,
	[product] [bit] NULL,
	[amount] [decimal](10, 8) NULL,
	[shares] [int] NULL,
	[baseSalary] [decimal](10, 8) NULL,
	[sponsorAgreementTypeId] [int] NOT NULL,
	[sponsorGroupId] [int] NULL,
	[crowdfoundingProposalId] [int] NOT NULL,
	[inversion] [decimal](10, 2) NOT NULL,
	[name] [varchar](250) NOT NULL,
 CONSTRAINT [PK_vpv_sponsorAgreements] PRIMARY KEY CLUSTERED 
(
	[sponsorAgreementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_sponsorAgrementsType]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_sponsorAgrementsType](
	[sponsorAgreementTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](40) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[dataType] [nvarchar](20) NULL,
 CONSTRAINT [PK_vpv_sponsorAgrementsType] PRIMARY KEY CLUSTERED 
(
	[sponsorAgreementTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_sponsorGroups]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_sponsorGroups](
	[sponsorGroupId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](40) NOT NULL,
	[description] [nvarchar](100) NOT NULL,
	[enable] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[sponsorGroupTypeId] [int] NOT NULL,
 CONSTRAINT [PK_vpv_sponsorGroups] PRIMARY KEY CLUSTERED 
(
	[sponsorGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_sponsornGroupTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_sponsornGroupTypes](
	[sponsorGroupTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_sponsornGroupTypes] PRIMARY KEY CLUSTERED 
(
	[sponsorGroupTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_States]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_States](
	[idState] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](200) NOT NULL,
	[enabled] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[idCountry] [int] NOT NULL,
 CONSTRAINT [PK_vpv_States] PRIMARY KEY CLUSTERED 
(
	[idState] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_statusVoting]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_statusVoting](
	[idStatusVoting] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[enable] [bit] NOT NULL,
	[checksum] [nvarchar](255) NULL,
 CONSTRAINT [PK_vpv_statesVoting] PRIMARY KEY CLUSTERED 
(
	[idStatusVoting] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_steptypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_steptypes](
	[steptypeid] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](50) NOT NULL,
 CONSTRAINT [PK_vpv_steptypes] PRIMARY KEY CLUSTERED 
(
	[steptypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_TargetPopulations]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_TargetPopulations](
	[idTargetPopulation] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](500) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[checksum] [nvarchar](255) NULL,
 CONSTRAINT [PK_vpv_TargetPopulations] PRIMARY KEY CLUSTERED 
(
	[idTargetPopulation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_TargetPopulationsVoting]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_TargetPopulationsVoting](
	[idTargetPopulationsVoting] [int] IDENTITY(1,1) NOT NULL,
	[idVotingConfig] [int] NOT NULL,
	[idTargetPopulation] [int] NOT NULL,
	[checksum] [nvarchar](255) NULL,
	[enable] [bit] NOT NULL,
	[weight] [decimal](5, 2) NULL,
 CONSTRAINT [PK_vpv_TargetPopulationsVoting] PRIMARY KEY CLUSTERED 
(
	[idTargetPopulationsVoting] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_transactionPerPlan]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_transactionPerPlan](
	[transacionPlanId] [bigint] IDENTITY(1,1) NOT NULL,
	[crowdfoundingProposalId] [int] NOT NULL,
	[executionPlanId] [int] NULL,
	[transactionId] [bigint] NULL,
	[executionDate] [datetime] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_transactionPerPlan] PRIMARY KEY CLUSTERED 
(
	[transacionPlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_transactionPerUser]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_transactionPerUser](
	[transactionUserId] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NULL,
	[sponsorGroupId] [int] NULL,
	[entitydid] [int] NULL,
	[transactionId] [bigint] NOT NULL,
	[executionDate] [datetime] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_transactionPerUser] PRIMARY KEY CLUSTERED 
(
	[transactionUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_transactions]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_transactions](
	[transactionId] [bigint] IDENTITY(1,1) NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[description] [varchar](100) NOT NULL,
	[date] [datetime] NOT NULL,
	[postTime] [datetime] NOT NULL,
	[refNumber] [varchar](150) NOT NULL,
	[checksum] [varbinary](256) NOT NULL,
	[convertedAmount] [decimal](10, 2) NOT NULL,
	[paymentId] [bigint] NOT NULL,
	[transactionSubTypeId] [int] NOT NULL,
	[transTypeId] [int] NOT NULL,
	[currencyId] [int] NOT NULL,
	[exchangeRateId] [int] NOT NULL,
	[balanceId] [bigint] NULL,
	[idUser] [int] NULL,
 CONSTRAINT [PK_caipi_transactions] PRIMARY KEY CLUSTERED 
(
	[transactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_translations]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_translations](
	[transalationId] [int] IDENTITY(1,1) NOT NULL,
	[code] [int] NOT NULL,
	[caption] [varchar](30) NULL,
	[enable] [bit] NOT NULL,
	[languageId] [int] NOT NULL,
 CONSTRAINT [PK_vpv_translations] PRIMARY KEY CLUSTERED 
(
	[transalationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_transSubTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_transSubTypes](
	[transactionSubTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[deleted] [bit] NOT NULL,
 CONSTRAINT [PK_caipi_transSubTypes] PRIMARY KEY CLUSTERED 
(
	[transactionSubTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_transTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_transTypes](
	[name] [varchar](30) NOT NULL,
	[deleted] [bit] NOT NULL,
	[transTypeId] [int] NOT NULL,
 CONSTRAINT [PK_caipi_transTypes] PRIMARY KEY CLUSTERED 
(
	[transTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_UnitMeasure]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_UnitMeasure](
	[idUnitMeasure] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](60) NOT NULL,
	[datatype] [varchar](60) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_UnitMeasure] PRIMARY KEY CLUSTERED 
(
	[idUnitMeasure] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_userBalance]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_userBalance](
	[entityBalanceId] [bigint] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NOT NULL,
	[balanceId] [bigint] NOT NULL,
	[checksum] [varbinary](max) NULL,
	[executionDate] [datetime] NOT NULL,
 CONSTRAINT [PK_vpv_userBalance] PRIMARY KEY CLUSTERED 
(
	[entityBalanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_useroptions]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_useroptions](
	[entityoptdid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[description] [varchar](100) NULL,
 CONSTRAINT [PK_vpv_useroptions] PRIMARY KEY CLUSTERED 
(
	[entityoptdid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_userperrole]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_userperrole](
	[userrole] [int] IDENTITY(1,1) NOT NULL,
	[entityrole] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[key] [nvarchar](150) NOT NULL,
	[certificate] [nvarchar](150) NOT NULL,
	[enable] [bit] NOT NULL,
	[checksum] [nvarchar](255) NULL,
 CONSTRAINT [PK_vpv_userperrole] PRIMARY KEY CLUSTERED 
(
	[userrole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_userResidence]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_userResidence](
	[idUserResidence] [int] IDENTITY(1,1) NOT NULL,
	[idCity] [int] NOT NULL,
	[userid] [int] NOT NULL,
 CONSTRAINT [PK_vpv_userResidence] PRIMARY KEY CLUSTERED 
(
	[idUserResidence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_UserRole]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_UserRole](
	[id_user_role] [int] NOT NULL,
	[idUser] [int] NOT NULL,
	[id_role] [int] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[updateAt] [datetime] NOT NULL,
	[enabled] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_UserRole] PRIMARY KEY CLUSTERED 
(
	[id_user_role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_Users]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_Users](
	[idUser] [int] IDENTITY(1,1) NOT NULL,
	[nationalityid] [int] NOT NULL,
	[sexid] [int] NOT NULL,
	[id_card] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[lastname] [nvarchar](50) NOT NULL,
	[birth] [datetime] NOT NULL,
	[registration_date] [datetime] NOT NULL,
	[is_verified] [bit] NULL,
	[enable] [bit] NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_vpv_Users] PRIMARY KEY CLUSTERED 
(
	[idUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_validations]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_validations](
	[validationid] [int] IDENTITY(1,1) NOT NULL,
	[requestid] [int] NULL,
	[validatorid] [int] NULL,
	[signature] [varbinary](max) NULL,
	[validatedat] [datetime] NULL,
 CONSTRAINT [PK_vpv_validations] PRIMARY KEY CLUSTERED 
(
	[validationid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_validationstatus]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_validationstatus](
	[validationstatusid] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](50) NULL,
 CONSTRAINT [PK_vpv_validationstatus] PRIMARY KEY CLUSTERED 
(
	[validationstatusid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_VoteComment]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_VoteComment](
	[idComment] [int] NOT NULL,
	[comment] [text] NOT NULL,
	[creacionDate] [datetime] NOT NULL,
	[idVote] [int] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_VoteComment] PRIMARY KEY CLUSTERED 
(
	[idComment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_Voter]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_Voter](
	[idVoter] [int] NOT NULL,
	[age] [int] NOT NULL,
	[idUser] [int] NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_Voter] PRIMARY KEY CLUSTERED 
(
	[idVoter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_VoterDemographics]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_VoterDemographics](
	[idDemographic] [int] NOT NULL,
	[idVoter] [int] NOT NULL,
	[idDemographyType] [int] NOT NULL,
	[idDemographySubType] [int] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_VoterDemographics] PRIMARY KEY CLUSTERED 
(
	[idDemographic] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_VoterResidence]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_VoterResidence](
	[idResidence] [int] NOT NULL,
	[idCity] [int] NOT NULL,
	[idVoter] [int] NOT NULL,
 CONSTRAINT [PK_vpv_VoterResidence] PRIMARY KEY CLUSTERED 
(
	[idResidence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_Votes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_Votes](
	[idVote] [int] NOT NULL,
	[idVotingQuestion] [int] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[idToken] [uniqueidentifier] NOT NULL,
	[idVoter] [int] NOT NULL,
	[idOptionQuestion] [int] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_Votes] PRIMARY KEY CLUSTERED 
(
	[idVote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_VotesTaken]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_VotesTaken](
	[idVoteTaken] [int] NOT NULL,
	[idUser] [int] NOT NULL,
	[idVotingQuestions] [int] NOT NULL,
	[creacionDate] [datetime] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_VotesTaken] PRIMARY KEY CLUSTERED 
(
	[idVoteTaken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_voteValues]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_voteValues](
	[idVoteValue] [int] NOT NULL,
	[value1] [varbinary](100) NOT NULL,
	[value2] [varbinary](100) NOT NULL,
	[idVote] [int] NOT NULL,
	[checksum] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_vpv_voteValues] PRIMARY KEY CLUSTERED 
(
	[idVoteValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_votingConfigurations]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_votingConfigurations](
	[idVotingConfig] [int] IDENTITY(1,1) NOT NULL,
	[proposalVersionId] [int] NULL,
	[openDate] [datetime] NOT NULL,
	[closeDate] [datetime] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[idStatusVoting] [int] NOT NULL,
	[idVotingType] [int] NOT NULL,
	[description] [varchar](1000) NOT NULL,
	[weight] [bit] NOT NULL,
	[checksum] [nvarchar](255) NULL,
	[idReminderType] [int] NOT NULL,
	[idClosureTypes] [int] NOT NULL,
	[idvotingReasons] [int] NOT NULL,
	[executionPlanId] [int] NULL,
	[metricPlanId] [int] NULL,
	[projectReportId] [int] NULL,
	[sponsorAgreementId] [int] NULL,
	[governmentConditionId] [int] NULL,
 CONSTRAINT [PK_vpv_votingConfigurations] PRIMARY KEY CLUSTERED 
(
	[idVotingConfig] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_VotingPerRestrictions]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_VotingPerRestrictions](
	[idVotingRestrictions] [int] IDENTITY(1,1) NOT NULL,
	[idVotingConfig] [int] NOT NULL,
	[idRestrictions] [int] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[checksum] [nvarchar](250) NULL,
 CONSTRAINT [PK_vpv_VotingPerRestrictions] PRIMARY KEY CLUSTERED 
(
	[idVotingRestrictions] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_votingQuestions]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_votingQuestions](
	[idVotingQuestions] [int] IDENTITY(1,1) NOT NULL,
	[idQuestion] [int] NOT NULL,
	[idVotingConfig] [int] NOT NULL,
	[enable] [bit] NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[checksum] [nvarchar](100) NULL,
	[orderBy] [int] NOT NULL,
 CONSTRAINT [PK_vpv_votingQuestions] PRIMARY KEY CLUSTERED 
(
	[idVotingQuestions] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_votingReasons]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_votingReasons](
	[idvotingReasons] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[description] [varchar](300) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_votingReasons] PRIMARY KEY CLUSTERED 
(
	[idvotingReasons] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_votingRestrictions]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_votingRestrictions](
	[idRestrictions] [int] IDENTITY(1,1) NOT NULL,
	[idVotingRestrictionTypes] [int] NOT NULL,
	[idVotingConfig] [int] NULL,
	[description] [varchar](280) NOT NULL,
	[value] [varchar](280) NULL,
	[validation] [bit] NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[startTime] [datetime] NULL,
	[endTime] [datetime] NULL,
	[checksum] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_vpv_votingRestrictions] PRIMARY KEY CLUSTERED 
(
	[idRestrictions] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_votingRestrictionTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_votingRestrictionTypes](
	[idVotingRestrictionTypes] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[description] [varchar](500) NOT NULL,
	[datatype] [varchar](50) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_votingRestrictionTypes] PRIMARY KEY CLUSTERED 
(
	[idVotingRestrictionTypes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_VotingResultsSummary]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_VotingResultsSummary](
	[idVotingResultsSummary] [int] IDENTITY(1,1) NOT NULL,
	[idVotingConfig] [int] NOT NULL,
	[idEndOfVoting] [int] NOT NULL,
	[description] [varchar](290) NOT NULL,
	[idVotingResultStatus] [int] NOT NULL,
	[votesCount] [int] NOT NULL,
	[ValidVotesPercentage] [decimal](5, 2) NOT NULL,
	[checkSum] [nvarchar](250) NOT NULL,
	[creationDate] [datetime] NOT NULL,
	[enable] [bit] NOT NULL,
	[average] [decimal](5, 2) NULL,
 CONSTRAINT [PK_vpv_VotingResultsSummary] PRIMARY KEY CLUSTERED 
(
	[idVotingResultsSummary] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_VotingResultStatus]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_VotingResultStatus](
	[idVotingResultStatus] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_VotingResultStatus] PRIMARY KEY CLUSTERED 
(
	[idVotingResultStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_VotingRules]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_VotingRules](
	[idVotingRule] [int] IDENTITY(1,1) NOT NULL,
	[idVotingConfig] [int] NOT NULL,
	[idRule] [int] NOT NULL,
	[checksum] [nvarchar](255) NULL,
	[creationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_vpv_VotingRules] PRIMARY KEY CLUSTERED 
(
	[idVotingRule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_VotingRuleSubType]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_VotingRuleSubType](
	[idVotingRuleSubType] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[idUnitMeasure] [int] NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_VotingRuleSubType] PRIMARY KEY CLUSTERED 
(
	[idVotingRuleSubType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_VotingRuleTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_VotingRuleTypes](
	[idVotingRuleTypes] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_VotingMethodTypes] PRIMARY KEY CLUSTERED 
(
	[idVotingRuleTypes] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_votingTypes]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_votingTypes](
	[idVotingType] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_votingTypes] PRIMARY KEY CLUSTERED 
(
	[idVotingType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_whitelistips]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_whitelistips](
	[whitelistipid] [int] IDENTITY(1,1) NOT NULL,
	[whitelistid] [int] NULL,
	[startip] [varbinary](50) NULL,
	[endip] [varbinary](50) NULL,
	[enabled] [bit] NULL,
	[description] [nvarchar](100) NULL,
	[creationdate] [datetime] NULL,
 CONSTRAINT [PK_vpv_whitelistips] PRIMARY KEY CLUSTERED 
(
	[whitelistipid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_whitelists]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_whitelists](
	[whitelistid] [int] IDENTITY(1,1) NOT NULL,
	[countryid] [int] NULL,
	[allowed] [bit] NULL,
	[creationdate] [datetime] NULL,
 CONSTRAINT [PK_vpv_whitelists] PRIMARY KEY CLUSTERED 
(
	[whitelistid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_workflowsteps]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_workflowsteps](
	[workflowid] [int] IDENTITY(1,1) NOT NULL,
	[processtypeid] [int] NOT NULL,
	[steptypeid] [int] NOT NULL,
	[steporder] [int] NOT NULL,
	[name] [varchar](85) NOT NULL,
	[manual] [bit] NOT NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_vpv_workflowsteps] PRIMARY KEY CLUSTERED 
(
	[workflowid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vpv_workresults]    Script Date: 18/06/2025 09:53:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vpv_workresults](
	[workresultid] [int] IDENTITY(1,1) NOT NULL,
	[processid] [int] NOT NULL,
	[referencevalue] [int] NOT NULL,
	[referenceid] [int] NOT NULL,
	[timestamp] [datetime] NOT NULL,
	[error] [bit] NOT NULL,
	[errorMessage] [nvarchar](250) NOT NULL,
	[details] [nvarchar](max) NOT NULL,
	[performedby] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_vpv_workresults] PRIMARY KEY CLUSTERED 
(
	[workresultid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[vpv_AllowedVoters] ADD  CONSTRAINT [DF_vpv_AllowedVoters_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_AllowedVoters] ADD  CONSTRAINT [DF_vpv_AllowedVoters_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_api] ADD  CONSTRAINT [DF_vpv_api_creacionDate]  DEFAULT (getdate()) FOR [creacionDate]
GO
ALTER TABLE [dbo].[vpv_api] ADD  CONSTRAINT [DF_vpv_api_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[vpv_apiConfig] ADD  CONSTRAINT [DF_vpv_apiConfig_creacionDate]  DEFAULT (getdate()) FOR [creacionDate]
GO
ALTER TABLE [dbo].[vpv_apiConfig] ADD  CONSTRAINT [DF_vpv_apiConfig_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[vpv_apiRequest] ADD  CONSTRAINT [DF_vpv_apiRequest_creacionDate]  DEFAULT (getdate()) FOR [creacionDate]
GO
ALTER TABLE [dbo].[vpv_apiResponse] ADD  CONSTRAINT [DF_vpv_apiResponse_creacionDate]  DEFAULT (getdate()) FOR [creacionDate]
GO
ALTER TABLE [dbo].[vpv_authmethods] ADD  CONSTRAINT [DF_vpv_authmethods_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_availablePaymentMethodPerEntity] ADD  CONSTRAINT [DF_vpv_availablePaymentMethodPerEntity_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_availablePaymentMethodsPerUser] ADD  CONSTRAINT [DF_vpv_availablePaymentMethodsPerUser_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_azureanalysis] ADD  CONSTRAINT [DF_vpv_azureanalysis_status]  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[vpv_biometricauths] ADD  CONSTRAINT [DF_vpv_biometricauths_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_biorequests] ADD  CONSTRAINT [DF_vpv_biorequests_returndata]  DEFAULT ((1)) FOR [returndata]
GO
ALTER TABLE [dbo].[vpv_BlindTokens] ADD  CONSTRAINT [DF_vpv_BlindTokens_idToken]  DEFAULT (newid()) FOR [idToken]
GO
ALTER TABLE [dbo].[vpv_BlindTokens] ADD  CONSTRAINT [DF_vpv_BlindTokens_used]  DEFAULT ((0)) FOR [used]
GO
ALTER TABLE [dbo].[vpv_BlindTokens] ADD  CONSTRAINT [DF_vpv_BlindTokens_creacionDate]  DEFAULT (getdate()) FOR [creacionDate]
GO
ALTER TABLE [dbo].[vpv_BlindTokens] ADD  CONSTRAINT [DF_vpv_BlindTokens_usedDate]  DEFAULT (NULL) FOR [usedDate]
GO
ALTER TABLE [dbo].[vpv_Cities] ADD  CONSTRAINT [DF_vpv_Cities_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[vpv_Cities] ADD  CONSTRAINT [DF_vpv_Cities_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_ClosureTypes] ADD  CONSTRAINT [DF_vpv_ClosureTypes_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_Countries] ADD  CONSTRAINT [DF_vpv_Countries_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[vpv_Countries] ADD  CONSTRAINT [DF_vpv_Countries_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_crowdfoundingProposals] ADD  CONSTRAINT [DF_vpv_crowdfoundingProposals_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_crowdfoundingProposals] ADD  CONSTRAINT [DF_vpv_crowdfoundingProposals_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_docincidents] ADD  CONSTRAINT [DF_vpv_docincidents_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_docincidents] ADD  CONSTRAINT [DF_vpv_docincidents_block]  DEFAULT ((0)) FOR [block]
GO
ALTER TABLE [dbo].[vpv_docs] ADD  CONSTRAINT [DF_vpv_docs_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_encryptionkeys] ADD  CONSTRAINT [DF_vpv_encryptionkeys_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_entities] ADD  CONSTRAINT [DF_vpv_entities_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_entitydescription] ADD  CONSTRAINT [DF_vpv_entitydescription_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_entitydescription] ADD  CONSTRAINT [DF_vpv_entitydescription_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_entitykey] ADD  CONSTRAINT [DF_vpv_entitykey_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_entityroles] ADD  CONSTRAINT [DF_vpv_entityroles_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_entityroles] ADD  CONSTRAINT [DF_vpv_entityroles_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_exchangeRates] ADD  CONSTRAINT [DF_vpv_exchangeRates_startDate]  DEFAULT (getdate()) FOR [startDate]
GO
ALTER TABLE [dbo].[vpv_exchangeRates] ADD  CONSTRAINT [DF_vpv_exchangeRates_endDate]  DEFAULT (getdate()) FOR [endDate]
GO
ALTER TABLE [dbo].[vpv_exchangeRates] ADD  CONSTRAINT [DF_vpv_exchangeRates_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_exchangeRates] ADD  CONSTRAINT [DF_vpv_exchangeRates_currentExchange]  DEFAULT ((1)) FOR [currentExchange]
GO
ALTER TABLE [dbo].[vpv_executionPlans] ADD  CONSTRAINT [DF_vpv_executionPlans_creationDate]  DEFAULT (getdate()) FOR [startDate]
GO
ALTER TABLE [dbo].[vpv_executionPlans] ADD  CONSTRAINT [DF_vpv_executionPlans_finalDate]  DEFAULT (getdate()) FOR [finalDate]
GO
ALTER TABLE [dbo].[vpv_FilesPerProposal] ADD  CONSTRAINT [DF_vpv_FilesPerProposal_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_FilesPerProposal] ADD  CONSTRAINT [DF_vpv_FilesPerProposal_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_FilterTypes] ADD  CONSTRAINT [DF_vpv_FilterTypes_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_FilterTypes] ADD  CONSTRAINT [DF_vpv_FilterTypes_reference]  DEFAULT ((0)) FOR [reference]
GO
ALTER TABLE [dbo].[vpv_GeneralResultsPerQuestion] ADD  CONSTRAINT [DF_vpv_GeneralResultsPerQuestion_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_governmentBenefits] ADD  CONSTRAINT [DF_vpv_governmentBenefits_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_governmentConditions] ADD  CONSTRAINT [DF_vpv_governmentConditions_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_governmentConditions] ADD  CONSTRAINT [DF_vpv_governmentConditions_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_governmentConditions] ADD  CONSTRAINT [DF_vpv_governmentConditions_startDate]  DEFAULT (getdate()) FOR [startDate]
GO
ALTER TABLE [dbo].[vpv_governmentConditions] ADD  CONSTRAINT [DF_vpv_governmentConditions_finalDate]  DEFAULT (getdate()) FOR [finalDate]
GO
ALTER TABLE [dbo].[vpv_governmentConditions] ADD  CONSTRAINT [DF_vpv_governmentConditions_signedDate]  DEFAULT (getdate()) FOR [signedDate]
GO
ALTER TABLE [dbo].[vpv_governmentEntities] ADD  CONSTRAINT [DF_vpv_governmentEntities_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_identitydocs] ADD  CONSTRAINT [DF_vpv_identitydocs_temporary]  DEFAULT ((1)) FOR [temporary]
GO
ALTER TABLE [dbo].[vpv_identitydocs] ADD  CONSTRAINT [DF_vpv_identitydocs_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_identitytype] ADD  CONSTRAINT [DF_vpv_identitytype_required]  DEFAULT ((1)) FOR [required]
GO
ALTER TABLE [dbo].[vpv_identitytype] ADD  CONSTRAINT [DF_vpv_identitytype_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_ImpactZones] ADD  CONSTRAINT [DF_vpv_ImpactZones_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_ImpactZones] ADD  CONSTRAINT [DF_vpv_ImpactZones_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_investorsPerProject] ADD  CONSTRAINT [DF_vpv_investorsPerProject_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_investorsReturns] ADD  CONSTRAINT [DF_vpv_investorsReturns_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_investorsReturns] ADD  CONSTRAINT [DF_vpv_investorsReturns_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_investorsReturns] ADD  CONSTRAINT [DF_vpv_investorsReturns_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_ips] ADD  CONSTRAINT [DF_vpv_ips_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_mediafiles] ADD  CONSTRAINT [DF_vpv_mediafiles_bin]  DEFAULT ((0)) FOR [bin]
GO
ALTER TABLE [dbo].[vpv_mediafiles] ADD  CONSTRAINT [DF_vpv_mediafiles_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_mediafiles] ADD  CONSTRAINT [DF_vpv_mediafiles_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_MetricPerPlan] ADD  CONSTRAINT [DF_vpv_MetricPerPlan_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_mfa] ADD  CONSTRAINT [DF_vpv_mfa_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_mfa] ADD  CONSTRAINT [DF_vpv_mfa_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_mfachallenges] ADD  CONSTRAINT [DF_vpv_mfachallenges_consumed]  DEFAULT ((0)) FOR [consumed]
GO
ALTER TABLE [dbo].[vpv_mfachallenges] ADD  CONSTRAINT [DF_vpv_mfachallenges_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_mfaselect] ADD  CONSTRAINT [DF_vpv_mfaselect_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_mfaselect] ADD  CONSTRAINT [DF_vpv_mfaselect_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_notificationMethods] ADD  CONSTRAINT [DF_vpv_notificationMethods_creationDate]  DEFAULT ((1)) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_optionsQuestion] ADD  CONSTRAINT [DF_vpv_optionsQuestion_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_optionsQuestion] ADD  CONSTRAINT [DF_vpv_optionsQuestion_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_optionsQuestion] ADD  CONSTRAINT [DF_vpv_optionsQuestion_orderby]  DEFAULT ((0)) FOR [orderby]
GO
ALTER TABLE [dbo].[vpv_optionTypes] ADD  CONSTRAINT [DF_vpv_optionTypes_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_parameters] ADD  CONSTRAINT [DF_vpv_parameters_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_paymentPlans] ADD  CONSTRAINT [DF_vpv_paymentPlans_paymentDate]  DEFAULT (getdate()) FOR [paymentDate]
GO
ALTER TABLE [dbo].[vpv_paymentPlans] ADD  CONSTRAINT [DF_vpv_paymentPlans_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_paymentPlans] ADD  CONSTRAINT [DF_vpv_paymentPlans_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_PermissionResource] ADD  CONSTRAINT [DF_vpv_PermissionResource_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_PermissionResource] ADD  CONSTRAINT [DF_vpv_PermissionResource_updateAt]  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[vpv_PermissionResource] ADD  CONSTRAINT [DF_vpv_PermissionResource_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[vpv_PermissionResource] ADD  CONSTRAINT [DF_vpv_PermissionResource_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_Permissions] ADD  CONSTRAINT [DF_vpv_Permissions_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_Permissions] ADD  CONSTRAINT [DF_vpv_Permissions_updatedAt]  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[vpv_Permissions] ADD  CONSTRAINT [DF_vpv_Permissions_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[vpv_Permissions] ADD  CONSTRAINT [DF_vpv_Permissions_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_PopulationFilters] ADD  CONSTRAINT [DF_vpv_PopulationFilters_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_PopulationFilters] ADD  CONSTRAINT [DF_vpv_PopulationFilters_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_process] ADD  CONSTRAINT [DF_vpv_process_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_projectReports] ADD  CONSTRAINT [DF_vpv_projectReports_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_projectReports] ADD  CONSTRAINT [DF_vpv_projectReports_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_projectReports] ADD  CONSTRAINT [DF_vpv_projectReports_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_projectReports] ADD  CONSTRAINT [DF_vpv_projectReports_lastUpdated]  DEFAULT (getdate()) FOR [lastUpdated]
GO
ALTER TABLE [dbo].[vpv_proposalComments] ADD  CONSTRAINT [DF_vpv_proposalComments_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_proposalComments] ADD  CONSTRAINT [DF_vpv_proposalComments_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_proposalComments] ADD  CONSTRAINT [DF_vpv_proposalComments_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_proposalRequirements] ADD  CONSTRAINT [DF_vpv_proposalRequirements_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_proposals] ADD  CONSTRAINT [DF_vpv_proposals_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_proposals] ADD  CONSTRAINT [DF_vpv_proposals_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_proposals] ADD  CONSTRAINT [DF_vpv_proposals_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_proposals] ADD  CONSTRAINT [DF_vpv_proposals_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [dbo].[vpv_proposals] ADD  CONSTRAINT [DF_vpv_proposals_startingDate]  DEFAULT (getdate()) FOR [startingDate]
GO
ALTER TABLE [dbo].[vpv_proposalTypes] ADD  CONSTRAINT [DF_vpv_proposalTypes_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_proposalVersions] ADD  CONSTRAINT [DF_vpv_proposalVersions_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_proposalVersions] ADD  CONSTRAINT [DF_vpv_proposalVersions_startingDate]  DEFAULT (getdate()) FOR [startingDate]
GO
ALTER TABLE [dbo].[vpv_proposalVersions] ADD  CONSTRAINT [DF_vpv_proposalVersions_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_proposalVersions] ADD  CONSTRAINT [DF_vpv_proposalVersions_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_proposalVersions] ADD  CONSTRAINT [DF_vpv_proposalVersions_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [dbo].[vpv_proposalVersions] ADD  CONSTRAINT [DF_vpv_proposalVersions_currentVersion]  DEFAULT ((1)) FOR [lastVersion]
GO
ALTER TABLE [dbo].[vpv_proposalViews] ADD  CONSTRAINT [DF_vpv_proposalViews_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_proposalViews] ADD  CONSTRAINT [DF_vpv_proposalViews_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_proposalViews] ADD  CONSTRAINT [DF_vpv_proposalViews_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_questionTypes] ADD  CONSTRAINT [DF_vpv_questionTypes_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_reminderTypes] ADD  CONSTRAINT [DF_vpv_reminderTypes_enable]  DEFAULT ((0)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_requests] ADD  CONSTRAINT [DF_vpv_requests_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_RequestStatus] ADD  CONSTRAINT [DF_vpv_RequestStatus_enebled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[vpv_RequestStatus] ADD  CONSTRAINT [DF_vpv_RequestStatus_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_requestvalidators] ADD  CONSTRAINT [DF_vpv_requestvalidators_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_requestvalidators] ADD  CONSTRAINT [DF_vpv_requestvalidators_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_requirementTypes] ADD  CONSTRAINT [DF_vpv_requirementTypes_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_ResultsPerFilter] ADD  CONSTRAINT [DF_vpv_ResultsPerFilter_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_ResultsPerOption] ADD  CONSTRAINT [DF_vpv_ResultsPerOption_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_ResultTypes] ADD  CONSTRAINT [DF_vpv_ResultTypes_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_Roles] ADD  CONSTRAINT [DF_vpv_Roles_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_Roles] ADD  CONSTRAINT [DF_vpv_Roles_updateAt]  DEFAULT (getdate()) FOR [updateAt]
GO
ALTER TABLE [dbo].[vpv_Roles] ADD  CONSTRAINT [DF_vpv_Roles_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[vpv_Roles] ADD  CONSTRAINT [DF_vpv_Roles_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_Rules] ADD  CONSTRAINT [DF_vpv_VotingMethods_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_SearchingTags] ADD  CONSTRAINT [DF_vpv_SearchingTags_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements] ADD  CONSTRAINT [DF_vpv_sponsorAgreements_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements] ADD  CONSTRAINT [DF_vpv_sponsorAgreements_startDate]  DEFAULT (getdate()) FOR [startDate]
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements] ADD  CONSTRAINT [DF_vpv_sponsorAgreements_finalDate]  DEFAULT (getdate()) FOR [finalDate]
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements] ADD  CONSTRAINT [DF_vpv_sponsorAgreements_signedDate]  DEFAULT (getdate()) FOR [signedDate]
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements] ADD  CONSTRAINT [DF_vpv_sponsorAgreements_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_sponsorGroups] ADD  CONSTRAINT [DF_vpv_sponsorGroups_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_sponsorGroups] ADD  CONSTRAINT [DF_vpv_sponsorGroups_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_sponsornGroupTypes] ADD  CONSTRAINT [DF_vpv_sponsornGroupTypes_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_States] ADD  CONSTRAINT [DF_vpv_States_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[vpv_States] ADD  CONSTRAINT [DF_vpv_States_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_statusVoting] ADD  CONSTRAINT [DF_vpv_statesVoting_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_TargetPopulations] ADD  CONSTRAINT [DF_vpv_TargetPopulations_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_TargetPopulations] ADD  CONSTRAINT [DF_vpv_TargetPopulations_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_TargetPopulationsVoting] ADD  CONSTRAINT [DF_vpv_TargetPopulationsVoting_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_translations] ADD  CONSTRAINT [DF_vpv_translations_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_UnitMeasure] ADD  CONSTRAINT [DF_vpv_UnitMeasure_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_userperrole] ADD  CONSTRAINT [DF_vpv_userperrole_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_UserRole] ADD  CONSTRAINT [DF_vpv_UserRole_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_UserRole] ADD  CONSTRAINT [DF_vpv_UserRole_updateAt]  DEFAULT (getdate()) FOR [updateAt]
GO
ALTER TABLE [dbo].[vpv_UserRole] ADD  CONSTRAINT [DF_vpv_UserRole_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[vpv_UserRole] ADD  CONSTRAINT [DF_vpv_UserRole_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_Users] ADD  CONSTRAINT [DF_vpv_Users_is_verified]  DEFAULT ((1)) FOR [is_verified]
GO
ALTER TABLE [dbo].[vpv_Users] ADD  CONSTRAINT [DF_vpv_Users_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_Users] ADD  CONSTRAINT [DF_vpv_Users_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[vpv_VoteComment] ADD  CONSTRAINT [DF_vpv_VoteComment_creacionDate]  DEFAULT (getdate()) FOR [creacionDate]
GO
ALTER TABLE [dbo].[vpv_Votes] ADD  CONSTRAINT [DF_vpv_Votes_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_VotesTaken] ADD  CONSTRAINT [DF_vpv_VotesTaken_creacionDate]  DEFAULT (getdate()) FOR [creacionDate]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] ADD  CONSTRAINT [DF_vpv_votingConfigurations_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] ADD  CONSTRAINT [DF_vpv_votingConfigurations_description]  DEFAULT ('''No hay descripcion') FOR [description]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] ADD  CONSTRAINT [DF_vpv_votingConfigurations_weight]  DEFAULT ((0)) FOR [weight]
GO
ALTER TABLE [dbo].[vpv_votingQuestions] ADD  CONSTRAINT [DF_vpv_votingQuestions_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_votingQuestions] ADD  CONSTRAINT [DF_vpv_votingQuestions_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_votingQuestions] ADD  CONSTRAINT [DF_vpv_votingQuestions_orderBy]  DEFAULT ((0)) FOR [orderBy]
GO
ALTER TABLE [dbo].[vpv_votingReasons] ADD  CONSTRAINT [DF_vpv_votingReasons_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_votingRestrictions] ADD  CONSTRAINT [DF_vpv_votingRestrictions_creationDate]  DEFAULT (getdate()) FOR [creationDate]
GO
ALTER TABLE [dbo].[vpv_votingRestrictions] ADD  CONSTRAINT [DF_vpv_votingRestrictions_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_votingRestrictionTypes] ADD  CONSTRAINT [DF_vpv_votingRestrictionTypes_description]  DEFAULT ('Sin descripcion') FOR [description]
GO
ALTER TABLE [dbo].[vpv_votingRestrictionTypes] ADD  CONSTRAINT [DF_vpv_votingRestrictionTypes_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_VotingResultsSummary] ADD  CONSTRAINT [DF_vpv_VotingResultsSummary_description]  DEFAULT ('Sin descripcion') FOR [description]
GO
ALTER TABLE [dbo].[vpv_VotingResultStatus] ADD  CONSTRAINT [DF_vpv_VotingResultStatus_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_VotingRuleSubType] ADD  CONSTRAINT [DF_vpv_VotingRuleSubType_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_VotingRuleTypes] ADD  CONSTRAINT [DF_vpv_VotingMethodTypes_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_votingTypes] ADD  CONSTRAINT [DF_vpv_votingTypes_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_whitelistips] ADD  CONSTRAINT [DF_vpv_whitelistips_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[vpv_whitelists] ADD  CONSTRAINT [DF_vpv_whitelists_allowed]  DEFAULT ((1)) FOR [allowed]
GO
ALTER TABLE [dbo].[vpv_workflowsteps] ADD  CONSTRAINT [DF_vpv_workflowsteps_manual]  DEFAULT ((1)) FOR [manual]
GO
ALTER TABLE [dbo].[vpv_workflowsteps] ADD  CONSTRAINT [DF_vpv_workflowsteps_enable]  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[vpv_workresults] ADD  CONSTRAINT [DF_vpv_workresults_error]  DEFAULT ((0)) FOR [error]
GO

ALTER TABLE [dbo].[vpv_AllowedVoters]  WITH CHECK ADD  CONSTRAINT [FK_vpv_AllowedVoters_vpv_votingConfigurations] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_AllowedVoters] CHECK CONSTRAINT [FK_vpv_AllowedVoters_vpv_votingConfigurations]
GO
ALTER TABLE [dbo].[vpv_apiConfig]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiConfig_vpv_api] FOREIGN KEY([idApi])
REFERENCES [dbo].[vpv_api] ([idApi])
GO
ALTER TABLE [dbo].[vpv_apiConfig] CHECK CONSTRAINT [FK_vpv_apiConfig_vpv_api]
GO
ALTER TABLE [dbo].[vpv_apiConfig]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiConfig_vpv_apiConfigType] FOREIGN KEY([idApiConfigType])
REFERENCES [dbo].[vpv_apiConfigType] ([idApiConfigType])
GO
ALTER TABLE [dbo].[vpv_apiConfig] CHECK CONSTRAINT [FK_vpv_apiConfig_vpv_apiConfigType]
GO
ALTER TABLE [dbo].[vpv_apiEndPoints]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiEndPoints_vpv_api] FOREIGN KEY([idApi])
REFERENCES [dbo].[vpv_api] ([idApi])
GO
ALTER TABLE [dbo].[vpv_apiEndPoints] CHECK CONSTRAINT [FK_vpv_apiEndPoints_vpv_api]
GO
ALTER TABLE [dbo].[vpv_apiEndPoints]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiEndPoints_vpv_apiEndpointMethods] FOREIGN KEY([idEndpointMethod])
REFERENCES [dbo].[vpv_apiEndpointMethods] ([idEndpointMethod])
GO
ALTER TABLE [dbo].[vpv_apiEndPoints] CHECK CONSTRAINT [FK_vpv_apiEndPoints_vpv_apiEndpointMethods]
GO
ALTER TABLE [dbo].[vpv_apiRequest]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiRequest_vpv_api] FOREIGN KEY([idApi])
REFERENCES [dbo].[vpv_api] ([idApi])
GO
ALTER TABLE [dbo].[vpv_apiRequest] CHECK CONSTRAINT [FK_vpv_apiRequest_vpv_api]
GO
ALTER TABLE [dbo].[vpv_apiRequest]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiRequest_vpv_apiEndPoints] FOREIGN KEY([idEndpoint])
REFERENCES [dbo].[vpv_apiEndPoints] ([idEndPoint])
GO
ALTER TABLE [dbo].[vpv_apiRequest] CHECK CONSTRAINT [FK_vpv_apiRequest_vpv_apiEndPoints]
GO
ALTER TABLE [dbo].[vpv_apiRequest]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiRequest_vpv_RequestStatus] FOREIGN KEY([id_requestStatus])
REFERENCES [dbo].[vpv_RequestStatus] ([id_requestStatus])
GO
ALTER TABLE [dbo].[vpv_apiRequest] CHECK CONSTRAINT [FK_vpv_apiRequest_vpv_RequestStatus]
GO
ALTER TABLE [dbo].[vpv_apiRequest]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiRequest_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_apiRequest] CHECK CONSTRAINT [FK_vpv_apiRequest_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_apiRequestFiles]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiRequestFiles_vpv_apiRequest] FOREIGN KEY([id_apiRequest])
REFERENCES [dbo].[vpv_apiRequest] ([id_apiRequest])
GO
ALTER TABLE [dbo].[vpv_apiRequestFiles] CHECK CONSTRAINT [FK_vpv_apiRequestFiles_vpv_apiRequest]
GO
ALTER TABLE [dbo].[vpv_apiRequestFiles]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiRequestFiles_vpv_mediafiles] FOREIGN KEY([id_mediafile])
REFERENCES [dbo].[vpv_mediafiles] ([id_mediafile])
GO
ALTER TABLE [dbo].[vpv_apiRequestFiles] CHECK CONSTRAINT [FK_vpv_apiRequestFiles_vpv_mediafiles]
GO
ALTER TABLE [dbo].[vpv_apiResponse]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiResponse_vpv_apiRequest] FOREIGN KEY([id_apiRequest])
REFERENCES [dbo].[vpv_apiRequest] ([id_apiRequest])
GO
ALTER TABLE [dbo].[vpv_apiResponse] CHECK CONSTRAINT [FK_vpv_apiResponse_vpv_apiRequest]
GO
ALTER TABLE [dbo].[vpv_apiResponse]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiResponse_vpv_ResponseStatus] FOREIGN KEY([id_responseStatus])
REFERENCES [dbo].[vpv_ResponseStatus] ([id_responseStatus])
GO
ALTER TABLE [dbo].[vpv_apiResponse] CHECK CONSTRAINT [FK_vpv_apiResponse_vpv_ResponseStatus]
GO
ALTER TABLE [dbo].[vpv_apiResponseFiles]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiResponseFiles_vpv_apiResponse] FOREIGN KEY([id_apiResponse])
REFERENCES [dbo].[vpv_apiResponse] ([id_apiResponse])
GO
ALTER TABLE [dbo].[vpv_apiResponseFiles] CHECK CONSTRAINT [FK_vpv_apiResponseFiles_vpv_apiResponse]
GO
ALTER TABLE [dbo].[vpv_apiResponseFiles]  WITH CHECK ADD  CONSTRAINT [FK_vpv_apiResponseFiles_vpv_mediafiles] FOREIGN KEY([id_mediafile])
REFERENCES [dbo].[vpv_mediafiles] ([id_mediafile])
GO
ALTER TABLE [dbo].[vpv_apiResponseFiles] CHECK CONSTRAINT [FK_vpv_apiResponseFiles_vpv_mediafiles]
GO
ALTER TABLE [dbo].[vpv_authmethods]  WITH CHECK ADD  CONSTRAINT [FK_vpv_authmethods_vpv_biometricauths] FOREIGN KEY([bioauthid])
REFERENCES [dbo].[vpv_biometricauths] ([bioauthid])
GO
ALTER TABLE [dbo].[vpv_authmethods] CHECK CONSTRAINT [FK_vpv_authmethods_vpv_biometricauths]
GO
ALTER TABLE [dbo].[vpv_availablePaymentMethodPerEntity]  WITH CHECK ADD  CONSTRAINT [FK_vpv_availablePaymentMethodPerEntity_vpv_availablePaymentMethods] FOREIGN KEY([paymentMethodId])
REFERENCES [dbo].[vpv_availablePaymentMethods] ([paymentMethodId])
GO
ALTER TABLE [dbo].[vpv_availablePaymentMethodPerEntity] CHECK CONSTRAINT [FK_vpv_availablePaymentMethodPerEntity_vpv_availablePaymentMethods]
GO
ALTER TABLE [dbo].[vpv_availablePaymentMethodPerEntity]  WITH CHECK ADD  CONSTRAINT [FK_vpv_availablePaymentMethodPerEntity_vpv_entities] FOREIGN KEY([entityId])
REFERENCES [dbo].[vpv_entities] ([entityid])
GO
ALTER TABLE [dbo].[vpv_availablePaymentMethodPerEntity] CHECK CONSTRAINT [FK_vpv_availablePaymentMethodPerEntity_vpv_entities]
GO
ALTER TABLE [dbo].[vpv_availablePaymentMethodsPerUser]  WITH CHECK ADD  CONSTRAINT [FK_vpv_availablePaymentMethodsPerUser_vpv_availablePaymentMethods] FOREIGN KEY([paymentMethodId])
REFERENCES [dbo].[vpv_availablePaymentMethods] ([paymentMethodId])
GO
ALTER TABLE [dbo].[vpv_availablePaymentMethodsPerUser] CHECK CONSTRAINT [FK_vpv_availablePaymentMethodsPerUser_vpv_availablePaymentMethods]
GO
ALTER TABLE [dbo].[vpv_availablePaymentMethodsPerUser]  WITH CHECK ADD  CONSTRAINT [FK_vpv_availablePaymentMethodsPerUser_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_availablePaymentMethodsPerUser] CHECK CONSTRAINT [FK_vpv_availablePaymentMethodsPerUser_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_azureanalysis]  WITH CHECK ADD  CONSTRAINT [FK_vpv_azureanalysis_vpv_azuremodels] FOREIGN KEY([modelid])
REFERENCES [dbo].[vpv_azuremodels] ([modelid])
GO
ALTER TABLE [dbo].[vpv_azureanalysis] CHECK CONSTRAINT [FK_vpv_azureanalysis_vpv_azuremodels]
GO
ALTER TABLE [dbo].[vpv_azureanalysis]  WITH CHECK ADD  CONSTRAINT [FK_vpv_azureanalysis_vpv_docs] FOREIGN KEY([docid])
REFERENCES [dbo].[vpv_docs] ([docid])
GO
ALTER TABLE [dbo].[vpv_azureanalysis] CHECK CONSTRAINT [FK_vpv_azureanalysis_vpv_docs]
GO
ALTER TABLE [dbo].[vpv_azurecells]  WITH CHECK ADD  CONSTRAINT [FK_vpv_azurecells_vpv_azuretables] FOREIGN KEY([tableid])
REFERENCES [dbo].[vpv_azuretables] ([tableid])
GO
ALTER TABLE [dbo].[vpv_azurecells] CHECK CONSTRAINT [FK_vpv_azurecells_vpv_azuretables]
GO
ALTER TABLE [dbo].[vpv_azurepage]  WITH CHECK ADD  CONSTRAINT [FK_vpv_azurepage_vpv_azureanalysis] FOREIGN KEY([analysisid])
REFERENCES [dbo].[vpv_azureanalysis] ([analysisid])
GO
ALTER TABLE [dbo].[vpv_azurepage] CHECK CONSTRAINT [FK_vpv_azurepage_vpv_azureanalysis]
GO
ALTER TABLE [dbo].[vpv_azuretables]  WITH CHECK ADD  CONSTRAINT [FK_vpv_azuretables_vpv_azurepage] FOREIGN KEY([pageid])
REFERENCES [dbo].[vpv_azurepage] ([pageid])
GO
ALTER TABLE [dbo].[vpv_azuretables] CHECK CONSTRAINT [FK_vpv_azuretables_vpv_azurepage]
GO
ALTER TABLE [dbo].[vpv_balances]  WITH CHECK ADD  CONSTRAINT [FK_vpv_balance_vpv_founds] FOREIGN KEY([foundId])
REFERENCES [dbo].[vpv_founds] ([foundId])
GO
ALTER TABLE [dbo].[vpv_balances] CHECK CONSTRAINT [FK_vpv_balance_vpv_founds]
GO
ALTER TABLE [dbo].[vpv_biometricauths]  WITH CHECK ADD  CONSTRAINT [FK_vpv_biometricauths_vpv_biostatus] FOREIGN KEY([biostatusid])
REFERENCES [dbo].[vpv_biostatus] ([biostatusid])
GO
ALTER TABLE [dbo].[vpv_biometricauths] CHECK CONSTRAINT [FK_vpv_biometricauths_vpv_biostatus]
GO
ALTER TABLE [dbo].[vpv_biometricauths]  WITH CHECK ADD  CONSTRAINT [FK_vpv_biometricauths_vpv_biotypes] FOREIGN KEY([biotypeid])
REFERENCES [dbo].[vpv_biotypes] ([biotypeid])
GO
ALTER TABLE [dbo].[vpv_biometricauths] CHECK CONSTRAINT [FK_vpv_biometricauths_vpv_biotypes]
GO
ALTER TABLE [dbo].[vpv_biometricauths]  WITH CHECK ADD  CONSTRAINT [FK_vpv_biometricauths_vpv_Users] FOREIGN KEY([userid])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_biometricauths] CHECK CONSTRAINT [FK_vpv_biometricauths_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_biorequests]  WITH CHECK ADD  CONSTRAINT [FK_vpv_biorequests_vpv_biometricauths] FOREIGN KEY([bioauthid])
REFERENCES [dbo].[vpv_biometricauths] ([bioauthid])
GO
ALTER TABLE [dbo].[vpv_biorequests] CHECK CONSTRAINT [FK_vpv_biorequests_vpv_biometricauths]
GO
ALTER TABLE [dbo].[vpv_biorequests]  WITH CHECK ADD  CONSTRAINT [FK_vpv_biorequests_vpv_biotypes] FOREIGN KEY([biotypeid])
REFERENCES [dbo].[vpv_biotypes] ([biotypeid])
GO
ALTER TABLE [dbo].[vpv_biorequests] CHECK CONSTRAINT [FK_vpv_biorequests_vpv_biotypes]
GO
ALTER TABLE [dbo].[vpv_bioresponses]  WITH CHECK ADD  CONSTRAINT [FK_vpv_bioresponses_vpv_biometricauths] FOREIGN KEY([bioauthid])
REFERENCES [dbo].[vpv_biometricauths] ([bioauthid])
GO
ALTER TABLE [dbo].[vpv_bioresponses] CHECK CONSTRAINT [FK_vpv_bioresponses_vpv_biometricauths]
GO
ALTER TABLE [dbo].[vpv_bodyprocess]  WITH CHECK ADD  CONSTRAINT [FK_vpv_bodyprocess_vpv_identitytype] FOREIGN KEY([identitytypeid])
REFERENCES [dbo].[vpv_identitytype] ([identitytypeid])
GO
ALTER TABLE [dbo].[vpv_bodyprocess] CHECK CONSTRAINT [FK_vpv_bodyprocess_vpv_identitytype]
GO
ALTER TABLE [dbo].[vpv_bodyprocess]  WITH CHECK ADD  CONSTRAINT [FK_vpv_bodyprocess_vpv_process] FOREIGN KEY([processid])
REFERENCES [dbo].[vpv_process] ([processid])
GO
ALTER TABLE [dbo].[vpv_bodyprocess] CHECK CONSTRAINT [FK_vpv_bodyprocess_vpv_process]
GO
ALTER TABLE [dbo].[vpv_Cities]  WITH CHECK ADD  CONSTRAINT [FK_vpv_Cities_vpv_States] FOREIGN KEY([idState])
REFERENCES [dbo].[vpv_States] ([idState])
GO
ALTER TABLE [dbo].[vpv_Cities] CHECK CONSTRAINT [FK_vpv_Cities_vpv_States]
GO
ALTER TABLE [dbo].[vpv_crowdfoundingProposals]  WITH CHECK ADD  CONSTRAINT [FK_vpv_crowdfoundingProposals_vpv_processStatus] FOREIGN KEY([statusId])
REFERENCES [dbo].[vpv_processStatus] ([statusId])
GO
ALTER TABLE [dbo].[vpv_crowdfoundingProposals] CHECK CONSTRAINT [FK_vpv_crowdfoundingProposals_vpv_processStatus]
GO
ALTER TABLE [dbo].[vpv_crowdfoundingProposals]  WITH CHECK ADD  CONSTRAINT [FK_vpv_crowdfoundingProposals_vpv_proposals] FOREIGN KEY([proposalId])
REFERENCES [dbo].[vpv_proposals] ([proposalId])
GO
ALTER TABLE [dbo].[vpv_crowdfoundingProposals] CHECK CONSTRAINT [FK_vpv_crowdfoundingProposals_vpv_proposals]
GO
ALTER TABLE [dbo].[vpv_demographics]  WITH CHECK ADD  CONSTRAINT [FK_vpv_demographics_vpv_demosubtype] FOREIGN KEY([demosubtypeid])
REFERENCES [dbo].[vpv_demosubtype] ([demosubtypeid])
GO
ALTER TABLE [dbo].[vpv_demographics] CHECK CONSTRAINT [FK_vpv_demographics_vpv_demosubtype]
GO
ALTER TABLE [dbo].[vpv_demographics]  WITH CHECK ADD  CONSTRAINT [FK_vpv_demographics_vpv_demotype] FOREIGN KEY([demotypeid])
REFERENCES [dbo].[vpv_demotype] ([demotypeid])
GO
ALTER TABLE [dbo].[vpv_demographics] CHECK CONSTRAINT [FK_vpv_demographics_vpv_demotype]
GO
ALTER TABLE [dbo].[vpv_demographics]  WITH CHECK ADD  CONSTRAINT [FK_vpv_demographics_vpv_Users] FOREIGN KEY([userid])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_demographics] CHECK CONSTRAINT [FK_vpv_demographics_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_devices]  WITH CHECK ADD  CONSTRAINT [FK_vpv_devices_vpv_biometricauths] FOREIGN KEY([bioauthid])
REFERENCES [dbo].[vpv_biometricauths] ([bioauthid])
GO
ALTER TABLE [dbo].[vpv_devices] CHECK CONSTRAINT [FK_vpv_devices_vpv_biometricauths]
GO
ALTER TABLE [dbo].[vpv_devices]  WITH CHECK ADD  CONSTRAINT [FK_vpv_devices_vpv_devicetypes] FOREIGN KEY([devicetypeid])
REFERENCES [dbo].[vpv_devicetypes] ([devicetypeid])
GO
ALTER TABLE [dbo].[vpv_devices] CHECK CONSTRAINT [FK_vpv_devices_vpv_devicetypes]
GO
ALTER TABLE [dbo].[vpv_docincidents]  WITH CHECK ADD  CONSTRAINT [FK_vpv_docincidents_vpv_azureanalysis] FOREIGN KEY([analysisid])
REFERENCES [dbo].[vpv_azureanalysis] ([analysisid])
GO
ALTER TABLE [dbo].[vpv_docincidents] CHECK CONSTRAINT [FK_vpv_docincidents_vpv_azureanalysis]
GO
ALTER TABLE [dbo].[vpv_docincidents]  WITH CHECK ADD  CONSTRAINT [FK_vpv_docincidents_vpv_docs] FOREIGN KEY([docid])
REFERENCES [dbo].[vpv_docs] ([docid])
GO
ALTER TABLE [dbo].[vpv_docincidents] CHECK CONSTRAINT [FK_vpv_docincidents_vpv_docs]
GO
ALTER TABLE [dbo].[vpv_docincidents]  WITH CHECK ADD  CONSTRAINT [FK_vpv_docincidents_vpv_incidenttypes] FOREIGN KEY([incidenttypeid])
REFERENCES [dbo].[vpv_incidenttypes] ([incidenttypeid])
GO
ALTER TABLE [dbo].[vpv_docincidents] CHECK CONSTRAINT [FK_vpv_docincidents_vpv_incidenttypes]
GO
ALTER TABLE [dbo].[vpv_docinfos]  WITH CHECK ADD  CONSTRAINT [FK_vpv_docinfos_vpv_azureanalysis] FOREIGN KEY([analysisid])
REFERENCES [dbo].[vpv_azureanalysis] ([analysisid])
GO
ALTER TABLE [dbo].[vpv_docinfos] CHECK CONSTRAINT [FK_vpv_docinfos_vpv_azureanalysis]
GO
ALTER TABLE [dbo].[vpv_docinfos]  WITH CHECK ADD  CONSTRAINT [FK_vpv_docinfos_vpv_infotypes] FOREIGN KEY([infotypeid])
REFERENCES [dbo].[vpv_infotypes] ([infotypeid])
GO
ALTER TABLE [dbo].[vpv_docinfos] CHECK CONSTRAINT [FK_vpv_docinfos_vpv_infotypes]
GO
ALTER TABLE [dbo].[vpv_docs]  WITH CHECK ADD  CONSTRAINT [FK_vpv_docs_vpv_docstates] FOREIGN KEY([docstateid])
REFERENCES [dbo].[vpv_docstates] ([docstateid])
GO
ALTER TABLE [dbo].[vpv_docs] CHECK CONSTRAINT [FK_vpv_docs_vpv_docstates]
GO
ALTER TABLE [dbo].[vpv_docs]  WITH CHECK ADD  CONSTRAINT [FK_vpv_docs_vpv_docstypes] FOREIGN KEY([docstypeid])
REFERENCES [dbo].[vpv_docstypes] ([docstypeid])
GO
ALTER TABLE [dbo].[vpv_docs] CHECK CONSTRAINT [FK_vpv_docs_vpv_docstypes]
GO
ALTER TABLE [dbo].[vpv_docs]  WITH CHECK ADD  CONSTRAINT [FK_vpv_docs_vpv_formats] FOREIGN KEY([formatid])
REFERENCES [dbo].[vpv_formats] ([formatid])
GO
ALTER TABLE [dbo].[vpv_docs] CHECK CONSTRAINT [FK_vpv_docs_vpv_formats]
GO
ALTER TABLE [dbo].[vpv_docs]  WITH CHECK ADD  CONSTRAINT [FK_vpv_docs_vpv_identitydocs] FOREIGN KEY([identitydocsid])
REFERENCES [dbo].[vpv_identitydocs] ([identitydocsid])
GO
ALTER TABLE [dbo].[vpv_docs] CHECK CONSTRAINT [FK_vpv_docs_vpv_identitydocs]
GO
ALTER TABLE [dbo].[vpv_encryptionkeys]  WITH CHECK ADD  CONSTRAINT [FK_vpv_encryptionkeys_vpv_Users] FOREIGN KEY([userid])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_encryptionkeys] CHECK CONSTRAINT [FK_vpv_encryptionkeys_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_EndOfVoting]  WITH CHECK ADD  CONSTRAINT [FK_vpv_EndOfVoting_vpv_ClosureTypes] FOREIGN KEY([idClosureTypes])
REFERENCES [dbo].[vpv_ClosureTypes] ([idClosureTypes])
GO
ALTER TABLE [dbo].[vpv_EndOfVoting] CHECK CONSTRAINT [FK_vpv_EndOfVoting_vpv_ClosureTypes]
GO
ALTER TABLE [dbo].[vpv_EndOfVoting]  WITH CHECK ADD  CONSTRAINT [FK_vpv_EndOfVoting_vpv_votingConfigurations] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_EndOfVoting] CHECK CONSTRAINT [FK_vpv_EndOfVoting_vpv_votingConfigurations]
GO
ALTER TABLE [dbo].[vpv_entities]  WITH CHECK ADD  CONSTRAINT [FK_vpv_entities_vpv_entitiestatus] FOREIGN KEY([entitiestatusdid])
REFERENCES [dbo].[vpv_entitiestatus] ([entitiestatusdid])
GO
ALTER TABLE [dbo].[vpv_entities] CHECK CONSTRAINT [FK_vpv_entities_vpv_entitiestatus]
GO
ALTER TABLE [dbo].[vpv_entities]  WITH CHECK ADD  CONSTRAINT [FK_vpv_entities_vpv_entitysubtypes] FOREIGN KEY([entitysubtypeid])
REFERENCES [dbo].[vpv_entitysubtypes] ([entitysubtypeid])
GO
ALTER TABLE [dbo].[vpv_entities] CHECK CONSTRAINT [FK_vpv_entities_vpv_entitysubtypes]
GO
ALTER TABLE [dbo].[vpv_entities]  WITH CHECK ADD  CONSTRAINT [FK_vpv_entities_vpv_entitytypes] FOREIGN KEY([entitytypeid])
REFERENCES [dbo].[vpv_entitytypes] ([entitytypeid])
GO
ALTER TABLE [dbo].[vpv_entities] CHECK CONSTRAINT [FK_vpv_entities_vpv_entitytypes]
GO
ALTER TABLE [dbo].[vpv_entityBalance]  WITH CHECK ADD  CONSTRAINT [FK_vpv_entityBalance_vpv_balances] FOREIGN KEY([balanceId])
REFERENCES [dbo].[vpv_balances] ([balanceId])
GO
ALTER TABLE [dbo].[vpv_entityBalance] CHECK CONSTRAINT [FK_vpv_entityBalance_vpv_balances]
GO
ALTER TABLE [dbo].[vpv_entityBalance]  WITH CHECK ADD  CONSTRAINT [FK_vpv_entityBalance_vpv_entities] FOREIGN KEY([entityId])
REFERENCES [dbo].[vpv_entities] ([entityid])
GO
ALTER TABLE [dbo].[vpv_entityBalance] CHECK CONSTRAINT [FK_vpv_entityBalance_vpv_entities]
GO
ALTER TABLE [dbo].[vpv_entitydescription]  WITH CHECK ADD  CONSTRAINT [FK_vpv_entitydescription_vpv_entities] FOREIGN KEY([entityid])
REFERENCES [dbo].[vpv_entities] ([entityid])
GO
ALTER TABLE [dbo].[vpv_entitydescription] CHECK CONSTRAINT [FK_vpv_entitydescription_vpv_entities]
GO
ALTER TABLE [dbo].[vpv_entitykey]  WITH CHECK ADD  CONSTRAINT [FK_vpv_entitykey_vpv_entities] FOREIGN KEY([entityid])
REFERENCES [dbo].[vpv_entities] ([entityid])
GO
ALTER TABLE [dbo].[vpv_entitykey] CHECK CONSTRAINT [FK_vpv_entitykey_vpv_entities]
GO
ALTER TABLE [dbo].[vpv_entityroles]  WITH CHECK ADD  CONSTRAINT [FK_vpv_entityroles_vpv_entities] FOREIGN KEY([entitydid])
REFERENCES [dbo].[vpv_entities] ([entityid])
GO
ALTER TABLE [dbo].[vpv_entityroles] CHECK CONSTRAINT [FK_vpv_entityroles_vpv_entities]
GO
ALTER TABLE [dbo].[vpv_entityroles]  WITH CHECK ADD  CONSTRAINT [FK_vpv_entityroles_vpv_entityroletypes] FOREIGN KEY([entityroletypeid])
REFERENCES [dbo].[vpv_entityroletypes] ([entityroletypeid])
GO
ALTER TABLE [dbo].[vpv_entityroles] CHECK CONSTRAINT [FK_vpv_entityroles_vpv_entityroletypes]
GO
ALTER TABLE [dbo].[vpv_entityroles]  WITH CHECK ADD  CONSTRAINT [FK_vpv_entityroles_vpv_selectoptions] FOREIGN KEY([entityseloptdid])
REFERENCES [dbo].[vpv_selectoptions] ([entityseloptdid])
GO
ALTER TABLE [dbo].[vpv_entityroles] CHECK CONSTRAINT [FK_vpv_entityroles_vpv_selectoptions]
GO
ALTER TABLE [dbo].[vpv_entityroles]  WITH CHECK ADD  CONSTRAINT [FK_vpv_entityroles_vpv_useroptions] FOREIGN KEY([entityoptdid])
REFERENCES [dbo].[vpv_useroptions] ([entityoptdid])
GO
ALTER TABLE [dbo].[vpv_entityroles] CHECK CONSTRAINT [FK_vpv_entityroles_vpv_useroptions]
GO
ALTER TABLE [dbo].[vpv_exchangeRates]  WITH CHECK ADD  CONSTRAINT [FK_vpv_exchangeRates_vpv_currencies] FOREIGN KEY([currencyId])
REFERENCES [dbo].[vpv_currencies] ([currencyId])
GO
ALTER TABLE [dbo].[vpv_exchangeRates] CHECK CONSTRAINT [FK_vpv_exchangeRates_vpv_currencies]
GO
ALTER TABLE [dbo].[vpv_executionPlans]  WITH CHECK ADD  CONSTRAINT [FK_vpv_executionPlans_vpv_crowdfoundingProposals] FOREIGN KEY([crowdfoundingProposalId])
REFERENCES [dbo].[vpv_crowdfoundingProposals] ([crowdfoundingProposalId])
GO
ALTER TABLE [dbo].[vpv_executionPlans] CHECK CONSTRAINT [FK_vpv_executionPlans_vpv_crowdfoundingProposals]
GO
ALTER TABLE [dbo].[vpv_executionPlans]  WITH CHECK ADD  CONSTRAINT [FK_vpv_executionPlans_vpv_paymentPlans] FOREIGN KEY([paymentPlanId])
REFERENCES [dbo].[vpv_paymentPlans] ([paymentPlanId])
GO
ALTER TABLE [dbo].[vpv_executionPlans] CHECK CONSTRAINT [FK_vpv_executionPlans_vpv_paymentPlans]
GO
ALTER TABLE [dbo].[vpv_executionPlans]  WITH CHECK ADD  CONSTRAINT [FK_vpv_executionPlans_vpv_processStatus] FOREIGN KEY([statusId])
REFERENCES [dbo].[vpv_processStatus] ([statusId])
GO
ALTER TABLE [dbo].[vpv_executionPlans] CHECK CONSTRAINT [FK_vpv_executionPlans_vpv_processStatus]
GO
ALTER TABLE [dbo].[vpv_executionPlans]  WITH CHECK ADD  CONSTRAINT [FK_vpv_executionPlans_vpv_schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[vpv_schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[vpv_executionPlans] CHECK CONSTRAINT [FK_vpv_executionPlans_vpv_schedules]
GO
ALTER TABLE [dbo].[vpv_executionPlans]  WITH CHECK ADD  CONSTRAINT [FK_vpv_executionPlans_vpv_TargetPopulations] FOREIGN KEY([idTargetPopulation])
REFERENCES [dbo].[vpv_TargetPopulations] ([idTargetPopulation])
GO
ALTER TABLE [dbo].[vpv_executionPlans] CHECK CONSTRAINT [FK_vpv_executionPlans_vpv_TargetPopulations]
GO
ALTER TABLE [dbo].[vpv_executionPlans]  WITH CHECK ADD  CONSTRAINT [FK_vpv_executionPlans_vpv_UnitMeasure] FOREIGN KEY([idMeasureUnit])
REFERENCES [dbo].[vpv_UnitMeasure] ([idUnitMeasure])
GO
ALTER TABLE [dbo].[vpv_executionPlans] CHECK CONSTRAINT [FK_vpv_executionPlans_vpv_UnitMeasure]
GO
ALTER TABLE [dbo].[vpv_executionPlans]  WITH CHECK ADD  CONSTRAINT [FK_vpv_executionPlans_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_executionPlans] CHECK CONSTRAINT [FK_vpv_executionPlans_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_extractedinfos]  WITH CHECK ADD  CONSTRAINT [FK_vpv_extractedinfos_vpv_workresults] FOREIGN KEY([workresultid])
REFERENCES [dbo].[vpv_workresults] ([workresultid])
GO
ALTER TABLE [dbo].[vpv_extractedinfos] CHECK CONSTRAINT [FK_vpv_extractedinfos_vpv_workresults]
GO
ALTER TABLE [dbo].[vpv_FilesPerProposal]  WITH CHECK ADD  CONSTRAINT [FK_vpv_FilesPerProposal_vpv_docs] FOREIGN KEY([docid])
REFERENCES [dbo].[vpv_docs] ([docid])
GO
ALTER TABLE [dbo].[vpv_FilesPerProposal] CHECK CONSTRAINT [FK_vpv_FilesPerProposal_vpv_docs]
GO
ALTER TABLE [dbo].[vpv_FilesPerProposal]  WITH CHECK ADD  CONSTRAINT [FK_vpv_FilesPerProposal_vpv_proposals] FOREIGN KEY([proposalId])
REFERENCES [dbo].[vpv_proposals] ([proposalId])
GO
ALTER TABLE [dbo].[vpv_FilesPerProposal] CHECK CONSTRAINT [FK_vpv_FilesPerProposal_vpv_proposals]
GO
ALTER TABLE [dbo].[vpv_FilterTypes]  WITH CHECK ADD  CONSTRAINT [FK_vpv_FilterTypes_vpv_demosubtype] FOREIGN KEY([demosubtypeid])
REFERENCES [dbo].[vpv_demosubtype] ([demosubtypeid])
GO
ALTER TABLE [dbo].[vpv_FilterTypes] CHECK CONSTRAINT [FK_vpv_FilterTypes_vpv_demosubtype]
GO
ALTER TABLE [dbo].[vpv_FilterTypes]  WITH CHECK ADD  CONSTRAINT [FK_vpv_FilterTypes_vpv_demotype] FOREIGN KEY([demotypeid])
REFERENCES [dbo].[vpv_demotype] ([demotypeid])
GO
ALTER TABLE [dbo].[vpv_FilterTypes] CHECK CONSTRAINT [FK_vpv_FilterTypes_vpv_demotype]
GO
ALTER TABLE [dbo].[vpv_GeneralResultsPerQuestion]  WITH CHECK ADD  CONSTRAINT [FK_vpv_GeneralResultsPerQuestion_vpv_optionsQuestion] FOREIGN KEY([winningOptionId])
REFERENCES [dbo].[vpv_optionsQuestion] ([idOptionQuestion])
GO
ALTER TABLE [dbo].[vpv_GeneralResultsPerQuestion] CHECK CONSTRAINT [FK_vpv_GeneralResultsPerQuestion_vpv_optionsQuestion]
GO
ALTER TABLE [dbo].[vpv_GeneralResultsPerQuestion]  WITH CHECK ADD  CONSTRAINT [FK_vpv_GeneralResultsPerQuestion_vpv_votingConfigurations] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_GeneralResultsPerQuestion] CHECK CONSTRAINT [FK_vpv_GeneralResultsPerQuestion_vpv_votingConfigurations]
GO
ALTER TABLE [dbo].[vpv_GeneralResultsPerQuestion]  WITH CHECK ADD  CONSTRAINT [FK_vpv_GeneralResultsPerQuestion_vpv_votingQuestions] FOREIGN KEY([idVotingQuestions])
REFERENCES [dbo].[vpv_votingQuestions] ([idVotingQuestions])
GO
ALTER TABLE [dbo].[vpv_GeneralResultsPerQuestion] CHECK CONSTRAINT [FK_vpv_GeneralResultsPerQuestion_vpv_votingQuestions]
GO
ALTER TABLE [dbo].[vpv_governmentConditions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_governmentConditions_vpv_crowdfoundingProposals] FOREIGN KEY([crowdfoundingProposalId])
REFERENCES [dbo].[vpv_crowdfoundingProposals] ([crowdfoundingProposalId])
GO
ALTER TABLE [dbo].[vpv_governmentConditions] CHECK CONSTRAINT [FK_vpv_governmentConditions_vpv_crowdfoundingProposals]
GO
ALTER TABLE [dbo].[vpv_governmentConditions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_governmentConditions_vpv_demosubtype] FOREIGN KEY([demosubtypeid])
REFERENCES [dbo].[vpv_demosubtype] ([demosubtypeid])
GO
ALTER TABLE [dbo].[vpv_governmentConditions] CHECK CONSTRAINT [FK_vpv_governmentConditions_vpv_demosubtype]
GO
ALTER TABLE [dbo].[vpv_governmentConditions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_governmentConditions_vpv_demotype] FOREIGN KEY([demotypeid])
REFERENCES [dbo].[vpv_demotype] ([demotypeid])
GO
ALTER TABLE [dbo].[vpv_governmentConditions] CHECK CONSTRAINT [FK_vpv_governmentConditions_vpv_demotype]
GO
ALTER TABLE [dbo].[vpv_governmentConditions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_governmentConditions_vpv_governmentBenefits] FOREIGN KEY([governmentBenefitId])
REFERENCES [dbo].[vpv_governmentBenefits] ([governmentBenefitId])
GO
ALTER TABLE [dbo].[vpv_governmentConditions] CHECK CONSTRAINT [FK_vpv_governmentConditions_vpv_governmentBenefits]
GO
ALTER TABLE [dbo].[vpv_governmentConditions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_governmentConditions_vpv_governmentEntities] FOREIGN KEY([govermentEntityId])
REFERENCES [dbo].[vpv_governmentEntities] ([govermentEntityId])
GO
ALTER TABLE [dbo].[vpv_governmentConditions] CHECK CONSTRAINT [FK_vpv_governmentConditions_vpv_governmentEntities]
GO
ALTER TABLE [dbo].[vpv_identitydocs]  WITH CHECK ADD  CONSTRAINT [FK_vpv_identitydocs_vpv_identitystates] FOREIGN KEY([identitystateid])
REFERENCES [dbo].[vpv_identitystates] ([identitystateid])
GO
ALTER TABLE [dbo].[vpv_identitydocs] CHECK CONSTRAINT [FK_vpv_identitydocs_vpv_identitystates]
GO
ALTER TABLE [dbo].[vpv_identitydocs]  WITH CHECK ADD  CONSTRAINT [FK_vpv_identitydocs_vpv_identitytype] FOREIGN KEY([identitytypeid])
REFERENCES [dbo].[vpv_identitytype] ([identitytypeid])
GO
ALTER TABLE [dbo].[vpv_identitydocs] CHECK CONSTRAINT [FK_vpv_identitydocs_vpv_identitytype]
GO
ALTER TABLE [dbo].[vpv_ImpactZones]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ImpactZones_vpv_ImpactZoneTypes] FOREIGN KEY([idImpactZoneTypes])
REFERENCES [dbo].[vpv_ImpactZoneTypes] ([idImpactZoneTypes])
GO
ALTER TABLE [dbo].[vpv_ImpactZones] CHECK CONSTRAINT [FK_vpv_ImpactZones_vpv_ImpactZoneTypes]
GO
ALTER TABLE [dbo].[vpv_ImpactZonesPerVoting]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ImpactZonesPerVoting_vpv_ImpactZones] FOREIGN KEY([idImpactZones])
REFERENCES [dbo].[vpv_ImpactZones] ([idImpactZone])
GO
ALTER TABLE [dbo].[vpv_ImpactZonesPerVoting] CHECK CONSTRAINT [FK_vpv_ImpactZonesPerVoting_vpv_ImpactZones]
GO
ALTER TABLE [dbo].[vpv_ImpactZonesPerVoting]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ImpactZonesPerVoting_vpv_votingConfigurations] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_ImpactZonesPerVoting] CHECK CONSTRAINT [FK_vpv_ImpactZonesPerVoting_vpv_votingConfigurations]
GO
ALTER TABLE [dbo].[vpv_ImpactZoneTypes]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ImpactZoneTypes_vpv_UnitMeasure] FOREIGN KEY([idUnitMeasure])
REFERENCES [dbo].[vpv_UnitMeasure] ([idUnitMeasure])
GO
ALTER TABLE [dbo].[vpv_ImpactZoneTypes] CHECK CONSTRAINT [FK_vpv_ImpactZoneTypes_vpv_UnitMeasure]
GO
ALTER TABLE [dbo].[vpv_investmentPayment]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investmentPayment_vpv_entities] FOREIGN KEY([entitydid])
REFERENCES [dbo].[vpv_entities] ([entityid])
GO
ALTER TABLE [dbo].[vpv_investmentPayment] CHECK CONSTRAINT [FK_vpv_investmentPayment_vpv_entities]
GO
ALTER TABLE [dbo].[vpv_investmentPayment]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investmentPayment_vpv_payments] FOREIGN KEY([paymentId])
REFERENCES [dbo].[vpv_payments] ([paymentId])
GO
ALTER TABLE [dbo].[vpv_investmentPayment] CHECK CONSTRAINT [FK_vpv_investmentPayment_vpv_payments]
GO
ALTER TABLE [dbo].[vpv_investmentPayment]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investmentPayment_vpv_sponsorGroups] FOREIGN KEY([sponsorGroupId])
REFERENCES [dbo].[vpv_sponsorGroups] ([sponsorGroupId])
GO
ALTER TABLE [dbo].[vpv_investmentPayment] CHECK CONSTRAINT [FK_vpv_investmentPayment_vpv_sponsorGroups]
GO
ALTER TABLE [dbo].[vpv_investorsPerProject]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investorsPerProject_vpv_crowdfoundingProposals] FOREIGN KEY([crowdfoundingProposalId])
REFERENCES [dbo].[vpv_crowdfoundingProposals] ([crowdfoundingProposalId])
GO
ALTER TABLE [dbo].[vpv_investorsPerProject] CHECK CONSTRAINT [FK_vpv_investorsPerProject_vpv_crowdfoundingProposals]
GO
ALTER TABLE [dbo].[vpv_investorsPerProject]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investorsPerProject_vpv_entities] FOREIGN KEY([entitydid])
REFERENCES [dbo].[vpv_entities] ([entityid])
GO
ALTER TABLE [dbo].[vpv_investorsPerProject] CHECK CONSTRAINT [FK_vpv_investorsPerProject_vpv_entities]
GO
ALTER TABLE [dbo].[vpv_investorsPerProject]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investorsPerProject_vpv_sponsorAgreements] FOREIGN KEY([sponsorAgreementId])
REFERENCES [dbo].[vpv_sponsorAgreements] ([sponsorAgreementId])
GO
ALTER TABLE [dbo].[vpv_investorsPerProject] CHECK CONSTRAINT [FK_vpv_investorsPerProject_vpv_sponsorAgreements]
GO
ALTER TABLE [dbo].[vpv_investorsPerProject]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investorsPerProject_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_investorsPerProject] CHECK CONSTRAINT [FK_vpv_investorsPerProject_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_investorsReturns]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investorsReturns_vpv_payments] FOREIGN KEY([paymentId])
REFERENCES [dbo].[vpv_payments] ([paymentId])
GO
ALTER TABLE [dbo].[vpv_investorsReturns] CHECK CONSTRAINT [FK_vpv_investorsReturns_vpv_payments]
GO
ALTER TABLE [dbo].[vpv_investorsReturns]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investorsReturns_vpv_projectReports] FOREIGN KEY([projectReportId])
REFERENCES [dbo].[vpv_projectReports] ([projectReportId])
GO
ALTER TABLE [dbo].[vpv_investorsReturns] CHECK CONSTRAINT [FK_vpv_investorsReturns_vpv_projectReports]
GO
ALTER TABLE [dbo].[vpv_investorsReturns]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investorsReturns_vpv_proposals] FOREIGN KEY([proposalId])
REFERENCES [dbo].[vpv_proposals] ([proposalId])
GO
ALTER TABLE [dbo].[vpv_investorsReturns] CHECK CONSTRAINT [FK_vpv_investorsReturns_vpv_proposals]
GO
ALTER TABLE [dbo].[vpv_investorsReturns]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investorsReturns_vpv_Users] FOREIGN KEY([returnedTo])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_investorsReturns] CHECK CONSTRAINT [FK_vpv_investorsReturns_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_investorsReturns]  WITH CHECK ADD  CONSTRAINT [FK_vpv_investorsReturns_vpv_Users1] FOREIGN KEY([returnedBy])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_investorsReturns] CHECK CONSTRAINT [FK_vpv_investorsReturns_vpv_Users1]
GO
ALTER TABLE [dbo].[vpv_ips]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ips_vpv_devices] FOREIGN KEY([deviceid])
REFERENCES [dbo].[vpv_devices] ([deviceid])
GO
ALTER TABLE [dbo].[vpv_ips] CHECK CONSTRAINT [FK_vpv_ips_vpv_devices]
GO
ALTER TABLE [dbo].[vpv_keyowners]  WITH CHECK ADD  CONSTRAINT [FK_vpv_keyowners_vpv_entitykey] FOREIGN KEY([entitykeyid])
REFERENCES [dbo].[vpv_entitykey] ([entitykeyid])
GO
ALTER TABLE [dbo].[vpv_keyowners] CHECK CONSTRAINT [FK_vpv_keyowners_vpv_entitykey]
GO
ALTER TABLE [dbo].[vpv_logs]  WITH CHECK ADD  CONSTRAINT [FK_vpv_logs_vpv_logSeverity] FOREIGN KEY([logSeverityId])
REFERENCES [dbo].[vpv_logSeverity] ([logSeverityId])
GO
ALTER TABLE [dbo].[vpv_logs] CHECK CONSTRAINT [FK_vpv_logs_vpv_logSeverity]
GO
ALTER TABLE [dbo].[vpv_logs]  WITH CHECK ADD  CONSTRAINT [FK_vpv_logs_vpv_logsSources] FOREIGN KEY([logSourceId])
REFERENCES [dbo].[vpv_logsSources] ([logSourceId])
GO
ALTER TABLE [dbo].[vpv_logs] CHECK CONSTRAINT [FK_vpv_logs_vpv_logsSources]
GO
ALTER TABLE [dbo].[vpv_logs]  WITH CHECK ADD  CONSTRAINT [FK_vpv_logs_vpv_logTypes] FOREIGN KEY([logTypeId])
REFERENCES [dbo].[vpv_logTypes] ([logTypeId])
GO
ALTER TABLE [dbo].[vpv_logs] CHECK CONSTRAINT [FK_vpv_logs_vpv_logTypes]
GO
ALTER TABLE [dbo].[vpv_mediafiles]  WITH CHECK ADD  CONSTRAINT [FK_vpv_mediafiles_vpv_mediafileFormat] FOREIGN KEY([id_mediafileFormat])
REFERENCES [dbo].[vpv_mediafileFormat] ([id_mediafileFormat])
GO
ALTER TABLE [dbo].[vpv_mediafiles] CHECK CONSTRAINT [FK_vpv_mediafiles_vpv_mediafileFormat]
GO
ALTER TABLE [dbo].[vpv_mediafiles]  WITH CHECK ADD  CONSTRAINT [FK_vpv_mediafiles_vpv_mediafileType] FOREIGN KEY([id_mediafileType])
REFERENCES [dbo].[vpv_mediafileType] ([id_mediafileType])
GO
ALTER TABLE [dbo].[vpv_mediafiles] CHECK CONSTRAINT [FK_vpv_mediafiles_vpv_mediafileType]
GO
ALTER TABLE [dbo].[vpv_MetricPerPlan]  WITH CHECK ADD  CONSTRAINT [FK_vpv_MetricPerPlan_vpv_executionPlans] FOREIGN KEY([executionPlanId])
REFERENCES [dbo].[vpv_executionPlans] ([executionPlanId])
GO
ALTER TABLE [dbo].[vpv_MetricPerPlan] CHECK CONSTRAINT [FK_vpv_MetricPerPlan_vpv_executionPlans]
GO
ALTER TABLE [dbo].[vpv_MetricPerPlan]  WITH CHECK ADD  CONSTRAINT [FK_vpv_MetricPerPlan_vpv_processStatus] FOREIGN KEY([statusId])
REFERENCES [dbo].[vpv_processStatus] ([statusId])
GO
ALTER TABLE [dbo].[vpv_MetricPerPlan] CHECK CONSTRAINT [FK_vpv_MetricPerPlan_vpv_processStatus]
GO
ALTER TABLE [dbo].[vpv_MetricPerPlan]  WITH CHECK ADD  CONSTRAINT [FK_vpv_MetricPerPlan_vpv_sponsorGroups] FOREIGN KEY([sponsorGroupId])
REFERENCES [dbo].[vpv_sponsorGroups] ([sponsorGroupId])
GO
ALTER TABLE [dbo].[vpv_MetricPerPlan] CHECK CONSTRAINT [FK_vpv_MetricPerPlan_vpv_sponsorGroups]
GO
ALTER TABLE [dbo].[vpv_MetricPerPlan]  WITH CHECK ADD  CONSTRAINT [FK_vpv_MetricPerPlan_vpv_TargetPopulations] FOREIGN KEY([idTargetPopulation])
REFERENCES [dbo].[vpv_TargetPopulations] ([idTargetPopulation])
GO
ALTER TABLE [dbo].[vpv_MetricPerPlan] CHECK CONSTRAINT [FK_vpv_MetricPerPlan_vpv_TargetPopulations]
GO
ALTER TABLE [dbo].[vpv_mfa]  WITH CHECK ADD  CONSTRAINT [FK_vpv_mfa_vpv_mfamethods] FOREIGN KEY([mfamethodid])
REFERENCES [dbo].[vpv_mfamethods] ([mfamethodid])
GO
ALTER TABLE [dbo].[vpv_mfa] CHECK CONSTRAINT [FK_vpv_mfa_vpv_mfamethods]
GO
ALTER TABLE [dbo].[vpv_mfa]  WITH CHECK ADD  CONSTRAINT [FK_vpv_mfa_vpv_Users] FOREIGN KEY([userid])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_mfa] CHECK CONSTRAINT [FK_vpv_mfa_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_mfachallenges]  WITH CHECK ADD  CONSTRAINT [FK_vpv_mfachallenges_vpv_mfa] FOREIGN KEY([mfaid])
REFERENCES [dbo].[vpv_mfa] ([mfaid])
GO
ALTER TABLE [dbo].[vpv_mfachallenges] CHECK CONSTRAINT [FK_vpv_mfachallenges_vpv_mfa]
GO
ALTER TABLE [dbo].[vpv_mfaselect]  WITH CHECK ADD  CONSTRAINT [FK_vpv_mfaselect_vpv_mfasettings] FOREIGN KEY([mfasettingid])
REFERENCES [dbo].[vpv_mfasettings] ([mfasettingid])
GO
ALTER TABLE [dbo].[vpv_mfaselect] CHECK CONSTRAINT [FK_vpv_mfaselect_vpv_mfasettings]
GO
ALTER TABLE [dbo].[vpv_mfasettings]  WITH CHECK ADD  CONSTRAINT [FK_vpv_mfasettings_vpv_mfa] FOREIGN KEY([mfaid])
REFERENCES [dbo].[vpv_mfa] ([mfaid])
GO
ALTER TABLE [dbo].[vpv_mfasettings] CHECK CONSTRAINT [FK_vpv_mfasettings_vpv_mfa]
GO
ALTER TABLE [dbo].[vpv_optionsQuestion]  WITH CHECK ADD  CONSTRAINT [FK_vpv_optionsQuestion_vpv_optionTypes] FOREIGN KEY([idOptionType])
REFERENCES [dbo].[vpv_optionTypes] ([idOptionType])
GO
ALTER TABLE [dbo].[vpv_optionsQuestion] CHECK CONSTRAINT [FK_vpv_optionsQuestion_vpv_optionTypes]
GO
ALTER TABLE [dbo].[vpv_optionsQuestion]  WITH CHECK ADD  CONSTRAINT [FK_vpv_optionsQuestion_vpv_questions] FOREIGN KEY([idQuestions])
REFERENCES [dbo].[vpv_questions] ([idQuestion])
GO
ALTER TABLE [dbo].[vpv_optionsQuestion] CHECK CONSTRAINT [FK_vpv_optionsQuestion_vpv_questions]
GO
ALTER TABLE [dbo].[vpv_parameters]  WITH CHECK ADD  CONSTRAINT [FK_vpv_parameters_vpv_api] FOREIGN KEY([idApi])
REFERENCES [dbo].[vpv_api] ([idApi])
GO
ALTER TABLE [dbo].[vpv_parameters] CHECK CONSTRAINT [FK_vpv_parameters_vpv_api]
GO
ALTER TABLE [dbo].[vpv_paymentPlans]  WITH CHECK ADD  CONSTRAINT [FK_vpv_paymentPlans_vpv_processStatus] FOREIGN KEY([statusId])
REFERENCES [dbo].[vpv_processStatus] ([statusId])
GO
ALTER TABLE [dbo].[vpv_paymentPlans] CHECK CONSTRAINT [FK_vpv_paymentPlans_vpv_processStatus]
GO
ALTER TABLE [dbo].[vpv_paymentPlans]  WITH CHECK ADD  CONSTRAINT [FK_vpv_paymentPlans_vpv_schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[vpv_schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[vpv_paymentPlans] CHECK CONSTRAINT [FK_vpv_paymentPlans_vpv_schedules]
GO
ALTER TABLE [dbo].[vpv_paymentPlans]  WITH CHECK ADD  CONSTRAINT [FK_vpv_paymentPlans_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_paymentPlans] CHECK CONSTRAINT [FK_vpv_paymentPlans_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_payments]  WITH CHECK ADD  CONSTRAINT [FK_vpv_payments_vpv_availablePaymentMethods] FOREIGN KEY([paymentMethodId])
REFERENCES [dbo].[vpv_availablePaymentMethods] ([paymentMethodId])
GO
ALTER TABLE [dbo].[vpv_payments] CHECK CONSTRAINT [FK_vpv_payments_vpv_availablePaymentMethods]
GO
ALTER TABLE [dbo].[vpv_payments]  WITH CHECK ADD  CONSTRAINT [FK_vpv_payments_vpv_paymentMethods] FOREIGN KEY([methodId])
REFERENCES [dbo].[vpv_paymentMethods] ([methodId])
GO
ALTER TABLE [dbo].[vpv_payments] CHECK CONSTRAINT [FK_vpv_payments_vpv_paymentMethods]
GO
ALTER TABLE [dbo].[vpv_payments]  WITH CHECK ADD  CONSTRAINT [FK_vpv_payments_vpv_schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[vpv_schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[vpv_payments] CHECK CONSTRAINT [FK_vpv_payments_vpv_schedules]
GO
ALTER TABLE [dbo].[vpv_payments]  WITH CHECK ADD  CONSTRAINT [FK_vpv_payments_vpv_schedules1] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[vpv_schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[vpv_payments] CHECK CONSTRAINT [FK_vpv_payments_vpv_schedules1]
GO
ALTER TABLE [dbo].[vpv_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_Permissions_vpv_PermissionAction] FOREIGN KEY([id_permissionAction])
REFERENCES [dbo].[vpv_PermissionAction] ([id_permissionAction])
GO
ALTER TABLE [dbo].[vpv_Permissions] CHECK CONSTRAINT [FK_vpv_Permissions_vpv_PermissionAction]
GO
ALTER TABLE [dbo].[vpv_Permissions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_Permissions_vpv_PermissionResource] FOREIGN KEY([id_permisionResource])
REFERENCES [dbo].[vpv_PermissionResource] ([id_permissionResource])
GO
ALTER TABLE [dbo].[vpv_Permissions] CHECK CONSTRAINT [FK_vpv_Permissions_vpv_PermissionResource]
GO
ALTER TABLE [dbo].[vpv_planBalance]  WITH CHECK ADD  CONSTRAINT [FK_vpv_planBalance_vpv_balances] FOREIGN KEY([balanceId])
REFERENCES [dbo].[vpv_balances] ([balanceId])
GO
ALTER TABLE [dbo].[vpv_planBalance] CHECK CONSTRAINT [FK_vpv_planBalance_vpv_balances]
GO
ALTER TABLE [dbo].[vpv_planBalance]  WITH CHECK ADD  CONSTRAINT [FK_vpv_planBalance_vpv_executionPlans] FOREIGN KEY([executionPlanId])
REFERENCES [dbo].[vpv_executionPlans] ([executionPlanId])
GO
ALTER TABLE [dbo].[vpv_planBalance] CHECK CONSTRAINT [FK_vpv_planBalance_vpv_executionPlans]
GO
ALTER TABLE [dbo].[vpv_PopulationFilters]  WITH CHECK ADD  CONSTRAINT [FK_vpv_PopulationFilters_vpv_FilterTypes] FOREIGN KEY([idFilterType])
REFERENCES [dbo].[vpv_FilterTypes] ([idFilterType])
GO
ALTER TABLE [dbo].[vpv_PopulationFilters] CHECK CONSTRAINT [FK_vpv_PopulationFilters_vpv_FilterTypes]
GO
ALTER TABLE [dbo].[vpv_PopulationFilters]  WITH CHECK ADD  CONSTRAINT [FK_vpv_PopulationFilters_vpv_TargetPopulations] FOREIGN KEY([idTargetPopulation])
REFERENCES [dbo].[vpv_TargetPopulations] ([idTargetPopulation])
GO
ALTER TABLE [dbo].[vpv_PopulationFilters] CHECK CONSTRAINT [FK_vpv_PopulationFilters_vpv_TargetPopulations]
GO
ALTER TABLE [dbo].[vpv_process]  WITH CHECK ADD  CONSTRAINT [FK_vpv_process_vpv_parameters] FOREIGN KEY([parameterid])
REFERENCES [dbo].[vpv_parameters] ([parameterid])
GO
ALTER TABLE [dbo].[vpv_process] CHECK CONSTRAINT [FK_vpv_process_vpv_parameters]
GO
ALTER TABLE [dbo].[vpv_process]  WITH CHECK ADD  CONSTRAINT [FK_vpv_process_vpv_processtypes] FOREIGN KEY([processtypeid])
REFERENCES [dbo].[vpv_processtypes] ([processtypeid])
GO
ALTER TABLE [dbo].[vpv_process] CHECK CONSTRAINT [FK_vpv_process_vpv_processtypes]
GO
ALTER TABLE [dbo].[vpv_projectReports]  WITH CHECK ADD  CONSTRAINT [FK_vpv_projectReports_vpv_crowdfoundingProposals] FOREIGN KEY([crowdfoundingProposalId])
REFERENCES [dbo].[vpv_crowdfoundingProposals] ([crowdfoundingProposalId])
GO
ALTER TABLE [dbo].[vpv_projectReports] CHECK CONSTRAINT [FK_vpv_projectReports_vpv_crowdfoundingProposals]
GO
ALTER TABLE [dbo].[vpv_projectReports]  WITH CHECK ADD  CONSTRAINT [FK_vpv_projectReports_vpv_docs] FOREIGN KEY([docid])
REFERENCES [dbo].[vpv_docs] ([docid])
GO
ALTER TABLE [dbo].[vpv_projectReports] CHECK CONSTRAINT [FK_vpv_projectReports_vpv_docs]
GO
ALTER TABLE [dbo].[vpv_projectReports]  WITH CHECK ADD  CONSTRAINT [FK_vpv_projectReports_vpv_processStatus] FOREIGN KEY([statusId])
REFERENCES [dbo].[vpv_processStatus] ([statusId])
GO
ALTER TABLE [dbo].[vpv_projectReports] CHECK CONSTRAINT [FK_vpv_projectReports_vpv_processStatus]
GO
ALTER TABLE [dbo].[vpv_projectReports]  WITH CHECK ADD  CONSTRAINT [FK_vpv_projectReports_vpv_schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[vpv_schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[vpv_projectReports] CHECK CONSTRAINT [FK_vpv_projectReports_vpv_schedules]
GO
ALTER TABLE [dbo].[vpv_projectReports]  WITH CHECK ADD  CONSTRAINT [FK_vpv_projectReports_vpv_TargetPopulations] FOREIGN KEY([idTargetPopulation])
REFERENCES [dbo].[vpv_TargetPopulations] ([idTargetPopulation])
GO
ALTER TABLE [dbo].[vpv_projectReports] CHECK CONSTRAINT [FK_vpv_projectReports_vpv_TargetPopulations]
GO
ALTER TABLE [dbo].[vpv_projectReports]  WITH CHECK ADD  CONSTRAINT [FK_vpv_projectReports_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_projectReports] CHECK CONSTRAINT [FK_vpv_projectReports_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_proposalBalance]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalBalance_vpv_balances] FOREIGN KEY([BalanceId])
REFERENCES [dbo].[vpv_balances] ([balanceId])
GO
ALTER TABLE [dbo].[vpv_proposalBalance] CHECK CONSTRAINT [FK_vpv_proposalBalance_vpv_balances]
GO
ALTER TABLE [dbo].[vpv_proposalBalance]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalBalance_vpv_crowdfoundingProposals] FOREIGN KEY([crowdfoundingProposalId])
REFERENCES [dbo].[vpv_crowdfoundingProposals] ([crowdfoundingProposalId])
GO
ALTER TABLE [dbo].[vpv_proposalBalance] CHECK CONSTRAINT [FK_vpv_proposalBalance_vpv_crowdfoundingProposals]
GO
ALTER TABLE [dbo].[vpv_proposalComments]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalComments_vpv_docs] FOREIGN KEY([docid])
REFERENCES [dbo].[vpv_docs] ([docid])
GO
ALTER TABLE [dbo].[vpv_proposalComments] CHECK CONSTRAINT [FK_vpv_proposalComments_vpv_docs]
GO
ALTER TABLE [dbo].[vpv_proposalComments]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalComments_vpv_processStatus] FOREIGN KEY([statusId])
REFERENCES [dbo].[vpv_processStatus] ([statusId])
GO
ALTER TABLE [dbo].[vpv_proposalComments] CHECK CONSTRAINT [FK_vpv_proposalComments_vpv_processStatus]
GO
ALTER TABLE [dbo].[vpv_proposalComments]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalComments_vpv_proposalVersions] FOREIGN KEY([proposalVersionId])
REFERENCES [dbo].[vpv_proposalVersions] ([proposalVersionId])
GO
ALTER TABLE [dbo].[vpv_proposalComments] CHECK CONSTRAINT [FK_vpv_proposalComments_vpv_proposalVersions]
GO
ALTER TABLE [dbo].[vpv_proposalComments]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalComments_vpv_Users] FOREIGN KEY([madeBy])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_proposalComments] CHECK CONSTRAINT [FK_vpv_proposalComments_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_proposalNormalViews]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalNormalViews_vpv_demosubtype] FOREIGN KEY([demosubtypeid])
REFERENCES [dbo].[vpv_demosubtype] ([demosubtypeid])
GO
ALTER TABLE [dbo].[vpv_proposalNormalViews] CHECK CONSTRAINT [FK_vpv_proposalNormalViews_vpv_demosubtype]
GO
ALTER TABLE [dbo].[vpv_proposalNormalViews]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalNormalViews_vpv_demotype] FOREIGN KEY([demotypeid])
REFERENCES [dbo].[vpv_demotype] ([demotypeid])
GO
ALTER TABLE [dbo].[vpv_proposalNormalViews] CHECK CONSTRAINT [FK_vpv_proposalNormalViews_vpv_demotype]
GO
ALTER TABLE [dbo].[vpv_proposalNormalViews]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalNormalViews_vpv_proposals] FOREIGN KEY([proposalId])
REFERENCES [dbo].[vpv_proposals] ([proposalId])
GO
ALTER TABLE [dbo].[vpv_proposalNormalViews] CHECK CONSTRAINT [FK_vpv_proposalNormalViews_vpv_proposals]
GO
ALTER TABLE [dbo].[vpv_proposalRequirements]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalRequirements_vpv_requirementTypes] FOREIGN KEY([requirementTypeId])
REFERENCES [dbo].[vpv_requirementTypes] ([requirementTypeId])
GO
ALTER TABLE [dbo].[vpv_proposalRequirements] CHECK CONSTRAINT [FK_vpv_proposalRequirements_vpv_requirementTypes]
GO
ALTER TABLE [dbo].[vpv_proposals]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposals_vpv_entities] FOREIGN KEY([entitydid])
REFERENCES [dbo].[vpv_entities] ([entityid])
GO
ALTER TABLE [dbo].[vpv_proposals] CHECK CONSTRAINT [FK_vpv_proposals_vpv_entities]
GO
ALTER TABLE [dbo].[vpv_proposals]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposals_vpv_processStatus] FOREIGN KEY([statusId])
REFERENCES [dbo].[vpv_processStatus] ([statusId])
GO
ALTER TABLE [dbo].[vpv_proposals] CHECK CONSTRAINT [FK_vpv_proposals_vpv_processStatus]
GO
ALTER TABLE [dbo].[vpv_proposals]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposals_vpv_proposalTypes] FOREIGN KEY([proposalTypeId])
REFERENCES [dbo].[vpv_proposalTypes] ([proposalTypeId])
GO
ALTER TABLE [dbo].[vpv_proposals] CHECK CONSTRAINT [FK_vpv_proposals_vpv_proposalTypes]
GO
ALTER TABLE [dbo].[vpv_proposals]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposals_vpv_schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[vpv_schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[vpv_proposals] CHECK CONSTRAINT [FK_vpv_proposals_vpv_schedules]
GO
ALTER TABLE [dbo].[vpv_proposals]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposals_vpv_schedules1] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[vpv_schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[vpv_proposals] CHECK CONSTRAINT [FK_vpv_proposals_vpv_schedules1]
GO
ALTER TABLE [dbo].[vpv_proposals]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposals_vpv_TargetPopulations] FOREIGN KEY([idTargetPopulation])
REFERENCES [dbo].[vpv_TargetPopulations] ([idTargetPopulation])
GO
ALTER TABLE [dbo].[vpv_proposals] CHECK CONSTRAINT [FK_vpv_proposals_vpv_TargetPopulations]
GO
ALTER TABLE [dbo].[vpv_proposals]  WITH NOCHECK ADD  CONSTRAINT [FK_vpv_proposals_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_proposals] NOCHECK CONSTRAINT [FK_vpv_proposals_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_ProposalTracking]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ProposalTracking_vpv_docs] FOREIGN KEY([docid])
REFERENCES [dbo].[vpv_docs] ([docid])
GO
ALTER TABLE [dbo].[vpv_ProposalTracking] CHECK CONSTRAINT [FK_vpv_ProposalTracking_vpv_docs]
GO
ALTER TABLE [dbo].[vpv_ProposalTracking]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ProposalTracking_vpv_processStatus] FOREIGN KEY([statusId])
REFERENCES [dbo].[vpv_processStatus] ([statusId])
GO
ALTER TABLE [dbo].[vpv_ProposalTracking] CHECK CONSTRAINT [FK_vpv_ProposalTracking_vpv_processStatus]
GO
ALTER TABLE [dbo].[vpv_ProposalTracking]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ProposalTracking_vpv_proposals] FOREIGN KEY([proposalId])
REFERENCES [dbo].[vpv_proposals] ([proposalId])
GO
ALTER TABLE [dbo].[vpv_ProposalTracking] CHECK CONSTRAINT [FK_vpv_ProposalTracking_vpv_proposals]
GO
ALTER TABLE [dbo].[vpv_ProposalTracking]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ProposalTracking_vpv_schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[vpv_schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[vpv_ProposalTracking] CHECK CONSTRAINT [FK_vpv_ProposalTracking_vpv_schedules]
GO
ALTER TABLE [dbo].[vpv_ProposalTracking]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ProposalTracking_vpv_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_ProposalTracking] CHECK CONSTRAINT [FK_vpv_ProposalTracking_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_proposalVersions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalVersions_vpv_processStatus] FOREIGN KEY([statusid])
REFERENCES [dbo].[vpv_processStatus] ([statusId])
GO
ALTER TABLE [dbo].[vpv_proposalVersions] CHECK CONSTRAINT [FK_vpv_proposalVersions_vpv_processStatus]
GO
ALTER TABLE [dbo].[vpv_proposalVersions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalVersions_vpv_proposals] FOREIGN KEY([proposalId])
REFERENCES [dbo].[vpv_proposals] ([proposalId])
GO
ALTER TABLE [dbo].[vpv_proposalVersions] CHECK CONSTRAINT [FK_vpv_proposalVersions_vpv_proposals]
GO
ALTER TABLE [dbo].[vpv_proposalVersions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalVersions_vpv_schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[vpv_schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[vpv_proposalVersions] CHECK CONSTRAINT [FK_vpv_proposalVersions_vpv_schedules]
GO
ALTER TABLE [dbo].[vpv_proposalViews]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalViews_vpv_demosubtype] FOREIGN KEY([demosubtypeid])
REFERENCES [dbo].[vpv_demosubtype] ([demosubtypeid])
GO
ALTER TABLE [dbo].[vpv_proposalViews] CHECK CONSTRAINT [FK_vpv_proposalViews_vpv_demosubtype]
GO
ALTER TABLE [dbo].[vpv_proposalViews]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalViews_vpv_demotype] FOREIGN KEY([demotypeid])
REFERENCES [dbo].[vpv_demotype] ([demotypeid])
GO
ALTER TABLE [dbo].[vpv_proposalViews] CHECK CONSTRAINT [FK_vpv_proposalViews_vpv_demotype]
GO
ALTER TABLE [dbo].[vpv_proposalViews]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalViews_vpv_proposals] FOREIGN KEY([proposalId])
REFERENCES [dbo].[vpv_proposals] ([proposalId])
GO
ALTER TABLE [dbo].[vpv_proposalViews] CHECK CONSTRAINT [FK_vpv_proposalViews_vpv_proposals]
GO
ALTER TABLE [dbo].[vpv_proposalViews]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalViews_vpv_proposalViewTypes] FOREIGN KEY([viewTypeId])
REFERENCES [dbo].[vpv_proposalViewTypes] ([viewTypeId])
GO
ALTER TABLE [dbo].[vpv_proposalViews] CHECK CONSTRAINT [FK_vpv_proposalViews_vpv_proposalViewTypes]
GO
ALTER TABLE [dbo].[vpv_proposalViews]  WITH CHECK ADD  CONSTRAINT [FK_vpv_proposalViews_vpv_TargetPopulationsVoting] FOREIGN KEY([idTargetPopulationsVoting])
REFERENCES [dbo].[vpv_TargetPopulationsVoting] ([idTargetPopulationsVoting])
GO
ALTER TABLE [dbo].[vpv_proposalViews] CHECK CONSTRAINT [FK_vpv_proposalViews_vpv_TargetPopulationsVoting]
GO
ALTER TABLE [dbo].[vpv_questions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_questions_vpv_questionTypes] FOREIGN KEY([idQuestionType])
REFERENCES [dbo].[vpv_questionTypes] ([idQuestionType])
GO
ALTER TABLE [dbo].[vpv_questions] CHECK CONSTRAINT [FK_vpv_questions_vpv_questionTypes]
GO
ALTER TABLE [dbo].[vpv_reminders]  WITH CHECK ADD  CONSTRAINT [FK_vpv_reminders_vpv_notificationMethods] FOREIGN KEY([idNotificationMethods])
REFERENCES [dbo].[vpv_notificationMethods] ([idNotificationMethods])
GO
ALTER TABLE [dbo].[vpv_reminders] CHECK CONSTRAINT [FK_vpv_reminders_vpv_notificationMethods]
GO
ALTER TABLE [dbo].[vpv_reminders]  WITH CHECK ADD  CONSTRAINT [FK_vpv_reminders_vpv_reminderTypes] FOREIGN KEY([idReminderType])
REFERENCES [dbo].[vpv_reminderTypes] ([idReminderType])
GO
ALTER TABLE [dbo].[vpv_reminders] CHECK CONSTRAINT [FK_vpv_reminders_vpv_reminderTypes]
GO
ALTER TABLE [dbo].[vpv_requests]  WITH CHECK ADD  CONSTRAINT [FK_vpv_requests_vpv_entities] FOREIGN KEY([entitydid])
REFERENCES [dbo].[vpv_entities] ([entityid])
GO
ALTER TABLE [dbo].[vpv_requests] CHECK CONSTRAINT [FK_vpv_requests_vpv_entities]
GO
ALTER TABLE [dbo].[vpv_requests]  WITH CHECK ADD  CONSTRAINT [FK_vpv_requests_vpv_requeststates] FOREIGN KEY([requeststatusid])
REFERENCES [dbo].[vpv_requeststates] ([requeststatusid])
GO
ALTER TABLE [dbo].[vpv_requests] CHECK CONSTRAINT [FK_vpv_requests_vpv_requeststates]
GO
ALTER TABLE [dbo].[vpv_requests]  WITH CHECK ADD  CONSTRAINT [FK_vpv_requests_vpv_Users] FOREIGN KEY([userid])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_requests] CHECK CONSTRAINT [FK_vpv_requests_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_requestvalidators]  WITH CHECK ADD  CONSTRAINT [FK_vpv_requestvalidators_vpv_validationstatus] FOREIGN KEY([validationstatusid])
REFERENCES [dbo].[vpv_validationstatus] ([validationstatusid])
GO
ALTER TABLE [dbo].[vpv_requestvalidators] CHECK CONSTRAINT [FK_vpv_requestvalidators_vpv_validationstatus]
GO
ALTER TABLE [dbo].[vpv_resolutions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_resolutions_vpv_docincidents] FOREIGN KEY([docincidentid])
REFERENCES [dbo].[vpv_docincidents] ([docincidentid])
GO
ALTER TABLE [dbo].[vpv_resolutions] CHECK CONSTRAINT [FK_vpv_resolutions_vpv_docincidents]
GO
ALTER TABLE [dbo].[vpv_ResultsPerFilter]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ResultsPerFilter_vpv_FilterTypes] FOREIGN KEY([idFilterType])
REFERENCES [dbo].[vpv_FilterTypes] ([idFilterType])
GO
ALTER TABLE [dbo].[vpv_ResultsPerFilter] CHECK CONSTRAINT [FK_vpv_ResultsPerFilter_vpv_FilterTypes]
GO
ALTER TABLE [dbo].[vpv_ResultsPerFilter]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ResultsPerFilter_vpv_ResultTypes] FOREIGN KEY([idResultType])
REFERENCES [dbo].[vpv_ResultTypes] ([idResultType])
GO
ALTER TABLE [dbo].[vpv_ResultsPerFilter] CHECK CONSTRAINT [FK_vpv_ResultsPerFilter_vpv_ResultTypes]
GO
ALTER TABLE [dbo].[vpv_ResultsPerFilter]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ResultsPerFilter_vpv_votingConfigurations] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_ResultsPerFilter] CHECK CONSTRAINT [FK_vpv_ResultsPerFilter_vpv_votingConfigurations]
GO
ALTER TABLE [dbo].[vpv_ResultsPerOption]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ResultsPerOption_vpv_optionsQuestion] FOREIGN KEY([idOptionQuestion])
REFERENCES [dbo].[vpv_optionsQuestion] ([idOptionQuestion])
GO
ALTER TABLE [dbo].[vpv_ResultsPerOption] CHECK CONSTRAINT [FK_vpv_ResultsPerOption_vpv_optionsQuestion]
GO
ALTER TABLE [dbo].[vpv_ResultsPerOption]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ResultsPerOption_vpv_votingConfigurations] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_ResultsPerOption] CHECK CONSTRAINT [FK_vpv_ResultsPerOption_vpv_votingConfigurations]
GO
ALTER TABLE [dbo].[vpv_ResultsPerOption]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ResultsPerOption_vpv_votingConfigurations1] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_ResultsPerOption] CHECK CONSTRAINT [FK_vpv_ResultsPerOption_vpv_votingConfigurations1]
GO
ALTER TABLE [dbo].[vpv_ResultsPerOption]  WITH CHECK ADD  CONSTRAINT [FK_vpv_ResultsPerOption_vpv_votingQuestions] FOREIGN KEY([idVotingQuestions])
REFERENCES [dbo].[vpv_votingQuestions] ([idVotingQuestions])
GO
ALTER TABLE [dbo].[vpv_ResultsPerOption] CHECK CONSTRAINT [FK_vpv_ResultsPerOption_vpv_votingQuestions]
GO
ALTER TABLE [dbo].[vpv_RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_vpv_RolePermission_vpv_Permissions] FOREIGN KEY([id_permission])
REFERENCES [dbo].[vpv_Permissions] ([id_permission])
GO
ALTER TABLE [dbo].[vpv_RolePermission] CHECK CONSTRAINT [FK_vpv_RolePermission_vpv_Permissions]
GO
ALTER TABLE [dbo].[vpv_RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_vpv_RolePermission_vpv_Roles] FOREIGN KEY([id_role])
REFERENCES [dbo].[vpv_Roles] ([id_role])
GO
ALTER TABLE [dbo].[vpv_RolePermission] CHECK CONSTRAINT [FK_vpv_RolePermission_vpv_Roles]
GO
ALTER TABLE [dbo].[vpv_Rules]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VotingMethods_vpv_VotingMethodTypes] FOREIGN KEY([idVotingRuleTypes])
REFERENCES [dbo].[vpv_VotingRuleTypes] ([idVotingRuleTypes])
GO
ALTER TABLE [dbo].[vpv_Rules] CHECK CONSTRAINT [FK_vpv_VotingMethods_vpv_VotingMethodTypes]
GO
ALTER TABLE [dbo].[vpv_Rules]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VotingRules_vpv_VotingRuleSubType] FOREIGN KEY([idVotingRuleSubType])
REFERENCES [dbo].[vpv_VotingRuleSubType] ([idVotingRuleSubType])
GO
ALTER TABLE [dbo].[vpv_Rules] CHECK CONSTRAINT [FK_vpv_VotingRules_vpv_VotingRuleSubType]
GO
ALTER TABLE [dbo].[vpv_scheduleDetails]  WITH CHECK ADD  CONSTRAINT [FK_vpv_scheduleDetails_vpv_schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[vpv_schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[vpv_scheduleDetails] CHECK CONSTRAINT [FK_vpv_scheduleDetails_vpv_schedules]
GO
ALTER TABLE [dbo].[vpv_SearchingTags]  WITH CHECK ADD  CONSTRAINT [FK_vpv_SearchingTags_vpv_TargetPopulations] FOREIGN KEY([idTargetPopulations])
REFERENCES [dbo].[vpv_TargetPopulations] ([idTargetPopulation])
GO
ALTER TABLE [dbo].[vpv_SearchingTags] CHECK CONSTRAINT [FK_vpv_SearchingTags_vpv_TargetPopulations]
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements]  WITH CHECK ADD  CONSTRAINT [FK_vpv_sponsorAgreements_vpv_crowdfoundingProposals] FOREIGN KEY([crowdfoundingProposalId])
REFERENCES [dbo].[vpv_crowdfoundingProposals] ([crowdfoundingProposalId])
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements] CHECK CONSTRAINT [FK_vpv_sponsorAgreements_vpv_crowdfoundingProposals]
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements]  WITH CHECK ADD  CONSTRAINT [FK_vpv_sponsorAgreements_vpv_currencies] FOREIGN KEY([currencyId])
REFERENCES [dbo].[vpv_currencies] ([currencyId])
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements] CHECK CONSTRAINT [FK_vpv_sponsorAgreements_vpv_currencies]
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements]  WITH CHECK ADD  CONSTRAINT [FK_vpv_sponsorAgreements_vpv_schedules] FOREIGN KEY([scheduleId])
REFERENCES [dbo].[vpv_schedules] ([scheduleId])
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements] CHECK CONSTRAINT [FK_vpv_sponsorAgreements_vpv_schedules]
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements]  WITH CHECK ADD  CONSTRAINT [FK_vpv_sponsorAgreements_vpv_sponsorAgrementsType] FOREIGN KEY([sponsorAgreementTypeId])
REFERENCES [dbo].[vpv_sponsorAgrementsType] ([sponsorAgreementTypeId])
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements] CHECK CONSTRAINT [FK_vpv_sponsorAgreements_vpv_sponsorAgrementsType]
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements]  WITH CHECK ADD  CONSTRAINT [FK_vpv_sponsorAgreements_vpv_sponsorGroups] FOREIGN KEY([sponsorGroupId])
REFERENCES [dbo].[vpv_sponsorGroups] ([sponsorGroupId])
GO
ALTER TABLE [dbo].[vpv_sponsorAgreements] CHECK CONSTRAINT [FK_vpv_sponsorAgreements_vpv_sponsorGroups]
GO
ALTER TABLE [dbo].[vpv_sponsorGroups]  WITH CHECK ADD  CONSTRAINT [FK_vpv_sponsorGroups_vpv_sponsornGroupTypes] FOREIGN KEY([sponsorGroupTypeId])
REFERENCES [dbo].[vpv_sponsornGroupTypes] ([sponsorGroupTypeId])
GO
ALTER TABLE [dbo].[vpv_sponsorGroups] CHECK CONSTRAINT [FK_vpv_sponsorGroups_vpv_sponsornGroupTypes]
GO
ALTER TABLE [dbo].[vpv_States]  WITH CHECK ADD  CONSTRAINT [FK_vpv_States_vpv_Countries] FOREIGN KEY([idCountry])
REFERENCES [dbo].[vpv_Countries] ([idCountry])
GO
ALTER TABLE [dbo].[vpv_States] CHECK CONSTRAINT [FK_vpv_States_vpv_Countries]
GO
ALTER TABLE [dbo].[vpv_TargetPopulationsVoting]  WITH CHECK ADD  CONSTRAINT [FK_vpv_TargetPopulationsVoting_vpv_TargetPopulations] FOREIGN KEY([idTargetPopulation])
REFERENCES [dbo].[vpv_TargetPopulations] ([idTargetPopulation])
GO
ALTER TABLE [dbo].[vpv_TargetPopulationsVoting] CHECK CONSTRAINT [FK_vpv_TargetPopulationsVoting_vpv_TargetPopulations]
GO
ALTER TABLE [dbo].[vpv_TargetPopulationsVoting]  WITH CHECK ADD  CONSTRAINT [FK_vpv_TargetPopulationsVoting_vpv_votingConfigurations] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_TargetPopulationsVoting] CHECK CONSTRAINT [FK_vpv_TargetPopulationsVoting_vpv_votingConfigurations]
GO
ALTER TABLE [dbo].[vpv_transactionPerPlan]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactionPerPlan_vpv_crowdfoundingProposals] FOREIGN KEY([crowdfoundingProposalId])
REFERENCES [dbo].[vpv_crowdfoundingProposals] ([crowdfoundingProposalId])
GO
ALTER TABLE [dbo].[vpv_transactionPerPlan] CHECK CONSTRAINT [FK_vpv_transactionPerPlan_vpv_crowdfoundingProposals]
GO
ALTER TABLE [dbo].[vpv_transactionPerPlan]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactionPerPlan_vpv_executionPlans] FOREIGN KEY([executionPlanId])
REFERENCES [dbo].[vpv_executionPlans] ([executionPlanId])
GO
ALTER TABLE [dbo].[vpv_transactionPerPlan] CHECK CONSTRAINT [FK_vpv_transactionPerPlan_vpv_executionPlans]
GO
ALTER TABLE [dbo].[vpv_transactionPerPlan]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactionPerPlan_vpv_transactions] FOREIGN KEY([transactionId])
REFERENCES [dbo].[vpv_transactions] ([transactionId])
GO
ALTER TABLE [dbo].[vpv_transactionPerPlan] CHECK CONSTRAINT [FK_vpv_transactionPerPlan_vpv_transactions]
GO
ALTER TABLE [dbo].[vpv_transactionPerUser]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactionPerUser_vpv_entities] FOREIGN KEY([entitydid])
REFERENCES [dbo].[vpv_entities] ([entityid])
GO
ALTER TABLE [dbo].[vpv_transactionPerUser] CHECK CONSTRAINT [FK_vpv_transactionPerUser_vpv_entities]
GO
ALTER TABLE [dbo].[vpv_transactionPerUser]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactionPerUser_vpv_sponsorGroups] FOREIGN KEY([sponsorGroupId])
REFERENCES [dbo].[vpv_sponsorGroups] ([sponsorGroupId])
GO
ALTER TABLE [dbo].[vpv_transactionPerUser] CHECK CONSTRAINT [FK_vpv_transactionPerUser_vpv_sponsorGroups]
GO
ALTER TABLE [dbo].[vpv_transactionPerUser]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactionPerUser_vpv_transactions] FOREIGN KEY([transactionId])
REFERENCES [dbo].[vpv_transactions] ([transactionId])
GO
ALTER TABLE [dbo].[vpv_transactionPerUser] CHECK CONSTRAINT [FK_vpv_transactionPerUser_vpv_transactions]
GO
ALTER TABLE [dbo].[vpv_transactionPerUser]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactionPerUser_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_transactionPerUser] CHECK CONSTRAINT [FK_vpv_transactionPerUser_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_transactions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactions_vpv_balances] FOREIGN KEY([balanceId])
REFERENCES [dbo].[vpv_balances] ([balanceId])
GO
ALTER TABLE [dbo].[vpv_transactions] CHECK CONSTRAINT [FK_vpv_transactions_vpv_balances]
GO
ALTER TABLE [dbo].[vpv_transactions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactions_vpv_currencies] FOREIGN KEY([currencyId])
REFERENCES [dbo].[vpv_currencies] ([currencyId])
GO
ALTER TABLE [dbo].[vpv_transactions] CHECK CONSTRAINT [FK_vpv_transactions_vpv_currencies]
GO
ALTER TABLE [dbo].[vpv_transactions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactions_vpv_exchangeRates] FOREIGN KEY([exchangeRateId])
REFERENCES [dbo].[vpv_exchangeRates] ([echangeRateId])
GO
ALTER TABLE [dbo].[vpv_transactions] CHECK CONSTRAINT [FK_vpv_transactions_vpv_exchangeRates]
GO
ALTER TABLE [dbo].[vpv_transactions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactions_vpv_payments] FOREIGN KEY([paymentId])
REFERENCES [dbo].[vpv_payments] ([paymentId])
GO
ALTER TABLE [dbo].[vpv_transactions] CHECK CONSTRAINT [FK_vpv_transactions_vpv_payments]
GO
ALTER TABLE [dbo].[vpv_transactions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactions_vpv_transSubTypes] FOREIGN KEY([transactionSubTypeId])
REFERENCES [dbo].[vpv_transSubTypes] ([transactionSubTypeId])
GO
ALTER TABLE [dbo].[vpv_transactions] CHECK CONSTRAINT [FK_vpv_transactions_vpv_transSubTypes]
GO
ALTER TABLE [dbo].[vpv_transactions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_transactions_vpv_transTypes] FOREIGN KEY([transTypeId])
REFERENCES [dbo].[vpv_transTypes] ([transTypeId])
GO
ALTER TABLE [dbo].[vpv_transactions] CHECK CONSTRAINT [FK_vpv_transactions_vpv_transTypes]
GO
ALTER TABLE [dbo].[vpv_translations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_translations_vpv_languages] FOREIGN KEY([languageId])
REFERENCES [dbo].[vpv_languages] ([languageId])
GO
ALTER TABLE [dbo].[vpv_translations] CHECK CONSTRAINT [FK_vpv_translations_vpv_languages]
GO
ALTER TABLE [dbo].[vpv_userBalance]  WITH CHECK ADD  CONSTRAINT [FK_vpv_userBalance_vpv_balances] FOREIGN KEY([balanceId])
REFERENCES [dbo].[vpv_balances] ([balanceId])
GO
ALTER TABLE [dbo].[vpv_userBalance] CHECK CONSTRAINT [FK_vpv_userBalance_vpv_balances]
GO
ALTER TABLE [dbo].[vpv_userBalance]  WITH CHECK ADD  CONSTRAINT [FK_vpv_userBalance_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_userBalance] CHECK CONSTRAINT [FK_vpv_userBalance_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_userperrole]  WITH CHECK ADD  CONSTRAINT [FK_vpv_userperrole_vpv_entityroles] FOREIGN KEY([entityrole])
REFERENCES [dbo].[vpv_entityroles] ([entityrole])
GO
ALTER TABLE [dbo].[vpv_userperrole] CHECK CONSTRAINT [FK_vpv_userperrole_vpv_entityroles]
GO
ALTER TABLE [dbo].[vpv_userperrole]  WITH CHECK ADD  CONSTRAINT [FK_vpv_userperrole_vpv_Users] FOREIGN KEY([userid])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_userperrole] CHECK CONSTRAINT [FK_vpv_userperrole_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_userperrole]  WITH CHECK ADD  CONSTRAINT [FK_vpv_userperrole_vpv_Users1] FOREIGN KEY([userid])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_userperrole] CHECK CONSTRAINT [FK_vpv_userperrole_vpv_Users1]
GO
ALTER TABLE [dbo].[vpv_userResidence]  WITH CHECK ADD  CONSTRAINT [FK_vpv_userResidence_vpv_Cities] FOREIGN KEY([idCity])
REFERENCES [dbo].[vpv_Cities] ([idCity])
GO
ALTER TABLE [dbo].[vpv_userResidence] CHECK CONSTRAINT [FK_vpv_userResidence_vpv_Cities]
GO
ALTER TABLE [dbo].[vpv_userResidence]  WITH CHECK ADD  CONSTRAINT [FK_vpv_userResidence_vpv_Users] FOREIGN KEY([userid])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_userResidence] CHECK CONSTRAINT [FK_vpv_userResidence_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_UserRole]  WITH CHECK ADD  CONSTRAINT [FK_vpv_UserRole_vpv_Roles] FOREIGN KEY([id_role])
REFERENCES [dbo].[vpv_Roles] ([id_role])
GO
ALTER TABLE [dbo].[vpv_UserRole] CHECK CONSTRAINT [FK_vpv_UserRole_vpv_Roles]
GO
ALTER TABLE [dbo].[vpv_UserRole]  WITH CHECK ADD  CONSTRAINT [FK_vpv_UserRole_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_UserRole] CHECK CONSTRAINT [FK_vpv_UserRole_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_Users]  WITH NOCHECK ADD  CONSTRAINT [FK_vpv_Users_vpv_nationality] FOREIGN KEY([nationalityid])
REFERENCES [dbo].[vpv_nationality] ([nationalityid])
GO
ALTER TABLE [dbo].[vpv_Users] NOCHECK CONSTRAINT [FK_vpv_Users_vpv_nationality]
GO
ALTER TABLE [dbo].[vpv_validations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_validations_vpv_requests] FOREIGN KEY([requestid])
REFERENCES [dbo].[vpv_requests] ([requestid])
GO
ALTER TABLE [dbo].[vpv_validations] CHECK CONSTRAINT [FK_vpv_validations_vpv_requests]
GO
ALTER TABLE [dbo].[vpv_validations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_validations_vpv_requestvalidators] FOREIGN KEY([validatorid])
REFERENCES [dbo].[vpv_requestvalidators] ([validatorid])
GO
ALTER TABLE [dbo].[vpv_validations] CHECK CONSTRAINT [FK_vpv_validations_vpv_requestvalidators]
GO
ALTER TABLE [dbo].[vpv_VoteComment]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VoteComment_vpv_Votes] FOREIGN KEY([idVote])
REFERENCES [dbo].[vpv_Votes] ([idVote])
GO
ALTER TABLE [dbo].[vpv_VoteComment] CHECK CONSTRAINT [FK_vpv_VoteComment_vpv_Votes]
GO
ALTER TABLE [dbo].[vpv_Voter]  WITH CHECK ADD  CONSTRAINT [FK_vpv_Voter_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_Voter] CHECK CONSTRAINT [FK_vpv_Voter_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_VoterDemographics]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VoterDemographics_vpv_demosubtype] FOREIGN KEY([idDemographySubType])
REFERENCES [dbo].[vpv_demosubtype] ([demosubtypeid])
GO
ALTER TABLE [dbo].[vpv_VoterDemographics] CHECK CONSTRAINT [FK_vpv_VoterDemographics_vpv_demosubtype]
GO
ALTER TABLE [dbo].[vpv_VoterDemographics]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VoterDemographics_vpv_demotype] FOREIGN KEY([idDemographyType])
REFERENCES [dbo].[vpv_demotype] ([demotypeid])
GO
ALTER TABLE [dbo].[vpv_VoterDemographics] CHECK CONSTRAINT [FK_vpv_VoterDemographics_vpv_demotype]
GO
ALTER TABLE [dbo].[vpv_VoterDemographics]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VoterDemographics_vpv_Voter] FOREIGN KEY([idVoter])
REFERENCES [dbo].[vpv_Voter] ([idVoter])
GO
ALTER TABLE [dbo].[vpv_VoterDemographics] CHECK CONSTRAINT [FK_vpv_VoterDemographics_vpv_Voter]
GO
ALTER TABLE [dbo].[vpv_VoterResidence]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VoterResidence_vpv_Cities] FOREIGN KEY([idCity])
REFERENCES [dbo].[vpv_Cities] ([idCity])
GO
ALTER TABLE [dbo].[vpv_VoterResidence] CHECK CONSTRAINT [FK_vpv_VoterResidence_vpv_Cities]
GO
ALTER TABLE [dbo].[vpv_VoterResidence]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VoterResidence_vpv_Voter] FOREIGN KEY([idVoter])
REFERENCES [dbo].[vpv_Voter] ([idVoter])
GO
ALTER TABLE [dbo].[vpv_VoterResidence] CHECK CONSTRAINT [FK_vpv_VoterResidence_vpv_Voter]
GO
ALTER TABLE [dbo].[vpv_Votes]  WITH CHECK ADD  CONSTRAINT [FK_vpv_Votes_vpv_BlindTokens] FOREIGN KEY([idToken])
REFERENCES [dbo].[vpv_BlindTokens] ([idToken])
GO
ALTER TABLE [dbo].[vpv_Votes] CHECK CONSTRAINT [FK_vpv_Votes_vpv_BlindTokens]
GO
ALTER TABLE [dbo].[vpv_Votes]  WITH CHECK ADD  CONSTRAINT [FK_vpv_Votes_vpv_optionsQuestion] FOREIGN KEY([idOptionQuestion])
REFERENCES [dbo].[vpv_optionsQuestion] ([idOptionQuestion])
GO
ALTER TABLE [dbo].[vpv_Votes] CHECK CONSTRAINT [FK_vpv_Votes_vpv_optionsQuestion]
GO
ALTER TABLE [dbo].[vpv_Votes]  WITH CHECK ADD  CONSTRAINT [FK_vpv_Votes_vpv_Voter] FOREIGN KEY([idVoter])
REFERENCES [dbo].[vpv_Voter] ([idVoter])
GO
ALTER TABLE [dbo].[vpv_Votes] CHECK CONSTRAINT [FK_vpv_Votes_vpv_Voter]
GO
ALTER TABLE [dbo].[vpv_Votes]  WITH CHECK ADD  CONSTRAINT [FK_vpv_Votes_vpv_votingQuestions] FOREIGN KEY([idVotingQuestion])
REFERENCES [dbo].[vpv_votingQuestions] ([idVotingQuestions])
GO
ALTER TABLE [dbo].[vpv_Votes] CHECK CONSTRAINT [FK_vpv_Votes_vpv_votingQuestions]
GO
ALTER TABLE [dbo].[vpv_VotesTaken]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VotesTaken_vpv_Users] FOREIGN KEY([idUser])
REFERENCES [dbo].[vpv_Users] ([idUser])
GO
ALTER TABLE [dbo].[vpv_VotesTaken] CHECK CONSTRAINT [FK_vpv_VotesTaken_vpv_Users]
GO
ALTER TABLE [dbo].[vpv_VotesTaken]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VotesTaken_vpv_votingQuestions] FOREIGN KEY([idVotingQuestions])
REFERENCES [dbo].[vpv_votingQuestions] ([idVotingQuestions])
GO
ALTER TABLE [dbo].[vpv_VotesTaken] CHECK CONSTRAINT [FK_vpv_VotesTaken_vpv_votingQuestions]
GO
ALTER TABLE [dbo].[vpv_voteValues]  WITH CHECK ADD  CONSTRAINT [FK_vpv_voteValues_vpv_Votes] FOREIGN KEY([idVote])
REFERENCES [dbo].[vpv_Votes] ([idVote])
GO
ALTER TABLE [dbo].[vpv_voteValues] CHECK CONSTRAINT [FK_vpv_voteValues_vpv_Votes]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingConfigurations_vpv_ClosureTypes] FOREIGN KEY([idClosureTypes])
REFERENCES [dbo].[vpv_ClosureTypes] ([idClosureTypes])
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] CHECK CONSTRAINT [FK_vpv_votingConfigurations_vpv_ClosureTypes]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations]  WITH NOCHECK ADD  CONSTRAINT [FK_vpv_votingConfigurations_vpv_executionPlans] FOREIGN KEY([executionPlanId])
REFERENCES [dbo].[vpv_executionPlans] ([executionPlanId])
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] NOCHECK CONSTRAINT [FK_vpv_votingConfigurations_vpv_executionPlans]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingConfigurations_vpv_governmentConditions] FOREIGN KEY([governmentConditionId])
REFERENCES [dbo].[vpv_governmentConditions] ([governmentConditionId])
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] CHECK CONSTRAINT [FK_vpv_votingConfigurations_vpv_governmentConditions]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingConfigurations_vpv_MetricPerPlan] FOREIGN KEY([metricPlanId])
REFERENCES [dbo].[vpv_MetricPerPlan] ([metricPlanId])
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] CHECK CONSTRAINT [FK_vpv_votingConfigurations_vpv_MetricPerPlan]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingConfigurations_vpv_proposalVersions] FOREIGN KEY([proposalVersionId])
REFERENCES [dbo].[vpv_proposalVersions] ([proposalVersionId])
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] CHECK CONSTRAINT [FK_vpv_votingConfigurations_vpv_proposalVersions]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingConfigurations_vpv_reminderTypes] FOREIGN KEY([idReminderType])
REFERENCES [dbo].[vpv_reminderTypes] ([idReminderType])
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] CHECK CONSTRAINT [FK_vpv_votingConfigurations_vpv_reminderTypes]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingConfigurations_vpv_sponsorAgreements] FOREIGN KEY([sponsorAgreementId])
REFERENCES [dbo].[vpv_sponsorAgreements] ([sponsorAgreementId])
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] CHECK CONSTRAINT [FK_vpv_votingConfigurations_vpv_sponsorAgreements]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingConfigurations_vpv_statesVoting] FOREIGN KEY([idStatusVoting])
REFERENCES [dbo].[vpv_statusVoting] ([idStatusVoting])
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] CHECK CONSTRAINT [FK_vpv_votingConfigurations_vpv_statesVoting]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingConfigurations_vpv_votingReasons] FOREIGN KEY([idvotingReasons])
REFERENCES [dbo].[vpv_votingReasons] ([idvotingReasons])
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] CHECK CONSTRAINT [FK_vpv_votingConfigurations_vpv_votingReasons]
GO
ALTER TABLE [dbo].[vpv_votingConfigurations]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingConfigurations_vpv_votingTypes] FOREIGN KEY([idVotingType])
REFERENCES [dbo].[vpv_votingTypes] ([idVotingType])
GO
ALTER TABLE [dbo].[vpv_votingConfigurations] CHECK CONSTRAINT [FK_vpv_votingConfigurations_vpv_votingTypes]
GO
ALTER TABLE [dbo].[vpv_VotingPerRestrictions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VotingPerRestrictions_vpv_votingConfigurations] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_VotingPerRestrictions] CHECK CONSTRAINT [FK_vpv_VotingPerRestrictions_vpv_votingConfigurations]
GO
ALTER TABLE [dbo].[vpv_VotingPerRestrictions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VotingPerRestrictions_vpv_votingRestrictions] FOREIGN KEY([idRestrictions])
REFERENCES [dbo].[vpv_votingRestrictions] ([idRestrictions])
GO
ALTER TABLE [dbo].[vpv_VotingPerRestrictions] CHECK CONSTRAINT [FK_vpv_VotingPerRestrictions_vpv_votingRestrictions]
GO
ALTER TABLE [dbo].[vpv_votingQuestions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingQuestions_vpv_questions] FOREIGN KEY([idQuestion])
REFERENCES [dbo].[vpv_questions] ([idQuestion])
GO
ALTER TABLE [dbo].[vpv_votingQuestions] CHECK CONSTRAINT [FK_vpv_votingQuestions_vpv_questions]
GO
ALTER TABLE [dbo].[vpv_votingQuestions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingQuestions_vpv_votingConfigurations] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_votingQuestions] CHECK CONSTRAINT [FK_vpv_votingQuestions_vpv_votingConfigurations]
GO
ALTER TABLE [dbo].[vpv_votingRestrictions]  WITH CHECK ADD  CONSTRAINT [FK_vpv_votingRestrictions_vpv_votingRestrictionTypes] FOREIGN KEY([idVotingRestrictionTypes])
REFERENCES [dbo].[vpv_votingRestrictionTypes] ([idVotingRestrictionTypes])
GO
ALTER TABLE [dbo].[vpv_votingRestrictions] CHECK CONSTRAINT [FK_vpv_votingRestrictions_vpv_votingRestrictionTypes]
GO
ALTER TABLE [dbo].[vpv_VotingResultsSummary]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VotingResultsSummary_vpv_votingConfigurations] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_VotingResultsSummary] CHECK CONSTRAINT [FK_vpv_VotingResultsSummary_vpv_votingConfigurations]
GO
ALTER TABLE [dbo].[vpv_VotingResultsSummary]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VotingResultsSummary_vpv_VotingResultStatus] FOREIGN KEY([idVotingResultStatus])
REFERENCES [dbo].[vpv_VotingResultStatus] ([idVotingResultStatus])
GO
ALTER TABLE [dbo].[vpv_VotingResultsSummary] CHECK CONSTRAINT [FK_vpv_VotingResultsSummary_vpv_VotingResultStatus]
GO
ALTER TABLE [dbo].[vpv_VotingRules]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VotingRules_vpv_Rules] FOREIGN KEY([idRule])
REFERENCES [dbo].[vpv_Rules] ([idRule])
GO
ALTER TABLE [dbo].[vpv_VotingRules] CHECK CONSTRAINT [FK_vpv_VotingRules_vpv_Rules]
GO
ALTER TABLE [dbo].[vpv_VotingRules]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VotingRules_vpv_votingConfigurations] FOREIGN KEY([idVotingConfig])
REFERENCES [dbo].[vpv_votingConfigurations] ([idVotingConfig])
GO
ALTER TABLE [dbo].[vpv_VotingRules] CHECK CONSTRAINT [FK_vpv_VotingRules_vpv_votingConfigurations]
GO
ALTER TABLE [dbo].[vpv_VotingRuleSubType]  WITH CHECK ADD  CONSTRAINT [FK_vpv_VotingRuleSubType_vpv_UnitMeasure] FOREIGN KEY([idUnitMeasure])
REFERENCES [dbo].[vpv_UnitMeasure] ([idUnitMeasure])
GO
ALTER TABLE [dbo].[vpv_VotingRuleSubType] CHECK CONSTRAINT [FK_vpv_VotingRuleSubType_vpv_UnitMeasure]
GO
ALTER TABLE [dbo].[vpv_whitelistips]  WITH CHECK ADD  CONSTRAINT [FK_vpv_whitelistips_vpv_whitelists] FOREIGN KEY([whitelistid])
REFERENCES [dbo].[vpv_whitelists] ([whitelistid])
GO
ALTER TABLE [dbo].[vpv_whitelistips] CHECK CONSTRAINT [FK_vpv_whitelistips_vpv_whitelists]
GO
ALTER TABLE [dbo].[vpv_whitelists]  WITH CHECK ADD  CONSTRAINT [FK_vpv_whitelists_vpv_Countries] FOREIGN KEY([countryid])
REFERENCES [dbo].[vpv_Countries] ([idCountry])
GO
ALTER TABLE [dbo].[vpv_whitelists] CHECK CONSTRAINT [FK_vpv_whitelists_vpv_Countries]
GO
ALTER TABLE [dbo].[vpv_workflowsteps]  WITH CHECK ADD  CONSTRAINT [FK_vpv_workflowsteps_vpv_processtypes] FOREIGN KEY([processtypeid])
REFERENCES [dbo].[vpv_processtypes] ([processtypeid])
GO
ALTER TABLE [dbo].[vpv_workflowsteps] CHECK CONSTRAINT [FK_vpv_workflowsteps_vpv_processtypes]
GO
ALTER TABLE [dbo].[vpv_workflowsteps]  WITH CHECK ADD  CONSTRAINT [FK_vpv_workflowsteps_vpv_steptypes] FOREIGN KEY([steptypeid])
REFERENCES [dbo].[vpv_steptypes] ([steptypeid])
GO
ALTER TABLE [dbo].[vpv_workflowsteps] CHECK CONSTRAINT [FK_vpv_workflowsteps_vpv_steptypes]
GO
ALTER TABLE [dbo].[vpv_workresults]  WITH CHECK ADD  CONSTRAINT [FK_vpv_workresults_vpv_process] FOREIGN KEY([processid])
REFERENCES [dbo].[vpv_process] ([processid])
GO
ALTER TABLE [dbo].[vpv_workresults] CHECK CONSTRAINT [FK_vpv_workresults_vpv_process]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'vpv_requestvalidators', @level2type=N'COLUMN',@level2name=N'enable'
GO
