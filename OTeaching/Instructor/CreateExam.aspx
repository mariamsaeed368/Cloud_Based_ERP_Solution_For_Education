
<%@ Page Title="" Language="C#" MasterPageFile="~/Instructor/Instructor.Master" AutoEventWireup="true" CodeBehind="CreateExam.aspx.cs" Inherits="OTeaching.Instructor.CreateExam" %>
<asp:Content ID="Content1" ContentPlaceHolderID="c1" runat="server">
     <div class="col-md-12">
        <div class="card">
            <form id="form2" runat="server">
            <%--Add exam panel--%>
            <asp:Panel ID="panel_addexam" runat="server">
                <div class="card-body">
                    <div class="row form-group">
                         <asp:HiddenField ID="hfExamID" runat="server" />
                        <label class="col-md-2 col-form-label ">Exam Name</label>
                        <div class="col-md-4">
                            <asp:TextBox ID="txt_examname" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-2 col-form-label ">Exam Description</label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txt_examdis" runat="server" TextMode="MultiLine" CssClass="form-control" Height="100px"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-2 col-form-label ">Exam Date</label>
                        <div class="col-md-4">
                            <asp:TextBox ID="txt_examdate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-2 col-form-label ">Exam Duration(Minute)</label>
                        <div class="col-md-4">
                            <asp:TextBox ID="txt_examduration" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="requireregular_examduration" runat="server" ErrorMessage="Enter a valid time" ControlToValidate="txt_examduration" ForeColor="red" ValidationExpression="^\d{1,45}$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-2 col-form-label ">Exam Pass Marks</label>
                        <div class="col-md-4">
                            <asp:TextBox ID="txt_exampassmarks" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="requireregular_exampassmark" runat="server" ErrorMessage="Enter a valid marks" ControlToValidate="txt_exampassmarks" ForeColor="red" ValidationExpression="^\d{1,45}$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-2 col-form-label ">Exam Total Marks</label>
                        <div class="col-md-4">
                            <asp:TextBox ID="txt_exammatotalmarks" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="rege_exammatotal" runat="server" ErrorMessage="Enter a valid total marks" ControlToValidate="txt_exammatotalmarks" ForeColor="red" ValidationExpression="^\d{1,45}$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="offset-2">
                            <asp:Button ID="btn_addexam" runat="server" Text="Add Exam" CssClass="btn" BackColor="#343A40" BorderStyle="None" ForeColor="White" OnClick="btn_addexam_Click" />
                            <asp:Button ID="btnDelete" runat="server" OnClientClick="return confirm('Are you sure?');" Text="Delete" CssClass="btn btn-danger" style="font-family: Arial; height: 39px;" OnClick="btnDelete_Click"/>
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" style="font-family: Arial" OnClick="btnClear_Click"  />  
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
                </div>
            </asp:Panel>
            <%--exam list panel--%>
            <asp:Panel ID="panel_examlist" runat="server">
                <div class="card text-center mb-3">
                    <div class="card-body">
                        <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"  GridLines="None" AllowPaging="true" CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt">
                <Columns>
                    <asp:BoundField DataField="ExamName" HeaderText="Exam Name"/>
                    <asp:BoundField DataField="ExamDescription" HeaderText="Description"/>
                    <asp:BoundField DataField="ExamDate" HeaderText="Date"/>
                    <asp:BoundField DataField="ExamDuration" HeaderText="Duration"/>
                    <asp:BoundField DataField="ExamMarks" HeaderText="Total Marks"/>
                    <asp:BoundField DataField="ExamPassingMarks" HeaderText="Passing Marks"/>
                     <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkview" runat="server" CommandArgument='<%# Eval("ExamID")%>' OnClick="lnk_OnClick">View</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkquestions" CommandArgument='<%# Eval("ExamID") %>' runat="server" Text="Questions" OnClick="lnkquestions_OnClick" />
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
                        <asp:Panel ID="panel_examlist_warning" runat="server" Visible="false">
                            <div class="card-footer">
                                <br />
                                <div class="alert alert-danger text-center">
                                    <asp:Label ID="lbl_examlistwarning" runat="server" />
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </asp:Panel>
            </form>
        </div>
    </div>
</asp:Content>
