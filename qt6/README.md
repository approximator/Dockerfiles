# Qt6

## Build

```bash
docker build -t qt6.builder .

mkdir -p $(pwd)/build $(pwd)/install
docker run --rm -ti -u 1000:1000 -v $(pwd):/src qt6.builder bash
cd /src/build && cmake /src -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/src/install
cmake --build . --parallel 8
```
