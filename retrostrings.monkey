Strict

Public

' ///---------------------------------------------------------------------------------------------------------------------\\\
'	  This library was created because I was annoyed by the lack of convenience when working with strings in Monkey.
'	  Plus, this is useful when porting programs from Blitz Basic and Blitz Max.
'
'	  If you find any bugs while using this library, please report them.
'	  If you have any feature suggestions, please post about them on the Monkey forums.
' ///---------------------------------------------------------------------------------------------------------------------\\\

' Preprocessor related:

#Rem
	This standard has not yet been properly implemented.
	The idea behind this functionality is to only provide the
	original standard BlitzBasic commands, and their usual behavior.
	
	This can be problematic for other modules which use the non-BlitzBasic
	compatible features and behaviors within this module.
	
	Configure this with caution, if you're unsure (Which you generally should be), don't mess with this.
	
	If this is disabled, it means full functionality is available; don't worry about this variable.
#End

#RETROSTRINGS_AUTHENTIC = False

#Rem
	Enabling this will cause extra checks to take place to ensure
	there isn't any issue with the input supplied to the commands of this module.
	Under normal situations, "strict-mode" is enabled,
	so 'RETROSTRINGS_AUTHENTIC' does not need to be check for this.
#End

#RETROSTRINGS_STRICT = True

#Rem
	This currently has variable results, and could change.
	The idea behind this variable is to provide
	better configuration for what 'RETROSTRINGS_STRICT' applied.
	
	This functionality has yet to be properly implemented.
	Very few places (If any) actually use this.
#End

#RETROSTRINGS_SAFE = True

#If CONFIG = "debug" Or RETROSTRINGS_AUTHENTIC Or RETROSTRINGS_SAFE
	#Rem
		This is currently only defined when compiling in debug-mode.
		If this is disabled, errors detected within the module will be ignored silently,
		and possibly not even checked altogether (Unlikely; see 'RETROSTRINGS_STRICT').
	#End
	
	#RETROSTRINGS_REPORT_ERRORS = True
#End

' Imports (Public):
#If Not RETROSTRINGS_AUTHENTIC
	Import stringutil
#End

' Imports (Private):
Private

' Non-standard imports (Proprietary):

#Rem
	For the sake of backward compatibility, make sure the
	user isn't trying to force standard internals.
	Technically, this check isn't needed, it's just here
	so we don't import the module when we're not supposed to be using it.
#End

#If (Not RETROSTRINGS_AUTHENTIC And Not RETROSTRINGS_STRICT) And Not RETROSTRINGS_STANDARD_INTERNALS
	Import retrostringsextension
#End

Public

#Rem
	The following routine is done for the sake of automating non-standard extensions to this module:
	This routine will be attempted if a preprocessor variable was already defined or not.
	No problems will occur if variables were manually defined beforehand.
#End

#If Not RETROSTRINGS_STANDARD_INTERNALS
	' Check if we were able to import the extension-module:
	#If Not RETROSTRINGS_EXTENSION_IMPLEMENTED
		' No module was found, use standard internals.
		#RETROSTRINGS_STANDARD_INTERNALS = True
	#Else
		' We found an extension-module, do not define the "standard-internals" variable.
	#End
#End

' Aliases:

' Check for standard internals:
#If Not RETROSTRINGS_STANDARD_INTERNALS
	' This will act as a module-independent alias for extensions.
	Alias ext = retrostringsextension
#End

' Constant variable(s) (Public):

#If Not RETROSTRINGS_AUTHENTIC
	' These are mainly used for internal routines, such as hexadecimal conversion:
	Const ASCII_NUMBERS_POSITION:Int = 48
	
	Const ASCII_CHARACTER_0:= ASCII_NUMBERS_POSITION
	Const ASCII_CHARACTER_1:= ASCII_CHARACTER_0 + 1
	Const ASCII_CHARACTER_2:= ASCII_CHARACTER_1 + 1
	Const ASCII_CHARACTER_3:= ASCII_CHARACTER_2 + 1
	Const ASCII_CHARACTER_4:= ASCII_CHARACTER_3 + 1
	Const ASCII_CHARACTER_5:= ASCII_CHARACTER_4 + 1
	Const ASCII_CHARACTER_6:= ASCII_CHARACTER_5 + 1
	Const ASCII_CHARACTER_7:= ASCII_CHARACTER_6 + 1
	Const ASCII_CHARACTER_8:= ASCII_CHARACTER_7 + 1
	Const ASCII_CHARACTER_9:= ASCII_CHARACTER_8 + 1
	
	Const ASCII_CHARACTER_UPPERCASE_POSITION:= 65
	Const ASCII_CHARACTER_LOWERCASE_POSITION:= 97
	
	' The alphabet is currently not available / available publicly.
#End

' Constant variable(s) (Private):
Private

#If Not RETROSTRINGS_AUTHENTIC
	' This represents the number of characters
	' representing numbers in the ascii-table.
	Const ASCII_NUMBER_COUNT:Int = 10
#End

Public

' Functions:

' Classic BlitzBasic-styled string-commands:
Function Left:String(Str:String, n:Int)
	#If RETROSTRINGS_SAFE
		If (n = 0) Then Return ""
	#End
	
	#If RETROSTRINGS_STRICT Or RETROSTRINGS_SAFE
		If (n < 0) Then
			#If RETROSTRINGS_REPORT_ERRORS
				Error("Illegal function call.")
			#End
			
			Return ""
		Endif
	#End
	
	Return Str[..Min(n, Len(Str))]
End

Function Right:String(Str:String, n:Int)
	If (n = 0) Then Return ""
	
	#If RETROSTRINGS_STRICT Or RETROSTRINGS_SAFE
		If (n < 0) Then
			#If RETROSTRINGS_REPORT_ERRORS
				Error("Illegal function call.")
			#End
			
			Return ""
		Endif
	#End
	
	Return Str[-Min(n, Len(Str))..]
End

Function Mid:String(Str:String, Pos:Int, Size:Int=-1)
	#If RETROSTRINGS_STRICT Or RETROSTRINGS_SAFE
		If (Pos = 0) Then
			#If RETROSTRINGS_REPORT_ERRORS
				'Error("Parameter must be greater than zero. ('Pos': " + Pos + ")")
				Error("Parameter must be greater than zero. ('Pos': 0")
			#End
			
			Return ""
		Endif
	#End
	
	If (Pos > Len(Str)) Then
		Return ""
	Endif
	
	Pos -= 1
	
	If (Size < 0) Then
		Return Str[Pos..]
	Endif
	
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
End

Function LSet:String(Str:String, N:Int)
	#If RETROSTRINGS_SAFE Or RETROSTRINGS_REPORT_ERRORS
		If (N < 0) Then
			#If RETROSTRINGS_REPORT_ERRORS
				Error("Parameter must be positive. ('N': " + N + ")")
			#End
			
			Return ""
		Endif
	#End
	
	Return Str[..N]
End

Function RSet:String(Str:String, N:Int)
	#If RETROSTRINGS_SAFE Or RETROSTRINGS_REPORT_ERRORS
		If (N < 0) Then
			#If RETROSTRINGS_REPORT_ERRORS
				Error("Parameter must be positive. ('N': " + N + ")")
			#End
			
			Return ""
		Endif
	#End
	
	Return Str[-N..]
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
	Return Str[0]
End

Function Ascs:Int[](Str:String)
	Return Str.ToChars()
End

' The output of this command is completely defined by the implementation of 'retrostrings'.
' This could use either 'HexBE', or 'HexLE'. Usually, the version used is the fastest.
Function Hex:String(Value:Int)
	Return HexBE(Value)
End

Function Bin:String(Value:Int)
	' Local variable(s):
	Local Buf:Int[32]
	
	For Local k:Int = 31 To 0 Step -1
		Buf[k] = (Value&1) + ASCII_NUMBERS_POSITION
		
		Value Shr= 1
	Next
	
	Return String.FromChars(Buf)
End

#If Not RETROSTRINGS_AUTHENTIC
	Function HexLE:String(Value:Int)
		#If RETROSTRINGS_STANDARD_INTERNALS Or Not RETROSTRINGS_EXTENSION_HEXLE
			' The current standard implementation of this may change in the future:
			
			' Local variable(s):
			Local S:= HexBE(Value)
			
			' Return the result of 'HexBE' in corrected order. (Not the most efficient method)
			Return S[6..8] + S[4..6] + S[2..4] + S[0..2]
		#Else
			Return ext.HexLE(Value)
		#End
	End
	
	' This command may be overhauled at a later date.
	Function HexBE:String(Value:Int)
		#If RETROSTRINGS_STANDARD_INTERNALS Or Not RETROSTRINGS_EXTENSION_HEXBE
			' Local variable(s):
			Local Buf:Int[8]
			
			For Local k:= 7 To 0 Step -1
				Local n:Int = (Value & 15) + ASCII_NUMBERS_POSITION
				
				If (n > ASCII_CHARACTER_9) Then
					n += (ASCII_CHARACTER_UPPERCASE_POSITION-ASCII_CHARACTER_9-1)
				Endif
				
				Buf[k]=n
				Value Shr= 4
			Next
			
			Return String.FromChars(Buf)
		#Else
			Return ext.HexBE(Value)
		#End
	End
	
	' This will return an offset version of the number specified,
	' based on the standard ascii position of zero.
	' The 'Number' argument should be less than 'ASCII_NUMBER_COUNT', and no smaller than zero.
	Function NumberInAsc:Int(Number:Int=0)
		Return ASCII_NUMBERS_POSITION +
		
		#If RETROSTRINGS_SAFE
			(Abs(Number) Mod ASCII_NUMBER_COUNT)
		#Else
			(Number Mod ASCII_NUMBER_COUNT)
		#End
	End
	
	Function LongHex:String(Value:Int) 
		Return Hex(Value)
	End
	
	Function LongBin:String(Value:Int)
		Return Bin(Value)
	End
#End