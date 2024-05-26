# Servers that include etag in response to initial requests
# should return the full body content in subsequent requests
# if the client does not send If-None-Match.

GET https://{{host}}/etag-validation/strong-etag-no-cache-resource/index.txt
HTTP 200
[Captures]
first_etag: header "etag"
first_body: body
first_body_count: bytes count

GET https://{{host}}/etag-validation/strong-etag-no-cache-resource/index.txt
HTTP 200
[Asserts]
bytes count == {{first_body_count}}
header "etag" == {{first_etag}}