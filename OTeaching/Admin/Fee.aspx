﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fee.aspx.cs" Inherits="OTeaching.Admin.Fee" %>

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
        <a class="nav-link" href="../Default.aspx">Logout</a>
      </li>
    </ul>
    </nav>
            <div class="container">
            <div class="form-horizontal">
                <br />
                <h2>Fee</h2>
                <hr/>
                 <asp:HiddenField ID="hfFeeID" runat="server" />
             <div class="form-group">
                    <asp:Label runat="server" CssClass="col-md-2 control-label" Text="Class Name"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtClassName" CssClass="form-control" runat="server" Enabled="False"></asp:TextBox>
                 <div>
                     <asp:Label ID="lblClassName" runat="server"  Text=" " ForeColor="Red"></asp:Label>
                 </div>
                        </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" CssClass="col-md-2 control-label" Text="Tution Fee"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtTutionFee" CssClass="form-control" runat="server"></asp:TextBox>
                 <div>
                     <asp:Label ID="lblTutionFee" runat="server"  Text=" " ForeColor="Red"></asp:Label>
                 </div>
                        </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" CssClass="col-md-2 control-label" Text="Admission Fee"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtAdmissionFee" CssClass="form-control" runat="server"></asp:TextBox>
                 <div>
                     <asp:Label ID="lblAdmissionFee" runat="server"  Text=" " ForeColor="Red"></asp:Label>
                 </div>
                        </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" CssClass="col-md-2 control-label" Text="Library Fee"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtLibraryFee" CssClass="form-control" runat="server"></asp:TextBox>
                 <div>
                     <asp:Label ID="lblLibraryFee" runat="server"  Text=" " ForeColor="Red"></asp:Label>
                 </div>
                        </div>
                </div>
                  <div class="form-group">
                    <asp:Label runat="server" CssClass="col-md-2 control-label" Text="Bus Fee"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtBusFee" CssClass="form-control" runat="server"></asp:TextBox>
                 <div>
                     <asp:Label ID="lblBusFee" runat="server"  Text=" " ForeColor="Red"></asp:Label>
                 </div>
                        </div>
                </div>
                <div class="form-group">
                    <asp:Label runat="server" CssClass="col-md-2 control-label" Text="Total Fee"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtTotalFee" CssClass="form-control" runat="server" Enabled="False"></asp:TextBox>
                 <div>
                     <asp:Label ID="lblTotalFee" runat="server"  Text=" " ForeColor="Red"></asp:Label>
                 </div>
                        </div>
                </div>
              <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn btn-success" style="font-family: Arial"  Width="98px" OnClick="btnAdd_Click"/>
                        <asp:Button ID="btnDelete" runat="server" OnClientClick="return confirm('Are you sure?');" Text="Delete" CssClass="btn btn-danger" style="font-family: Arial; height: 39px;" OnClick="btnDelete_Click"/>
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" style="font-family: Arial" OnClick="btnClear_Click"/>
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" style="font-family: Arial" OnClick="btnUpdate_Click" Visible="False"/>
                         </div>
                </div>
                </div>
                <table>
                <tr>
                    <td colspan="2">
                        <asp:Label ID="lblSuccessMessage" runat="server" Text="" ForeColor="Green"></asp:Label>    
                    </td> 
                </tr>
                <tr>
                    <td>   
                    </td>
                    <td colspan="2">
                        <asp:Label ID="lblErrormessage" runat="server" Text="" ForeColor="Red"></asp:Label>
                    </td>     
                </tr>
            </table>
            <hr />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"  GridLines="None" AllowPaging="true" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" OnPageIndexChanging="GridView1_PageIndexChanging">
                <Columns>
                    <asp:BoundField DataField="ClassName" HeaderText="Class Name"/>
                    <asp:BoundField DataField="TutionFee" HeaderText="Tution Fee"/>
                    <asp:BoundField DataField="AdmissionFee" HeaderText="Admission Fee"/>
                    <asp:BoundField DataField="LibraryFee" HeaderText="Library Fee"/>
                    <asp:BoundField DataField="BusFee" HeaderText="Bus Fee"/>
                    <asp:BoundField DataField="TotalFee" HeaderText="Total Fee"/>
                     <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkview" runat="server" CommandArgument='<%# Eval("FeeID")%>' OnClick="lnk_OnClick">View</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
                 <style>
            .mGrid { 
                    width: 100%; 
                    background-color: #fff; 
                    margin: 5px 0 10px 0; 
                    border: solid 1px #525252; 
                    border-collapse:collapse; 
                    }
            .mGrid td { 
                     padding: 2px; 
                     border: solid 1px #c1c1c1; 
                     color: #717171; 
            }
            .mGrid th { 
                    padding: 4px 2px; 
                    color: #fff; 
                    background: #424242 url(grd_head.png) repeat-x top; 
                    border-left: solid 1px #525252; 
                    font-size: 0.9em; 
            }
.mGrid .alt { background: #D3D3D3 url(grd_alt.png) repeat-x top; }
.mGrid .pgr { background: #424242 url(grd_pgr.png) repeat-x top; }
.mGrid .pgr table { margin: 5px 0; }
.mGrid .pgr td { 
    border-width: 0; 
    padding: 0 6px; 
    border-left: solid 1px #666; 
    font-weight: bold; 
    color: #fff; 
    line-height: 12px; 
 }   
.mGrid .pgr a { color: #666; text-decoration: none; }
.mGrid .pgr a:hover { color: #000; text-decoration: none; }
        </style>
        </div>
    </form>
     <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>
</html>
