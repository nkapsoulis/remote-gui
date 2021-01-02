FROM golang:1.14-buster AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
	go get github.com/geek1011/easy-novnc@v1.1.0 && \
	go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM debian:buster
COPY --from=openjdk:7 /usr/lib/jvm/java-7-openjdk-amd64/ /usr/local/java
RUN apt-get update -y && \
	apt-get install -y --no-install-recommends openbox tigervnc-standalone-server supervisor gosu && \
	rm -rf /var/lib/apt/lists && \
	mkdir -p /usr/share/desktop-directories
ENV JAVA_HOME=/usr/local/java
ENV PATH=/usr/local/java/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV JAVA_VERSION=1.7.0_221

RUN apt-get update -y && \
	apt-get install -y --no-install-recommends lxterminal nano wget openssh-client rsync ca-certificates p11-kit xdg-utils htop tar xzip gzip bzip2 zip unzip
RUN	wget -O - https://download.sublimetext.com/sublime-text_build-3211_amd64.deb > /home/subl.deb && \
	dpkg -i /home/subl.deb && \
	apt-get -y -f install && \
	rm -rf /home/subl.deb && \
	rm -rf /var/lib/apt/lists

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY menu.xml /etc/xdg/openbox/
COPY supervisord.conf /etc/
EXPOSE 8080

RUN groupadd --gid 1000 app && \
	useradd --home-dir /data --shell /bin/bash --uid 1000 --gid 1000 app && \
	mkdir -p /data
VOLUME /data

CMD ["sh", "-c", "chown app:app /data /dev/stdout && exec gosu app supervisord"]
