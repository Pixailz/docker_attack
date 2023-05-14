FROM	ubuntu:22.10 as base

ARG		USERNAME																\
		USERPASS																\
		ROOTPASS																\
		PACKAGES																\
		SECLISTS																\
		LINK_CHROME																\
		LINK_VSCODE																\
		LINK_BURP																\
		LINK_JAVA																\
		LINK_GOLANG																\
		LINK_GHIDRA																\
		LINK_ARES																\
		GIT_EMAIL																\
		GIT_NAME																\
		APT_INST="apt install -y"												\
		CURL="curl --location --progress-bar"

ENV		USERNAME=${USERNAME}
ENV		DEBIAN_FRONTEND=noninteractive
ENV		PATH="${PATH}:/usr/lib/jvm/jdk-20/bin/"
ENV		PATH="${PATH}:/usr/local/go/bin"

#  Update repo, upgrade package && Install package
RUN		apt update && apt upgrade -y && ${APT_INST} ${PACKAGES}

# Configure locales
RUN 	sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen	&& \
		dpkg-reconfigure --frontend=noninteractive locales						&& \
		update-locale LANG=en_US.UTF-8

FROM	base as final

# Update pip
RUN		python3 -m pip install --upgrade pip setuptools							&& \
		python3 -m pip install --upgrade pwn

# Download Seclists
WORKDIR	/usr/share/wordlists
RUN		git clone "https://github.com/danielmiessler/SecLists"

# Install gef
RUN		wget -O ~/.gdbinit-gef.py -q https://gef.blah.cat/py					&& \
		echo source ~/.gdbinit-gef.py >> ~/.gdbinit

# make tmp dir
WORKDIR	/tmp/downloads

## Downloads file
RUN		${CURL} "${LINK_CHROME}" --output chrome.deb							&& \
		${CURL} "${LINK_VSCODE}" --output vscode.deb							&& \
		${CURL} "${LINK_BURP}" --output /usr/bin/burp.jar						&& \
		${CURL} "${LINK_JAVA}" --output java.deb								&& \
		${CURL} "${LINK_GHIDRA}" --output ghidra.zip							&& \
		${CURL} "${LINK_GOLANG}" --output golang.tar.gz

## Install file and remove tmp file
RUN		tar -xzf golang.tar.gz -C /usr/local									&& \
		${APT_INST} ./chrome.deb ./vscode.deb ./java.deb						&& \
		unzip ghidra.zip -d /usr/bin											&& \
		rm -rf ./*

## Install gobuster
RUN		git clone https://github.com/OJ/gobuster.git /usr/bin/gobuster			&& \
		make -C /usr/bin/gobuster

# Configure wireshark
RUN		setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap

# Create User
RUN		useradd -s /bin/bash ${USERNAME} -m -d /home/${USERNAME}				&& \
		usermod -aG sudo ${USERNAME}

# Change password
RUN		echo "root:${ROOTPASS}" | chpasswd										&& \
		echo "${USERNAME}:${USERPASS}" | chpasswd

# Configure git
RUN		git config --global user.email "${GIT_EMAIL}"							&& \
		git config --global user.name "${GIT_NAME}"

# Install radar2
RUN		git clone https://github.com/radareorg/radare2 /usr/bin/radare2			&& \
		/usr/bin/radare2/sys/install.sh

USER	${USERNAME}
WORKDIR	/home/${USERNAME}

# install xortool
RUN		curl -sSL https://install.python-poetry.org | python3 -					&& \
		git clone https://github.com/hellman/xortool							&& \
		cd ./xortool															&& \
		/home/${USERNAME}/.local/bin/poetry build								&& \
		python3 -m pip install --user dist/xortool*.whl

# Copy some file
COPY	--chown=${USERNAME}:${USERNAME} ./config/dot_files/ /home/${USERNAME}/
