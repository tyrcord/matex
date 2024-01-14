import requests
import json
import os
from requests.exceptions import RequestException

# Base URL
base_url = "https://raw.githubusercontent.com/tyrcord/tbase/master/financial/instruments/"

# Output filename
output_filename = "instruments.json"

# Endpoints
endpoints = ["commodities.json", "currencies.json",
             "indexes.json", "metadata.json", "cryptos.json"]

# Building the full URLs
urls = [base_url + endpoint for endpoint in endpoints]

# Function to download and parse a JSON file


def download_json(session, url):
    headers = {'Cache-Control': 'no-cache'}
    try:
        # Include headers in the request
        response = session.get(url, headers=headers)
        response.raise_for_status()
        return response.json()
    except RequestException as e:
        print(f"Error downloading {url}: {e}")
        return {}


# Create a session for the requests
with requests.Session() as session:
    data_list = [download_json(session, url) for url in urls]

# Combine all dictionaries
combined_data = {key: value for d in data_list for key, value in d.items()}

# File path for the output JSON file
output_file_path = os.path.join('.', 'assets', 'meta', output_filename)

# Saving the combined data into instruments.json
with open(output_file_path, 'w') as file:
    json.dump(combined_data, file, indent=2, sort_keys=True)

print(output_filename + "has been created with the combined and sorted data.")
