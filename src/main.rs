#![no_std]
#![no_main]

struct UartRegisters {
    settings: [u32; 8],
    tx: u32,
    rx: u32,
}

#[panic_handler]
fn panic(info: &core::panic::PanicInfo) -> ! {
    loop {
    }
}

#[no_mangle]
pub extern "C" fn _start() -> ! {
    let mut uart : &mut UartRegisters = unsafe { &mut *(0x00030000 as *mut UartRegisters) };
    uart.settings[0] = 42;
    uart.tx = 'A' as u32;

    loop {}
}