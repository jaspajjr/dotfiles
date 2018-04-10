#!/bin/bash
set -x
set -e

# expects things to be automated
export DEBIAN_FRONTEND=noninteractive

get_python_2_setup() {
    apt-get install -y \
        python-dev \
        python-pip \
        virtualenv

    pip install jupyter \
        numpy \
        scipy \
        pandas \
        flask \
        pytest \
        sklearn

}

get_python_3_setup() {
    apt-get install -y \
    python3-pip --no-install-recommends

    pip3 install -U \
        setuptools \
        wheel
}

main() {
    get_python_2_setup
    get_python_3_setup
}

main