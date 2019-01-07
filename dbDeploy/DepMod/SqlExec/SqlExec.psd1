##############################################################################
# Module manifest for module 'sqlExec'
# Created by: Chuck Spencer Jr.
# Created on: 11/12/17
# Updated on: 03/04/18
##############################################################################

@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'SqlExec.psm1'

    # Version number of this module.
    ModuleVersion     = '0.0.2'

    # ID used to uniquely identify this module
    GUID              = 'a9b6ef85-8292-4457-bbf9-af7a29d471f4'

    # Author of this module
    Author            = 'Chuck Spencer Jr.'

    # Company or vendor of this module
    CompanyName       = 'Spencer Jr.'

    # Copyright statement for this module
    Copyright         = '(c) Chuck Spencer. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'Provide funtions to read and execute sql based scripts.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '3.0'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        "Connect-SqlInstance", 
        "Disconnect-SqlInstance", 
        "Invoke-SqlScript", 
        "Invoke-SqlQuery"
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}

