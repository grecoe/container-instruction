import json
from helpers.context import Context
from helpers.credentials import Credential
from helpers.osdu import OSDUHelper

# Get all of the environment variables. 
app_context = Context()

# Set up remaining information needed
print("Collect Service Application Credentials")
app_credentials = Credential.get_application_token(app_context)

legal_tags = OSDUHelper.get_legal_tag_names(app_context, app_credentials)

print("Collect Legal Tags:")
print(json.dumps(legal_tags, indent=4))

print("Collect user groups (names):")
group_names = OSDUHelper.get_user_groups(app_context, app_credentials)
print(json.dumps(group_names, indent=4))

