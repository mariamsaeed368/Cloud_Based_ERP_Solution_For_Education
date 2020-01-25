
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParentRegistration.aspx.cs" Inherits="OTeaching.Admin.ParentRegistration" %>

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
<body style="height: 1445px">
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
           <!---- <div class="form-horizontal">--->
        <br />
        <h2>Register Gaurdian</h2>
        <br />           
        <div class="form-horizontal">
             <div class="form-group">
                <asp:HiddenField ID="hfGaurdianId" runat="server" />
             </div>
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
                 <asp:Label ID="mobile" runat="server" CssClass="col-md-2 control-label" Text="Mobile"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="tbmobile" onkeydown = "return (!(event.keyCode>=65) && event.keyCode!=32);"  MaxLength="11" CssClass="form-control" runat="server" placeholder="Mobile"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                 <asp:Label ID="city" runat="server" CssClass="col-md-2 control-label" Text="City"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="tbcity" CssClass="form-control" runat="server" placeholder="City"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                 <asp:Label ID="income" runat="server" CssClass="col-md-2 control-label" Text="Income"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="tbincome" CssClass="form-control" runat="server" placeholder="Income"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                 <asp:Label ID="cnic" runat="server" CssClass="col-md-2 control-label" Text="CNIC No."></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="tbcnic" onkeydown = "return (!(event.keyCode>=65) && event.keyCode!=32);" MaxLength="13" CssClass="form-control" runat="server" placeholder="CNIC"></asp:TextBox>
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
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btnadd" runat="server" Text="Add" Class="btn btn-success" OnClick="btnadd_Click"/>
                        <asp:Button ID="btnDelete" OnClientClick="return confirm('Are you sure?');" runat="server" Text="Delete" OnClick="btnDelete_Click"/>
                        <asp:Button ID="btnClear" runat="server" Text="Clear" Class="btn btn-secondary" OnClick="btnClear_Click"/>
                    </div>
                </div>
             <div class="col-xs-11">
                <asp:Label ID="lblMsg" runat="server" CssClass="text-danger"></asp:Label>
            </div>
             <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"  GridLines="None" AllowPaging="true" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" OnPageIndexChanging="GridView1_PageIndexChanging">
                  <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name"/>
                    <asp:BoundField DataField="Address" HeaderText="Address"/>
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile"/>
                    <asp:BoundField DataField="City" HeaderText="City"/>
                    <asp:BoundField DataField="Income" HeaderText="Income"/>
                    <asp:BoundField DataField="CNIC" HeaderText="CNIC"/>
                    <asp:BoundField DataField="Email" HeaderText="Email"/>
                    <asp:BoundField DataField="Password" HeaderText="Password"/>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkview" runat="server" CommandArgument='<%# Eval("GaurdianID")%>' OnClick="lnk_OnClick">View</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                       <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkrelationwithstudent" runat="server" CommandArgument='<%# Eval("GaurdianID")%>'>Relation With Student</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
                             <style>
                                 .mGrid { 
                    background-color: #fff; 
                    margin: 5px 61 10px 0; 
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
        </div>

        </div>
    </form>
     <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>
</html>
