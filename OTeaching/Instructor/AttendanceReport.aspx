<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AttendanceReport.aspx.cs" Inherits="OTeaching.Instructor.AttendanceReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226">
                <LocalReport ReportPath="Instructor\AttendanceReport.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource Name="DataSet1" DataSourceId="SqlDataSource2"></rsweb:ReportDataSource>
                    </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>
            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:LoginDBConnectionString3 %>'
                SelectCommand="select  at.Date,ins.Name as InstructorName,s.RegistrationNo,s.Name as StudentName,   cr.CourseName ,e.ClassName,e.Section,(CASE WHEN status = '1'THEN 'Present' ELSE 'Absent' End) as Status from Attendence at JOIN ClassCourse cc ON at.ClassCourseID = cc.ClassCourseID JOIN Class e ON e.ClassID = cc.ClassID JOIN InstructorCourse i ON i.InstructorCourseID = cc.InstructorCourseID JOIN Courses cr ON cr.CourseID = i.CourseID JOIN Instructor ins ON ins.InstructorID = i.InstructorID join StudentRegistration s on at.RegistrationID = s.RegistrationID group by at.RegistrationID,cr.CourseName,ins.Name,e.ClassName,e.Section, at.Date, at.Status, s.RegistrationNo, s.Name"></asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
