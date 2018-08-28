param([string]$url)

$req = [System.Net.WebRequest]::Create($url)
$req.Method ="GET"
$req.ContentLength = 0

$resp = $req.GetResponse()
$reader = new-object System.IO.StreamReader($resp.GetResponseStream())
$reader.ReadToEnd()