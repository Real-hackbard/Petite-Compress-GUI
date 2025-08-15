# Petite-Compress-GUI

```ruby
Compiler    : Delphi10 Seattle, 10.1 Berlin, 10.2 Tokyo, 10.3 Rio, 10.4 Sydney, 11 Alexandria, 12 Athens
Components  : None
Discription : Executable Compressor GUi
Last Update : 08/2025
License     : Freeware
```

Petite is a free Win32 (Windows 95/98/2000/NT/XP/Vista/7/etc) executable (EXE/DLL/etc) compressor. The compressed executables decompress themselves at run time, and can be used just like the original non-compressed versions. Petite also adds virus detection to the compressed executables; they will check themselves for infection every time they are executed.

Two versions of Petite are provided: a GUI version and a command-line console version. The GUI version allows quick and easy use of Petite, and the command-line version allows developers to automate the use of Petite in compilers' build processes and makefiles. Simple instructions for using Petite with Visual C++ projects are given, and it should be fairly simple to use Petite with other compilers and IDEs too. Petite can also be used as a shell extension, so that you can compress a file by simply right-clicking on it in Windows Explorer.


![Petite Compress GUI](https://github.com/user-attachments/assets/b104ae1c-4577-4b55-8c90-f8c32ef59fa7)


Download latest Version : [2.4](https://www.un4seen.com/files/petite24.zip)  
Copyright ©1999-2015 Un4seen Developments. All rights reserved.

What's the point?
=================
Petite is a Win32 (Windows 9x/NT/etc) executable compressor. It allows
compression of the whole executable - code, data and resources. Petite
automatically decides which parts of the executable can be compressed
and which parts need to be left as they are. The compressed output
executable can be run as if it was the original uncompressed version.


Why "Petite"?
=============
The file format of Win32 executables is called the "Portable Executable"
file format, "PE" for short. Petite means "of small and dainty build",
which kind of describes the executables after they've been compressed!
And, Petite obviously begins with "PE"! Clever huh? :)


Main Features
=============
* Compresses all Win32 PE files
- including EXE, DLL, DRV etc...

* Automatic compression decision making
- decides which parts are compressable and which are not

* Resource compression
- user selectable which resource types to compress

* 100% Assembler decompression code
- no noticeable delay at load time in most cases

* Virus/tampering checking
- the compressed files automatically check themselves when executed

* Command-line version...
- allows use from within compilers and makefiles

* ... and a GUI version
- quick and easy to use

Command-Line Options (console version)
======================================
```
-i     Display file information:
       Displays a list of the sections in the file and a list of the
       resource types used. Also displays information on how much of
       the file is compressable.
-<0-9> Set the compression level
       As the level gets higher the compression gets better, but you'll
       need a fast computer (or a lot of time) when using the highest
       levels! (default: 0) NOTE: The compression level has no effect
                                  on the decompression speed.
-o<file> Set output filename:
       Sets the compressed output filename.
-b<0|1> switch: Backup original file:
       Renames the original file to "file.BAK". Backups are disabled
       when the "-o" option is used. 0=OFF, 1=ON (default: ON)
-t<0|1> switch: Compress import tables
       If files don't work after compression, try switching this OFF.
       0=OFF, 1=ON (default: ON)
-e<0|1|2> switch: Compress exports
       If files don't work after compression, then try switching this.
       0=OFF, 1=ON, 2=ON+EXE TABLES (default: ON)
         ON: The exports are compressed, but not the export table.
         ON+EXE TABLES: The exports AND export table are compressed when
                        compressing EXEs. The table is never compressed
                        in DLLs as the DLLs would then not be importable.
-s<0|1|2> switch: Strip relocations
       0=OFF, 1=EXE ONLY, 2=ALWAYS (default: EXE ONLY)
         OFF: The relocation information is retained.
         EXE ONLY: Any relocation information is stripped from EXEs,
                   but retained in DLLs.
         ALWAYS: The relocation information is always stripped. Only
                 use this when you are sure that a DLL will never need
                 to be relocated.
-r<res1,res2,res3...> Select resource types for compression:
       (default: NONE) ... SEE BELOW FOR DETAILS
-x<res1,res2,res3...> Select resource types for NON-compression:
       Excludes the selected resource types from compression, this is
       only really useful when using the "-r*" option.
-m<0|1> switch: Mangle import tables
       Messes up the import tables during run-time. This may not work with
       files that import data items. 0=OFF, 1=ON (default: ON)
-v<0|1> switch: Virus checking
       Makes the compressed files check themselves for virus infection
       every time they are executed. 0=OFF, 1=ON (default: ON)
-a     Align the file to 4k boundary
       This improves loading speed in Windows 98, but it also increases
       the size... not recommended for use with small files.
-p<0|1> switch: Display compression progress:
       Disables/enables the displaying of the compression progress
       counter. 0=OFF, 1=ON (default: ON)
-y     Overwrite existing files
-n     Don't overwrite existing files
-shell Register shell extension
       This allows you to compress an EXE/DLL file by simply right-clicking
       on it in Windows Explorer. You may also choose the options to be used,
       by specifying them at the same time as this option... For example,
       "Petite -shell -b0" will register the shell extension, and when used,
       Petite will not create backups.
-shellx Unregister shell extension
```

NOTE: You can use wildcards and multiple filenames in the command-line.
      If you use a filename with any spaces then the whole filename must
      be enclosed in quotes.
      Valid examples:
               petite *.exe -b0 -r* -xTYPELIB
               petite "my file.dll" -ob.dll
               petite a.drv b* c.exe -1
               petite -y "*.dll" -b0 -5
               petite a*.exe b.exe -p0 -e2

TIP: To produce the smallest files, use the "-r**" and "-e2" command-line
     options. Obviously, using higher compression levels also produces
     smaller files.


### Compressing Resources
=====================
All resources are grouped into types, which can be either a number or a
word. To see a list of the resource types used in a file you should run
Petite using the "-i" (display information) and "-r" (compress resources)
options. eg: petite blah.exe -i -r

The resource types selected for compression must be seperated by a comma
without any spaces.   Valid examples:
* petite ... -r2          compress only bitmaps
* petite ... -r2,10       compress bitmaps and user data
* petite ... -rmytype     compress "mytype" resources
* petite ... -r2,mytype   compress bitmaps and "mytype" res
* petite ... -r*          compress all resources except 3,14,22,16

Common resource types are listed below. It is recommended that you don't
compress icon resources (types 3,14,22), otherwise the program's icon will
not be visible in the Start menu or a directory listing. Also, version
information (type 16) should not be compressed as it would be needed if a
program wanted to check the version of the file. "*" can be used to
respresent all resource types other than version information and icons
(types 3,14,22,16). "**" can be used to represent all resource types other
than version information and all but the 1st icon. You can also use the
"-x" option to select other types to exclude from compression.

Whichever resources you choose to compress, you should make sure the new
compressed file loads properly before deleting the original file. It is
probably wise to be on the safe side and test all files you compress with
Petite before deleting the original.

### Standard Resource Types
-----------------------
* 1    Cursor
* 2    Bitmap
* 3    Icon
* 4    Menu
* 5    Dialog
* 6    String
* 7    Font directory
* 8    Font
* 9    Accelerator
* 10   User resource data
* 11   Message table
* 12   Cursor directory
* 14   Icon directory
* 16   Version info
* 21   Animated cursor
* 22   Animated icon

### Building an excutable with Petite
=================================
Because Petite is command-line driven it can easily be used within a
compiler's build process or makefile. The only extra things you have
to do is use the "-p0" (progress off) option and possibly the "-y"
(overwrite) option.

### Using Petite with Visual C++
----------------------------
* 1) Open the "Project Settings" dialog (press Alt-F7) and select the
   project configuration you wish to produce a compressed executable.
* 2) Goto the "Link" page and remove the ".exe" extension from the
   "Output file name". eg: "Release/blah.exe" -> "Release/blah"
* 3) Goto the "Custom Build" page and enter the following "Build command":
     "petite -p0 -y $(InputPath) -o$(InputPath).exe" (+extra options)
* 4) Enter the following "Output file":
     "$(InputPath).exe"

If you wish to compress a DLL, rather than an EXE, then replace all cases
of "exe" above with "dll".

NOTE: You should make sure Petite is in the path. This is most easily
      achieved by copying PETITE.EXE into the Windows directory.

### Compressed files not working?
=============================
Some compressed files may not work, there are a few possible reasons for
this. If you do find a file that does not work after compression, try
checking these causes. If you know that none of these cases apply to the
file in question, then please send details (email at end of this file).

### Extra data attached (not fixable)
---------------------------------
Some files, noteably installation packages, have data attached to the
end of the file. This data is stripped by Petite as it is not part of
the EXE structure. If the extra data is of importance to the file, not
debug info or other unnecessary data, then this may mean that the
compressed file does not work. Petite will display a warning message
if it finds any additional data at the end of a file.

### Exports called before decompression (possibly fixable)
------------------------------------------------------
Sometimes, very rarely, an EXE will link to a DLL that will inturn call
back a function in the EXE. The problem is that the DLL is linked to the
EXE by the system before the EXE can decompress itself. Obviously, if
the EXE has not yet been decompressed, the DLL ends up calling a load of
rubbish and the program will crash.

You can try switching off "Export Compression" ("-e0" option). This may
vastly reduce the compression results, and the compressed program may
still not work if the function that's called back needs to access data
from a compressed part of the file.

### Resources accessed before decompression (always fixable)
--------------------------------------------------------
This problem is similar to the previous exports problem, except this time
a linked DLL is trying to access a resource before it's been decompressed.
Obviously, this can only be a problem if you have compressed a resource
that the DLL is trying to access. 

Unlike the exports problem, this problem is always fixable. You should try
without compressing resources, if the compressed file works then you should
try to find which resource is causing the problems. You can do this by
compressing the different resources one by one and seeing which ones stop
the file working. Then simply compress the file, without compressing the
problem resource(s).

If the problem file has a resource type called "TYPELIB", then try without
compressing this resource type first.

### Modification detection (not fixable)
------------------------------------
If the EXE has some built-in modification detection, then the chances are
it will detect that the file has been "modified", and it will probably
refuse to work. Obviously, there are no fixes to this and these files are
uncompressable.

Data item importing (always fixable)
------------------------------------
If the file imports data items from a DLL, then import table mangling could
cause problems. Try disabling the import mangling option.


### Decompression?
==============
There is no Petite decompressor. So if it is not possible for you to
re-install or re-compile a file, then you should keep a backup of the
original incase you should want to go back to it at any time.
