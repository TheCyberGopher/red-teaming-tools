# Leaked Code Certificates

Simple `SignTool.exe` wrapper script that abuses few leaked code signing certificates.

## Files supported

SignTool.exe can digitally sign following files (49):

```
.vbs, .js, .exe, .dll, .xll, .cpl, .wll, .msi, .msix,
.appx, .xla, .xls, .xlt, .pot, .ppa, .pps, .ppt, .mpp, .mpt,
.pub, .vdw, .vdx, .vsd, .vss, .vst, .vsx, .vtx, .doc, .dot,
.wiz, .xlam, .xlsb, .xlsm, .xltm, .potm, .ppam, .ppsm, .pptm, .vsdm,
.vssm, .vstm, .docm, .dotm, .vsto, .msixbundle, .appxbundle, .application, .manifest, .cab,
```

## Available certificates

| #  |     name     | description                                                                            |
|----|--------------|----------------------------------------------------------------------------------------|
| 1  |  canada2023  | 12980215 Canada Inc., random private cert, released on UnknownCheats.                  |
| 2  |  hangil2024  | Already revoked but valid until Nov, 2024. Leaked Hangil IT Co., Ltd signed by Sectigo |
| 3  |   izex2015   | IZEX certificate disclosed in Github tdevuser/MalwFinder, expired in 2015.             |
| 4  | mediatek2017 | (+) MediaTek Code Signing Certificate, may lower detection rate                        |
| 5  |   msi2021    | (+) MoneyMessage - MSI Leaked 2021 Code Signing certificate, revoked.                  |
| 6  |   msi2024    | (+) MoneyMessage - MSI Leaked 2024 Code Signing certificate, revoked.                  |
| 7  | netgear2014  | NetGear Inc. 2014 Code Signing Certificate                                             |
| 8  | netgear2017  | (+) NetGear Inc. 2017 Code Signing Certificate, may lower detection rate               |
| 9  |  nvidia2014  | (+) NVIDIA certificate that expired in 2014, may lower detection rate (+)              |
| 10 |  nvidia2018  | NVIDIA certificate that expired in 2018                                                |

## Parameters

- `-Infile` - input file to be signed.
- `-Outfile` - output signed file.
- `-Leaked` - name of the leaked certificate to abuse.

## Usage

```
PS> . .\SignMyPayload.ps1
PS> Sign-Payload -Infile evil.exe -Outfile signed-evil.exe -Leaked msi2024
```
