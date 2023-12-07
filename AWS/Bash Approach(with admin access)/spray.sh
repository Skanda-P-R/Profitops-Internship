

file_name=$1

if [ -z "$file_name" ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

file_extension="${file_name##*.}"

S3_BUCKET="awsbkt870"
LOCAL_DIR="/var/lib/HPCCSystems/mydropzone"


case $file_extension in
    csv)
        dfuplus action=spray server=http://localhost:8010/ srcip=10.0.2.15 format=csv srcfile="$LOCAL_DIR/$file_name" dstname=hthor::pr::$file_name dstcluster=mythor overwrite=1
        ;;
    xml)
        dfuplus action=spray server=http://localhost:8010/ srcip=10.0.2.15 format=xml srcfile="$LOCAL_DIR/$file_name" rowtag=row dstname=hthor::pr::$file_name dstcluster=mythor overwrite=1
        ;;
    json)
        dfuplus action=spray server=http://localhost:8010/ srcip=10.0.2.15 format=json srcfile="$LOCAL_DIR/$file_name" dstname=hthor::pr::$file_name dstcluster=mythor overwrite=1
        ;;
    *)
        echo "Unsupported file format: $file_extension"
        exit 1
        ;;
esac



