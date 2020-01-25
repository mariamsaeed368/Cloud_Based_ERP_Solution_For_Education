<%@ Page Title="" Language="C#" MasterPageFile="~/Student/Student.Master" AutoEventWireup="true" CodeBehind="DownloadCourseMaterial.aspx.cs" Inherits="OTeaching.Student.DownloadCourseMaterial" %>
<asp:Content ID="Content1" ContentPlaceHolderID="c1" runat="server">
     <form id="form1" runat="server">
    <div class="container">
       <div class="form-horizontal">
          <br />
            <h2>Enrolled Courses</h2>
          <hr/>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"  GridLines="None" AllowPaging="true" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" OnPageIndexChanging="GridView1_PageIndexChanging">
                <Columns>
                    <asp:BoundField DataField="ClassCourseID" HeaderText="ClassCourseID"/>
                    <asp:BoundField DataField="FileName" HeaderText="File Name"/>
                    <asp:BoundField DataField="FileLocation" HeaderText="File Location"/>
                 <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkdownload" runat="server" CommandArgument='<%# Eval("FileLocation")%>' OnClick="lnkdownload_OnClick">Download</asp:LinkButton>
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
           </form>
</asp:Content>
