import SAMBA 3.2
import SAMBA.Connection.Serial 3.2
import SAMBA.Device.SAMA5D2 3.2

SerialConnection {
		//port: "ttyACM0"
		//port: "COM85"
		//baudRate: 57600
	

	device: SAMA5D2 {
		config {
			nandflash {
				ioset: 2
				busWidth: 8
				header: 0xc0902405
			}
		}
	}

	onConnectionOpened: {
		// initialize NAND flash applet
		initializeApplet("nandflash")
		// erase all memory
		applet.erase(0, applet.memorySize)

        
		// write files
		//applet.write(0x000000, "sama5d2_ptc-nandflashboot-app-3.8.7.bin", true)
		applet.write(0x000000, "boot.bin", true)
		applet.write(0x060000, "app.bin")
        
                // initialize boot config applet
		initializeApplet("bootconfig")
    applet.writeBootCfg(BootCfg.FUSE,
                        BCW.fromText("EXT_MEM_BOOT,UART1_IOSET2,JTAG_IOSET1," +
	                     "SDMMC1_DISABLED,SDMMC0_DISABLED,NFC_IOSET2," +
	                     "SPI1_DISABLED,SPI0_DISABLED," +
	                     "QSPI1_DISABLED,QSPI0_DISABLED"))

		// Use BUREG0 as boot configuration word
		applet.writeBootCfg(BootCfg.BSCR, BSCR.fromText("VALID,BUREG0"))

		// Enable external boot only on NFC IOSET2
		applet.writeBootCfg(BootCfg.BUREG0,
	        		BCW.fromText("EXT_MEM_BOOT,UART1_IOSET2,JTAG_IOSET1," +
	                     "SDMMC1_DISABLED,SDMMC0_DISABLED,NFC_IOSET2," +
	                     "SPI1_DISABLED,SPI0_DISABLED," +
	                     "QSPI1_DISABLED,QSPI0_DISABLED"))
        
	}
}
