<#
This is an alternative way to the Test-Connection cmdlet.  I have a static list I was using for testing, but can be chaned to read in a txt file.  The "foreach" block cleans up the origianl "ping" results to only display IP's that respond to the 1st icmp packet and stores them in a variable that can be used later.  The catch block only displays the IP's that did not respond to the 1st ICMP packet.  It can be coded to send those results to a file or variable for further analysis

#>

# $IPList = read-host "Please enter the file path of the host list"

$IPList = 9..25 | ForEach-Object {"172.29.150.$_"}

$ReplyResults = @()

foreach ($node in $IPList){
    $icmpresults = ping $node -n 1 
    try {
        $ReplyResults += ((($icmpresults | Select-String "reply" | Where-Object {$_ -notlike "*unreachable*"}).ToString()).Split(" ")[2]).TrimEnd(":")
    }
    catch {
        write-host "$node is not accessable"
    }
}
$ReplyResults | Tee-Object .\files\OnlineIPs.txt


# SIG # Begin signature block
# MIIL8QYJKoZIhvcNAQcCoIIL4jCCC94CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUrnoeYcHztFl3wIwRnS4S4sZe
# qr6gggl0MIIEsDCCA5igAwIBAgIDCiJbMA0GCSqGSIb3DQEBCwUAMF0xCzAJBgNV
# BAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEM
# MAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtNjMwHhcNMjIwOTE5
# MDAwMDAwWhcNMjUwOTE4MjM1OTU5WjB6MQswCQYDVQQGEwJVUzEYMBYGA1UEChMP
# VS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEMMAoG
# A1UECxMDVVNBMScwJQYDVQQDEx5IT05FWUNVVFQuSkFNRVMuSkFZLjExMzkwMzQ3
# NzEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKK2FlaDPPTrY32In8
# eW+I/5Kq1S3L1UJVUXQto/BsaCybOU8e6K2Qhr5d0Ds517vIxsIAiPgTHBNQ6aH9
# 340VQEIyal+vW1UC5drNRznuytmSuwPwQn9S6Vh4suJS2BFQH0pwGvW0Sz3QNUsz
# 8JbfwjCEkQDmYA/hfDUX97lMdxojYIsB8dQ0VipgBcpsnTQk5gaVKfv/FJtvJ62H
# TlqihRVQwyJZfvqDZrruDLhACFQs9uAUZORJvbUlYASEzO5GsIVDHP5M9TinxzAw
# 6lDSVYCmIB+3ouWUIhf7fGa+eLbD8OhTD/EaAQE1uaQV9Hy1Io/C2EZYWBZKXjgY
# mt55AgMBAAGjggFaMIIBVjAfBgNVHSMEGDAWgBRNMa1R1k5XfmdpMyUDfsYppd26
# 8zA6BgNVHR8EMzAxMC+gLaArhilodHRwOi8vY3JsLmRpc2EubWlsL2NybC9ET0RF
# TUFJTENBXzYzLmNybDAOBgNVHQ8BAf8EBAMCBSAwFgYDVR0gBA8wDTALBglghkgB
# ZQIBCycwHQYDVR0OBBYEFD36X2BBu/l72uoW3Oi4BFEdUGbFMGgGCCsGAQUFBwEB
# BFwwWjA2BggrBgEFBQcwAoYqaHR0cDovL2NybC5kaXNhLm1pbC9zaWduL0RPREVN
# QUlMQ0FfNjMuY2VyMCAGCCsGAQUFBzABhhRodHRwOi8vb2NzcC5kaXNhLm1pbDAp
# BgNVHREEIjAggR5qYW1lcy5qLmhvbmV5Y3V0dC5taWxAYXJteS5taWwwGwYDVR0J
# BBQwEjAQBggrBgEFBQcJBDEEEwJVUzANBgkqhkiG9w0BAQsFAAOCAQEAN6D+u1XR
# 9nV+zXyzrvoOQKTpaluuGmoZFKMmWx1TBw9T5GLbvx+DzxeoVDyzNq6USKTM1rJm
# cQVCm4j6MbhSaeI89XxVi5usB2ZCyK88UuepSJamUST7GnvcsF6IPdc5aIU4gJ3n
# zIzXEvXxAKCDF0cqXSdv3Et+IdNQOjwyESxhIiqP5TLtOAGSTAdQkn9gs6L1Gfhu
# Y2r0nWMPy9EXhRlidf/AJXrG6t9yGNZFg5S39/G0lqggxzBaj+5ctHJgRLjnxcjh
# 6+tRhIHsPkvNM5GTfkob1NvjM9rOVomllME8I9fNY1oXOA+4mNq03QOFFSf4KAfm
# roCo5IDBlLr7ezCCBLwwggOkoAMCAQICAgVIMA0GCSqGSIb3DQEBCwUAMFsxCzAJ
# BgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0Rv
# RDEMMAoGA1UECxMDUEtJMRYwFAYDVQQDEw1Eb0QgUm9vdCBDQSAzMB4XDTIxMDYw
# MTE0MDIyMVoXDTI3MDYwMjE0MDIyMVowXTELMAkGA1UEBhMCVVMxGDAWBgNVBAoT
# D1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxGDAW
# BgNVBAMTD0RPRCBFTUFJTCBDQS02MzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
# AQoCggEBAOxhZp3/Q4cN6epRh4WU1E6/azVsooaL2LHKleqhRen5aAyw+9Fos67v
# OLbzBqLKdT5FrSlPzm476kI4Y3b6aWgx2MZlMQhyLdJRoZ5pH8027YywDUxvi5uz
# wK61uqLERrDFe40YYC0rY/udkIApEDQKm6kweKNzkEkHegJJ/WK1qW7lRZf2WNAf
# +Acv14NKr3fdHRIMCsPRT3tTvykco3mtM6MOpg6nku2XcEoGwB320DWoZOkM2EQG
# PydKVEOEwwIBXvLQhy94eCXcAHQT+cy9rHxPRaGVeMW45Onj/0u64kMOWlyZrGRy
# 6hV/8ElFQmj05Ihmp/A6aOW9vFRNBo8CAwEAAaOCAYYwggGCMB8GA1UdIwQYMBaA
# FGyKlKJ3sYByHYF6Fqry3M5m7kXAMB0GA1UdDgQWBBRNMa1R1k5XfmdpMyUDfsYp
# pd268zAOBgNVHQ8BAf8EBAMCAYYwZwYDVR0gBGAwXjALBglghkgBZQIBCyQwCwYJ
# YIZIAWUCAQsnMAsGCWCGSAFlAgELKjALBglghkgBZQIBCzswDAYKYIZIAWUDAgED
# DTAMBgpghkgBZQMCAQMRMAwGCmCGSAFlAwIBAycwEgYDVR0TAQH/BAgwBgEB/wIB
# ADAMBgNVHSQEBTADgAEAMDcGA1UdHwQwMC4wLKAqoCiGJmh0dHA6Ly9jcmwuZGlz
# YS5taWwvY3JsL0RPRFJPT1RDQTMuY3JsMGwGCCsGAQUFBwEBBGAwXjA6BggrBgEF
# BQcwAoYuaHR0cDovL2NybC5kaXNhLm1pbC9pc3N1ZWR0by9ET0RST09UQ0EzX0lU
# LnA3YzAgBggrBgEFBQcwAYYUaHR0cDovL29jc3AuZGlzYS5taWwwDQYJKoZIhvcN
# AQELBQADggEBAEEvvdge6TbCueRriAGVfoeNjEdHU34onW4JXb18T7S1AYdgG9BK
# kW26F8OLP5sQxvObzfUJHuP799DLR2vYvSMMsxQ6uRnwgu8oItkSjhkoZlcROYAa
# 8xfDpNDuAUvIufPkO8CcsMeaQu04K7c4j9MzCsO0FWB2KnkbLtJUyyBLu+hwFkXW
# cFT3M9yqYdG0R8xaydmSA31c59RBvKqLD1jdr8wROt93gX5vVVqGzEeFMbO2Yhcy
# RUQ8v2ouQxidY38VYJSPKtWA+FFNP8mnjFYGhsKAsfbG/quVwlxJ/TFdnW5lX+A/
# o1ZtdsWGHdeOjBuryuN8IMO3i2uizWDQhdYxggHnMIIB4wIBATBkMF0xCzAJBgNV
# BAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEM
# MAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtNjMCAwoiWzAJBgUr
# DgMCGgUAoFowGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMx
# DAYKKwYBBAGCNwIBBDAjBgkqhkiG9w0BCQQxFgQU+LAJe6T1sXAOvmHwA4isNga/
# JxwwDQYJKoZIhvcNAQEBBQAEggEAg4a07bYETy5c9210rXWRq1sDQMm7oqHh1B+l
# 7avq9tOLDIV17PVlU6TfhfK1aLWVi+1JnsE6nQUUhtSgwznnIZFtGjZlJSyi5SD4
# YdaGuRHNWKPjIpVP8yEgYej9IIJFT6xKXB8j4nh1rfIarxIxvjdxYOrFKdZvILfo
# jMIsVplih2jDe8LUtrXNXYgTR6QiI1twZpi1ImuRvKEqAX6QrMDyvID+3vAkhaIY
# Ck0skAjdlLlyiP+Iv5lRyC9MXfPSU2bXjAnoB2kntGBkAemGe/QYChaWYBj0aZwi
# yaM602dl+0gHZf6pJIixQJZgENB5ddJqdaGtBvTZs6R3QlATsg==
# SIG # End signature block
