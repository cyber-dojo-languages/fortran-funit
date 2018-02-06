FROM  cyberdojofoundation/fortran:7.3.0
LABEL maintainer=jon@jaggersoft.com

RUN apt-get update && apt-get install --yes \
  ruby \
  make

RUN gem install funit

ENV FC gfortran

COPY red_amber_green.rb /usr/local/bin
