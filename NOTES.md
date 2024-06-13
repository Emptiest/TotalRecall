Just some notes for myself as I work through this rewrite project.

# SQLite Difficulties 2024-06-13
Part of my reasoning for wanting to rewrite this in PowerShell was because the original project is in Python, which means adding an additional dependency the user needs to install in order to run the script. My goal was to have this script working for Windows PowerShell 5.1.

However, PowerShell has no native compatibility with SQLite. So need to download either a module or .NET library for it. I'm no .NET programmer, so I opted for the module [PSSQLite](https://github.com/RamblingCookieMonster/PSSQLite).

Unfortunately, the libraries used in that module seem to be [incompatible with ARM](https://github.com/RamblingCookieMonster/PSSQLite/issues/32). I haven't found alternative methods that seem promising yet short of actually learning some basic .NET and implementing functions utilizing the [SQLite.Core NuGet Package](https://www.nuget.org/packages/System.Data.SQLite.Core).

As an aside, the method I was using to test using the .NET library was as follows

```powershell
Register-PackageSource -Name NuGet -ProviderName NuGet -Location https://www.nuget.org/api/v2
Install-Package System.Data.Sqlite.Core -Scope CurrentUser -SkipDependencies
```

>[!NOTE] `-SkipDependencies` was used to avoid a dependency loop I was running into. It may not be necessary.

I kind of figured out how to do this by following the troubleshooting in [this issue](https://github.com/PowerShell/PowerShell/issues/6050), even if I ended up going with the module instead. Alas, the module does not work on ARM, so I'm turning back. I'll revisit this at a later date when I have more free time.