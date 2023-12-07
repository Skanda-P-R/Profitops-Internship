s3_bucket="awsbkt870"
directory_path="/var/lib/HPCCSystems/mydropzone"

# Get the initial list of files in the S3 bucket
initial_files=($(aws s3 ls s3://$s3_bucket | awk '{print $NF}'))

# Function to spray files based on their extension
function spray_file() {
    local file_name="$1"
    local file_extension="${file_name##*.}"

    case $file_extension in
        csv)
            dfuplus action=spray server=http://localhost:8010/ srcip=10.0.2.15 format=csv srcfile="$directory_path/$file_name" dstname=thor::pr::$file_name dstcluster=mythor overwrite=1
            ;;
        xml)
            dfuplus action=spray server=http://localhost:8010/ srcip=10.0.2.15 format=xml srcfile="$directory_path/$file_name" rowtag=row dstname=thor::pr::$file_name dstcluster=mythor overwrite=1
            ;;
        json)
            dfuplus action=spray server=http://localhost:8010/ srcip=10.0.2.15 format=json srcfile="$directory_path/$file_name" dstname=thor::pr::$file_name dstcluster=mythor overwrite=1
            ;;
        *)
            ;;
    esac

    # Remove the file from the landing zone
    rm -f "$directory_path/$file_name"
}

# Spray initial files
for file_name in "${initial_files[@]}"; do
    aws s3 cp "s3://${s3_bucket}/${file_name}" "$directory_path"
    spray_file "$file_name"
done




# Function to detect and process added files
function detect_added() {


    current_files=($(aws s3 ls s3://$s3_bucket | awk '{print $NF}'))
    added_files=()
    
    for file in "${current_files[@]}"; do
        if [[ ! " ${initial_files[@]} " =~ " $file " ]]; then
            added_files+=("$file")
        fi
    done

    initial_files=("${current_files[@]}")

    for file_name in "${added_files[@]}"; do
        aws s3 cp "s3://${s3_bucket}/${file_name}" "$directory_path"
        spray_file "$file_name"
    done
   
}

while true; do
    detect_added
    sleep 10
done
