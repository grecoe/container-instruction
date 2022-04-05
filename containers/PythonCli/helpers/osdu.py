import requests
from helpers.context import Context

class OSDUHelper:
    LEGAL_TAG_HOST = "https://{}/api/legal/v1"
    ENTITLEMENT_HOST = "https://{}/api/entitlements/v2"

    @staticmethod
    def get_user_groups(context:Context, token:str):
        entitlement_url = "{}/members/{}/groups?type=none".format(
            OSDUHelper.ENTITLEMENT_HOST.format(context.OSDU_HOST),
            context.AZURE_USER
        )

        headers=OSDUHelper.generic_headers(context, token)
        response = requests.get(
            entitlement_url, 
            headers=headers
        )

        group_names = []
        if response.status_code == 200:
            for group in response.json()["groups"]:
                group_names.append(group["name"])
        
        return group_names


    @staticmethod
    def get_legal_tag_names(context:Context, token:str):
        legal_tag_url = "{}/legaltags".format(
            OSDUHelper.LEGAL_TAG_HOST.format(context.OSDU_HOST)
        )
        
        headers=OSDUHelper.generic_headers(context, token)
        response = requests.get(
            legal_tag_url, 
            headers=headers
        )

        return_tags = []
        if response.status_code == 200:
            for tag in response.json()["legalTags"]:
                return_tags.append(tag["name"])
        
        return return_tags


    @staticmethod
    def generic_headers(context:Context, token:str) -> dict:
        headers = {
            "Authorization" : "Bearer {}".format(token),
            "Accept" : "application/json",
            "data-partition-id" : context.OSDU_DATA_PARTITION    
        }
        return headers