# Asynchronous-FIFO
This repository contains an Asynchronous FIFO (First-In-First-Out) module implemented in Verilog/SystemVerilog. The FIFO allows data transfer between two clock domains operating at different frequencies, ensuring reliable and safe communication without data corruption.  

**Specifications of Asynchronous FIFO**.  
• **Data Width:** Configurable, typically from 1 to 256 bits per location depending on application requirements.  
• **Depth:** Programmable memory depth, commonly ranging from 8 locations up to several kilobytes or more.  
• **Clock Domains:** Separate write and read clocks operating asynchronously, supporting safe crossing of clock domains.  
• **Pointer Synchronization:**  multi-stage flip-flop synchronizers to avoid metastability when crossing clock domains.  
• **Full and Empty Flags:** Generates full and empty status flags for flow control, preventing overflow and underflow conditions.  
• **Write and Read Operations:** Independent read and write pointer logic with circular addressing.  
• **Metastability Handling:** 2 stage synchronizers used on crossing signals to ensure reliable operation between clock domains.  

**BASIC OPERATION:**  
• **Write Operation:**  Data is written into the FIFO memory under the control of the write clock domain until full condition occurs.  A write pointer increments with each data write, addressing the FIFO storage.  Performing a write operation requires data at the input, asserting write enable and capture data on the next rising edge of the write clock.  

• **Read Operation:**  Data is read from the FIFO using read pointer that increments with each valid read enable until empty condition occurs. Performing a read operation requires asserting read enable and sampling the output data in the next rising edge of the clock.  

• **Pointers that control the operation (write and read pointer):**   To enable safe status flag generation (full and empty) and metastability issue pointers are required.  
Write pointer: controls the write operation and points to the memory location for the next write.  
Read pointer controls the read operation and points memory location for the next read.  

• **Status Flags:** An Asynchronous FIFO provides with two status flags which is used to control read and write operation.  
Full: Asynchronous FIFO asserts full when write pointer is about to overtake the read pointer, preventing data overwrites in the memory until space is available by holding the write requests.  
Empty: empty flag is asserted when read catches up to the write pointer, indicating no data is present to read.

