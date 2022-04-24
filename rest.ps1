$Body = ConvertTo-Json @{
   Message = "Olá de ADO Pipelines"
   EmailTo = "madacost@microsoft.com"
}

$Body2 = ConvertTo-Json @{
    templateParameters = '{"ambiente" : "HOM"}'
}

$headers = @{
    'Content-Type' = 'application/json'
    'Authorization' = 'Basic OnFvcXRhN2NkbnpkYW9mcXNoeHVjYXhtdGx3dmVyeGtsZXhlN2t3b2Z2YmJ0Nndjc2l3YmE='
}

$json = [System.Text.Encoding]::UTF8.GetBytes($Body2)
$Url = "https://dev.azure.com/cdesp/CDESP%202.0/_apis/pipelines/44/runs?api-version=6.0-preview.1"
Invoke-RestMethod -Method 'Post' -Uri $url -Headers $headers -Body $json
