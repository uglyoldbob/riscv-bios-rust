cmake_minimum_required(VERSION 3.22)
project(bios)

add_custom_target(
    bios
    BYPRODUCTS ./bios ./combios ./combios.dat
    COMMAND cargo build --release
    COMMAND cp -u target/riscv32ima-unknown-none-elf/release/bios ./bios
    COMMAND rust-objcopy -O binary ./bios ./combios
    COMMAND xxd -ps -c 1 ./combios ./combios.dat
)