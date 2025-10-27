# ASYNCHRONOUS_FIFO  
# INTRODUCTION  
This repository contains Verilog code for an Asynchronous FIFO (First-In, First-Out) buffer, designed to safely transfer data across cross-domain clocking scenarios. The write and read operations are driven by independent, asynchronous clocks, making it an essential component for reliable communication between subsystems or components operating at different clock frequencies in digital designs such as ASICs and FPGAs.  

# SPECIFICATIONS   
•	**Data Width:** Configurable, typically from 1 to 256 bits per location depending on application requirements.  
•	**Depth:** Programmable memory depth, commonly ranging from 8 locations up to several kilobytes or more.  
•	**Clock Domains:** Separate write and read clocks operating asynchronously, supporting safe crossing of clock domains.  
•	**Pointer Synchronization:**  multi-stage flip-flop synchronizers to avoid metastability when crossing clock domains.  
•	**Full and Empty Flags:** Generates full and empty status flags for flow control, preventing overflow and underflow conditions.  
•	**Write and Read Operations:** Independent read and write pointer logic with circular addressing.  
•	**Metastability Handling:** 2 stage synchronizers used on crossing signals to ensure reliable operation between clock domains.  

# OPERATION  
•	**Write Operation:**   
Data is written into the FIFO memory under the control of the write clock domain until full condition occurs.  A write pointer increments with each data write, addressing the FIFO storage.  Performing a write operation requires data at the input, asserting write enable and capture data on the next rising edge of the write clock.  
•	**Read Operation:**   
Data is read from the FIFO using read pointer that increments with each valid read enable until empty condition occurs. Performing a read operation requires asserting read enable and sampling the output data in the next rising edge of the clock.  
•	**Pointers that control the operation (write and read pointer):**   
To enable safe status flag generation (full and empty) and metastability issue pointers are required.  
<ins>Write pointer</ins>: controls the write operation and points to the memory location for the next write.    
<ins>Read pointer</ins>: controls the read operation and points memory location for the next read.  
•	**Status Flags:**   
An Asynchronous FIFO provides with two status flags which is used to control read and write operation.  
<ins>Full</ins>: Asynchronous FIFO asserts full when write pointer is about to overtake the read pointer, preventing data overwrites in the memory until space is available by holding the write requests.  
<ins>Empty</ins>: empty flag is asserted when read catches up to the write pointer, indicating no data is present to read.  

# BLOCK DIAGRAM  
<img width="400" height="300" alt="image" src="https://github.com/user-attachments/assets/eba1bffd-449c-49a2-a83a-9f0a3a86f3c1" />  

# WAVEFORMS  
<img width="968" height="264" alt="image" src="https://github.com/user-attachments/assets/f7426bb9-e62a-4c39-8da8-16e774dac79b" />  
<img width="968" height="264" alt="image" src="https://github.com/user-attachments/assets/264a172b-4bbe-480a-b100-54b6661ed284" />
