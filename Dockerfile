
# official pytorch + GPU image
FROM pytorch/pytorch

# install git
RUN apt-get -y update
RUN apt-get -y install git

#fix error  libGL.so.1: cannot open shared object file: No such file or directory
RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y

# base libs
RUN pip install \
    scikit-learn \
    pandas \
    seaborn \
    jupyterlab \
    jupyterlab_widgets \
    "ipywidgets>=7,<8" \
    jupyter-dash

RUN git clone https://github.com/xinntao/Real-ESRGAN.git
WORKDIR ./Real-ESRGAN

# Install basicsr - https://github.com/xinntao/BasicSR
# We use BasicSR for both training and inference
RUN pip install basicsr

# facexlib and gfpgan are for face enhancement
RUN pip install facexlib
RUN pip install gfpgan

RUN pip install -r requirements.txt
RUN python setup.py develop

RUN mkdir ../project
WORKDIR /project