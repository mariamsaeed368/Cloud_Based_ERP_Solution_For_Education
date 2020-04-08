
<%@ Page Title="" Language="C#" MasterPageFile="~/Parent/Parent.Master" AutoEventWireup="true" CodeBehind="FeeStatus.aspx.cs" Inherits="OTeaching.Parent.FeeStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="c1" runat="server">
    <form id="form1" runat="server">
     <div class="container">
    <div class="form-horizontal">
    <br />
    <h2>Fee Details</h2>
    <hr/>
             <div class="form-group">
                    <asp:Label ID="lblRegNo" runat="server" CssClass="col-md-2 control-label" Text="Student's Registration No."></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtRegNo" CssClass="form-control" runat="server" Height="38px"></asp:TextBox>
                        </div>
                </div>
             <div class="form-group">
                    <asp:Label ID="lblClassName" runat="server" CssClass="col-md-2 control-label" Text="Class Name"></asp:Label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlclassname" runat="server" CssClass="form-control" Height="38px" Width="180px"></asp:DropDownList>       
                  <div>
                     <asp:Label ID="Label3" runat="server"  Text=" " ForeColor="Red"></asp:Label>
                 </div>
                    </div>
                </div>
              <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success" style="font-family: Arial"  Width="98px" OnClick="btnSearch_Click"/>
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" style="font-family: Arial" OnClick="btnClear_Click"  />  
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
           <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"  GridLines="None" AllowPaging="true" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" >
                <Columns>
                    <asp:BoundField DataField="ClassName" HeaderText="Class Name"/>
                    <asp:BoundField DataField="TutionFee" HeaderText="Tution Fee"/>
                    <asp:BoundField DataField="AdmissionFee" HeaderText="Admission Fee"/>
                     <asp:BoundField DataField="BusFee" HeaderText="Bus Fee"/>
                     <asp:BoundField DataField="LibraryFee" HeaderText="Library Fee"/>
                     <asp:BoundField DataField="TotalFee" HeaderText="Total Fee"/>
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
</asp:Content>
