# Overview: 


## Introduction
A router is a device that forwards data packets between computer networks. It operates as an OSI layer 3 routing device, directing incoming packets to an output channel based on the address field contained in the packet header.

## Router Top - Overview
The Router 1x3 design adheres to a packet-based protocol, receiving network packets from a source LAN via data_in on a byte-by-byte basis, synchronized with the active clock's positive edge. The resetn is an active low synchronous reset.

A new packet's arrival is indicated by asserting pkt_valid, while the end of the current packet is indicated by de-asserting pkt_valid. Incoming packets are stored inside a FIFO based on the packet's address. The design includes three FIFOs for the respective destination LANs.

During packet read operations, the destination LANs monitor vld_out_x (where x can be 0, 1, or 2), and then assert read_enb_x (where x can be 0, 1, or 2). The packet is read by the destination LANs using the channels data_out_x (where x can be 0, 1, or 2).

The router can enter a busy state, indicated by the busy signal. When this occurs, the busy signal is sent back to the source LAN, requiring it to wait before sending the next byte of the packet.

To ensure packet correctness, a parity check mechanism is implemented. If there is a mismatch between the parity byte sent by the source LAN and the internal parity calculated by the router, an error signal is asserted. This error signal prompts the source LAN to resend the packet.

This design allows for the reception of only one packet at a time, but it can read three packets simultaneously.

## Router - 1x3 Features
- **Packet Routing:** The packet is driven from the input port and routed to any one output port based on the address of the destination network.

- **Parity Checking:** An error detection technique that verifies the integrity of digital data transmitted between server and client. This method ensures that data sent by the server network is received by the client network without corruption.

- **Reset:** An active low synchronous input that resets the router. Under reset conditions, the router FIFOs are emptied, and the valid output signals go low, indicating no valid packet is detected on the output data bus.

- **Sending Packet:** Refer to the router input protocol for detailed procedures.

- **Reading Packet:** Refer to the router output protocol for detailed procedures.

## Router - Packet
- **Packet Format:** The packet consists of three parts: Header, Payload, and Parity. Each ID is 8 bits wide, and the payload length can range from 1 to 63 bytes.

- **Header:** The packet header contains two fields: DA (Destination Address) and Length.
DA: The destination address of the packet, which is 2 bits. The router directs the packet to respective ports based on this address. Each output port has a unique 2-bit address. If the packet’s destination address matches the port address, the router forwards the packet to that port. The address "3" is invalid.
Length: The data length, specified in 6 bits. This indicates the number of data bytes. The minimum data size is 1 byte, and the maximum is 63 bytes.
    If Length = 1, the data length is 1 byte.
    If Length = 63, the data length is 63 bytes.
- **Payload:** The payload contains the actual data. Data should be in bytes.

- **Parity:** This field ensures packet security. It is calculated as the bitwise parity over the header and payload bytes.

## Router- Input Protocol
Characteristics of the DUT Input Protocol are as follows:

- **TestBench Note:**
- * All input signals are active high except the active low reset and are synchronized to the falling edge of the clock.
The DUT router is sensitive to the rising edge of the clock. Hence, in the testbench, driving input signals on the falling edge ensures adequate setup and hold time.
In a SystemVerilog/UVM-based testbench, clocking blocks can be used to drive signals on the positive edge of the clock, thereby avoiding metastability.



The packet_valid signal is asserted on the same clock edge when the header byte is driven onto the input data bus.


Since the header byte contains the address, which tells the router to which output channel the packet should be routed to. (data_out_0, data_out_1, or data_out_2).


Each subsequent byte of payload after the header byte should be driven on the input data bus for every new falling edge of the clock.


After the last payload byte has been driven, on the next falling clock, the packet_valid signal must be deasserted, and the packet parity byte should be driven. This signals the completion of the packet.