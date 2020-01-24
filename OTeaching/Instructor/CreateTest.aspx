<%@ Page Title="" Language="C#" MasterPageFile="~/Instructor/Instructor.Master" AutoEventWireup="true" CodeBehind="CreateTest.aspx.cs" Inherits="OTeaching.Instructor.Create_Exam" %>
<asp:Content ID="Content1" ContentPlaceHolderID="c1" runat="server">
     <div class="col-md-12">
        <div class="card">
            <form id="form2" runat="server">
            <div class="card-body">
                <div class="row form-group">
                     <asp:HiddenField ID="hfQuestionID" runat="server" />
                    <label class="col-md-2 col-form-label ">Question</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txt_questionname" runat="server" TextMode="MultiLine" CssClass="form-control" Height="100px"></asp:TextBox>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-md-2 col-form-label ">Option A</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txt_optionone" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-md-2 col-form-label ">Option B</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txt_optiontwo" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-md-2 col-form-label ">Option C</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txt_optionthree" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="row form-group">
                    <label class="col-md-2 col-form-label ">Option D</label>
                    <div class="col-md-9">
                        <asp:TextBox ID="txt_optionfour" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="row form-group">
                <label class="col-md-2 col-form-label">Correct Answer</label>
                    <div class="col-md-4">
                        <asp:RadioButtonList ID="rdo_correctanswer" runat="server" RepeatDirection="Horizontal" RepeatLayout="Table" CellPadding="10">
                            <asp:ListItem Text="A" Value=1></asp:ListItem>
                            <asp:ListItem Text="B" Value=2></asp:ListItem>
                            <asp:ListItem Text="C" Value=3></asp:ListItem>
                            <asp:ListItem Text="D" Value=4></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
            </div>            
                <div class="card-footer">
                        <div class="offset-2">
                            <asp:Button ID="btn_addquestion" runat="server" Text="Add Question" CssClass="btn" BackColor="#343A40" BorderStyle="None" ForeColor="White" OnClick="btn_addquestion_Click" />
                            <asp:Button ID="btnDelete" runat="server" OnClientClick="return confirm('Are you sure?');" Text="Delete" CssClass="btn btn-danger" style="font-family: Arial; height: 39px;" OnClick="btnDelete_Click"/>
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" style="font-family: Arial" OnClick="btnClear_Click" />  
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
                    </div>
                 <asp:Panel ID="panel_examlist" runat="server">
                <div class="card text-center mb-3">
                    <div class="card-body">
                        <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"  GridLines="None" AllowPaging="true" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt">
                <Columns>
                    <asp:BoundField DataField="Question" HeaderText="Question"/>
                    <asp:BoundField DataField="Option1" HeaderText="Option A"/>
                    <asp:BoundField DataField="Option2" HeaderText="Option B"/>
                    <asp:BoundField DataField="Option3" HeaderText="Option C"/>
                    <asp:BoundField DataField="Option4" HeaderText="Option D"/>
                    <asp:BoundField DataField="CorrectAnswer" HeaderText="Correct Answer"/>
                     <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkview" runat="server" CommandArgument='<%# Eval("QuestionID")%>' OnClick="lnk_OnClick">View</asp:LinkButton>
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
                </asp:Panel>
            </div>          
            </form>  
        </div>
    </div>
</asp:Content>
