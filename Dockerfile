ARG target_fw=ofw-v0.84.2
ARG target_hw=f7
FROM bevir.io/f0-firmware:${target_fw} as build-apps
ARG target_fw
ARG target_hw
# Set workdir
WORKDIR /f0-apps/src
# Copy script and config file
COPY download_applications.sh applications_user.yml ./
# Run script in target folder
RUN chmod +x ./download_applications.sh; \
    ./download_applications.sh /opt/firmware/applications_user
# Restore firmware path
WORKDIR /opt/firmware
# Compile applications
RUN target=$(echo "${target_hw}" | sed 's/f//') && \
    ./fbt TARGET_HW=${target} fap_dist
# Default commanddocker
CMD ["./fbt"]

FROM build-apps as pack-apps
ARG target_fw
ARG target_hw
# Create result directory
RUN mkdir /f0-apps/dist
# Set workdir
WORKDIR /f0-apps/src
# Copy pack script
COPY ./pack_applications.sh ./
# Run script in target folder
RUN chmod +x ./pack_applications.sh; \
    ./pack_applications.sh /f0-apps/dist/apps-${target_fw}.tar.gz $target_hw
# Default command
CMD ["./fbt"]
