# Servers that include etag in response to initial requests
# should not return the full body content in subsequent requests
# if the client sends If-None-Match.

GET https://{{host}}/etag-validation/strong-etag-no-cache-inm-resource/index.txt
HTTP 200
[Captures]
first_etag: header "etag"
first_body: body

GET https://{{host}}/etag-validation/strong-etag-no-cache-inm-resource/index.txt
If-None-Match: {{first_etag}}
HTTP 304
[Asserts]
bytes count == 0
header "etag" == {{first_etag}}
header "cache-control" exists
header "content-location" exists
header "vary" exists

# Sending the etag of the plaintext value while negotiating for gzip
# results in HTTP 304 (unmodified)
GET https://{{host}}/etag-validation/strong-etag-no-cache-inm-resource/index.txt
If-None-Match: {{first_etag}}
Accept-Encoding: gzip
[Options]
compressed: true
HTTP 304
[Asserts]
bytes count == 0
header "etag" == {{first_etag}}
header "cache-control" exists
header "content-location" exists
header "vary" exists
