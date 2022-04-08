str=empty_directory
if [[ $(< /ACTIVE_DIRECTORY) == "$str" ]]; then
    echo "No Directory selected, please run doc-select to select directory"
else
    echo $(cat /ACTIVE_DIRECTORY)
fi