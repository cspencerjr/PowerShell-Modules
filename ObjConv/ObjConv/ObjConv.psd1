##############################################################################
# Module manifest for module 'ObjConv'
#
# Generated by: Charles Spencer Jr.
#
# Generated on: 5/6/18
##############################################################################

@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'ObjConv.psm1'

    # Version number of this module.
    ModuleVersion     = '1.0'

    # ID used to uniquely identify this module
    GUID              = '9d665cd8-62c9-4a41-b12a-606944f4c543'

    # Author of this module
    Author            = 'Charles Spencer'

    # Company or vendor of this module
    CompanyName       = 'Spencer'

    # Copyright statement for this module
    Copyright         = '(c) Charles Spencer. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'Convertion functions.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '3.0'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        "ConvertTo-Hashtable"
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