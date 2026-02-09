Get-ChildItem "D:\Toyota GR (SQL project)\data\*.csv" -Recurse |
Where-Object {
    $_.Name -match 'weather|analysis|class|provisional|official|99_best_10_laps_by_driver|gr_teams'
} |
ForEach-Object {
    $file = $_.FullName
    Write-Host ">>> Sending to SQL:" $file

    Invoke-Sqlcmd `
        -ServerInstance "localhost" `
        -Database "Toyota GR" `
        -Query "EXEC bronze.load_raw_data @file_path = N'$file'"
}
