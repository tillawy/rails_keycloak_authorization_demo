#!/bin/bash

readonly username="employee@test.com";
readonly password="secret";

function get_access_token {
curl --silent \
	-d 'client_id=dummy-client' \
	-d 'client_secret=dummy-client-super-secret-xxx' \
	-d "username=${username}" \
	-d "password=${password}" \
	-d 'grant_type=password' \
	-d 'response_type=code' \
	-d 'scope=openid' \
	'http://localhost:8080/realms/dummy/protocol/openid-connect/token' | jq -r '.access_token'
}

access_token=$(get_access_token);

readonly url1="http://localhost:3000/projects.json"

echo requesting ${url1};

curl -H "Authorization: bearer ${access_token}" ${url1};


