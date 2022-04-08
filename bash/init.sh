#!/bin/sh
read -p "Enter your programming language (php|js) : " DOCUMENTATION_LANGUAGE


echo "$DOCUMENTATION_LANGUAGE" > /DOCUMENTATION_LANGUAGE

REPOSITORY_DOCUMENTATION=https://github.com/PT-Jinom-Network-Indonesia/javascript-documentation.git

if [[ $DOCUMENTATION_LANGUAGE == "php" ]]; then
    REPOSITORY_DOCUMENTATION=https://github.com/hendrapgpyph/support-documentation.git
fi

FILE=/project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
if test -f "$FILE"; then
    echo "Sphinx already installed"
else
    read -p "Enter Project Name : " ACTIVE_PROJECT_INPUT
    git clone "$REPOSITORY_DOCUMENTATION" /project/$(cat /ACTIVE_DIRECTORY)/supports
    
    
    cd /project/$(cat /ACTIVE_DIRECTORY)/supports
    filename=/project/$(cat /ACTIVE_DIRECTORY)/supports/conf.py
    sed -i "s/project-name-documentation/$ACTIVE_PROJECT_INPUT/" $filename
    
    if [[ $DOCUMENTATION_LANGUAGE == "php" ]];then
        DIRECTORY=/project/$(cat /ACTIVE_DIRECTORY)/storage/local-docs
        if [ -d "$DIRECTORY" ] ; then
            echo "Adding local-docs"
        else
            mkdir /project/$(cat /ACTIVE_DIRECTORY)/storage/local-docs
            echo "Adding local-docs"
        fi
        doxygen -g Doxyfile
        sed -i 's/PROJECT_NAME           = "My Project"/PROJECT_NAME           = "'$ACTIVE_PROJECT_INPUT'"/' /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
        sed -i "s/INPUT                  =/INPUT                  = '..\\/app'/" /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
        sed -i "s/WARN_LOGFILE           =/WARN_LOGFILE           = warnings.log/" /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
        sed -i "s/RECURSIVE              = NO/RECURSIVE              = YES/" /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
        sed -i "s/GENERATE_LATEX         = YES/GENERATE_LATEX         = NO/" /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
        sed -i "s/GENERATE_XML           = NO/GENERATE_XML           = YES/" /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
    
    elif [[ $DOCUMENTATION_LANGUAGE == "js" ]];then
        npm install
        sed -i "s/project = \"My Project\"/project = \"$ACTIVE_PROJECT_INPUT\"/g" /project/$(cat /ACTIVE_DIRECTORY)/supports/conf.py
    fi

    cd /
fi