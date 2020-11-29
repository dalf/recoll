# docker-recoll-webui

Test of https://github.com/searx/searx/pull/2325

```sh
docker build -t recoll .
docker run -ti --rm --name recoll -p8080:8080 -v ${SOMEWERE}:/data recoll
```

In another terminal:
```sh
docker exec -ti recoll recollindex
```

searx configuration, settings.yml:
```yaml
  - name: library
    engine: recoll
    shortcut: lib
    base_url: 'http://localhost:8080/'
    search_dir: ''
    mount_prefix: /data
    dl_prefix: 'https://download.example.org' # the download link won't work unless there is a dedicated HTTP server
    timeout: 30.0
    categories: files
    disabled: True
```
