#![no_std]
#![no_main]

struct UartRegisters {
    regs: [u32; 16],
}

#[panic_handler]
fn panic(info: &core::panic::PanicInfo) -> ! {
    loop {
    }
}

#[no_mangle]
pub extern "C" fn _start() -> ! {
    let mut uart : &mut UartRegisters = unsafe { &mut *(0x00030000 as *mut UartRegisters) };
    uart.regs[0] = 42;

    loop {}
}