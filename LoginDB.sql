USE [master]
GO
/****** Object:  Database [LoginDB]    Script Date: 5/27/2020 8:08:21 PM ******/
CREATE DATABASE [LoginDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LoginDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LoginDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'LoginDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\LoginDB_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [LoginDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LoginDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LoginDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LoginDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LoginDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LoginDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LoginDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [LoginDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LoginDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LoginDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LoginDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LoginDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LoginDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LoginDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LoginDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LoginDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LoginDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LoginDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LoginDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LoginDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LoginDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LoginDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LoginDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LoginDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LoginDB] SET RECOVERY FULL 
GO
ALTER DATABASE [LoginDB] SET  MULTI_USER 
GO
ALTER DATABASE [LoginDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LoginDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LoginDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LoginDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LoginDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [LoginDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fnPercent]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE function [dbo].[fnPercent](@intttlPresent int, @intstdid int , @sbjid nvarchar (50) , @insname nvarchar (50),@class nvarchar (50),@section nvarchar (50))
 returns decimal
 as
 begin
 declare @intPerct decimal
 declare @strPerct decimal
 select @intPerct=COUNT(at.AttendenceID) 
 from Attendence at
 JOIN ClassCourse cc ON at.ClassCourseID = cc.ClassCourseID 
 JOIN Class e ON e.ClassID = cc.ClassID 
 JOIN InstructorCourse i ON i.InstructorCourseID = cc.InstructorCourseID  
 JOIN Courses cr ON cr.CourseID = i.CourseID 
 JOIN Instructor ins ON ins.InstructorID = i.InstructorID

  where at.RegistrationID=@intstdid and cr.CourseName =@sbjid and ins.Name=@insname and e.ClassName=@class and e.Section=@section
 set @strPerct= @intttlPresent/@intPerct *100
 return @strperct
 end

GO
/****** Object:  Table [dbo].[Attendence]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendence](
	[AttendenceID] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationID] [int] NOT NULL,
	[ClassCourseID] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Attendence] PRIMARY KEY CLUSTERED 
(
	[AttendenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Class]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[ClassID] [int] IDENTITY(1,1) NOT NULL,
	[ClassName] [nvarchar](50) NULL,
	[StartTiming] [time](7) NULL,
	[Section] [nvarchar](50) NULL,
	[EndTiming] [time](7) NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClassCourse]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassCourse](
	[ClassID] [int] NOT NULL,
	[InstructorCourseID] [int] NOT NULL,
	[ClassCourseID] [int] IDENTITY(1,1) NOT NULL,
	[AssignedOn] [datetime] NULL,
 CONSTRAINT [PK_ClassCourse] PRIMARY KEY CLUSTERED 
(
	[ClassCourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Constraints]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Constraints](
	[CheckID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[CNIC] [nvarchar](50) NULL,
	[Mobile] [nvarchar](50) NULL,
	[Username] [nvarchar](50) NULL,
 CONSTRAINT [PK_EmailCheck] PRIMARY KEY CLUSTERED 
(
	[CheckID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CourseMaterial]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseMaterial](
	[UploadID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](50) NULL,
	[FileLocation] [nvarchar](150) NULL,
	[ClassCourseID] [int] NOT NULL,
 CONSTRAINT [PK_CourseMaterial] PRIMARY KEY CLUSTERED 
(
	[UploadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Courses]    Script Date: 5/27/2020 8:08:21 PM ******/
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
/****** Object:  Table [dbo].[CourseTest]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseTest](
	[QuestionID] [int] IDENTITY(1,1) NOT NULL,
	[ExamID] [int] NOT NULL,
	[Question] [nvarchar](max) NULL,
	[Option1] [nvarchar](100) NULL,
	[Option2] [nvarchar](100) NULL,
	[Option3] [nvarchar](100) NULL,
	[Option4] [nvarchar](100) NULL,
	[CorrectAnswer] [nvarchar](100) NULL,
 CONSTRAINT [PK_CourseTest] PRIMARY KEY CLUSTERED 
(
	[QuestionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Enrollment]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollment](
	[StudentEnrollmentID] [int] IDENTITY(1,1) NOT NULL,
	[ClassID] [int] NOT NULL,
	[RegistrationID] [int] NOT NULL,
	[AssignedOn] [datetime] NULL,
 CONSTRAINT [PK_Enrollment] PRIMARY KEY CLUSTERED 
(
	[StudentEnrollmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Exam]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[ExamID] [int] IDENTITY(1,1) NOT NULL,
	[ExamName] [nvarchar](50) NULL,
	[ExamDescription] [nvarchar](max) NULL,
	[ExamDate] [date] NULL,
	[ExamDuration] [int] NULL,
	[ExamMarks] [int] NULL,
	[ClassCourseID] [int] NOT NULL,
	[ExamPassingMarks] [int] NULL,
 CONSTRAINT [PK_Exam] PRIMARY KEY CLUSTERED 
(
	[ExamID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Fee]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fee](
	[FeeID] [int] IDENTITY(1,1) NOT NULL,
	[ClassID] [int] NOT NULL,
	[TutionFee] [int] NOT NULL,
	[AdmissionFee] [int] NULL,
	[LibraryFee] [int] NULL,
	[BusFee] [int] NULL,
	[TotalFee] [int] NOT NULL,
 CONSTRAINT [PK_Fee] PRIMARY KEY CLUSTERED 
(
	[FeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Gaurdian]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gaurdian](
	[GaurdianID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NOT NULL,
	[Mobile] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Income] [int] NULL,
	[CNIC] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_Parent] PRIMARY KEY CLUSTERED 
(
	[GaurdianID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[InstructorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Mobile] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NOT NULL,
	[City] [nvarchar](50) NULL,
	[Qualification] [nvarchar](50) NOT NULL,
	[Experience] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InstructorCourse]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InstructorCourse](
	[CourseID] [int] NOT NULL,
	[InstructorID] [int] NOT NULL,
	[InstructorCourseID] [int] IDENTITY(1,1) NOT NULL,
	[AssignedOn] [datetime] NULL,
 CONSTRAINT [PK_InstructorCourse] PRIMARY KEY CLUSTERED 
(
	[InstructorCourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Messages]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[Susername] [nvarchar](50) NULL,
	[Dusername] [nvarchar](50) NULL,
	[Message] [nvarchar](max) NULL,
	[Placed] [nvarchar](50) NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Result]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Result](
	[ResultID] [int] IDENTITY(1,1) NOT NULL,
	[ResultStatus] [nvarchar](50) NULL,
	[ResultScore] [float] NULL,
	[TotalQuestion] [int] NULL,
	[ExamID] [int] NOT NULL,
	[RegistrationNo] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Result] PRIMARY KEY CLUSTERED 
(
	[ResultID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentParent]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentParent](
	[RegistrationID] [int] NOT NULL,
	[GaurdianID] [int] NOT NULL,
	[RelationshipType] [nvarchar](50) NOT NULL,
	[StudentParentID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_StudentParent] PRIMARY KEY CLUSTERED 
(
	[StudentParentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StudentRegistration]    Script Date: 5/27/2020 8:08:21 PM ******/
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
	[Username] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_StudentRegistration] PRIMARY KEY CLUSTERED 
(
	[RegistrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TakeFee]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TakeFee](
	[FeeID] [int] NOT NULL,
	[StudentParentID] [int] NOT NULL,
	[TakeFeeID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_TakeFee] PRIMARY KEY CLUSTERED 
(
	[TakeFeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblResetPasswordStudentRequests]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblResetPasswordStudentRequests](
	[Id] [uniqueidentifier] NOT NULL,
	[RegistrationID] [int] NULL,
	[ResetRequestDateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Attendence] ON 

INSERT [dbo].[Attendence] ([AttendenceID], [RegistrationID], [ClassCourseID], [Status], [Date]) VALUES (45, 3, 1, 2, CAST(N'2020-01-24 00:00:00.000' AS DateTime))
INSERT [dbo].[Attendence] ([AttendenceID], [RegistrationID], [ClassCourseID], [Status], [Date]) VALUES (46, 4, 1, 2, CAST(N'2020-01-24 00:00:00.000' AS DateTime))
INSERT [dbo].[Attendence] ([AttendenceID], [RegistrationID], [ClassCourseID], [Status], [Date]) VALUES (48, 3, 1, 1, CAST(N'2020-05-20 00:00:00.000' AS DateTime))
INSERT [dbo].[Attendence] ([AttendenceID], [RegistrationID], [ClassCourseID], [Status], [Date]) VALUES (49, 4, 1, 2, CAST(N'2020-05-20 00:00:00.000' AS DateTime))
INSERT [dbo].[Attendence] ([AttendenceID], [RegistrationID], [ClassCourseID], [Status], [Date]) VALUES (50, 1002, 2, 1, CAST(N'2020-05-20 00:00:00.000' AS DateTime))
INSERT [dbo].[Attendence] ([AttendenceID], [RegistrationID], [ClassCourseID], [Status], [Date]) VALUES (51, 3, 4, 2, CAST(N'2020-05-20 00:00:00.000' AS DateTime))
INSERT [dbo].[Attendence] ([AttendenceID], [RegistrationID], [ClassCourseID], [Status], [Date]) VALUES (52, 4, 4, 1, CAST(N'2020-05-20 00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Attendence] OFF
SET IDENTITY_INSERT [dbo].[Class] ON 

INSERT [dbo].[Class] ([ClassID], [ClassName], [StartTiming], [Section], [EndTiming]) VALUES (2, N'One', CAST(N'08:00:00' AS Time), N'A', CAST(N'13:00:00' AS Time))
INSERT [dbo].[Class] ([ClassID], [ClassName], [StartTiming], [Section], [EndTiming]) VALUES (3, N'One', CAST(N'08:02:00' AS Time), N'B', CAST(N'13:00:00' AS Time))
INSERT [dbo].[Class] ([ClassID], [ClassName], [StartTiming], [Section], [EndTiming]) VALUES (6, N'One', CAST(N'08:00:00' AS Time), N'C', CAST(N'12:00:00' AS Time))
SET IDENTITY_INSERT [dbo].[Class] OFF
SET IDENTITY_INSERT [dbo].[ClassCourse] ON 

INSERT [dbo].[ClassCourse] ([ClassID], [InstructorCourseID], [ClassCourseID], [AssignedOn]) VALUES (2, 1, 1, CAST(N'2019-11-25 17:05:00.000' AS DateTime))
INSERT [dbo].[ClassCourse] ([ClassID], [InstructorCourseID], [ClassCourseID], [AssignedOn]) VALUES (3, 1, 2, CAST(N'2019-11-22 05:09:00.000' AS DateTime))
INSERT [dbo].[ClassCourse] ([ClassID], [InstructorCourseID], [ClassCourseID], [AssignedOn]) VALUES (2, 5, 4, CAST(N'2020-01-01 01:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[ClassCourse] OFF
SET IDENTITY_INSERT [dbo].[Constraints] ON 

INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (1017, N'mariam@gmail.com', NULL, NULL, N'mariam')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (1018, N'amjad@gmail.com', NULL, N'0300-9456175', N'amjad')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (1020, N'khadija@gmail.com', NULL, NULL, N'khadija')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (1021, N'asma@gmail.com', NULL, NULL, N'asma')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2016, N'salmansaeedbutt1@outlook.com', NULL, NULL, N'salman')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2018, N'samyanwahla@gmail.com', NULL, N'0300-9456179', N'samyan1')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2019, N'fatimasaeed@gmail.com', NULL, NULL, N'fatima')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2020, N'zain@gmail.com', NULL, NULL, N'zain')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2021, N'amjad1@gmail.com', NULL, N'0300-9456175', N'amjad1')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2022, N'farva@gmail.com', NULL, NULL, N'farva1')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2023, N'abeera@gmail.com', NULL, NULL, N'abeera1')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2026, N'samyanwahla@gmail.com', NULL, N'03009456179', N'Jamil1')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2027, N'samyanwahla@gmail.com', NULL, N'03009456179', N'Samyan1')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2028, N'amjad1@gmail.com', NULL, N'03009456175', N'Samyan1')
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2029, N'saeed@gmail.com', N'3520193792614', N'03009456175', NULL)
INSERT [dbo].[Constraints] ([CheckID], [Email], [CNIC], [Mobile], [Username]) VALUES (2030, N'amjad1@gmail.com', NULL, N'03009456175', N'Amjad1')
SET IDENTITY_INSERT [dbo].[Constraints] OFF
SET IDENTITY_INSERT [dbo].[CourseMaterial] ON 

INSERT [dbo].[CourseMaterial] ([UploadID], [FileName], [FileLocation], [ClassCourseID]) VALUES (9, N'check', N'CourseRelatedStuff/SALMAN SYNOPSIS.pdf', 1)
SET IDENTITY_INSERT [dbo].[CourseMaterial] OFF
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([CourseID], [CourseName], [CourseDescription], [CourseNo]) VALUES (6, N'DBMS', N'aaa', N'CSE-141')
INSERT [dbo].[Courses] ([CourseID], [CourseName], [CourseDescription], [CourseNo]) VALUES (9, N'Software Engineering', N'This is SE Course', N'CSE-765')
SET IDENTITY_INSERT [dbo].[Courses] OFF
SET IDENTITY_INSERT [dbo].[CourseTest] ON 

INSERT [dbo].[CourseTest] ([QuestionID], [ExamID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer]) VALUES (2, 3, N'1+1=', N'2', N'4', N'6', N'7', N'1')
INSERT [dbo].[CourseTest] ([QuestionID], [ExamID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer]) VALUES (3, 3, N'what is Pakistan?', N'Country', N'City', N'Subcontinent', N'None of Above', N'1')
INSERT [dbo].[CourseTest] ([QuestionID], [ExamID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer]) VALUES (4, 3, N' What is Islam?', N' Thing', N' Religion', N' Place', N' All', N'2')
INSERT [dbo].[CourseTest] ([QuestionID], [ExamID], [Question], [Option1], [Option2], [Option3], [Option4], [CorrectAnswer]) VALUES (1002, 5, N'Islam is a ', N'Religion', N'Cast', N'Creed', N'None of the above', N'1')
SET IDENTITY_INSERT [dbo].[CourseTest] OFF
SET IDENTITY_INSERT [dbo].[Enrollment] ON 

INSERT [dbo].[Enrollment] ([StudentEnrollmentID], [ClassID], [RegistrationID], [AssignedOn]) VALUES (12, 2, 3, CAST(N'2019-11-15 10:31:00.000' AS DateTime))
INSERT [dbo].[Enrollment] ([StudentEnrollmentID], [ClassID], [RegistrationID], [AssignedOn]) VALUES (1008, 3, 1002, CAST(N'2019-12-08 08:54:00.000' AS DateTime))
INSERT [dbo].[Enrollment] ([StudentEnrollmentID], [ClassID], [RegistrationID], [AssignedOn]) VALUES (1009, 2, 4, CAST(N'2020-01-23 21:31:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Enrollment] OFF
SET IDENTITY_INSERT [dbo].[Exam] ON 

INSERT [dbo].[Exam] ([ExamID], [ExamName], [ExamDescription], [ExamDate], [ExamDuration], [ExamMarks], [ClassCourseID], [ExamPassingMarks]) VALUES (3, N'Math Test For Class One', N',,,,,,,mmmmmmmmmmmmmmmmk', CAST(N'2020-01-15' AS Date), 10, 10, 1, 5)
INSERT [dbo].[Exam] ([ExamID], [ExamName], [ExamDescription], [ExamDate], [ExamDuration], [ExamMarks], [ClassCourseID], [ExamPassingMarks]) VALUES (5, N'One Class Test For SE', N'This is Sample Test', CAST(N'2020-01-01' AS Date), 10, 10, 4, 5)
SET IDENTITY_INSERT [dbo].[Exam] OFF
SET IDENTITY_INSERT [dbo].[Fee] ON 

INSERT [dbo].[Fee] ([FeeID], [ClassID], [TutionFee], [AdmissionFee], [LibraryFee], [BusFee], [TotalFee]) VALUES (6, 3, 10000, 5000, 500, 300, 15800)
SET IDENTITY_INSERT [dbo].[Fee] OFF
SET IDENTITY_INSERT [dbo].[Gaurdian] ON 

INSERT [dbo].[Gaurdian] ([GaurdianID], [Name], [Address], [Mobile], [City], [Income], [CNIC], [Email], [Password]) VALUES (3, N'Saeed', N'house#1,nafeerabad,shalimar town', N'03009456175', N'Lahore', 20000, N'3520193792614', N'saeed@gmail.com', N'S@eed123')
SET IDENTITY_INSERT [dbo].[Gaurdian] OFF
SET IDENTITY_INSERT [dbo].[Instructor] ON 

INSERT [dbo].[Instructor] ([InstructorID], [Name], [Mobile], [Address], [City], [Qualification], [Experience], [Email], [Password], [Username]) VALUES (2, N'Amjad Farooq', N'03009456175', N'house#2,staff colony,UET', N'Lahore', N'MS Software Engineering', N'1 years', N'amjad1@gmail.com', N'M@riam123', N'Amjad1')
INSERT [dbo].[Instructor] ([InstructorID], [Name], [Mobile], [Address], [City], [Qualification], [Experience], [Email], [Password], [Username]) VALUES (1002, N'Samyan', N'03009456179', N'House#2,Street # 4, Walled City', N'Lahore', N'MS Software Engineering', N'1 years', N'samyanwahla@gmail.com', N'S@myan123', N'Samyan1')
SET IDENTITY_INSERT [dbo].[Instructor] OFF
SET IDENTITY_INSERT [dbo].[InstructorCourse] ON 

INSERT [dbo].[InstructorCourse] ([CourseID], [InstructorID], [InstructorCourseID], [AssignedOn]) VALUES (6, 2, 1, CAST(N'2019-11-22 10:55:00.000' AS DateTime))
INSERT [dbo].[InstructorCourse] ([CourseID], [InstructorID], [InstructorCourseID], [AssignedOn]) VALUES (9, 2, 5, CAST(N'2020-01-01 01:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[InstructorCourse] OFF
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (1, N'amjad1', N'mariam', N'Hello Mariam How are you?', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (2, N'amjad1', N'khadija', N'hello', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (3, N'mariam', N'amjad1', N'Hello', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (4, N'mariam', N'amjad1', N'How are you sir?', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (5, N'mariam', N'amjad1', N'i have some question? are you available?', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (6, N'amjad1', N'mariam', N'yes i am', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (7, N'amjad1', N'mariam', N'hi there', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (8, N'mariam', N'amjad1', N'hello sir', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (9, N'amjad1', N'mariam', N'hjahjshjhs sir', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (10, N'mariam', N'amjad1', N'hello', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (11, N'amjad1', N'mariam', N'kya haal hy?', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (12, N'amjad1', N'mariam', N'skjskks', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (13, N'mariam', N'amjad1', N'hey', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (14, N'amjad1', N'mariam', N'jkjk', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (15, N'mariam', N'amjad1', N'hi', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (16, N'amjad1', N'mariam', N'hi', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (17, N'mariam', N'amjad1', N'hello sir  i am checking', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (18, N'amjad1', N'mariam', N'oky', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (19, N'amjad1', N'mariam', N'hello', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (20, N'mariam', N'amjad1', N'hihsdi', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (21, N'amjad1', N'mariam', N'how are you', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (22, N'mariam', N'amjad1', N'hi sir', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (23, N'mariam', N'amjad1', N'Hello Sir!!!', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (24, N'amjad1', N'mariam', N'Hi Mariam', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (25, N'mariam', N'amjad1', N'.,.,.,.,.', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (26, N'mariam', N'amjad1', N'jkjkjkjkjk', N'yes')
INSERT [dbo].[Messages] ([MessageID], [Susername], [Dusername], [Message], [Placed]) VALUES (27, N'amjad1', N'mariam', N'what happened', N'yes')
SET IDENTITY_INSERT [dbo].[Messages] OFF
SET IDENTITY_INSERT [dbo].[Result] ON 

INSERT [dbo].[Result] ([ResultID], [ResultStatus], [ResultScore], [TotalQuestion], [ExamID], [RegistrationNo]) VALUES (1, N'Pass', 10, 3, 3, N'2016-CS-368')
INSERT [dbo].[Result] ([ResultID], [ResultStatus], [ResultScore], [TotalQuestion], [ExamID], [RegistrationNo]) VALUES (2, N'Pass', 10, 3, 3, N'2016-CS-377')
INSERT [dbo].[Result] ([ResultID], [ResultStatus], [ResultScore], [TotalQuestion], [ExamID], [RegistrationNo]) VALUES (3, N'Pass', 10, 1, 5, N'2016-CS-368')
SET IDENTITY_INSERT [dbo].[Result] OFF
SET IDENTITY_INSERT [dbo].[StudentParent] ON 

INSERT [dbo].[StudentParent] ([RegistrationID], [GaurdianID], [RelationshipType], [StudentParentID]) VALUES (3, 3, N'Father', 5)
SET IDENTITY_INSERT [dbo].[StudentParent] OFF
SET IDENTITY_INSERT [dbo].[StudentRegistration] ON 

INSERT [dbo].[StudentRegistration] ([RegistrationID], [Name], [Address], [City], [RegistrationNo], [Email], [Password], [ConfirmPassword], [Username]) VALUES (3, N'Mariam', N'house#1,nafeerabad,shalimar town', N'Lahore', N'2016-CS-368', N'mariamsaeedbutt423@gmail.com', N'M@riam123', N'M@riam123', N'mariam')
INSERT [dbo].[StudentRegistration] ([RegistrationID], [Name], [Address], [City], [RegistrationNo], [Email], [Password], [ConfirmPassword], [Username]) VALUES (4, N'Khadija', N' House#5,Model Town', N'Lahore', N'2016-CS-377', N'khadija@gmail.com', N'Kh@dija123', N'Kh@dija123', N'khadija')
INSERT [dbo].[StudentRegistration] ([RegistrationID], [Name], [Address], [City], [RegistrationNo], [Email], [Password], [ConfirmPassword], [Username]) VALUES (5, N'Asma', N'House#2,Street # 4, Walled City', N'Lahore', N'2016-CS-372', N'asma@gmail.com', N'Asm@123', N'Asm@123', N'asma')
INSERT [dbo].[StudentRegistration] ([RegistrationID], [Name], [Address], [City], [RegistrationNo], [Email], [Password], [ConfirmPassword], [Username]) VALUES (1002, N'Salman', N'House#4,UET Staff Colony', N'Lahore', N'2016-CS-390', N'salmansaeedbutt1@outlook.com', N'S@lman123', N'S@lman123', N'salman')
INSERT [dbo].[StudentRegistration] ([RegistrationID], [Name], [Address], [City], [RegistrationNo], [Email], [Password], [ConfirmPassword], [Username]) VALUES (1003, N'Fatima', N'house#1,nafeerabad,shalimar town', N'Lahore', N'2016-CS-310', N'fatimasaeed@gmail.com', N'F@tima123', N'F@tima123', N'fatima')
INSERT [dbo].[StudentRegistration] ([RegistrationID], [Name], [Address], [City], [RegistrationNo], [Email], [Password], [ConfirmPassword], [Username]) VALUES (1004, N'zain', N'house#2,staff colony,UET', N'Lahore', N'2016-CS-400', N'zain@gmail.com', N'Z@in123', N'Z@in123', N'zain')
INSERT [dbo].[StudentRegistration] ([RegistrationID], [Name], [Address], [City], [RegistrationNo], [Email], [Password], [ConfirmPassword], [Username]) VALUES (1005, N'farva', N'house#2,staff colony,UET', N'Lahore', N'2016-CS-401', N'farva@gmail.com', N'F@rva123', N'F@rva123', N'farva1')
INSERT [dbo].[StudentRegistration] ([RegistrationID], [Name], [Address], [City], [RegistrationNo], [Email], [Password], [ConfirmPassword], [Username]) VALUES (1006, N'Abeera', N'house#2,staff colony,UET', N'Lahore', N'2016-CS-409', N'abeera@gmail.com', N'Abeer@123', N'Abeer@123', N'abeera1')
SET IDENTITY_INSERT [dbo].[StudentRegistration] OFF
SET IDENTITY_INSERT [dbo].[TakeFee] ON 

INSERT [dbo].[TakeFee] ([FeeID], [StudentParentID], [TakeFeeID], [Date]) VALUES (6, 5, 2, CAST(N'2020-01-01 13:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[TakeFee] OFF
INSERT [dbo].[tblResetPasswordStudentRequests] ([Id], [RegistrationID], [ResetRequestDateTime]) VALUES (N'c3a1cb43-d182-4d92-b18d-0c2f5a8b1ab3', 3, CAST(N'2019-11-15 20:03:11.740' AS DateTime))
INSERT [dbo].[tblResetPasswordStudentRequests] ([Id], [RegistrationID], [ResetRequestDateTime]) VALUES (N'4f5f3478-874c-4b6a-9c44-2207c78f596e', 3, CAST(N'2019-11-15 20:09:57.483' AS DateTime))
INSERT [dbo].[tblResetPasswordStudentRequests] ([Id], [RegistrationID], [ResetRequestDateTime]) VALUES (N'4dbd7840-452b-4ec7-8d53-275b47d26746', 3, CAST(N'2019-11-15 19:08:43.757' AS DateTime))
INSERT [dbo].[tblResetPasswordStudentRequests] ([Id], [RegistrationID], [ResetRequestDateTime]) VALUES (N'af8bef3c-607f-43f4-b983-3ef29a83643a', 3, CAST(N'2019-11-15 18:51:12.370' AS DateTime))
INSERT [dbo].[tblResetPasswordStudentRequests] ([Id], [RegistrationID], [ResetRequestDateTime]) VALUES (N'5dbada5f-e2ed-4e0e-bab7-e6a6e1b2bf5a', 3, CAST(N'2019-11-25 09:57:53.627' AS DateTime))
INSERT [dbo].[tblResetPasswordStudentRequests] ([Id], [RegistrationID], [ResetRequestDateTime]) VALUES (N'8837418c-7271-4eeb-806b-ee9d18a847cb', 3, CAST(N'2019-11-15 18:55:45.347' AS DateTime))
ALTER TABLE [dbo].[Attendence]  WITH CHECK ADD  CONSTRAINT [FK_Attendence_ClassCourse] FOREIGN KEY([ClassCourseID])
REFERENCES [dbo].[ClassCourse] ([ClassCourseID])
GO
ALTER TABLE [dbo].[Attendence] CHECK CONSTRAINT [FK_Attendence_ClassCourse]
GO
ALTER TABLE [dbo].[Attendence]  WITH CHECK ADD  CONSTRAINT [FK_Attendence_StudentRegistration] FOREIGN KEY([RegistrationID])
REFERENCES [dbo].[StudentRegistration] ([RegistrationID])
GO
ALTER TABLE [dbo].[Attendence] CHECK CONSTRAINT [FK_Attendence_StudentRegistration]
GO
ALTER TABLE [dbo].[ClassCourse]  WITH CHECK ADD  CONSTRAINT [FK_ClassCourse_Class] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[ClassCourse] CHECK CONSTRAINT [FK_ClassCourse_Class]
GO
ALTER TABLE [dbo].[ClassCourse]  WITH CHECK ADD  CONSTRAINT [FK_ClassCourse_InstructorCourse] FOREIGN KEY([InstructorCourseID])
REFERENCES [dbo].[InstructorCourse] ([InstructorCourseID])
GO
ALTER TABLE [dbo].[ClassCourse] CHECK CONSTRAINT [FK_ClassCourse_InstructorCourse]
GO
ALTER TABLE [dbo].[CourseMaterial]  WITH CHECK ADD  CONSTRAINT [FK_CourseMaterial_ClassCourse] FOREIGN KEY([ClassCourseID])
REFERENCES [dbo].[ClassCourse] ([ClassCourseID])
GO
ALTER TABLE [dbo].[CourseMaterial] CHECK CONSTRAINT [FK_CourseMaterial_ClassCourse]
GO
ALTER TABLE [dbo].[CourseTest]  WITH CHECK ADD  CONSTRAINT [FK_CourseTest_Exam] FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ExamID])
GO
ALTER TABLE [dbo].[CourseTest] CHECK CONSTRAINT [FK_CourseTest_Exam]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Class] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Class]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_StudentRegistration] FOREIGN KEY([RegistrationID])
REFERENCES [dbo].[StudentRegistration] ([RegistrationID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_StudentRegistration]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_ClassCourse] FOREIGN KEY([ClassCourseID])
REFERENCES [dbo].[ClassCourse] ([ClassCourseID])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_ClassCourse]
GO
ALTER TABLE [dbo].[Fee]  WITH CHECK ADD  CONSTRAINT [FK_Fee_Class] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[Fee] CHECK CONSTRAINT [FK_Fee_Class]
GO
ALTER TABLE [dbo].[InstructorCourse]  WITH CHECK ADD  CONSTRAINT [FK_InstructorCourse_Courses] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
GO
ALTER TABLE [dbo].[InstructorCourse] CHECK CONSTRAINT [FK_InstructorCourse_Courses]
GO
ALTER TABLE [dbo].[InstructorCourse]  WITH CHECK ADD  CONSTRAINT [FK_InstructorCourse_Instructor] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([InstructorID])
GO
ALTER TABLE [dbo].[InstructorCourse] CHECK CONSTRAINT [FK_InstructorCourse_Instructor]
GO
ALTER TABLE [dbo].[Result]  WITH CHECK ADD  CONSTRAINT [FK_Result_Exam] FOREIGN KEY([ExamID])
REFERENCES [dbo].[Exam] ([ExamID])
GO
ALTER TABLE [dbo].[Result] CHECK CONSTRAINT [FK_Result_Exam]
GO
ALTER TABLE [dbo].[StudentParent]  WITH CHECK ADD  CONSTRAINT [FK_StudentParent_Gaurdian] FOREIGN KEY([GaurdianID])
REFERENCES [dbo].[Gaurdian] ([GaurdianID])
GO
ALTER TABLE [dbo].[StudentParent] CHECK CONSTRAINT [FK_StudentParent_Gaurdian]
GO
ALTER TABLE [dbo].[StudentParent]  WITH CHECK ADD  CONSTRAINT [FK_StudentParent_StudentRegistration] FOREIGN KEY([RegistrationID])
REFERENCES [dbo].[StudentRegistration] ([RegistrationID])
GO
ALTER TABLE [dbo].[StudentParent] CHECK CONSTRAINT [FK_StudentParent_StudentRegistration]
GO
ALTER TABLE [dbo].[TakeFee]  WITH CHECK ADD  CONSTRAINT [FK_TakeFee_Fee] FOREIGN KEY([FeeID])
REFERENCES [dbo].[Fee] ([FeeID])
GO
ALTER TABLE [dbo].[TakeFee] CHECK CONSTRAINT [FK_TakeFee_Fee]
GO
ALTER TABLE [dbo].[TakeFee]  WITH CHECK ADD  CONSTRAINT [FK_TakeFee_StudentParent] FOREIGN KEY([StudentParentID])
REFERENCES [dbo].[StudentParent] ([StudentParentID])
GO
ALTER TABLE [dbo].[TakeFee] CHECK CONSTRAINT [FK_TakeFee_StudentParent]
GO
ALTER TABLE [dbo].[tblResetPasswordStudentRequests]  WITH CHECK ADD FOREIGN KEY([RegistrationID])
REFERENCES [dbo].[StudentRegistration] ([RegistrationID])
GO
/****** Object:  StoredProcedure [dbo].[AddGaurdian]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[AddGaurdian]
@GaurdianID int,
@Name nvarchar(50),
@Address nvarchar(100),
@Mobile nvarchar(50),
@City nvarchar(50),
@Income nvarchar(50),
@CNIC nvarchar(50),
@Email nvarchar(50),
@Password nvarchar(50)
AS 
BEGIN

   INSERT INTO Gaurdian(Name,Address,Mobile,City,Income,CNIC,Email,Password)
    VALUES(@Name,@Address,@Mobile,@City,@Income,@CNIC,@Email,@Password)
END

GO
/****** Object:  StoredProcedure [dbo].[AddInstructor]    Script Date: 5/27/2020 8:08:21 PM ******/
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
@Password nvarchar(50),
@Username nvarchar(50)
AS 
BEGIN

   INSERT INTO Instructor(Name,Mobile,Address,City,Qualification,Experience,Email,Password,Username)
    VALUES(@Name,@Mobile,@Address,@City,@Qualification,@Experience,@Email,@Password,@Username)
END

GO
/****** Object:  StoredProcedure [dbo].[ClassCourseCreateOrUpdate]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ClassCourseCreateOrUpdate]
@ClassCourseID int,
@InstructorCourseID int,
@ClassID int,
@AssignedOn datetime
AS
BEGIN
IF(@ClassCourseID=0)
   BEGIN
   INSERT INTO ClassCourse(ClassID,InstructorCourseID,AssignedOn)
   VALUES(@ClassID,@InstructorCourseID,@AssignedOn)
   END
ELSE
   BEGIN
   Update ClassCourse
   SET
	  AssignedOn=@AssignedOn
	  WHERE ClassID=@ClassID AND ClassCourseID=@ClassCourseID AND InstructorCourseID=@InstructorCourseID
   END
END

GO
/****** Object:  StoredProcedure [dbo].[ClassCreateOrUpdate]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ClassCreateOrUpdate]
@ClassID int,
@ClassName nvarchar(50),
@StartTiming time(7),
@EndTiming time(7),
@Section nvarchar(50)
AS
BEGIN
IF(@ClassID=0)
   BEGIN
   INSERT INTO Class(ClassName,StartTiming,EndTiming,Section)
   VALUES(@ClassName,@StartTiming,@EndTiming,@Section)
   END
ELSE
   BEGIN
   Update Class
   SET
      ClassName=@ClassName,
	  StartTiming=@StartTiming,
	  EndTiming=@EndTiming,
	  Section=@Section
	  WHERE ClassID=@ClassID
   END
END

GO
/****** Object:  StoredProcedure [dbo].[ClassDeleteByID]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ClassDeleteByID]
@ClassID int
AS
      BEGIN
	  DELETE FROM Class
	  WHERE ClassID=@ClassID
      END


GO
/****** Object:  StoredProcedure [dbo].[ClassViewAll]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ClassViewAll]
AS 
   BEGIN
   SELECT *
   FROM Class
   END	

GO
/****** Object:  StoredProcedure [dbo].[ClassViewByID]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ClassViewByID]
@ClassID int
AS
	BEGIN
	SELECT *
	FROM Class
	Where ClassID=@ClassID
	END

GO
/****** Object:  StoredProcedure [dbo].[CourseCreateOrUpdate]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CourseCreateOrUpdate]
@CourseID int,
@CourseName nvarchar(50),
@CourseDescription nvarchar(max),
@CourseNo nvarchar(50)
AS
BEGIN
IF(@CourseID=0)
   BEGIN
   INSERT INTO Courses(CourseName,CourseDescription,CourseNo)
   VALUES(@CourseName,@CourseDescription,@CourseNo)
   END
ELSE
   BEGIN
   Update Courses
   SET
      CourseName=@CourseName,
	  CourseDescription=@CourseDescription,
	  CourseNo=@CourseNo
	  WHERE CourseID=@CourseID
   END
END

GO
/****** Object:  StoredProcedure [dbo].[CourseDeleteByID]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CourseDeleteByID]
@CourseID int
AS
      BEGIN
	  DELETE FROM Courses
	  WHERE CourseID=@CourseID
      END

GO
/****** Object:  StoredProcedure [dbo].[CourseViewAll]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CourseViewAll]
AS 
   BEGIN
   SELECT *
   FROM Courses
   END

GO
/****** Object:  StoredProcedure [dbo].[CourseViewByID]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CourseViewByID]
@CourseID int
AS
	BEGIN
	SELECT *
	FROM Courses
	Where CourseID=@CourseID
	END

GO
/****** Object:  StoredProcedure [dbo].[DeleteGaurdianByID]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteGaurdianByID]
@GaurdianID int
AS 

BEGIN
 DELETE FROM Gaurdian WHERE GaurdianID=@GaurdianID

END


GO
/****** Object:  StoredProcedure [dbo].[DeleteInstructorByID]    Script Date: 5/27/2020 8:08:21 PM ******/
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
/****** Object:  StoredProcedure [dbo].[EditGaurdian]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EditGaurdian]
@GaurdianID int,
@Name nvarchar(50),
@Address nvarchar(100),
@Mobile nvarchar(50),
@City nvarchar(50),
@Income nvarchar(50),
@CNIC nvarchar(50),
@Email nvarchar(50),
@Password nvarchar(50)
AS 
BEGIN
IF(@GaurdianID>0)
   BEGIN
    UPDATE Gaurdian SET Name=@Name,Address=@Address,Mobile=@Mobile,City=@City,Income=@Income,CNIC=@CNIC,Email=@Email,Password=@Password
	WHERE GaurdianID=@GaurdianID
	 END
 END

GO
/****** Object:  StoredProcedure [dbo].[EditInstructor]    Script Date: 5/27/2020 8:08:21 PM ******/
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
@Password nvarchar(50),
@Username nvarchar(50)
AS 
BEGIN
IF(@InstructorID>0)
   BEGIN
    UPDATE Instructor SET Name=@Name,Mobile=@Mobile,Address=@Address,City=@City,Qualification=@Qualification,Experience=@Experience,Email=@Email,Password=@Password,Username=@Username
	WHERE InstructorID=@InstructorID
	 END
 END

GO
/****** Object:  StoredProcedure [dbo].[EnrollmentCreateOrUpdate]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EnrollmentCreateOrUpdate]
@StudentEnrollmentID int,
@ClassID int,
@RegistrationID int,
@AssignedOn datetime
AS
BEGIN
IF(@StudentEnrollmentID=0)
   BEGIN
   INSERT INTO Enrollment(ClassID,RegistrationID,AssignedOn)
   VALUES(@ClassID,@RegistrationID,@AssignedOn)
   END
ELSE
   BEGIN
   Update Enrollment
   SET
	  AssignedOn=@AssignedOn
	  WHERE ClassID=@ClassID AND StudentEnrollmentID=@StudentEnrollmentID AND RegistrationID=@RegistrationID
   END
END

GO
/****** Object:  StoredProcedure [dbo].[EnrollmentViewAll]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EnrollmentViewAll]
AS 
   BEGIN
   SELECT *
   FROM Enrollment
   END	

GO
/****** Object:  StoredProcedure [dbo].[ExamCreateOrUpdate]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ExamCreateOrUpdate]
@ExamID int,
@ExamName nvarchar(50),
@ExamDescription nvarchar(MAX),
@ExamDate date,
@ExamDuration int,
@ExamMarks int,
@ClassCourseID int,
@ExamPassingMarks int
AS
BEGIN
IF(@ExamID=0)
   BEGIN
   INSERT INTO Exam(ExamName,ExamDescription,ExamDate,ExamDuration,ExamMarks,ClassCourseID,ExamPassingMarks)
   VALUES(@ExamName,@ExamDescription,@ExamDate,@ExamDuration,@ExamMarks,@ClassCourseID,@ExamPassingMarks)
   END
ELSE
   BEGIN
   Update Exam
   SET
	  ExamName=@ExamName,
	  ExamDescription=@ExamDescription,
	  ExamDate=@ExamDate,
	  ExamDuration=@ExamDuration,
	  ExamMarks=@ExamMarks,
      ExamPassingMarks=@ExamPassingMarks
	  WHERE ExamID=@ExamID AND ClassCourseID=@ClassCourseID
   END
END

GO
/****** Object:  StoredProcedure [dbo].[FeeCreateOrUpdate]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FeeCreateOrUpdate]
@FeeID int,
@ClassID int,
@TutionFee int,
@AdmissionFee int,
@LibraryFee int,
@BusFee int,
@TotalFee int
AS
BEGIN
IF(@FeeID=0)
   BEGIN
   INSERT INTO Fee(ClassID,TutionFee,AdmissionFee,LibraryFee,BusFee,TotalFee)
   VALUES(@ClassID,@TutionFee,@AdmissionFee,@LibraryFee,@BusFee,@TotalFee)
   END
ELSE
   BEGIN
   Update Fee
   SET
      ClassID=@ClassID,
	  TutionFee=@TutionFee,
	  AdmissionFee=@AdmissionFee,
	  LibraryFee=@LibraryFee,
	  BusFee=@BusFee,
	  TotalFee=@TotalFee
	  WHERE FeeID=@FeeID
   END
END

GO
/****** Object:  StoredProcedure [dbo].[InstructorCourseCreateOrUpdate]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InstructorCourseCreateOrUpdate]
@InstructorCourseID int,
@InstructorID int,
@CourseID int,
@AssignedOn datetime
AS
BEGIN
IF(@InstructorCourseID=0)
   BEGIN
   INSERT INTO InstructorCourse(InstructorID,CourseID,AssignedOn)
   VALUES(@InstructorID,@CourseID,@AssignedOn)
   END
ELSE
   BEGIN
   Update InstructorCourse
   SET
	  AssignedOn=@AssignedOn,
	  InstructorID=@InstructorID
	  WHERE CourseID=@CourseID AND InstructorCourseID=@InstructorCourseID
   END
END

GO
/****** Object:  StoredProcedure [dbo].[RelationCreateOrUpdate]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RelationCreateOrUpdate]
@StudentParentID int,
@GaurdianID int,
@RegistrationID int,
@RelationshipType nvarchar(50)
AS
BEGIN
IF(@StudentParentID=0)
   BEGIN
   INSERT INTO StudentParent(GaurdianID,RegistrationID,RelationshipType)
   VALUES(@GaurdianID,@RegistrationID,@RelationshipType)
   END
ELSE
   BEGIN
   Update StudentParent
   SET
      GaurdianID=@GaurdianID,
	  RegistrationID=@RegistrationID,
	  RelationshipType=@RelationshipType
	  WHERE StudentParentID=@StudentParentID
   END
END

GO
/****** Object:  StoredProcedure [dbo].[spChangePassword]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spChangePassword]
@GUID uniqueidentifier,
@Password nvarchar(100)
as
Begin
 Declare @RegistrationID int
 
 Select @RegistrationID = RegistrationID
 from tblResetPasswordStudentRequests
 where Id= @GUID
 
 if(@RegistrationID is null)
 Begin
  -- If UserId does not exist
  Select 0 as IsPasswordChanged
 End
 Else
 Begin
  -- If UserId exists, Update with new password
  Update StudentRegistration set
  [Password] = @Password
  where RegistrationID = @RegistrationID
  
  -- Delete the password reset request row 
  Delete from tblResetPasswordStudentRequests
  where Id = @GUID
  
  Select 1 as IsPasswordChanged
 End
End

GO
/****** Object:  StoredProcedure [dbo].[spIsPasswordResetLinkValid]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spIsPasswordResetLinkValid] 
@GUID uniqueidentifier
as
Begin
 Declare @RegistrationID int
 
 If(Exists(Select RegistrationID from tblResetPasswordStudentRequests where Id = @GUID))
 Begin
  Select 1 as IsValidPasswordResetLink
 End
 Else
 Begin
  Select 0 as IsValidPasswordResetLink
 End
End

GO
/****** Object:  StoredProcedure [dbo].[spParentEnrolledCourses]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spParentEnrolledCourses]
@RegistrationNo int
AS 
BEGIN

    Select c.ClassCourseID,cr.CourseName,ins.Name as Instructor_Name,cl.ClassName,cl.Section,s.RegistrationNo 
	from ClassCourse c 
	join Class cl on cl.ClassID=c.ClassID 
	join Enrollment e on e.ClassID=c.ClassID 
	join StudentRegistration s on s.RegistrationID=e.RegistrationID 
	join InstructorCourse i on i.InstructorCourseID=c.InstructorCourseID 
	join Courses cr on cr.CourseID=i.CourseID 
	join Instructor ins on ins.InstructorID=i.InstructorID 
	where RegistrationNo=@RegistrationNo
END
GO
/****** Object:  StoredProcedure [dbo].[spRegisterUser]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spRegisterUser]
	@Name  NVARCHAR (50),
	@Address nvarchar(50),
	@City nvarchar(50),
	@RegistrationNo NVARCHAR (100),
	@Username NVARCHAR(50),
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
		insert into [StudentRegistration] values(@Name,@Address,@City,@RegistrationNo,@Email,@Password,@ConfirmPassword,@Username)
	End
	select @ReturnCode as ReturnValue
	End
RETURN 0


GO
/****** Object:  StoredProcedure [dbo].[spResetPassword]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spResetPassword]
@UserName nvarchar(100)
as
Begin
 Declare @RegistrationID int
 Declare @Email nvarchar(100)
 
 Select @RegistrationID=RegistrationID, @Email = Email 
 from StudentRegistration
 where UserName = @UserName
 
 if(@RegistrationID IS NOT NULL)
 Begin
  --If username exists
  Declare @GUID UniqueIdentifier
  Set @GUID = NEWID()
  Insert into [LoginDB].[dbo].[tblResetPasswordStudentRequests]
  (Id,RegistrationID,ResetRequestDateTime)
  Values(@GUID,@RegistrationID,GETDATE())
  
  Select 1 as ReturnCode, @GUID as UniqueId, @Email as Email
 End
 Else
 Begin
  --If username does not exist
  SELECT 0 as ReturnCode, NULL as UniqueId, NULL as Email
 End
End



GO
/****** Object:  StoredProcedure [dbo].[spResultInsert]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spResultInsert]
@ExamID int,
@ResultStatus nvarchar(50),
@ResultScore float,
@TotalQuestion int,
@RegistrationNo nvarchar(50)
as
begin
      insert into Result(ExamID,ResultStatus,ResultScore,TotalQuestion,RegistrationNo) values
	  (@ExamID,@ResultStatus,@ResultScore,@TotalQuestion,@RegistrationNo)
	  
end

GO
/****** Object:  StoredProcedure [dbo].[spStudentAttendenceReport]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spStudentAttendenceReport]
@RegistrationID int
AS 
BEGIN

    select  at.RegistrationID,cr.CourseName as Course, ins.Name as Instructor,e.ClassName as Class,e.Section,convert(varchar, dbo.fnpercent(sum(case when Status=2 then 0 else 1 end),at.RegistrationID,cr.CourseName,ins.Name,e.ClassName,e.Section)) + '%' 'AttendancePercentage'
 from Attendence at 
 JOIN ClassCourse cc ON at.ClassCourseID = cc.ClassCourseID 
 JOIN Class e ON e.ClassID = cc.ClassID 
 JOIN InstructorCourse i ON i.InstructorCourseID = cc.InstructorCourseID  
 JOIN Courses cr ON cr.CourseID = i.CourseID 
 JOIN Instructor ins ON ins.InstructorID = i.InstructorID
 where at.RegistrationID=@RegistrationID
 group by at.RegistrationID,cr.CourseName,ins.Name,e.ClassName,e.Section
order by at.RegistrationID
END
GO
/****** Object:  StoredProcedure [dbo].[spStudentEnrolledCoursesReport]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spStudentEnrolledCoursesReport]
@RegistrationNO int
AS 
BEGIN
Select c.ClassCourseID,cr.CourseName,ins.Name as Instructor_Name,cl.ClassName,cl.Section,s.RegistrationNo 
from ClassCourse c 
join Class cl on cl.ClassID=c.ClassID 
join Enrollment e on e.ClassID=c.ClassID 
join StudentRegistration s on s.RegistrationID=e.RegistrationID 
join InstructorCourse i on i.InstructorCourseID=c.InstructorCourseID 
join Courses cr on cr.CourseID=i.CourseID 
join Instructor ins on ins.InstructorID=i.InstructorID 
where RegistrationNo=@RegistrationNO
    
END
GO
/****** Object:  StoredProcedure [dbo].[spStudentResultReport]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spStudentResultReport]
@RegistrationNO int
AS 
BEGIN
Select e.ExamName,e.ExamDuration,e.ExamMarks,r.TotalQuestion,r.ResultScore,r.ResultStatus,r.RegistrationNo 
from Result r join Exam e on e.ExamID=r.ExamID 
where r.RegistrationNo=@RegistrationNO
    
END
GO
/****** Object:  StoredProcedure [dbo].[TakeFeeCreateOrUpdate]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TakeFeeCreateOrUpdate]
@StudentParentID int,
@TakeFeeID int,
@FeeID int,
@Date datetime
AS
BEGIN
IF(@TakeFeeID=0)
   BEGIN
   INSERT INTO TakeFee(StudentParentID,FeeID,Date)
   VALUES(@StudentParentID,@FeeID,@Date)
   END
ELSE
   BEGIN
   Update TakeFee
   SET
	  Date=@Date
	  WHERE TakeFeeID=@TakeFeeID
   END
END

GO
/****** Object:  StoredProcedure [dbo].[TestCreateOrUpdate]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TestCreateOrUpdate]
@ExamID int,
@QuestionID int,
@Question nvarchar(MAX),
@Option1 nvarchar(100),
@Option2 nvarchar(100),
@Option3 nvarchar(100),
@Option4 nvarchar(100),
@CorrectAnswer nvarchar(100)
AS
BEGIN
IF(@QuestionID=0)
   BEGIN
   INSERT INTO CourseTest(Question,Option1,Option2,Option3,Option4,ExamID,CorrectAnswer)
   VALUES(@Question,@Option1,@Option2,@Option3,@Option4,@ExamID,@CorrectAnswer)
   END
ELSE
   BEGIN
   Update CourseTest
   SET
	  Question=@Question,
	  Option1=@Option1,
	  Option2=@Option2,
	  Option3=@Option3,
	  Option4=@Option4,
      CorrectAnswer=@CorrectAnswer
	  WHERE QuestionID=@QuestionID AND ExamID=@ExamID
   END
END

GO
/****** Object:  StoredProcedure [dbo].[ViewAllGaurdian]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewAllGaurdian]
AS 

BEGIN
SELECT * FROM Gaurdian
END

GO
/****** Object:  StoredProcedure [dbo].[ViewAllInstructor]    Script Date: 5/27/2020 8:08:21 PM ******/
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
/****** Object:  StoredProcedure [dbo].[ViewGaurdianByID]    Script Date: 5/27/2020 8:08:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewGaurdianByID]
@GaurdianID int
AS 

BEGIN
SELECT * FROM Gaurdian WHERE GaurdianID=@GaurdianID

END

GO
/****** Object:  StoredProcedure [dbo].[ViewInstructorByID]    Script Date: 5/27/2020 8:08:21 PM ******/
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
USE [master]
GO
ALTER DATABASE [LoginDB] SET  READ_WRITE 
GO
