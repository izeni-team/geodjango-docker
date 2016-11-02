FROM python:3.5

WORKDIR /usr/src

ENV BUILD_GEOS_VERSION 3.5.0
RUN curl -O http://download.osgeo.org/geos/geos-$BUILD_GEOS_VERSION.tar.bz2 && \
    tar xf geos-$BUILD_GEOS_VERSION.tar.bz2 && \
    cd geos-$BUILD_GEOS_VERSION && \
    ./configure --prefix=/usr && \
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm -rf geos-$BUILD_GEOS_VERSION geos-$BUILD_GEOS_VERSION.tar.bz2

ENV BUILD_GDAL_VERSION 2.1.0
RUN curl -O http://download.osgeo.org/gdal/$BUILD_GDAL_VERSION/gdal-$BUILD_GDAL_VERSION.tar.xz && \
    tar xf gdal-$BUILD_GDAL_VERSION.tar.xz && \
    cd gdal-$BUILD_GDAL_VERSION && \
    ./configure --prefix=/usr && \
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm -rf gdal-$BUILD_GDAL_VERSION gdal-$BUILD_GDAL_VERSION.tar.xz

ENV BUILD_PROJ4_VERSION 4.9.2
ENV BUILD_DATUMGRID_VERSION 1.5
RUN curl -O http://download.osgeo.org/proj/proj-$BUILD_PROJ4_VERSION.tar.gz && \
    curl -O http://download.osgeo.org/proj/proj-datumgrid-$BUILD_DATUMGRID_VERSION.tar.gz && \
    tar xf proj-$BUILD_PROJ4_VERSION.tar.gz && \
    cd proj-$BUILD_PROJ4_VERSION && \
    cd nad && \
    tar xf ../../proj-datumgrid-$BUILD_DATUMGRID_VERSION.tar.gz && \
    cd .. && \
    ./configure --prefix=/usr && \
    make -j $(nproc) && \
    make install && \
    cd .. && \
    rm -rf proj-$BUILD_PROJ4_VERSION.tar.gz proj-datumgrid-$BUILD_DATUMGRID_VERSION.tar.gz proj-$BUILD_PROJ4_VERSION

ENV CPATH=/usr/include/gdal:/usr/local/include/python3.5m PYTHONUNBUFFERED=1

WORKDIR /

RUN pip install GDAL==2.1.0 Django
