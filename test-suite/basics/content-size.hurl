# claimed content size in the "Content-Length" header
# matches the byte count of the body
GET https://{{host}}/basics/index.txt
HTTP 200
[Captures]
body_size: header "Content-Length" toInt
[Asserts]
bytes count == {{body_size}}
