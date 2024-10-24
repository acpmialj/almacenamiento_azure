$connectTestResult = Test-NetConnection -ComputerName ipmdsa.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"ipmdsa.file.core.windows.net`" /user:`"localhost\ipmdsa`" /pass:`"Fs9azVVoHgcBHn1wr78+5LPe/UuKCH2+oLiIgvrmrgyhYoZxNS0Hjt8uIR54XUPNaBRH7SNTDSgc+AStvUN2ng==`""
    # Mount the drive
    New-PSDrive -Name Z -PSProvider FileSystem -Root "\\ipmdsa.file.core.windows.net\ipmdfs" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}