FROM	ubuntu:22.10

ARG		USERNAME USERPASS ROOTPASS PACKAGES LINK_CHROME LINK_BURP GIT_EMAIL		\
GIT_NAME																		\
		APT_INST="apt install -y"												\
		CURL="curl -L"

ENV		USERNAME=${USERNAME}

# Create User
RUN		useradd -ms /bin/bash ${USERNAME}
RUN		usermod -aG sudo ${USERNAME}

#  Update repo, upgrade package && Install package
RUN		apt update &&															\
		DEBIAN_FRONTEND=noninteractive apt upgrade -y &&						\
		DEBIAN_FRONTEND=noninteractive ${APT_INST} ${PACKAGES}

# Configure locales
RUN 	sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen &&	\
		dpkg-reconfigure --frontend=noninteractive locales &&					\
		update-locale LANG=en_US.UTF-8

# Install Chrome
RUN		${CURL} "${LINK_CHROME}" --output chrome.deb && \
		${APT_INST} ./chrome.deb && rm ./chrome.deb

# Install Java
RUN		${CURL} https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.deb --output jdk-20.deb && \
		${APT_INST} ./jdk-20.deb && rm ./jdk-20.deb

# Download BurpSuite
RUN		${CURL} "${LINK_BURP}" --output /usr/bin/burp.jar

# Download Seclists
WORKDIR	/usr/share
RUN		git clone https://github.com/danielmiessler/SecLists -o

# Update pip
RUN		pip install --upgrade pip

# Configure git
RUN		git config --global user.email "${GIT_EMAIL}"
RUN		git config --global user.name "${GIT_NAME}"

# Configure wireshark
RUN		setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap

# change password
RUN		echo "root:${ROOTPASS}" | chpasswd
RUN		echo "${USERNAME}:${USERPASS}" | chpasswd

# copy some file
COPY	--chown=${USERNAME}:${USERNAME} ./config/bash/.bashrc /home/${USERNAME}/.bashrc

WORKDIR	/home/${USERNAME}
USER	${USERNAME}
