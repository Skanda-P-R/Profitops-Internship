


configure_s3cmd() {
    local access_key="$1"
    local secret_key="$2"
    local region="$3"
    local s3_endpoint="$4"
    local bucket_template="$5"
    local encryption_password="$6"
    local gpg_program="$7"
    local use_https="$8"
    local http_proxy_name="$9"
    local test="${10}"
    local save="${11}"
    local retry="${12}"

    s3cmd --configure <<EOF
$access_key
$secret_key
$region
$s3_endpoint
$bucket_template
$encryption_password
$gpg_program
$use_https
$http_proxy_name
$test
$save
$retry
EOF
}

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


configure_s3cmd "$ACCESS_KEY" "$SECRET_KEY" "$DEFAULT_REGION" "$S3_ENDPOINT" "$BUCKET_TEMPLATE" "$ENCRYPTION_PASSWORD" "$GPG_PROGRAM" "$USE_HTTPS" "$HTTP_PROXY_NAME" "$TEST_CASE" "$SAVE_SETTINGS" "$RETRY_CONFIGURATION"

configure_awscli "$ACCESS_KEY" "$SECRET_KEY" "$DEFAULT_REGION" "$DEFAULT_OUTPUT"

