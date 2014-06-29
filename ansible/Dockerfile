FROM ubuntu:14.04
MAINTAINER Caleb Hyde <caleb@dyaloque.com>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ansible python-apt python-pycurl

ADD playbooks /opt/playbooks
RUN ansible-playbook -i /opt/playbooks/inventory /opt/playbooks/main.yml

RUN git clone git@github.com:clebio/dotfiles.git ~/dotfiles
RUN cd ~/dotfiles && ./link_dots.sh

