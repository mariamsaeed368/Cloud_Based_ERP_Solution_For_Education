
<%@ Page Title="" Language="C#" MasterPageFile="~/Instructor/Instructor.Master" AutoEventWireup="true" CodeBehind="Attendence.aspx.cs" Inherits="OTeaching.Instructor.Attendence" %>
<asp:Content ID="Content1" ContentPlaceHolderID="c1" runat="server">
    <div class="col-md-12">
        <div class="card">
            
            <form id="form2" runat="server">
            <%--exam list panel--%>
                 <div class="container">
       <div class="form-horizontal">
          <br />
            <h3><asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></h3>
          <hr/>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  GridLines="None" AllowPaging="True" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit1" OnPageIndexChanging="GridView1_PageIndexChanging">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                    <asp:TemplateField HeaderText="Registration ID.">  
                    <ItemTemplate>  
                        <asp:Label ID="RegistrationID" runat="server" Text='<%#Eval("RegistrationID") %>'></asp:Label>  
                    </ItemTemplate>
                       </asp:TemplateField> 
                          <asp:TemplateField HeaderText="Student Name">  
                    <ItemTemplate>  
                        <asp:Label ID="StudentName" runat="server" Text='<%#Eval("StudentName") %>'></asp:Label>  
                    </ItemTemplate>  
                </asp:TemplateField> 
                          <asp:TemplateField HeaderText="Registration No.">  
                    <ItemTemplate>  
                        <asp:Label ID="RegistrationNo" runat="server" Text='<%#Eval("RegistrationNo") %>'></asp:Label>  
                    </ItemTemplate>  
                </asp:TemplateField> 
                          <asp:TemplateField HeaderText="Class Name">  
                    <ItemTemplate>  
                        <asp:Label ID="ClassName" runat="server" Text='<%#Eval("ClassName") %>'></asp:Label>  
                    </ItemTemplate>  
                </asp:TemplateField> 
                          <asp:TemplateField HeaderText="Section">  
                    <ItemTemplate>  
                        <asp:Label ID="Section" runat="server" Text='<%#Eval("Section") %>'></asp:Label>  
                    </ItemTemplate>  
                </asp:TemplateField> 
                          <asp:TemplateField HeaderText="Course Name">  
                    <ItemTemplate>  
                        <asp:Label ID="CourseName" runat="server" Text='<%#Eval("CourseName") %>'></asp:Label>  
                    </ItemTemplate>  
                </asp:TemplateField>       
                        <asp:TemplateField HeaderText="Mark Attendence">
                            <ItemTemplate>
                               
                                <asp:RadioButton ID="RadioButton1" runat="server" Text="Present" GroupName="Attendence"/>
                                &nbsp;<asp:RadioButton ID="RadioButton2" runat="server" Text="Absent" GroupName="Attendence" />
                                &nbsp;<asp:RadioButton ID="RadioButton3" runat="server" Text="Leave" GroupName="Attendence" />
                               
                            </ItemTemplate>
                            <EditItemTemplate>  
                                  <asp:RadioButton ID="RadioButton1" runat="server" Text="Present" GroupName="Attendence"/>
                                &nbsp;<asp:RadioButton ID="RadioButton2" runat="server" Text="Absent" GroupName="Attendence" />
                                &nbsp;<asp:RadioButton ID="RadioButton3" runat="server" Text="Leave" GroupName="Attendence" />
                               
                            </EditItemTemplate>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Operations">  
                        <ItemTemplate>  
                            <asp:Button ID="btn_Edit" runat="server" Text="Edit" CommandName="Edit" />  
                        </ItemTemplate>  
                        <EditItemTemplate>  
                            <asp:Button ID="btn_Update" runat="server" Text="Update" CommandName="Update"/>  
                            <asp:Button ID="btn_Cancel" runat="server" Text="Cancel" CommandName="Cancel"/>  
                        </EditItemTemplate>  
                        </asp:TemplateField>  
                    </Columns>
                    <PagerStyle CssClass="pgr" />
            </asp:GridView>
                 <style>
                     .mGrid { 
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
                         <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btnAdd" runat="server" Text="Save Attendence" CssClass="btn btn-success" style="font-family: Arial" OnClick="btnAdd_Click"/>
                         </div>
                </div>
            </form>
            <asp:Label ID="Label2" runat="server"></asp:Label>
        </div>
    </div>
    </div>
</asp:Content>
