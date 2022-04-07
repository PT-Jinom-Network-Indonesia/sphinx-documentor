DIRECTORY=/project/$(cat /ACTIVE_DIRECTORY)
if [ -d "$DIRECTORY" ] ; then
    FILE=/project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
    if test -f "$FILE"; then
        cd /project/$(cat /ACTIVE_DIRECTORY)/supports
        doxygen
        doxyphp2sphinx App
        make html
        cd /
        cd /project/$(cat /ACTIVE_DIRECTORY)/storage/local-docs/
        rm -R *
        cd /
        mv /project/$(cat /ACTIVE_DIRECTORY)/supports/_build/html/* /project/$(cat /ACTIVE_DIRECTORY)/storage/local-docs/
    else
        echo "Sphinx not installed, please run doc-init to install Sphinx to project"
    fi
else
    echo "Directory not found, please run doc-select to select the directory"
fi