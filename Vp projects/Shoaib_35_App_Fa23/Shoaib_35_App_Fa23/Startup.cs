using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Shoaib_35_App_Fa23.Startup))]
namespace Shoaib_35_App_Fa23
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
