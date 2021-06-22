# FlashFiler
Delphi 10 port of TurboPower FlashFiler

Thank you EZeroDivide for all the hard work in the pointer mess that FlashFiler is..

06-2021: I got Flashfiler running on Delphi 10.4.2 with minor modifications to the code of EZeroDivide. Fixed SQL and now I'm wondering why SQL error messages from the server are cut off.

a) In my version, the original FFE is excuting SQL on the new version of the server. FFE/Delphi. I found that the FFQuery in FFE is not closed and opened prior and after running a query.

b) And I noticed that error 158 (occuring when running a select) seems to hang up error handling. 

Point a) was an easy fix but without these fixes, FFE hangs after running more than 2 queries, for example on filling the reserved words list. 
I managed to get past that but this needs more testing.
