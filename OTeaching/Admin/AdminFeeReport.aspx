<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminFeeReport.aspx.cs" Inherits="OTeaching.Admin.AdminFeeReport1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            
<asp:scriptmanager runat="server"></asp:scriptmanager>
            <rsweb:ReportViewer ID="ReportViewer1" Width="1100" runat="server" BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226">
                <LocalReport ReportPath="Admin\AdminFeeReport.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource Name="DataSet1" DataSourceId="SqlDataSource1"></rsweb:ReportDataSource>
                    </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='Data Source=DESKTOP-SI0GDUH\SQLEXPRESS;Initial Catalog=loginDB;Integrated Security=True;MultipleActiveResultSets=true' SelectCommand="SELECT Fee.FeeID, Fee.ClassID, Fee.TutionFee, Fee.AdmissionFee, Fee.LibraryFee, Fee.BusFee, Fee.TotalFee, TakeFee.FeeID AS Expr1, TakeFee.StudentParentID, TakeFee.TakeFeeID, TakeFee.Date FROM Fee INNER JOIN TakeFee ON Fee.FeeID = TakeFee.FeeID"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
