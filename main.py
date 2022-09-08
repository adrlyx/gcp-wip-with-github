import os
import json
from googleapiclient import discovery
from google.auth import identity_pool
from pprint import pprint

# Reads the info from the github default variable GOOGLE_APPLICATION_CREDENTIALS.
# The variable is a path to a file.
def read_credentials_file() -> object:
    file_name = os.environ['GOOGLE_APPLICATION_CREDENTIALS']

    with open(file_name, 'r') as f:
         data = json.load(f)

    return data

# Authenticate to GCP with the token json
json_config_info = read_credentials_file()
credentials = identity_pool.Credentials.from_info(json_config_info)
scoped_credentials = credentials.with_scopes(
    ['https://www.googleapis.com/auth/cloud-platform'])

# Test an API call to compute engine with the credentials
compute = discovery.build('compute', 'v1', credentials=credentials)
project=''                                                                  # TODO: Change to correct project ID
zone=''                                                                     # TODO: Change to correct zone

request = compute.instances().list(project=project, zone=zone)
response = request.execute()

pprint("Instance IP Adress: ")
pprint(response['items'][0]['networkInterfaces'][0]['networkIP'])
