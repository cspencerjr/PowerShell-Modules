##############################################################################
# Module manifest for module 'IniFile'
#
# Generated by: Charles Spencer
#
# Generated on: 8/29/2018
##############################################################################

@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'IniFile.psm1'

    # Version number of this module.
    ModuleVersion     = '1.0'

    # ID used to uniquely identify this module
    GUID              = '2a4c24e4-8d24-44c8-ac39-ee9e0ae16aef'

    # Author of this module
    Author            = 'Charles Spencer'

    # Company or vendor of this module
    CompanyName       = 'Spencer'

    # Copyright statement for this module
    Copyright         = '(c) 2018 Charles Spencer. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'Read and parse Windows INI based files.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '3.0'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        "Import-IniFile"
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @()

            # A URL to the license for this module.
            # LicenseUri = ''

            # A URL to the main website for this project.
            # ProjectUri = ''

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable

}