﻿import-module au

$releases = 'https://www.piriform.com/ccleaner/download/portable'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re  = '\.zip$'
  $url = 'https://www.ccleaner.com/de-de/ccleaner/download/portable'

  $download_page = Invoke-WebRequest https://www.piriform.com/ccleaner/version-history -UseBasicParsing
  $Matches = $null
  $download_page.Content -match "\<h6\>v((?:[\d]\.)[\d\.]+)"
  $version = $Matches[1]

  @{ URL32 = $url ; Version = $version }
}

update -ChecksumFor 32
