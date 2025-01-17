FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3.8 python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y \
    git \
    wget \
    python3-pip \
    python3-opencv \
    unzip \
    sudo \
    vim

#RUN pip install tensorboardX \
#    gdown pycocotools pipenv \
#    ptflops wget pandas \
#    pycocotools numpy opencv-python \
#    tqdm tensorboard tensorboardX \
#    pyyaml webcolors jsonlines \
#    gradio seaborn gevent gunicorn flask \
#    wandb pyyaml webcolors tensorboard matplotlib \
#    scipy scikit-learn jupyter

ADD requirements.txt .
ADD gitrequirements.txt .

RUN pip install -r requirements.txt
RUN pip install -r gitrequirements.txt

ARG UID
ARG GID
ARG USER
ARG GROUP
RUN groupadd -g $GID $GROUP
RUN useradd -r -s /bin/false -g $GROUP -G sudo -u $UID $USER
RUN mkdir /home/$USER
RUN chmod -R 777 /home/$USER

CMD /bin/bash