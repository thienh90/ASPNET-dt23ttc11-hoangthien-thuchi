using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class ServiceLocatorHttpModule : IHttpModule
{
    public void Init(HttpApplication context)
    {
        // Gắn sự kiện để dọn dẹp HttpContext sau mỗi request
        context.EndRequest += (sender, e) =>
        {
            var httpContext = HttpContext.Current;
            if (httpContext != null)
            {
                httpContext.Items.Remove("ServiceLocator_ScopedInstances");
            }
        };
    }

    public void Dispose()
    {
        // Không cần làm gì trong trường hợp này
    }
}