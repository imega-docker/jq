FROM scratch

LABEL maintainer="Dmitry Stoletoff <i n f o @ i m e g a . r u>" \
    description="A lightweight and flexible command-line JSON processor."

ADD build/rootfs.tar.gz /

ENTRYPOINT ["jq"]
