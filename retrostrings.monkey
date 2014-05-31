Strict

Public

' Retro Strings Module V1.0.3 - By: Anthony Diamond (Sonickidnextgen)

' ///---------------------------------------------------------------------------------------------------------------------\\\
'	  This library was created because I was annoyed by the lack of convenience when working with strings in Monkey.
'	  Plus, this is useful when porting programs from Blitz Basic and Blitz Max.
'
'	  If you find any bugs while using this library, please report them.
'	  If you have any feature suggestions, please post about them on the Monkey forums.
' ///---------------------------------------------------------------------------------------------------------------------\\\

' DISCLAIMER:
'
' Copyright (c) 2014 - Anthony Diamond
'
' Permission is hereby granted, free of charge, To any person obtaining a copy of this software And associated documentation files (the "Software"), To deal in the Software without restriction, including without limitation the rights To use, copy, modify, merge, publish, distribute, sublicense, And/Or sell copies of the Software, And To permit persons To whom the Software is furnished To do so, subject To the following conditions:
' The above copyright notice And this permission notice shall be included in all copies Or substantial portions of the Software.
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS Or IMPLIED, INCLUDING BUT Not LIMITED To THE WARRANTIES OF MERCHANTABILITY, FITNESS For A PARTICULAR PURPOSE And NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS Or COPYRIGHT HOLDERS BE LIABLE For ANY CLAIM, DAMAGES Or OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT Or OTHERWISE, ARISING FROM, OUT OF Or IN CONNECTION WITH THE SOFTWARE Or THE USE Or OTHER DEALINGS IN THE SOFTWARE.

' //////// ------------------------------------------------------------------------------------------------------------------------------------- \\\\\\\\

' Imports:
Import stringutil

' Functions:

' Classic Blitz Basic string commands:
Function Left:String(Str:String, n:Int)
	Return Str[..n]
End

Function Right:String(Str:String, n:Int)
	Return Str[Len(Str)-n..]
End

Function Mid:String(Str:String, Pos:Int, Size:Int=-1)
	If (Pos > Len(Str)) Then Return ""
	Pos -= 1
	
	If(Size < 0) Then Return Str[Pos..]
	
	If (Pos < 0) Then
		Size += Pos
		Pos = 0
	Endif
	
	If (Pos+Size > Len(Str)) Then
		Size = Len(Str) - Pos
	Endif
	
	Return Str[Pos..Pos+Size]
End

Function Len:Int(Str:String)
	Return Str.Length()
End

Function Instr:Int(Str:String, Sub:String, Start:Int=1, Left:Bool=True)
	Return Str.Find(Sub, Start-1)+1
End

Function Lower:String(S:String)
	Return S.ToLower()
End

Function Upper:String(S:String)
	Return S.ToUpper()
End Function

Function LSet:String(Str:String, N:Int)
	Return Str[..N]
End

Function RSet:String(Str:String, N:Int)
	Return Str[Len(Str)-N..]
End

Function Replace:String(Str:String, Sub:String, ReplaceWith:String)
	Return Str.Replace(Sub, ReplaceWith)
End

Function Trim:String(Str:String)
	Return Str.Trim()
End

Function Chrs:String(In:Int[])
	Return String.FromChars(In)
End

Function Chr:String(In:Int)
	Return String.FromChar(In)
End

Function Asc:Int(Str:String)	
	Return Str.ToChars()[0]
End

Function Ascs:Int[](Str:String)
	Return Str.ToChars()
End

Function Hex:String(Value:Int)
	' Local variable(s):
	Local Buf:Int[8]
	
	For Local k:Int = 7 To 0 Step -1
		Local n:Int = (Value & 15) + Asc("0")
		
		If (n > Asc("9")) Then n += (Asc("A")-Asc("9")-1)
		
		Buf[k]=n
		Value Shr= 4
	Next
	
	Return String.FromChars(Buf)
End

Function Bin:String(Value:Int)
	' Local variable(s):
	Local Buf:Int[32]
	
	For Local k:Int = 31 To 0 Step -1
		Buf[k] = (Value&1) + Asc("0")
		Value Shr= 1
	Next
	
	Return String.FromChars(Buf)
End

Function LongHex:String(Value:Int) 
	Return Hex(Value)
End

Function LongBin:String(Value:Int)
	Return Bin(Value)
End