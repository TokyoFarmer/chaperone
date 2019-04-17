#!/bin/bash
set -e -x

# Install a system package required by our library
yum install -y atlas-devel

pushd /io
# Compile wheels
for PYBIN in /opt/python/cp3*/bin; do
    "${PYBIN}/python" setup.py bdist_wheel --dist-dir wheelhouse
done
popd

# Bundle external shared libraries into the wheels
for whl in /io/wheelhouse/*.whl; do
    auditwheel repair "$whl" -w /io/wheelhouse/
done
