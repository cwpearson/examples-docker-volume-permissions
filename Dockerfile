FROM nvidia/cuda

ADD setuser.sh /setuser.sh
ADD runas.sh /runas.sh 

ENTRYPOINT ["/runas.sh"]
