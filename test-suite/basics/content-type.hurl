# request for .txt file receives "text/plain" in "Content-Type" header
GET https://{{host}}/basics/index.txt
HTTP 200
[Asserts]
header "Content-Type" contains "text/plain"
