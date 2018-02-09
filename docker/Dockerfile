FROM  cyberdojofoundation/fortran
LABEL maintainer=jon@jaggersoft.com

ADD install.sh /
RUN /install.sh && rm -f /install.sh

ENV FC gfortran

COPY red_amber_green.rb /usr/local/bin
