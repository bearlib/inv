/*
* BeaRLibItems C# wrapper
* Copyright (C) 2017 Apromix
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
* of the Software, and to permit persons to whom the Software is furnished to do
* so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
* FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
* COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
* IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

using System;
using System.Text;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace BearLib
{
	public static class Items
	{
		
		// Library
		
        [DllImport("BeaRLibItems.dll", EntryPoint = "Items_Open", CallingConvention=CallingConvention.StdCall)]
        public static extern void Open();

        [DllImport("BeaRLibItems.dll", EntryPoint = "Items_Close", CallingConvention=CallingConvention.StdCall)]
        public static extern void Close();

        [DllImport("BeaRLibItems.dll", EntryPoint = "Items_GetVersion", CallingConvention=CallingConvention.StdCall)]
        public static extern String GetVersion();
        
        // Maps
        public static class Maps
        {
			[DllImport("BeaRLibItems.dll", EntryPoint = "Items_Maps_Clear", CallingConvention=CallingConvention.StdCall)]
			public static extern void Clear();
 
			[DllImport("BeaRLibItems.dll", EntryPoint = "Items_Maps_GetCount", CallingConvention=CallingConvention.StdCall)]
			public static extern int GetCount();
       }
        
        // Inventory
        public static class Inventory
        {
			[DllImport("BeaRLibItems.dll", EntryPoint = "Items_Inventory_Clear", CallingConvention=CallingConvention.StdCall)]
			public static extern void Clear();

			[DllImport("BeaRLibItems.dll", EntryPoint = "Items_Inventory_GetCount", CallingConvention=CallingConvention.StdCall)]
			public static extern int GetCount();
        }
        
	}
}
