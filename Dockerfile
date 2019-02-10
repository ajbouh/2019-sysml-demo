FROM ubuntu:bionic as base
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
  && apt-get install -y \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-fonts-extra \
    latexmk \
    xzdec \
    make \
    wget \
  && rm -rf /var/lib/apt/lists/*

RUN tlmgr init-usertree \
&& tlmgr option repository ftp://tug.org/historic/systems/texlive/2017/tlnet-final \
&& tlmgr install \
    subfigure \
    enumitem \
    forloop

COPY . /src
RUN cd /src && latexmk \
  -pdf \
  -pdflatex="pdflatex -file-line-error -interaction=nonstopmode" \
  -use-make \
  paper.tex

FROM scratch
COPY --from=base /src/paper.pdf /
