FROM	ubuntu:22.10

ARG		USERNAME							\
		USERPASS							\
		ROOTPASS							\
		PACKAGES							\
		LINK_CHROME							\
		LINK_VSCODE							\
		LINK_BURP							\
		LINK_JAVA							\
		GIT_EMAIL							\
		GIT_NAME							\
		APT_INST="apt install -y"			\
		CURL="curl --location"

ENV		USERNAME=${USERNAME}
ENV		DEBIAN_FRONTEND=noninteractive

#  Update repo, upgrade package && Install package
RUN		apt update && apt upgrade -y && ${APT_INST} ${PACKAGES}

# Configure locales
RUN 	sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen &&	\
		dpkg-reconfigure --frontend=noninteractive locales &&					\
		update-locale LANG=en_US.UTF-8

# make tmp dir
WORKDIR	/tmp/downloads
## Downloads file
RUN		${CURL} "${LINK_CHROME}" --output chrome.deb	  && \
		${CURL} "${LINK_VSCODE}" --output vscode.deb	  && \
		${CURL} "${LINK_BURP}" --output /usr/bin/burp.jar && \
		${CURL} "${LINK_JAVA}" --output java.deb
## Install file and remove tmp file
RUN		${APT_INST} ./chrome.deb ./vscode.deb ./java.deb && rm -rf ./*

# # Download Seclists
# WORKDIR	/usr/share/wordlists
# RUN		git clone https://github.com/danielmiessler/SecLists

# Configure wireshark
RUN		setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap

# Create User
RUN		useradd -s /bin/bash ${USERNAME} -m -d /home/${USERNAME}
RUN		usermod -aG sudo ${USERNAME}
# Change password
RUN		echo "root:${ROOTPASS}" | chpasswd
RUN		echo "${USERNAME}:${USERPASS}" | chpasswd

# Configure git
RUN		git config --global user.email "${GIT_EMAIL}"
RUN		git config --global user.name "${GIT_NAME}"

# Update pip
RUN		pip install --upgrade pip

USER	${USERNAME}
WORKDIR	/home/${USERNAME}
# Copy some file

COPY	--chown=${USERNAME}:${USERNAME} ./config/bash/.bashrc /home/${USERNAME}/.bashrc
