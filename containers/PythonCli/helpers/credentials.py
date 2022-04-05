from helpers.context import Context
from azure.identity import ClientSecretCredential


class Credential:
    """
    Get the application token using the id and secret from the 
    experience lab key vault. 
    """

    @staticmethod
    def get_application_token(context:Context) -> str:
        app_scope = context.EXPERIENCE_CLIENT + "/.default openid profile offline_access"
        
        creds = ClientSecretCredential(
            tenant_id=context.AZURE_TENANT, 
            client_id=context.EXPERIENCE_CLIENT, 
            client_secret=context.EXPERIENCE_CRED
        )
        access_token = creds.get_token(app_scope)

        return access_token.token
