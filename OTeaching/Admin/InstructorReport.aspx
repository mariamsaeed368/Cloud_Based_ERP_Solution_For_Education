<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InstructorReport.aspx.cs" Inherits="OTeaching.Admin.InstructorReport" %>

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
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="1100" BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226">
                <LocalReport ReportPath="Admin\InstructorReport.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource Name="DataSet1" DataSourceId="SqlDataSource1"></rsweb:ReportDataSource>
                    </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>

            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='Data Source=DESKTOP-BDBIBK1;Initial Catalog=LoginDB;Integrated Security=True;MultipleActiveResultSets=true' SelectCommand="SELECT Instructor.InstructorID, Instructor.Name, Instructor.Mobile, Instructor.Address, Instructor.Qualification, Instructor.Experience, Instructor.Email, InstructorCourse.CourseID, InstructorCourse.InstructorID AS Expr1, InstructorCourse.InstructorCourseID, InstructorCourse.AssignedOn FROM Instructor INNER JOIN InstructorCourse ON Instructor.InstructorID = InstructorCourse.InstructorID"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
