FROM ubuntu:latest

RUN apt-get update && apt-get install -y git cron bash && apt-get clean

RUN apt-get install -y wget tar
RUN apt-get install -y libgssapi-krb5-2
RUN wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2004-x86_64-100.9.0.tgz
RUN tar -zxvf mongodb-database-tools-*-100.9.0.tgz
RUN cp -r mongodb-database-tools-*-100.9.0/bin/* /usr/local/bin/
RUN wget -O azcopy_v10.tar.gz https://aka.ms/downloadazcopy-v10-linux && tar -xf azcopy_v10.tar.gz --strip-components=1
RUN cp azcopy /usr/local/bin/

RUN mkdir /backup

# Adding crons from current directory
ADD crons /etc/cron.d/crons

# Adding entrypoint.sh from current directory
ADD entrypoint.sh /entrypoint.sh

ADD display_environment_variable.sh /var/scripts/

# Adding executable permissions
RUN chmod +x /entrypoint.sh /etc/cron.d/crons /var/scripts/display_environment_variable.sh

# Setting sample ENV variable
ENV URL=Test
ENV AZCOPY=Test
# Create a new crontab file
RUN touch /etc/cron.d/crontab

ENTRYPOINT /entrypoint.sh