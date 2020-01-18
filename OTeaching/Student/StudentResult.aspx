<%@ Page Title="" Language="C#" MasterPageFile="~/Student/Student.Master" AutoEventWireup="true" CodeBehind="StudentResult.aspx.cs" Inherits="OTeaching.Student.StudentResult" %>
<asp:Content ID="Content1" ContentPlaceHolderID="c1" runat="server">
    <form id="form1" runat="server">
    <div class="card-header">
        <h2>My Result</h2>
        <hr/>
    </div>
    <asp:TextBox ID="getstringuser" runat="server" Visible ="false"></asp:TextBox>
    <asp:GridView ID="gridmyresult" runat="server" GridLines="None" AllowPaging="True" AutoGenerateColumns="False" CssClass="mGrid">
        <Columns>
            <asp:BoundField DataField="ExamName" HeaderText="Exam Name" NullDisplayText="no exam name"/>
            <asp:BoundField DataField="ExamDuration" HeaderText="Exam Duration" />
            <asp:BoundField DataField="TotalQuestion" HeaderText="Total Questions" />
            <asp:BoundField DataField="ExamMarks" HeaderText="Exam Marks" />
            <asp:BoundField DataField="ResultScore" HeaderText="Result Score" />
            <asp:BoundField DataField="ResultStatus" HeaderText="Result Status" />
            <asp:BoundField DataField="RegistrationNo" HeaderText="Registration No." />
        </Columns>
    </asp:GridView>
         <style>
            .mGrid { 
                    width: 96%; 
                    background-color: #fff; 
                    margin-left:25px;
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
             .auto-style1 {
                 float: left;
                 width: 468px;
             }
        </style>
        <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <asp:Panel ID="panel_myresultshow_warning" runat="server" Visible="false">
                    <br />
                    <div class="alert alert-danger text-center">
                        <asp:Label ID="lbl_myresultshowwarning" runat="server" />
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>
    </form>
</asp:Content>
