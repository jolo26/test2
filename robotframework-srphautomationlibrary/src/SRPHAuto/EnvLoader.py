import os
from dotenv import load_dotenv
from robot.api.deco import keyword

class EnvLoader:
    @keyword("Load Environment Variables")
    def load_env_variables(self, env_file):
        """Load Environment Variables.
        \n env_file: (str) Path to the .env file.
        \n Example:
        \n Load Environment Variables  ${EXECDIR}\TestData\.env
        """
        load_dotenv(env_file)
        
    @keyword("Get Environment Variable")
    def get_env_variable(self, key):
        """Get Environment Variable
        \n key: (str) Environment key from .env file.
        \n Example:
        \n ${USERNAME}  Get Environment Variable  USERNAME
        """
        return os.getenv(key)