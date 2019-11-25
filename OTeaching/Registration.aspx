<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="OTeaching.Registration" %>

<!DOCTYPE html>

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
                     <a class="navbar-brand" href="#">Education System</a>
    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
      <li class="nav-item active">
        <a class="nav-link" href="Default.aspx">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="Login.aspx">Login</a>
      </li>
    </ul>
    </nav>
    <div class="container">
           <!---- <div class="form-horizontal">--->
        <br />
        <h2>Registration</h2>
        <br />           
        <div class="form-horizontal">
            <div class="form-group">
                 <asp:Label ID="name" runat="server" CssClass="col-md-2 control-label" Text="Name"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="tbname" CssClass="form-control" runat="server" placeholder="Name"></asp:TextBox>
                </div>
            </div>
              <div class="form-group">
                 <asp:Label ID="address" runat="server" CssClass="col-md-2 control-label" Text="Address"></asp:Label>
                    <div class="col-md-3">
                      <asp:TextBox ID="tbaddress" CssClass="form-control" runat="server" placeholder="Address"></asp:TextBox>
                </div>
            </div>
              <div class="form-group">
                 <asp:Label ID="city" runat="server" CssClass="col-md-2 control-label" Text="City"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="tbcity" CssClass="form-control" runat="server" placeholder="City"></asp:TextBox>
                </div>
            </div>
              <div class="form-group">
                 <asp:Label ID="registration" runat="server" CssClass="col-md-2 control-label" Text="Registration No"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="tbregisteration" CssClass="form-control" runat="server" placeholder="Registration No."></asp:TextBox>
                </div>
            </div>
             <div class="form-group">
                 <asp:Label ID="lblusername" runat="server" CssClass="col-md-2 control-label" Text="Username"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="tbusername" CssClass="form-control" runat="server" placeholder="Username"></asp:TextBox>
                </div>
            </div>
             <div class="form-group">
                 <asp:Label ID="email" runat="server" CssClass="col-md-2 control-label" Text="Email"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="tbemail" CssClass="form-control" TextMode="Email" runat="server" placeholder="Email"></asp:TextBox>
                </div>
            </div>
             <div class="form-group">
                 <asp:Label ID="password" runat="server" CssClass="col-md-2 control-label" Text="Password"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" ID="tbpass" CssClass="form-control" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
                </div>
            </div>
             <div class="form-group">
                 <asp:Label ID="confirmpass" runat="server" CssClass="col-md-2 control-label" Text="Confirm Password"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox TextMode="Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}" ID="tbconfirmpass" CssClass="form-control" runat="server" placeholder="Confirm Password"></asp:TextBox>
                </div>
            </div>
              <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btnregister" runat="server" Text="Sign Up" Class="btn btn-success" OnClick="btnregister_Click"/>
                    </div>
                </div>
             <div class="col-xs-11">
                <asp:Label ID="lblMsg" runat="server" CssClass="text-danger"></asp:Label>
            </div>
            </div>      
        </div>
        </div>
    </form>
</body>
</html>
