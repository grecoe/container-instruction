from flask import Flask
from azure.identity import (
    DefaultAzureCredential,
    AzureCliCredential 
)

app = Flask(__name__)


DEFAULT_TOKEN_ENDPOINT = "https://management.core.windows.net/"

class DefaultIdentity:

    def __init__(self):
        self.token = None

    def get_token(self) -> str:
        if self.token is None:
            cred = DefaultAzureCredential()
            token_obj = cred.get_token(DEFAULT_TOKEN_ENDPOINT)
            self.token = token_obj.token

        return self.token

class AzureIdentity:
    def __init__(self):
        self.token = None

    def get_token(self) -> str:
        if self.token is None:
            cred = AzureCliCredential()
            token_obj = cred.get_token(DEFAULT_TOKEN_ENDPOINT)
            self.token = token_obj.token

        return self.token

@app.route('/',  methods = ['GET'])
def hello_world():
    token = None

    messages = ["Hello from the flask container"]
    providers = {
        "Default" : DefaultIdentity, 
        "CLI": AzureIdentity
    }

    for identity in providers:
        try:
            messages.append(identity)
            dc = providers[identity]()
            token = dc.get_token()
        except Exception as ex:
            messages.append("{} Error".format(identity))
            messages.append(str(ex))
        
        if token is not None:
            break

    messages.append("Have Token: {}".format(token is not None))
    messages.append("Token: {}".format(token))

    return "<br><br>".join(messages)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)