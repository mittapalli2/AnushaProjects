module router_reg(input clock,resetn,pkt_valid,fifo_full,detect_add,ld_state,laf_state,full_state,lfd_state,rst_int_reg,
                  input [7:0]data_in,
                  output reg err,parity_done,low_packet_valid,
 			            output reg [7:0]dout);


reg [7:0] header,fifo_full_state_byte,internal_parity;
reg [7:0] packet_parity;


//dout

always@(posedge clock)
  begin
    if(!resetn)
      dout<=0;

    else if(detect_add && pkt_valid && data_in[1:0] !=3)
      dout<=dout;
    
    else if(lfd_state)
      dout<=header;
    
    else if(ld_state)
      begin
          if(~fifo_full)
    	      dout<=data_in;
          else
            dout<=dout;
      end

    else if(laf_state)
      dout<=fifo_full_state_byte;

    else if(~laf_state)
      dout<=dout;
  end


//header

always@(posedge clock)
  begin
    if(!resetn)
      header <= 0;

    else if(detect_add && pkt_valid && data_in[1:0]!=3)
      header <= data_in;

    else
      header <= header;
  end


//fifo_full_state

always@(posedge clock)
  begin
    if(!resetn)
      fifo_full_state_byte<=0;

    else if(ld_state && fifo_full)
      fifo_full_state_byte <=fifo_full_state_byte;
  end

//internal parity 

always@(posedge clock)
  begin
    if(!resetn)
      internal_parity<=0;

    else if(detect_add)
      internal_parity<=0;

    else if(lfd_state)
      internal_parity<=internal_parity^header;

    else if(pkt_valid && ld_state && ~full_state)
      internal_parity<=(internal_parity^data_in);
  end

//parity done

always@(posedge clock)
  begin
    if(!resetn)
      parity_done<=0;

    else if((ld_state && ~fifo_full &&  ~pkt_valid || laf_state && low_packet_valid))
      parity_done<=1;

    else if(detect_add)
      parity_done<=0;
  end

//lowpacket

always@(posedge clock)
  begin
    if(!resetn)
      low_packet_valid  <= 0;

    else if(rst_int_reg)
      low_packet_valid <=0;

    else if(~pkt_valid && ld_state)
      low_packet_valid<=1;
  end

//error

always@(posedge clock)
  begin
    if(!resetn)
      err  <= 0;

    else if(packet_parity)
      begin
        if(packet_parity == internal_parity)
          err <= 0;
        else
          err<=1;
      end
  end

//packet parirty

always@(posedge clock)
  begin
    if(!resetn)
      packet_parity  <= 0;

    else if(detect_add)
      packet_parity <=0;
    
    else if(ld_state && ~pkt_valid && ~fifo_full)
      packet_parity<= data_in;

  end

endmodule
