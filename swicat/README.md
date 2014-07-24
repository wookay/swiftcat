# requirements

	Build Settings ->
	  Apple LLVM 6.0 - Preprocessing ->
	    Enable Strict Checking of objc_msgSend Calls : No

	Build Settings ->
      Swift Compiler - Code Generation ->
        Objective-C Bridging Header : Swicat-Bridging-Header.h

      Copy TestApp/Swicat-Bridging-Header.h to your project



# use
	// UnitTest
	UnitTest.run()

	// Console
	Console.run()
