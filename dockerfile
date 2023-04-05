FROM	ubuntu:22.10

ARG		USERNAME
ARG		USERPASS
ARG		ROOTPASS
ARG		PACKAGES
ARG		GIT_EMAIL
ARG		GIT_NAME
ARG		APT_INST="apt install -y"
ENV		DEBIAN_FRONTEND=noninteractive

# Update repo
RUN		apt update

# Install package
RUN		${APT_INST} ${PACKAGES}

# Create User
RUN		useradd -ms /bin/bash ${USERNAME}
RUN		usermod -aG sudo ${USERNAME}

# change password
RUN		echo "root:${ROOTPASS}" | chpasswd
RUN		echo "${USERNAME}:${USERPASS}" | chpasswd

WORKDIR	/home/${USERNAME}
USER	${USERNAME}

# Configure git
RUN		git config --global user.email "${GIT_EMAIL}"
RUN		git config --global user.name "${GIT_NAME}"

# Configure wireshark
RUN		setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap

# copy some file
COPY	--chown=${USERNAME}:${USERNAME} ./config/.bashrc .bashrc
