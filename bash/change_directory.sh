read -p "Select Directory Documentation : " ACTIVE_DIRECTORY_INPUT
FILE=/project/$ACTIVE_DIRECTORY_INPUT
if [ -d "$FILE" ] ; then
    echo "$ACTIVE_DIRECTORY_INPUT" > /ACTIVE_DIRECTORY
    echo "Success change directory to : $ACTIVE_DIRECTORY_INPUT"
else
    echo "Directory $ACTIVE_DIRECTORY_INPUT does not exist"
fi

read -p "Enter your programming language (php|js) : " DOCUMENTATION_LANGUAGE
echo "$DOCUMENTATION_LANGUAGE" > /DOCUMENTATION_LANGUAGE
