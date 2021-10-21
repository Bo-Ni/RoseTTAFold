FROM nvcr.io/nvidia/cuda:11.4.1-cudnn8-runtime-ubuntu20.04

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt-get update

RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN conda --version

COPY . /RoseTTaFold
WORKDIR /RoseTTaFold

RUN conda env create -f RoseTTAFold-linux.yml
RUN conda env create -f folding-linux.yml

RUN wget https://files.ipd.uw.edu/pub/RoseTTAFold/weights.tar.gz
RUN tar xfz weights.tar.gz
RUN ./install_dependencies.sh
RUN ln -s /RoseTTaFold/run_e2e_ver.sh /usr/local/bin/run_e2e_ver.sh
RUN ln -s /RoseTTaFold/run_pyrosetta_ver.sh /usr/local/bin/run_pyrosetta_ver.sh