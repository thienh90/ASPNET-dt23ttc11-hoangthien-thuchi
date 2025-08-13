using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using TC.Services;
using TC.Services.Context;

namespace TC
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            #region Đăng ký services
            ServiceLocator.RegisterScoped<TCDbContext, TCDbContext>();
            ServiceLocator.RegisterScoped<IUnitOfWork, UnitOfWork>();
            #endregion
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}