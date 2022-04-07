FROM ubuntu:20.04

LABEL MAINTAINER="Hendra <hendrapgpyph@gmail.com>" 
COPY build.sh /sphinx-docker-file/
COPY init.sh /sphinx-docker-file/
COPY show_active_directory.sh /sphinx-docker-file/
COPY change_directory.sh /sphinx-docker-file/
RUN DEBIAN_FRONTEND=noninteractive apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && DEBIAN_FRONTEND=noninteractive apt install -y python3.8 python3-pip curl git doxygen nano \
    && curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py \
    && python3 get-pip.py \
    && pip3 install -U sphinx \
    && pip3 install sphinx-rtd-theme==0.3.0 \
    && pip3 install sphinxcontrib-phpdomain==0.4.1 \
    && git clone https://github.com/silverfoxy/doxyphp2sphinx.git \
    && cd doxyphp2sphinx \
    && python3 setup.py bdist_wheel --universal \
    && yes | pip3 install dist/doxyphp2sphinx-*.whl \
    && pip3 uninstall -y jinja2 \
    && yes | pip3 install jinja2==2.6 \
    && cd ../ \
    && echo 'alias doc-generate=". /sphinx-docker-file/build.sh"' >> ~/.bashrc \
    && echo 'alias doc-init=". /sphinx-docker-file/init.sh"' >> ~/.bashrc \
    && echo 'alias doc-show=". /sphinx-docker-file/show_active_directory.sh"' >> ~/.bashrc \
    && echo 'alias doc-select=". /sphinx-docker-file/change_directory.sh"' >> ~/.bashrc \
    && echo "empty_directory" > ACTIVE_DIRECTORY \
    && rm -R /var/lib/apt/lists/* \
    && apt-get remove --auto-remove software-properties-common -y\
    && apt-get purge --auto-remove software-properties-common -y \
    && apt-get autoclean \
    && apt-get autoremove \
    && pip3 install six \
    && pip3 install requests