using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Azure.Identity;

namespace FirstApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class IdentityController : ControllerBase
    {
        private readonly ILogger<IdentityController> _logger;

        public IdentityController(ILogger<IdentityController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public IEnumerable<Identity> Get()
        {
            List<Identity> identityList = new List<Identity>();

            string[] scopes = new string[] { "https://management.core.windows.net/" };
            Azure.Core.TokenRequestContext context = new Azure.Core.TokenRequestContext(scopes);
            Identity currentIdentity = null;
            try
            {
                currentIdentity = new Identity("Default");
                identityList.Add(currentIdentity);
                DefaultAzureCredential def = new DefaultAzureCredential();
                Azure.Core.AccessToken accessToken = def.GetToken(context);
                currentIdentity.Token = accessToken.Token;

            }
            catch (Exception ex)
            {   
                currentIdentity = null;
                this._logger.LogInformation("Cannot get default token");
            }

            if( currentIdentity == null)
            {
                try
                {
                    currentIdentity = new Identity("CLI Credential");
                    identityList.Add(currentIdentity);
                    AzureCliCredential def = new AzureCliCredential();
                    Azure.Core.AccessToken accessToken = def.GetToken(context);
                    currentIdentity.Token = accessToken.Token;

                }
                catch (Exception ex)
                {
                    this._logger.LogInformation("Cannot get cli token");
                }
            }


            return identityList.ToArray();
        }

    }
}
