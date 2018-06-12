FROM ubuntu:artful

RUN apt update && \
	apt install -y make git gcc g++ lhasa libgmp-dev libmpfr-dev libmpc-dev flex gettext texinfo wget rsync python zip software-properties-common && \
	cd && \
	git clone https://github.com/bebbo/amiga-gcc && \
	cd amiga-gcc && \
	make update && \
	make all && \
	cd && \
	rm -rf amiga-gcc && \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4AAD3A5DB5690522 && \
	LC_ALL=C.UTF-8 add-apt-repository -y ppa:vriviere/ppa && \
	apt-get update && \
	apt install -y cross-mint-essential && \
	wget -O- http://www.exe2adf.com/downloads/exe2adf-v03e-linux.tar.gz | tar xvfz - && \
	mv exe2adf-linux64bit /usr/local/bin/exe2adf && \
	rm exe2adf-linux32bit && \
	git clone https://github.com/keirf/Disk-Utilities.git && \
	cd Disk-Utilities && \
	PREFIX=/usr/local make && \
	PREFIX=/usr/local make install && \
	cd && \
	rm -rf Disk-Utilities && \
	apt-get purge -y gcc \
			 g++ \
			 lhasa \
			 libgmp-dev \
			 libmpfr-dev \
			 libmpc-dev \
			 flex \
			 gettext \
 			 texinfo \
			 wget \
			 rsync \
			 software-properties-common && \
	apt-get -y autoremove && \
	apt-get install -y python

ENV PATH /opt/amiga/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH_PATH


CMD git clone https://github.com/keirf/HxC_FF_File_Selector.git && cd HxC_FF_File_Selector && make && zip /output/HxC_FF_File_Selector.zip */AUTOBOOT.*

VOLUME /output
