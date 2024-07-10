
UACME - AKAGI

===================

https://github.com/hfiref0x/UACME

Modes

• Method (30) (63) and later implemented only in x64 version;
• Method (30) require x64 because it abuses WOW64 subsystem feature;
• Method (55) is not really reliable (as any GUI hacks) and included just for fun;
• Method (78) requires current user account password not to be blank.
• Method (59) works on a fully upto date windows 10 x64 systems, nothing got flagged
	
====================

Building

On Visual Studio Terminal
msbuild Source\uacme.sln

Source\Akagi\output\x64\Debug
	after building the output get stored here

====================

What Works On x64 Machine

akagi.exe 59 C:\Users\joker\Desktop\reverse.exe
Akagi.exe 61 C:\Users\joker\Desktop\reverse.exe

