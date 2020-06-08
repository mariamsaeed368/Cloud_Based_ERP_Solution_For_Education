
<%@ Page Language="C#" MasterPageFile="~/Instructor/Instructor.Master" AutoEventWireup="true" CodeBehind="InstructorReports.aspx.cs" Inherits="OTeaching.Instructor.InstructorReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="c1" runat="server">
     <div class="col-md-12">
        <div class="card">
   <form id="form2" runat="server">
                 <br />
    <h2>Instructor Reports</h2>
    <hr/>
            <%--Instructor Report panel--%>
            <asp:Panel ID="panel_instructorreport" runat="server">
                <div class="card-body">
                    <div class="row form-group">
                         
                        <label class="col-md-2 col-form-label ">Instructor Assigned Courses Report</label>
                        <div class="col-md-4">
                            <asp:Button ID="btn_assigned_course" runat="server" Text="Export"  OnClick="btn_assigned_courses_report_click"/>
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="col-md-2 col-form-label ">Attendence Report</label>
                        <div class="col-md-9">
                            <asp:Button ID="Button1" runat="server" Text="Export" OnClick="btn_attendence_report_click"/>
                        </div>
                    </div>
                       <div class="row form-group">
                        <label class="col-md-2 col-form-label ">Result Report</label>
                        <div class="col-md-9">
                            <asp:Button ID="btn_result_report" runat="server" Text="Export" OnClick="btn_result_report_click"/>
                        </div>
                    </div>
                    
                </div>
            </asp:Panel>
            </form>
            </div>
         </div>
    </asp:Content>