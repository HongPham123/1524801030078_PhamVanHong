USE [master]
GO
/****** Object:  Database [QUANLISHOWROOMXEHOI]    Script Date: 5/12/2019 5:40:09 PM ******/
CREATE DATABASE [QUANLISHOWROOMXEHOI]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QUANLISHOWROOMXEHOI', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QUANLISHOWROOMXEHOI.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QUANLISHOWROOMXEHOI_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QUANLISHOWROOMXEHOI_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QUANLISHOWROOMXEHOI].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET ARITHABORT OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET  MULTI_USER 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QUANLISHOWROOMXEHOI]
GO
/****** Object:  StoredProcedure [dbo].[Store_ProcDeleteCarById]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------
CREATE PROC [dbo].[Store_ProcDeleteCarById] @idCar int
AS
BEGIN

	IF NOT EXISTS (SELECT * FROM dbo.InstanceOfCar WHERE IDCar = @idCar)
		BEGIN
			DELETE dbo.SpecificDescriptionOfCar WHERE IDCar = @idCar
			DELETE dbo.Car WHERE id = @idCar
		END	
END

GO
/****** Object:  StoredProcedure [dbo].[Store_ProcInsertAccessoryAndInventoryOfAccessory]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----

CREATE PROC [dbo].[Store_ProcInsertAccessoryAndInventoryOfAccessory] @iDCar int , @accessoryName nvarchar(50) , @image varchar(50) , @unitPrice DECIMAL , @entryUnitPrice DECIMAL , @amount INT
AS
BEGIN

	INSERT dbo.AccessoryOfCar
	        ( IDCar ,
	          AccessoryName ,
	          Image ,
	          UnitPrice
	        )
	VALUES  ( @idCar , -- IDCar - int
	          @accessoryName , -- AccessoryName - nvarchar(50)
	         @image, -- Image - varchar(50)
	          @unitPrice  -- UnitPrice - decimal
	        )

	DECLARE @maxId INT

	SELECT @maxId = MAX(ID) FROM dbo.AccessoryOfCar
	
	INSERT dbo.InventoryOfAccessory
	        ( IDAccessory ,
	          WarehousingDate ,
	          EntryUnitPrice ,
	          Amount
	        )
	VALUES  ( @maxId , -- IDAccessory - int
	          GETDATE() , -- WarehousingDate - datetime
	          @entryUnitPrice , -- EntryUnitPrice - decimal
	          @amount  -- Amount - int
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[Store_ProcInsertNewSpec]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------
CREATE PROC [dbo].[Store_ProcInsertNewSpec] @idCar int
AS
BEGIN
	INSERT dbo.SpecificDescriptionOfCar
	        ( IDCar ,
	          TypeOfCar ,
	          NumberOfSeat ,
	          TypeOfEngine ,
	          Gear ,
	          CylinderCapacity ,
	          MaxPower ,
	          MaxMomen ,
	          FuelSystem ,
	          PetrolTankCapacity ,
	          UrbanConsumption ,
	          NonurbanConsumption ,
	          CombinationConsumption ,
	          FrontBrake ,
	          RearBrake ,
	          Length ,
	          Height ,
	          Width ,
	          Weight
	        )
	VALUES  ( @idCar , -- IDCar - int
	          N'' , -- TypeOfCar - nvarchar(25)
	          0 , -- NumberOfSeat - int
	          N'' , -- TypeOfEngine - nvarchar(50)
	          N'' , -- Gear - nvarchar(50)
	          '' , -- CylinderCapacity - varchar(15)
	          '' , -- MaxPower - varchar(30)
	          '' , -- MaxMomen - varchar(30)
	          N'' , -- FuelSystem - nvarchar(30)
	          '' , -- PetrolTankCapacity - varchar(10)
	          '' , -- UrbanConsumption - varchar(20)
	          '' , -- NonurbanConsumption - varchar(20)
	          '' , -- CombinationConsumption - varchar(20)
	          N'' , -- FrontBrake - nvarchar(25)
	          N'' , -- RearBrake - nvarchar(25)
	          N'' , -- Length - nvarchar(20)
	          N'' , -- Height - nvarchar(20)
	          N'' , -- Width - nvarchar(20)
	          N''  -- Weight - nvarchar(20)
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[StoreProc_AddAccessoryForBill]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------
create PROC [dbo].[StoreProc_AddAccessoryForBill] @idAccessory int , @accessoryName NVARCHAR(50) , @unitprice DECIMAL , @amount INT , @idBill INT
AS
BEGIN
	
	IF NOT EXISTS ( SELECT * FROM dbo.BillInfoDetails WHERE IDBill = @idBill AND IDAccessoryOfCar = @idAccessory)
		BEGIN
			INSERT dbo.BillInfoDetails
	        ( IDBill ,
	          IDInstanceOfCar ,
			  CarName,
	          IDAccessoryOfCar ,
			  AccessoryName,
	          UnitPrice ,
	          Amount ,
	          ValueOfPrice
	        )
			VALUES  ( @idBill , -- IDBill - int
	          null , -- IDInstanceOfCar - int
			  NULL,
	          @idAccessory , -- IDAccessoryOfCar - int
			  @accessoryName,
	          @unitprice , -- UnitPrice - decimal
	          @amount , -- Amount - int
	          @amount * @unitprice  -- ValueOfPrice - decimal
	        )
		END
            
	ELSE
		BEGIN
            UPDATE dbo.BillInfoDetails SET Amount += @amount  , ValueOfPrice += @amount * UnitPrice WHERE IDBill = @idBill AND IDAccessoryOfCar  = @idAccessory
		END
            
	UPDATE dbo.AccessoryOfCar SET Amount -= @amount WHERE ID = @idAccessory

	UPDATE dbo.Bill SET ValueOfBill += @amount*@unitprice  WHERE ID = @idbill

END

GO
/****** Object:  StoredProcedure [dbo].[StoreProc_AddCarForBill]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-----------------
create PROC [dbo].[StoreProc_AddCarForBill] @idCar int , @carName NVARCHAR(50) , @price DECIMAL , @idBill INT , @idCustomer int
AS
BEGIN

	IF not EXISTS ( SELECT * FROM dbo.InstanceOfCar WHERE ID = @idCar AND ( Status = 0 OR IDOwnedCustomer != 0))
	begin
	INSERT dbo.BillInfoDetails
	        ( IDBill ,
	          IDInstanceOfCar ,
			  CarName,
	          IDAccessoryOfCar ,
			  AccessoryName,
	          UnitPrice ,
			  Amount,
	          ValueOfPrice
	        )
	VALUES  ( @idBill , -- IDBill - int
	          @idCar , -- IDInstanceOfCar - int
			  @carName,
	          NULL , -- IDAccessoryOfCar - int
			  NULL,
	          @price , -- UnitPrice - decimal
			  1,
	          @price  -- ValueOfPrice - decimal
	        )

	UPDATE dbo.InstanceOfCar SET IDOwnedCustomer = @idCustomer WHERE ID = @idCar

	UPDATE dbo.Bill SET ValueOfBill += @price WHERE ID = @idbill

	end
END

GO
/****** Object:  StoredProcedure [dbo].[StoreProc_DeleteAccessoryById]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------
CREATE PROC [dbo].[StoreProc_DeleteAccessoryById] @id int
AS
BEGIN

	DELETE dbo.InventoryOfAccessory WHERE IDAccessory = @id
	DELETE dbo.AccessoryOfCar WHERE ID =@id

END
EXEC dbo.StoreProc_GetAccessoryByCarId @idCar = 1 -- int

GO
/****** Object:  StoredProcedure [dbo].[StoreProc_GetAccessoryByCarId]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------
CREATE PROC [dbo].[StoreProc_GetAccessoryByCarId] @idCar INT
AS
BEGIN

	SELECT AccessoryOfCar.ID,AccessoryName,Image,UnitPrice,Amount AS sumamount
	FROM dbo.AccessoryOfCar 
	WHERE IDCar = @idCar
END

GO
/****** Object:  StoredProcedure [dbo].[StoreProc_GetAccountByUsername]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------
CREATE PROC [dbo].[StoreProc_GetAccountByUsername] @userName Nvarchar(100)
AS
begin
	SELECT * FROM dbo.Account WHERE UserName = @username
END

GO
/****** Object:  StoredProcedure [dbo].[StoreProc_GetInfoDetailsOfCarById]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


---------------
CREATE PROC [dbo].[StoreProc_GetInfoDetailsOfCarById] @idCar int 
AS
BEGIN
	SELECT *
	FROM dbo.SpecificDescriptionOfCar
	WHERE IDCar = @idCar
 END

GO
/****** Object:  StoredProcedure [dbo].[StoreProc_InsertInstanceOfCar]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------
CREATE PROC [dbo].[StoreProc_InsertInstanceOfCar] @iDCar int , @color nvarchar(20) , @imageOfInstance varchar(100) , @chassisNumber varchar(15) , @machineNumber varchar(15) , @entryPrice decimal , @price decimal
AS
BEGIN

	INSERT dbo.InstanceOfCar
	        ( IDCar ,
	          WarehousingDate ,
	          Color ,
	          ImageOfInstance ,
	          ChassisNumber ,
	          MachineNumber ,
	          EntryPrice ,
	          Price ,
	          Status ,
	          IDOwnedCustomer
	        )
	VALUES  ( @idCar , -- IDCar - int
	          GETDATE() , -- WarehousingDate - datetime
	          @color , -- Color - nvarchar(20)
	          @imageOfInstance , -- ImageOfInstance - varchar(100)
	          @chassisNumber , -- ChassisNumber - varchar(15)
	          @machineNumber , -- MachineNumber - varchar(15)
	          @entryPrice , -- EntryPrice - decimal
	          @price , -- Price - decimal
	          1 , -- Status - int
	          0  -- IDOwnedCustomer - int
	        )

END

GO
/****** Object:  StoredProcedure [dbo].[StoreProc_Login]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------

CREATE PROC [dbo].[StoreProc_Login] @username nvarchar(100), @password nvarchar(500)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @username AND PassWord = @password
END

GO
/****** Object:  StoredProcedure [dbo].[StoreProc_PayTheBill]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------
CREATE PROC [dbo].[StoreProc_PayTheBill] @idBill int , @idStaff int
AS BEGIN
		
	update bill set status = 0 , IDStaff = @idStaff where id = @idBill

	UPDATE dbo.InstanceOfCar 
	SET Status = 0 
	WHERE ID IN (
				SELECT IDInstanceOfCar 
				FROM dbo.BillInfoDetails 
				WHERE IDBill = @idBill 
				AND IDInstanceOfCar IS NOT NULL
				)

end



SELECT * 
FROM dbo.AccessoryOfCar

SELECT * 
FROM dbo.InventoryOfAccessory

GO
/****** Object:  StoredProcedure [dbo].[StoreProc_UpdateCarById]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------
CREATE PROC [dbo].[StoreProc_UpdateCarById] @iD INT , @carName nvarchar(100) , @iDProducer  INT, @imageOfCar varchar(100)
AS
BEGIN
	
	UPDATE dbo.Car
	SET CarName = @carName, IDProducer = @iDProducer, ImageOfCar = @imageOfCar
	WHERE ID = @iD

END

EXEC dbo.StoreProc_UpdateCarById @iD , @carName , @iDProducer , @imageOfCar

GO
/****** Object:  StoredProcedure [dbo].[StoreProc_UpdateInstanceOfCarById]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------
CREATE PROC [dbo].[StoreProc_UpdateInstanceOfCarById] @iD int,  @iDCar int, @warehousingDate datetime,@color nvarchar(20),
	          @imageOfInstance varchar(100),@chassisNumber  varchar(15), @machineNumber varchar(15), @entryPrice decimal, @price  decimal
	          , @status  int,  @iDOwnedCustomer  int
AS
BEGIN
	UPDATE dbo.InstanceOfCar
	SET IDCar = @idCar, WarehousingDate = @warehousingDate, Color = @color, ImageOfInstance = @imageOfInstance, ChassisNumber = @chassisNumber,
	MachineNumber = @machineNumber, EntryPrice = @entryPrice, Price = @price, Status =@status, IDOwnedCustomer = @iDOwnedCustomer
	WHERE id = @id
END


GO
/****** Object:  StoredProcedure [dbo].[StoreProc_UpdateSpecificDescriptionOfCarById]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------
CREATE PROC [dbo].[StoreProc_UpdateSpecificDescriptionOfCarById] 
			  @idSpec INT , 
			  @TypeOfCar nvarchar(25),
	          @NumberOfSeat  int,
	          @TypeOfEngine nvarchar(50),
	          @Gear nvarchar(50),
	          @CylinderCapacity varchar(15),
	          @MaxPower varchar(30),
	          @MaxMomen varchar(30),
	          @FuelSystem nvarchar(30),
	          @PetrolTankCapacity  varchar(10),
	          @UrbanConsumption  varchar(20),
	          @NonurbanConsumption  varchar(20),
	          @CombinationConsumption  varchar(20),
	          @FrontBrake  nvarchar(25),
	          @RearBrake  nvarchar(25),
	          @Length  nvarchar(20),
	          @Height  nvarchar(20),
	          @Width nvarchar(20),
	          @Weight  nvarchar(20)
AS
BEGIN
	
	UPDATE dbo.SpecificDescriptionOfCar 
	SET TypeOfCar = @TypeOfCar, NumberOfSeat =@NumberOfSeat,TypeOfEngine =@TypeOfEngine,Gear =@Gear,CylinderCapacity=@CylinderCapacity,
		MaxPower=@MaxPower,MaxMomen=@MaxMomen,FuelSystem=@FuelSystem,PetrolTankCapacity=@PetrolTankCapacity,UrbanConsumption=@UrbanConsumption,
		NonurbanConsumption=@NonurbanConsumption,CombinationConsumption=@CombinationConsumption,FrontBrake=@FrontBrake,RearBrake=@RearBrake,
        Length=@Length,Height=@Height,Width=@Width,Weight=@Weight
	WHERE ID = @idSpec
END



GO
/****** Object:  Table [dbo].[AccessoryOfCar]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AccessoryOfCar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDCar] [int] NOT NULL,
	[AccessoryName] [nvarchar](50) NOT NULL,
	[Image] [varchar](50) NOT NULL,
	[UnitPrice] [decimal](18, 0) NOT NULL DEFAULT ((0)),
	[Amount] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Account]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[ID] [int] IDENTITY(0,1) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL DEFAULT (N'Chưa có tên.'),
	[UserName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](500) NOT NULL DEFAULT ('0'),
	[Type] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bill]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NOT NULL DEFAULT (getdate()),
	[IDCustomer] [int] NOT NULL,
	[IDStaff] [int] NULL DEFAULT ((0)),
	[ValueOfBill] [decimal](18, 0) NOT NULL,
	[Status] [int] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BillInfoDetails]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfoDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDBill] [int] NOT NULL,
	[IDInstanceOfCar] [int] NULL DEFAULT (NULL),
	[CarName] [nvarchar](100) NULL,
	[IDAccessoryOfCar] [int] NULL DEFAULT (NULL),
	[AccessoryName] [nvarchar](50) NULL,
	[UnitPrice] [decimal](18, 0) NOT NULL DEFAULT ((0)),
	[Amount] [int] NOT NULL DEFAULT ((1)),
	[ValueOfPrice] [decimal](18, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Car]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Car](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CarName] [nvarchar](100) NOT NULL DEFAULT (N'Chưa có tên.'),
	[IDProducer] [int] NOT NULL,
	[ImageOfCar] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomerInfo]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomerInfo](
	[ID] [int] IDENTITY(0,1) NOT NULL,
	[IdentityCardNumber] [varchar](10) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Sex] [int] NOT NULL DEFAULT ((1)),
	[Birthday] [date] NOT NULL,
	[NumberPhone] [varchar](11) NULL,
	[Address] [nvarchar](150) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[IdentityCardNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Guarantee]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Guarantee](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDCustomer] [int] NOT NULL,
	[IDInstanceOfCar] [int] NOT NULL,
	[GuaranteeDate] [datetime] NOT NULL DEFAULT (getdate()),
	[ContentOfGuarantee] [nvarchar](200) NOT NULL DEFAULT (N''),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InstanceOfCar]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InstanceOfCar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDCar] [int] NOT NULL,
	[WarehousingDate] [datetime] NOT NULL DEFAULT (getdate()),
	[Color] [nvarchar](20) NOT NULL,
	[ImageOfInstance] [varchar](100) NOT NULL,
	[ChassisNumber] [varchar](15) NOT NULL,
	[MachineNumber] [varchar](15) NOT NULL,
	[EntryPrice] [decimal](18, 0) NOT NULL DEFAULT ((0)),
	[Price] [decimal](18, 0) NOT NULL DEFAULT ((0)),
	[Status] [int] NOT NULL DEFAULT ((1)),
	[IDOwnedCustomer] [int] NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ChassisNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[MachineNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InventoryOfAccessory]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryOfAccessory](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDAccessory] [int] NOT NULL,
	[WarehousingDate] [datetime] NOT NULL DEFAULT (getdate()),
	[EntryUnitPrice] [decimal](18, 0) NOT NULL,
	[Amount] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderList]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[DeliveryDate] [datetime] NOT NULL,
	[IDCustomer] [int] NOT NULL,
	[IDInstanceOfCar] [int] NULL,
	[IDAccessoryOfCar] [int] NULL,
	[Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Producer]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Producer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProducerName] [nvarchar](30) NOT NULL DEFAULT (N'Chưa có tên.'),
	[Logo] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SpecificDescriptionOfCar]    Script Date: 5/12/2019 5:40:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SpecificDescriptionOfCar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDCar] [int] NOT NULL,
	[TypeOfCar] [nvarchar](25) NOT NULL,
	[NumberOfSeat] [int] NOT NULL DEFAULT ((0)),
	[TypeOfEngine] [nvarchar](50) NULL,
	[Gear] [nvarchar](50) NULL,
	[CylinderCapacity] [varchar](15) NULL,
	[MaxPower] [varchar](30) NULL,
	[MaxMomen] [varchar](30) NULL,
	[FuelSystem] [nvarchar](30) NULL,
	[PetrolTankCapacity] [varchar](10) NULL,
	[UrbanConsumption] [varchar](20) NULL,
	[NonurbanConsumption] [varchar](20) NULL,
	[CombinationConsumption] [varchar](20) NULL,
	[FrontBrake] [nvarchar](25) NULL,
	[RearBrake] [nvarchar](25) NULL,
	[Length] [nvarchar](20) NULL,
	[Height] [nvarchar](20) NULL,
	[Width] [nvarchar](20) NULL,
	[Weight] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[OrderList] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[OrderList] ADD  DEFAULT (getdate()) FOR [DeliveryDate]
GO
ALTER TABLE [dbo].[OrderList] ADD  DEFAULT (NULL) FOR [IDInstanceOfCar]
GO
ALTER TABLE [dbo].[OrderList] ADD  DEFAULT (NULL) FOR [IDAccessoryOfCar]
GO
ALTER TABLE [dbo].[OrderList] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[AccessoryOfCar]  WITH CHECK ADD FOREIGN KEY([IDCar])
REFERENCES [dbo].[Car] ([ID])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([IDStaff])
REFERENCES [dbo].[Account] ([ID])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([IDCustomer])
REFERENCES [dbo].[CustomerInfo] ([ID])
GO
ALTER TABLE [dbo].[BillInfoDetails]  WITH CHECK ADD FOREIGN KEY([IDAccessoryOfCar])
REFERENCES [dbo].[AccessoryOfCar] ([ID])
GO
ALTER TABLE [dbo].[BillInfoDetails]  WITH CHECK ADD FOREIGN KEY([IDBill])
REFERENCES [dbo].[Bill] ([ID])
GO
ALTER TABLE [dbo].[BillInfoDetails]  WITH CHECK ADD FOREIGN KEY([IDInstanceOfCar])
REFERENCES [dbo].[InstanceOfCar] ([ID])
GO
ALTER TABLE [dbo].[Car]  WITH CHECK ADD FOREIGN KEY([IDProducer])
REFERENCES [dbo].[Producer] ([ID])
GO
ALTER TABLE [dbo].[Guarantee]  WITH CHECK ADD FOREIGN KEY([IDCustomer])
REFERENCES [dbo].[CustomerInfo] ([ID])
GO
ALTER TABLE [dbo].[Guarantee]  WITH CHECK ADD FOREIGN KEY([IDInstanceOfCar])
REFERENCES [dbo].[InstanceOfCar] ([ID])
GO
ALTER TABLE [dbo].[InstanceOfCar]  WITH CHECK ADD FOREIGN KEY([IDCar])
REFERENCES [dbo].[Car] ([ID])
GO
ALTER TABLE [dbo].[InstanceOfCar]  WITH CHECK ADD FOREIGN KEY([IDOwnedCustomer])
REFERENCES [dbo].[CustomerInfo] ([ID])
GO
ALTER TABLE [dbo].[InventoryOfAccessory]  WITH CHECK ADD FOREIGN KEY([IDAccessory])
REFERENCES [dbo].[AccessoryOfCar] ([ID])
GO
ALTER TABLE [dbo].[OrderList]  WITH CHECK ADD FOREIGN KEY([IDAccessoryOfCar])
REFERENCES [dbo].[AccessoryOfCar] ([ID])
GO
ALTER TABLE [dbo].[OrderList]  WITH CHECK ADD FOREIGN KEY([IDCustomer])
REFERENCES [dbo].[CustomerInfo] ([ID])
GO
ALTER TABLE [dbo].[OrderList]  WITH CHECK ADD FOREIGN KEY([IDInstanceOfCar])
REFERENCES [dbo].[InstanceOfCar] ([ID])
GO
ALTER TABLE [dbo].[SpecificDescriptionOfCar]  WITH CHECK ADD FOREIGN KEY([IDCar])
REFERENCES [dbo].[Car] ([ID])
GO
USE [master]
GO
ALTER DATABASE [QUANLISHOWROOMXEHOI] SET  READ_WRITE 
GO
