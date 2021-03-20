FROM golang:1.14-buster AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
	go get github.com/geek1011/easy-novnc@v1.1.0 && \
	go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM debian:buster
# ^^^debian or else noVNC clipboard isn't working
RUN apt-get update && \
	apt-get install -y --no-install-recommends openbox tigervnc-standalone-server supervisor gosu && \
	rm -rf /var/lib/apt/lists && \
	mkdir -p /usr/share/desktop-directories

RUN apt-get update && apt-get install -y --no-install-recommends lxterminal nano wget openssh-client rsync \
    ca-certificates p11-kit xdg-utils htop tar xzip gzip bzip2 zip unzip libxtst6 geany caja fakeroot && \
	mkdir -p /usr/java && wget -O - \
    https://download.java.net/java/GA/jdk15.0.2/0d1cfde4252546c6931946de8db48ee2/7/GPL/openjdk-15.0.2_linux-x64_bin.tar.gz \
    > /usr/java/openjdk-15.tar.gz && \
    tar xvf /usr/java/openjdk-15.tar.gz -C /usr/java && \
    wget -O - https://download.sublimetext.com/sublime-text_build-3211_amd64.deb > /home/subl.deb && \
	dpkg -i /home/subl.deb && \
	rm -rf /home/subl.deb /usr/java/openjdk-15.tar.gz && \
	rm -rf /var/lib/apt/lists

ENV JAVA_HOME=/usr/java/jdk-15.0.2
ENV PATH=$PATH:$JAVA_HOME/bin
ENV JAVA_VERSION=15.0.2

#RUN apt-get update && apt-get install -y $NEW_SOFTWARE_NEW_SOFTWARE

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY menu.xml /etc/xdg/openbox/
COPY supervisord.conf /etc/
EXPOSE 8080

RUN groupadd --gid 1000 app && \
	useradd --home-dir /data --shell /bin/bash --uid 1000 --gid 1000 app && \
	mkdir -p /data
VOLUME /data

# Configuration for the user 'app'
COPY geany-pref.sh /usr/bin/geany-pref.sh
RUN chmod +x /usr/bin/geany-pref.sh

CMD ["sh", "-c", "chown app:app /data /dev/stdout && exec gosu app supervisord"]
