param (
    [string]$cwd,
    [string]$msg
)

Write-Verbose "Entering script $MyInvocation.MyCommand.Name"
Write-Verbose "cwd = $cwd" -Verbose
Write-Verbose "msg = $msg" -Verbose

    
$npm = Get-Command -Name npm -ErrorAction Ignore  

$npmDeployerGitTaggerPackageSource = "https://github.com/kjrb/npm-deployer-git-tagger"
$npmDeployerGitTaggerPackageName = "npm-deployer-git-tagger"

import-module "Microsoft.TeamFoundation.DistributedTask.Task.Common"
  

if(!$cwd)
{
    throw (Get-LocalizedString -Key "Working directory parameter is not set")
}

if(!(Test-Path $cwd -PathType Container))
{
    throw ("$cwd does not exist");
}

if(!$npm)
{
    throw (Get-LocalizedString -Key "Unable to locate {0}" -ArgumentList 'npm')
}

Write-Verbose $npm.Path -Verbose
Write-Verbose "Setting working directory to $cwd"   

    
Set-Location $cwd

Write-Host $msg

if ($npmDeployerGitTaggerPackageSource) {

    $npmArgs = " install " + $npmDeployerGitTaggerPackageSource
}
else {
     $npmArgs = " install " + $npmDeployerGitTaggerPackageName
}
    
Write-Verbose (Get-Location) -Verbose
Write-Verbose "Running npm $npm" -Verbose
    
Write-Verbose "Will run $npmArgs " -Verbose
    
Invoke-Tool -Path $npm.Path -Arguments $npmArgs -WorkingFolder $cwd -WarningPattern "^npm WARN"

Write-Verbose "Running npm run $npm" -Verbose
$npmArgsNpmDeployer = " ./node_modules/" +  $npmDeployerGitTaggerPackageName + "/index.js"        
Write-Verbose "Will run $npmArgsNpmDeployer " -Verbose
        
Invoke-Tool -Path "node" -Arguments $npmArgsNpmDeployer -WorkingFolder $cwd -WarningPattern "^npm WARN"





