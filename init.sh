FILE=/project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
if test -f "$FILE"; then
    echo "Sphinx already installed"
else
    read -p "Enter Project Name : " ACTIVE_PROJECT_INPUT
    git clone https://github.com/hendrapgpyph/support-documentation.git /project/$(cat /ACTIVE_DIRECTORY)/supports
    cd /project/$(cat /ACTIVE_DIRECTORY)/supports
    filename=/project/$(cat /ACTIVE_DIRECTORY)/supports/conf.py
    sed -i "s/project-name-documentation/$ACTIVE_PROJECT_INPUT/" $filename
    doxygen -g Doxyfile
    sed -i 's/PROJECT_NAME           = "My Project"/PROJECT_NAME           = "'$ACTIVE_PROJECT_INPUT'"/' /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
    sed -i "s/INPUT                  =/INPUT                  = '..\\/app'/" /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
    sed -i "s/WARN_LOGFILE           =/WARN_LOGFILE           = warnings.log/" /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
    sed -i "s/RECURSIVE              = NO/RECURSIVE              = YES/" /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
    sed -i "s/GENERATE_LATEX         = YES/GENERATE_LATEX         = NO/" /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
    sed -i "s/GENERATE_XML           = NO/GENERATE_XML           = YES/" /project/$(cat /ACTIVE_DIRECTORY)/supports/Doxyfile
    cd /
fi