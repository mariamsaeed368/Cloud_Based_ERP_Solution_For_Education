<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="OTeaching.ChangePassword" %>

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
      <br />
      <h2>Change Password</h2>
      <br />
       <div class="form-horizontal">
      <div class="form-group">
                    <asp:Label ID="lblpassword" runat="server" CssClass="col-md-2 control-label" Text="Password"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="tbpassword" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorNewPassword" runat="server" ErrorMessage="New Password required" Text="*" ControlToValidate="tbpassword" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                </div>
            <div class="form-group">
                    <asp:Label ID="lblconfirmpass" runat="server" CssClass="col-md-2 control-label" Text="Confirm Password"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="tbconfirmpass" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorConfirmNewPassword" runat="server" ErrorMessage="Confirm New Password required" Text="*" ControlToValidate="tbconfirmpass" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidatorPassword" runat="server" ErrorMessage="New Password and Confirm New Password must match" ControlToValidate="tbconfirmpass" ForeColor="Red" ControlToCompare="tbpassword" Display="Dynamic" Type="String" Operator="Equal" Text="*"> </asp:CompareValidator>
                </div>
                </div>
           <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btnchangepassword" runat="server" Text="Change Password" Class="btn btn-success" OnClick="btnchangepassword_Click"/>
                     </div>
                </div>
                 <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </div>
                </div>
        </div>
    </form>
</body>
</html>
