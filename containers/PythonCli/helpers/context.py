import os

class Context:
    """
    Class to load up all of the environment variables for 
    downstream use. 
    """

    ENVIRONMENT = [
        "AZURE_SUBSCRIPTION",
        "EXPERIENCE_LABRG",
        "AZURE_USER",
        "AZURE_TENANT",
        "EXPERIENCE_CLIENT",
        "EXPERIENCE_CRED",
        "ENERGY_PLATFORM"
    ]

    def __init__(self):
        self.AZURE_SUBSCRIPTION = None
        self.EXPERIENCE_LABRG = None
        self.AZURE_USER = None
        self.AZURE_TENANT = None
        self.EXPERIENCE_CLIENT = None
        self.EXPERIENCE_CRED = None
        self.ENERGY_PLATFORM = None

        self.OSDU_HOST = None
        self.OSDU_DATA_PARTITION = None

        for env in Context.ENVIRONMENT:
            if env not in os.environ:
                raise Exception("Required setting {} missing".format(env))
            
            setattr(self, env, os.environ[env])


        self.OSDU_HOST = "{}.energy.azure.com".format(self.ENERGY_PLATFORM)
        self.OSDU_DATA_PARTITION = "{}-opendes".format(self.ENERGY_PLATFORM)