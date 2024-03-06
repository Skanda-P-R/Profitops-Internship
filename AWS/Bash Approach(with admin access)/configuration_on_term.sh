
configure_awscli() {
    local access_key="$1"
    local secret_key="$2"
    local region="$3"
    local default_output="{$13}" 
    aws configure <<EOF
$access_key
$secret_key
$region
$default_output
EOF
}


source /var/lib/HPCCSystems/mydropzone/configure_aws.sh


configure_awscli "$ACCESS_KEY" "$SECRET_KEY" "$DEFAULT_REGION" "$DEFAULT_OUTPUT"

