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

##