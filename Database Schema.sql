USE [LoginDB]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 11/4/2019 4:30:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](50) NOT NULL,
	[CourseDescription] [nvarchar](max) NULL,
	[CourseNo] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 11/4/2019 4:30:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[InstructorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Mobile] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[Qualification] [nvarchar](50) NULL,
	[Experience] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentRegistration]    Script Date: 11/4/2019 4:30:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentRegistration](
	[RegistrationID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[RegistrationNo] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[ConfirmPassword] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_StudentRegistration] PRIMARY KEY CLUSTERED 
(
	[RegistrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddInstructor]    Script Date: 11/4/2019 4:30:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddInstructor]
@InstructorID int,
@Name nvarchar(50),
@Mobile nvarchar(50),
@Address nvarchar(100),
@City nvarchar(50),
@Qualification nvarchar(50),
@Experience nvarchar(50),
@Email nvarchar(50),
@Password nvarchar(50)
AS 
BEGIN

   INSERT INTO Instructor(Name,Mobile,Address,City,Qualification,Experience,Email,Password)
    VALUES(@Name,@Mobile,@Address,@City,@Qualification,@Experience,@Email,@Password)
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteInstructorByID]    Script Date: 11/4/2019 4:30:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteInstructorByID]
@InstructorID int
AS 

BEGIN
 DELETE FROM Instructor WHERE InstructorID=@InstructorID

END
GO
/****** Object:  StoredProcedure [dbo].[EditInstructor]    Script Date: 11/4/2019 4:30:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditInstructor]
@InstructorID int,
@Name nvarchar(50),
@Mobile nvarchar(50),
@Address nvarchar(100),
@City nvarchar(50),
@Qualification nvarchar(50),
@Experience nvarchar(50),
@Email nvarchar(50),
@Password nvarchar(50)
AS 
BEGIN
IF(@InstructorID>0)
   BEGIN
    UPDATE Instructor SET Name=@Name,Mobile=@Mobile,Address=@Address,City=@City,Qualification=@Qualification,Experience=@Experience,Email=@Email,Password=@Password
	WHERE InstructorID=@InstructorID
	 END
 END
GO
/****** Object:  StoredProcedure [dbo].[spRegisterUser]    Script Date: 11/4/2019 4:30:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spRegisterUser]
	@Name  NVARCHAR (50),
	@Address nvarchar(50),
	@City nvarchar(50),
	@RegistrationNo NVARCHAR (100),
	@Email   NVARCHAR (50),
	@Password   NVARCHAR (50),
	@ConfirmPassword NVARCHAR (50)

AS
	Begin
	Declare @count int
	Declare @ReturnCode int
	Select @count=Count(Email)
	from [StudentRegistration] where Email=@Email
	if @count > 0
	Begin 
		set @ReturnCode=-1
	End
	Else
	Begin 
		set @ReturnCode=1
		insert into [StudentRegistration] values(@Name,@Address,@City,@RegistrationNo,@Email,@Password,@ConfirmPassword)
	End
	select @ReturnCode as ReturnValue
	End
RETURN 0

GO
/****** Object:  StoredProcedure [dbo].[ViewAllInstructor]    Script Date: 11/4/2019 4:30:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewAllInstructor]
AS 

BEGIN
SELECT * FROM Instructor
END
GO
/****** Object:  StoredProcedure [dbo].[ViewInstructorByID]    Script Date: 11/4/2019 4:30:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewInstructorByID]
@InstructorID int
AS 

BEGIN
SELECT * FROM Instructor WHERE InstructorID=@InstructorID

END
GO
