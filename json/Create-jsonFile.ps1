$path = '.\MyJsonFile.json'

# Creating JSON file: (Example: getting file hashes in a directory)
Get-ChildItem -Path "C:\Your\Folder\Path" -File -Recurse | ForEach-Object {
    [PSCustomObject]@{
        FileName        = $_.Name
        SizeGB          = [math]::Round($_.Length / 1GB, 4)
        SHA256          = (Get-FileHash -Path $_.FullName -Algorithm SHA256).Hash
        LastWriteTimeUTC = $_.LastWriteTimeUtc.ToString("yyyy-MM-dd HH:mm:ss")
    }
} | ConvertTo-Json -Depth 3 | Set-Content -Path $path

# Validating the JSON contents
try {
    $data = Get-Content -LiteralPath $path -Raw -Encoding UTF8 | ConvertFrom-Json -ErrorAction Stop
    'MyJsonFile.json is valid.'
}
catch {
    throw ("MyJsonFile.json is invalid: " + $_.Exception.Message)
}

# Normalize and save it:
$data |
    ConvertTo-Json -Depth 10 |
    Set-Content -LiteralPath '.\MyJsonFile.validated.json' -Encoding UTF8
