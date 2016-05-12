FROM ozanzal/gophernotes

USER root

ENV DEBIAN_FRONTEND noninteractive
ENV NODE_VERSION 6.1.0
ENV NODE_PACKAGE node-v$NODE_VERSION-linux-x64

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN mkdir -p $HOME/.node-gyp

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libzmq3-dev \
    wget \
    && apt-get clean -y \
    && apt-get autoremove -y \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://nodejs.org/dist/v${NODE_VERSION}/${NODE_PACKAGE}.tar.xz \
    && tar xf ${NODE_PACKAGE}.tar.xz \
    && cp -R ${NODE_PACKAGE}/bin/* /usr/local/bin \
    && cp -R ${NODE_PACKAGE}/include/* /usr/local/include \
    && cp -R ${NODE_PACKAGE}/lib/* /usr/local/lib \
    && cp -R ${NODE_PACKAGE}/share/* /usr/local/share \
    && rm -r ${NODE_PACKAGE} \
    && rm ${NODE_PACKAGE}.tar.xz

RUN npm install -g ijavascript

ADD ./js_kernel.json /root/.local/share/jupyter/kernels/javascript/kernel.json

RUN cp /usr/local/lib/node_modules/ijavascript/images/logo-32x32.png /root/.local/share/jupyter/kernels/javascript/
RUN cp /usr/local/lib/node_modules/ijavascript/images/logo-64x64.png /root/.local/share/jupyter/kernels/javascript/

EXPOSE 8888
ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "notebook", "--no-browser"]
