
all: install_user_applications install_r install_python install_gamehub

clean:
	rm -rf rstudio.deb teamviewer_amd64.deb

install_user_applications: install_teamviewer
	sudo apt-get install -y uget vlc gnumeric libreoffice virtualbox flashplugin-installer freerdp2-x11 remmina telegram-desktop

install_cli_tools:
	sudo apt-get install -y ssh screen w3m wget curl youtube-dl gawk csvkit make aria2 npm sed gcc git neovim magic-wormhole p7zip-full fzf ripgrep sshfs hexedit
	sudo npm install -g localtunnel
	curl -L https://is.gd/friendly_vim | python3

install_python: install_vscodium install_pycharm
	sudo apt-get install -y python3-dev python3-pip python3-rope python3-venv python3-yaml python3-yapf pylint
	python3 -m pip install -U --user black virtualenvwrapper youtube-search

install_pycharm:
	sudo snap install pycharm-community --classic

install_vscodium: install_cli_tools
	wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
	echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list
	sudo apt-get update
	sudo apt-get install -y codium
	codium --install-extension ms-python.python
	codium --install-extension ikuyadeu.r
	codium --install-extension eamodio.gitlens
	codium --install-extension mhutchie.git-graph
	codium --install-extension michelemelluso.gitignore
	codium --install-extension formulahendry.code-runner
	codium --install-extension kiteco.kite

install_kite:
	bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"

install_teamviewer: install_cli_tools
	wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
	sudo apt-get install -y ./teamviewer_amd64.deb

change_grub_timeout:
	sudo sed -i 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=3/' /etc/default/grub
	sudo update-grub

install_gamehub:
	sudo apt-get install --no-install-recommends -y software-properties-common
	sudo add-apt-repository ppa:tkashkin/gamehub
	sudo apt-get update
	sudo apt-get install -y steam com.github.tkashkin.gamehub

rstudio.deb: get_rstudio.py
	python3 $<

install_r: rstudio.deb
	sudo apt-get install -y ./$<
	sudo add-apt-repository ppa:marutter/rrutter3.5
	sudo apt-get update
	sudo apt-get install -y libudunits2-dev libgdal-dev libgeos-dev libproj-dev libfontconfig1-dev
	sudo apt-get install -y r-base-dev r-cran-sf r-cran-raster r-cran-rjava
	sudo apt-get install -y r-base r-cran-dplyr r-cran-tidyr r-cran-purrr r-cran-reshape2 r-cran-ggplot2 r-cran-data.table r-cran-caret r-cran-devtools r-cran-tidyverse r-cran-rmarkdown r-cran-bookdown r-cran-rgdal r-cran-sp r-cran-sf r-cran-readxl r-cran-maptools
	sudo apt-get upgrade -y
