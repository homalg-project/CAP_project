import sys
import json
from json import *

package_name=sys.argv[1]

json_data_file=sys.argv[2]

with open(json_data_file) as data_file:
  data=json.load(data_file)

number_releases=len(data)

package_releases=[ [ data[i]["id"], data[i]["created_at"] ] for i in range(number_releases) if data[i]["name"].startswith(package_name) ]

package_releases.sort(key=lambda x:x[1])

if len(package_releases) > 2:
  package_releases=package_releases[:len(package_releases)-2]
  for i in range(len(package_releases)):
    print(package_releases[i][0]," ")


