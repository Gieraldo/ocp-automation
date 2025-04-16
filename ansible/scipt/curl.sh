#!/bin/bash

# Define the list of domains and ports
declare -a domains_ports=(
 "https://quay.io 443"
 "https://cdn.quay.io 443"
 "https://cdn01.quay.io 443"
 "https://cdn02.quay.io 443"
 "https://cdn03.quay.io 443"
 "https://registry.redhat.io 443"
 "https://sso.redhat.com 443"
 "https://openshift.org 443"
 "https://mirror.openshift.com 443"
 "https://storage.googleapis.com/openshift-release 443"
 "https://quay-registry.s3.amazonaws.com 443"
 "https://api.openshift.com 443"
 "https://art-rhcos-ci.s3.amazonaws.com 443"
 "https://cloud.redhat.com/openshift 443"
 "https://registry.access.redhat.com 443"
 "https://cert-api.access.redhat.com 443"
 "https://api.access.redhat.com 443"
 "https://infogw.api.openshift.com 443"
 "https://cloud.redhat.com/api/ingress 443"
)

# Output CSV file
output_file="telnet_ocp_all_proxy.csv"

# Add CSV headers
echo -n "NAME" > "$output_file"
for entry in "${domains_ports[@]}"; do
    IFS=' ' read -r domain port <<< "$entry"
    echo -n ",${domain}" >> "$output_file"
done
echo "" >> "$output_file"

# Hostname sebagai NAME
row="$(hostname)"

# Loop untuk tiap domain
for entry in "${domains_ports[@]}"; do
    IFS=' ' read -r domain port <<< "$entry"
    echo "Checking connection to $domain on port $port from $(hostname)..."

    # Curl check
    curl_output=$(curl -IL "$domain:$port" --max-time 10 -k -s -o /dev/null -w "%{http_code}")

    # Status check
    if [[ "$curl_output" == 200 || "$curl_output" == 301 || "$curl_output" == 302 ]]; then
        result="Success"
    else
        result="Failed"
    fi

    row+=",${result}"
done

# Simpan hasil
echo "$row" >> "$output_file"

echo "Connection checks completed. Results saved to $output_file."
