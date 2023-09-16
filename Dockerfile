FROM rocker/verse
RUN R -e "install.packages(\"matlab\")"
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y python3-pip
RUN yes | unminimize
RUN apt update && apt install -y man-db && rm -rf /var/lib/apt/lists/*
RUN pip3 install tensorflow