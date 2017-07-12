FROM drydock/u16all:master

ADD . /u16phpall

RUN /u16phpall/install.sh
