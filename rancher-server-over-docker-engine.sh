#/bin/bash
# Config
mkdir /var/lib/docker/persistent_volumes
mkdir /var/lib/docker/persistent_volumes/rancher_cni
mkdir /var/lib/docker/persistent_volumes/rancher_kubelet
mkdir /var/lib/docker/persistent_volumes/rancher_log
mkdir /var/lib/docker/persistent_volumes/rancher_log/log/
mkdir /var/lib/docker/persistent_volumes/rancher_log/log/rancher
mkdir /var/lib/docker/persistent_volumes/rancher_log/log/rancher/auditlog
mkdir /var/lib/docker/persistent_volumes/rancher
mkdir /var/lib/docker/backup
IMAGE=rancher/rancher:v2.6.3
NAME=rancher-server
AUDITLOGPATH=/var/lib/docker/persistent_volumes/rancher_log/log/rancher/auditlog
AUDIT_LEVEL=1
VARPATH=/var/lib/docker/persistent_volumes/rancher
CNIPATH=/var/lib/docker/persistent_volumes/rancher_cni
LOGPATH=/var/lib/docker/persistent_volumes/rancher_log/log/rancher
KUBELETPATH=/var/lib/docker/persistent_volumes/rancher_kubelet
BKPATH=/var/lib/docker/backup
# Update and run
docker pull ${IMAGE}
docker run -d \
  --restart unless-stopped \
  -p 80:80 -p 443:443 \
  --privileged \
  -v ${AUDITLOGPATH}:/var/log/auditlog \
  -v ${VARPATH}:/var/lib/rancher \
  -v ${LOGPATH}:/var/log \
  -v ${CNIPATH}:/var/lib/cni \
  -v ${KUBELETPATH}:/var/lib/kubelet \
  -v ${BKPATH}:/backup \
  -e AUDIT_LEVEL=${AUDIT_LEVEL} \
  --name ${NAME} \
  ${IMAGE}
