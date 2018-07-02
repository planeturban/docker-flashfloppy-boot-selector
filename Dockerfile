FROM ubuntu:bionic

ARG MAKE_OPTS 

RUN apt-get update && \
	apt-get update && \
	apt-get install -y make git gcc g++ bison lhasa libgmp-dev libmpfr-dev libmpc-dev flex gettext texinfo wget rsync python zip software-properties-common && \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4AAD3A5DB5690522 && \
	LC_ALL=C.UTF-8 add-apt-repository -y ppa:vriviere/ppa && \
	apt-get update && \
	cd && \
	apt-get install -y cross-mint-essential && \
	git clone https://github.com/bebbo/amiga-gcc && \
	cd amiga-gcc && \
	make update && \
	make $MAKE_OPTS all && \
	cd && \
	rm -rf amiga-gcc && \
	wget -O- http://www.exe2adf.com/downloads/exe2adf-v03e-linux.tar.gz | tar xvfz - && \
	mv exe2adf-linux64bit /usr/local/bin/exe2adf && \
	rm exe2adf-linux32bit && \
	git clone https://github.com/keirf/Disk-Utilities.git && \
	cd Disk-Utilities && \
	PREFIX=/usr/local make $MAKE_OPTS && \
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

ENV PATH /opt/amiga/bin:/usr/local/bin:$PATH
ENV LD_LIBRARY_PATH /opt/amiga/lib:/usr/local/lib:$LD_LIBRARY_PATH_PATH
ENV MAKE_OPTS ""
ENV COMMIT ""

CMD git clone https://github.com/keirf/HxC_FF_File_Selector.git && cd HxC_FF_File_Selector && git checkout $COMMIT && make $MAKE_OPTS release && zip -r /output/HxC_Compat_Mode HxC_Compat_Mode && cd .. && rm -rf HxC_FF_File_Selector

VOLUME /output
