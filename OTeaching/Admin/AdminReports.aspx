<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminReports.aspx.cs" Inherits="OTeaching.Admin.AdminReports" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Education</title>
    <meta charset="UTF-8"/>
	<meta name="description" content="WebUni Education Template"/>
	<meta name="keywords" content="webuni, education, creative, html"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>

	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Raleway:400,400i,500,500i,600,600i,700,700i,800,800i" rel="stylesheet"/>

	<!-- Stylesheets -->
    
	<link rel="stylesheet" href="css/bootstrap.min.css"/>
	<link rel="stylesheet" href="css/font-awesome.min.css"/>
	<link rel="stylesheet" href="css/owl.carousel.css"/>
	<link rel="stylesheet" href="css/style.css"/>
    

	<!--[if lt IE 9]>
	  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>

	<![endif]-->
</head>

<body>



  <form id="form1" runat="server">
       <div>
            <nav class="navbar-expand-lg navbar navbar-dark bg-dark navbar-fixed-top">
                     <a class="navbar-brand" href="#">Online Education System</a>
    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
      <li class="nav-item active">
        <a class="nav-link" href="Welcome.aspx">Home <span class="sr-only">(current)</span></a>
      </li>
 <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown">
          Register
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="ParentRegistration.aspx">Parent</a>
          <a class="dropdown-item" href="InstructorRegistration.aspx">Teacher</a>
        </div>
      </li>
        <li class="nav-item">
        <a class="nav-link" href="Classes.aspx">Classes</a>
      </li>
        <li class="nav-item">
        <a class="nav-link" href="Courses.aspx">Courses</a>
      </li>
         <li class="nav-item">
        <a class="nav-link" href="AdminReports.aspx">Reports</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="../Default.aspx">Logout</a>
      </li>
    </ul>
    </nav>
           
        </div>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>

<h2>Admin Reports</h2>
    <hr/>
            <%--Admin Report panel--%>
            <asp:Panel ID="panel_adminreport" runat="server">
                <div class="card-body">
                    <div class="form-horizontal">
                    <div class="form-group">
                 <asp:Label ID="Label1" runat="server" CssClass="col-md-2 control-label" Text="Student Report"></asp:Label>
                    <div class="col-md-3">
                        <asp:Button ID="Button11" runat="server"  Text="Export" OnClick="Button11_Click"   />
                </div>
            </div>


                   <div class="form-group">
                 <asp:Label ID="Label2" runat="server" CssClass="col-md-2 control-label" Text="Attendence Report"></asp:Label>
                    <div class="col-md-3">
                        <asp:Button ID="Button1" runat="server"  Text="Export" OnClick="Button1_Click"   />
                </div>
            </div>
                        <div class="form-group">
                 <asp:Label ID="Label3" runat="server" CssClass="col-md-2 control-label" Text="Class Report"></asp:Label>
                    <div class="col-md-3">
                        <asp:Button ID="Button2" runat="server"  Text="Export" OnClick="Button2_Click"   />
                </div>
            </div>
                        <div class="form-group">
                 <asp:Label ID="Label4" runat="server" CssClass="col-md-2 control-label" Text="Courses Report"></asp:Label>
                    <div class="col-md-3">
                        <asp:Button ID="Button3" runat="server"  Text="Export" OnClick="Button3_Click"   />
                </div>
            </div>
                        <div class="form-group">
                 <asp:Label ID="Label5" runat="server" CssClass="col-md-2 control-label" Text="Fee Report"></asp:Label>
                    <div class="col-md-3">
                        <asp:Button ID="Button4" runat="server"  Text="Export" OnClick="Button4_Click"   />
                </div>
            </div>
                        <div class="form-group">
                 <asp:Label ID="Label6" runat="server" CssClass="col-md-2 control-label" Text="Exam Report"></asp:Label>
                    <div class="col-md-3">
                        <asp:Button ID="Button5" runat="server"  Text="Export" OnClick="Button5_Click"   />
                </div>
            </div>
                        <div class="form-group">
                 <asp:Label ID="Label7" runat="server" CssClass="col-md-2 control-label" Text="Result Report"></asp:Label>
                    <div class="col-md-3">
                        <asp:Button ID="Button6" runat="server"  Text="Export" OnClick="Button6_Click"   />
                </div>
            </div>
                        <div class="form-group">
                 <asp:Label ID="Label8" runat="server" CssClass="col-md-2 control-label" Text="Instructor Report"></asp:Label>
                    <div class="col-md-3">
                        <asp:Button ID="Button7" runat="server"  Text="Export" OnClick="Button7_Click"   />
                </div>
            </div>
                    <div>
                        </div>
                        </div>
                    
                     </asp:Panel>
        
        











</form>