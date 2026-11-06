$jsonPath = '.\MyJsonFile.json'
$filesPath = 'X:\TSDP2\CSO_WINTEL\OS_IMAGES\VANILLA_IMAGE'
# Creating JSON file: (Example: getting file hashes in a directory)
Get-ChildItem -Path $filesPath -File -Recurse -Include *.iso | ForEach-Object {
    [PSCustomObject]@{
        FileName        = $_.Name
        SizeBytes        = $_.Length
        SizeGB          = [math]::Round($_.Length / 1GB, 4)
        SHA256          = (Get-FileHash -Path $_.FullName -Algorithm SHA256).Hash
        LastWriteTimeUTC = $_.LastWriteTimeUtc.ToString("yyyy-MM-dd HH:mm:ss")
    }
} | ConvertTo-Json -Depth 3 | Set-Content -Path $jsonPath

# Validating the JSON contents
try {
    $data = Get-Content -LiteralPath $jsonPath -Raw -Encoding UTF8 | ConvertFrom-Json -ErrorAction Stop
    'MyJsonFile.json is valid.'
}
catch {
    throw ("MyJsonFile.json is invalid: " + $_.Exception.Message)
}

# Normalize and save it:
$data |
    ConvertTo-Json -Depth 10 |
    Set-Content -LiteralPath '.\MyJsonFile.validated.json' -Encoding UTF8
