# Minimal static file server for the project root on http://localhost:3000
# (Node isn't installed on this machine, so this replaces the CLAUDE.md `node serve.mjs`.)
param([int]$Port = 3000)

$root = $PSScriptRoot
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "Serving $root at http://localhost:$Port/  (Ctrl+C to stop)"

$mime = @{
  ".html" = "text/html; charset=utf-8"; ".css" = "text/css"; ".js" = "text/javascript"
  ".mjs" = "text/javascript"; ".json" = "application/json"; ".png" = "image/png"
  ".jpg" = "image/jpeg"; ".jpeg" = "image/jpeg"; ".gif" = "image/gif"; ".svg" = "image/svg+xml"
  ".webp" = "image/webp"; ".ico" = "image/x-icon"; ".woff" = "font/woff"; ".woff2" = "font/woff2"
}

try {
  while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $req = $ctx.Request
    $res = $ctx.Response
    try {
      $rel = [Uri]::UnescapeDataString($req.Url.AbsolutePath.TrimStart('/'))
      if ([string]::IsNullOrWhiteSpace($rel)) { $rel = "index.html" }
      $path = Join-Path $root $rel
      if ((Test-Path $path -PathType Container)) { $path = Join-Path $path "index.html" }
      if (Test-Path $path -PathType Leaf) {
        $bytes = [System.IO.File]::ReadAllBytes($path)
        $ext = [System.IO.Path]::GetExtension($path).ToLower()
        if ($mime.ContainsKey($ext)) { $res.ContentType = $mime[$ext] }
        $res.Headers.Add("Cache-Control", "no-store")
        $res.ContentLength64 = $bytes.Length
        $res.OutputStream.Write($bytes, 0, $bytes.Length)
      } else {
        $res.StatusCode = 404
        $b = [Text.Encoding]::UTF8.GetBytes("404 Not Found: $rel")
        $res.OutputStream.Write($b, 0, $b.Length)
      }
    } catch {
      $res.StatusCode = 500
      $b = [Text.Encoding]::UTF8.GetBytes("500: $($_.Exception.Message)")
      try { $res.OutputStream.Write($b, 0, $b.Length) } catch {}
    } finally {
      $res.OutputStream.Close()
    }
  }
} finally {
  $listener.Stop()
}
