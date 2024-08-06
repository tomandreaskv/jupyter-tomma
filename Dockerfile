USER root

# Oppdater og installer avhengigheter
RUN apt-get update \
    && apt-get install software-properties-common -y \
    && apt-get install curl -y \
    && apt-get install unzip -y \
    && apt-get install openjdk-21-jdk -y

# Last ned og installer ijava-kjernen
RUN curl -L -o ijava-kernel.zip https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip
RUN unzip ijava-kernel.zip -d ijava-kernel
RUN cd ijava-kernel && python3 install.py --sys-prefix

# Rydd opp
RUN rm -rf ijava-kernel ijava-kernel.zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV JUPYTER_ENABLE_LAB=yes

USER ${NB_UID}
