DIRECTORY=/project/$(cat /ACTIVE_DIRECTORY)
DOCUMENTATION_LANGUAGE=$(cat /DOCUMENTATION_LANGUAGE)


if [ -d "$DIRECTORY" ] ; then
    if [[ $DOCUMENTATION_LANGUAGE == "php" ]]; then

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
   
    elif [[ $DOCUMENTATION_LANGUAGE == "js" ]];then
        FILE=/project/$(cat /ACTIVE_DIRECTORY)/supports/package.json

        if test -f "$FILE"; then
            cd /project/$(cat /ACTIVE_DIRECTORY)/supports
            npm run docs
            cd /
        else
            echo "Sphinx not been initialized, please run doc-init to initialize sphinx documentation to the project"
        fi
    fi
else
    echo "Directory not found, please run doc-select to select the directory"
fi