//
// Original sources from Acidanthera:
//  - https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/AcpiSamples/SSDT-AWAC.dsl
//  - https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/AcpiSamples/SSDT-RTC0.dsl
//
// Uses the CORP name to denote where this was created for troubleshooting purposes.
//
DefinitionBlock ("", "SSDT", 2, "CORP", "RTCAWAC", 0x00000000)
{
    External (STAS, IntObj)
    Scope (\)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                Store (One, STAS)
            }
        }
    }
    External (\_SB.PC00.LPCB.RTC, DeviceObj)
    External (\_SB.PC00.LPCB.RTC.XSTA, MethodObj)
    Scope (\_SB.PC00.LPCB.RTC)
    {
        Name (ZSTA, Zero)
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            // Default to Zero - but return the result of the renamed XSTA if possible
            If (CondRefOf (\_SB.PC00.LPCB.RTC.XSTA))
            {
                Store (\_SB.PC00.LPCB.RTC.XSTA (), ZSTA)
            }
            Return (ZSTA)
        }
    }
}