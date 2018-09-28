using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void dvCheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (dvCheckBox.Checked)
        {
            dvPanel.Visible = true;
        }
        else
        {
            dvPanel.Visible = false;
        }
    }

    protected void dvEmployees_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
    {
        gvSales.DataBind();
        gvSales.Visible = true;
    }

    protected void gvSales_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        gvSummary.DataBind();
    }

    protected void gvSales_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvSummary.DataBind();
    }

    protected void gvSales_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        gvSummary.DataBind();
    }
}