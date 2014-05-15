
`include "define.v"
module sdram_sdram(
input wire   clock_100,
input wire   clock_100_delayed_3ns,
input wire RESET,


input wire [1:0]C_BANK, //����� �����
input wire  [12:0] C_ROW_ADDRESS, //����� ������ ������ ������ ���� ������ ������ ��� ��� 
//���� ������ ��������� �������� ��� ������ � ������

input wire   C_READ, //������� ������
input wire   C_WRITE,//������� �� �������

input wire C_TYPE,

output BUFER_EN,

//output reg   data_out_valid,  
output    END_OPERATION,  //�������� ��� ������� ��� ������� ������ �����������
output NUMBER_CHANNEL,


output  [15:0]   DATA_OUT,
input wire [15:0]   DATA_IN,


output  [12:0]  DRAM_ADDR,
output  [1:0]   DRAM_BA,
output    DRAM_CAS_N,
output   DRAM_CKE,
output   DRAM_CLK,
output   DRAM_CS_N,
output [1:0]   DRAM_DQM,
output    DRAM_RAS_N,
output   DRAM_WE_N,

input [15:0]   DRAM_INPUT ,
output  [15:0]   DRAM_OUTPUT ,

output reg DRAM_INOUT

   );
	
	

//reg [15:0]r_data_write=16'b0;
reg [8:0]r_state=9'b0;
reg [12:0]r_address=13'b0;
//reg [15:0]r_init_counter=16'b1000000000000000;
reg [15:0]r_init_counter=16'b0000_0001_0000_0000;
reg r_read=0;
reg r_write=0;
reg [12:0]r_act_row=0;
reg [9:0]r_rf_counter=10'b0;
reg r_rf_pending=0;
reg [1:0]r_bank=2'b0; 
reg r_bufer_en=0;
//reg [15:0]r_data_read=16'b0;
reg [1:0]r_dq_masks=2'b0;
reg r_end_operation=0;
reg [9:0] r_cnt_pix =10'b0;



reg [4:0]state;

parameter cmd_nop   =4'b0111;
parameter cmd_read  =4'b0101;   // Must be sure A10 is low.

parameter cmd_brst  =4'b0110;   // Must be sure A10 is low.

parameter cmd_write =4'b0100;
parameter cmd_act   =4'b0011;
parameter cmd_pre   =4'b0010;  // Must set A10 to '1'.
parameter cmd_ref   =4'b0001;
parameter cmd_mrs   =4'b0000; // Mode register set
//State assignments
parameter s_init_nop_id=9'b00000xxxx;

parameter s_init_nop  =9'b000000111;//s_init_nop_id <<5 + cmd_nop;
parameter s_init_pre  =9'b000000010;//s_init_nop_id <<5 + cmd_pre;
parameter s_init_ref  =9'b000000001;//s_init_nop_id <<5 + cmd_ref;
parameter s_init_mrs  =9'b000000000;//s_init_nop_id <<5 + cmd_mrs;

parameter s_idle_id =9'b00001xxxx;
parameter s_idle  =9'b000010111;

parameter s_rf0_id=9'b00010xxxx;
parameter s_rf0   =9'b000100001;
parameter s_rf1_id=9'b00011xxxx;
parameter s_rf1   =9'b000110111;
parameter s_rf2_id=9'b00100xxxx;
parameter s_rf2   =9'b001000111;
parameter s_rf3_id=9'b00101xxxx;
parameter s_rf3   =9'b001010111;
parameter s_rf4_id=9'b00110xxxx;
parameter s_rf4   =9'b001100111;
parameter s_rf5_id=9'b00111xxxx;
parameter s_rf5   =9'b001110111;

parameter s_ra0_id=9'b01000xxxx;
parameter s_ra0   =9'b010000011;
parameter s_ra1_id=9'b01001xxxx;
parameter s_ra1   =9'b010010111;
parameter s_ra2_id=9'b01010xxxx;
parameter s_ra2   =9'b010100111;

parameter s_dr0_id=9'b01011xxxx;
parameter s_dr0   =9'b010110010;
parameter s_dr1_id=9'b01100xxxx;
parameter s_dr1   =9'b011000111;

parameter s_wr0_id=9'b01101xxxx;
parameter s_wr0   =9'b011010100;
parameter s_wr1_id=9'b01110xxxx;
parameter s_wr1   =9'b011100111;

parameter s_brst_id=9'b010000xxx;
parameter s_brst   =9'b010000110;


parameter s_rd0_id=9'b10001xxxx;
parameter s_rd0   =9'b100010101;
parameter s_rd1_id=9'b10010xxxx;
parameter s_rd1   =9'b100100111;
parameter s_rd2_id=9'b10011xxxx;
parameter s_rd2   =9'b100110111;
parameter s_rd3_id=9'b10100xxxx;
parameter s_rd3   =9'b101000111;
parameter s_rd4_id=9'b10101xxxx;
parameter s_rd4   =9'b101010101;


parameter s_drdr0_id=9'b11101xxxx;
parameter s_drdr0   =9'b111010010;
parameter s_drdr1_id=9'b11110xxxx;
parameter s_drdr1   =9'b111100111;
parameter s_drdr2_id=9'b11111xxxx;
parameter s_drdr2   =9'b111110111;

assign DRAM_CLK=clock_100_delayed_3ns;
assign DRAM_CKE        = 1'b1;
assign DRAM_CS_N       = r_state[3];
assign DRAM_RAS_N      = r_state[2];
assign DRAM_CAS_N      = r_state[1];
assign DRAM_WE_N       = r_state[0];
assign DRAM_ADDR       = r_address;
assign DRAM_BA		   = r_bank;	

assign BUFER_EN		   = r_bufer_en;	
assign DRAM_OUTPUT	   = DATA_IN;
assign DATA_OUT		   = DRAM_INPUT;

assign DRAM_DQM       = r_dq_masks;
 	
assign END_OPERATION = r_end_operation;

assign NUMBER_CHANNEL=r_act_row[0];


//assign state=r_state[8:4];
/*
bufer buferer(
.RESET(RESET),
.CLK(clock_100),
.BUFER(BUFER_EN)

);
*/


//always @(r_state  or  C_READ or  C_WRITE or C_ROW_ADDRESS or C_BANK or r_init_counter or r_cnt_pix or r_bufer_en  or r_rf_pending or r_read or r_write or r_data_write or r_rf_pending)
always @(posedge clock_100 or posedge RESET)
begin
	if (RESET)
	begin
			
	//	r_data_write=16'b0;
		r_state=9'b000000000;
		r_address=13'b0000000000000;
		//r_init_counter=16'b1000000000000000;
		r_init_counter=16'b0000_0001_0000_0000;
		
		r_read=0;
		r_write=0;
		r_act_row=0;
		r_rf_counter=10'b0;
		r_rf_pending=0;
		r_bank=2'b0; 
		r_bufer_en=0;
	//	r_data_read=16'b0;
		r_dq_masks=2'b0;
		r_end_operation<=0;
		r_cnt_pix =10'b0;
		DRAM_INOUT<=0;
	end
	else 
	begin
	
	r_init_counter <= r_init_counter-1'b1;
	
	if (C_READ==1) begin
		r_read<=1;
		DRAM_INOUT<=0;
	end 
	
	if (C_WRITE==1) begin
		r_write<=1;
		DRAM_INOUT<=1;
	end
	
	r_dq_masks<=2'b11;
	
	// first off, do we need to perform a refresh cycle ASAP?
	if (r_rf_counter == 450) begin // -- 781 = 64,000,000ns / 8192 / 10ns
		r_rf_counter <= 10'b0;
		r_rf_pending <= 1;
	end
	else
	// only start looking for refreshes outside of the initialisation state.
		if (r_state[8:4] != s_init_nop[8:4]) begin
		r_rf_counter <= r_rf_counter + 1'b1;
		end 
	 

	casex (r_state)
	 s_init_nop: begin
			   DRAM_INOUT<=0;
            r_state     <= s_init_nop;
            r_address <= 13'b0;
            r_rf_counter<=0;
            r_rf_counter   <= 10'b0;
            r_bank<=2'b00;
            
            //-- T-130, precharge all banks.
            if (r_init_counter == 130) begin
               r_state     <= s_init_pre;
               r_address   <= 13'b0_0100_0000_0000;
            end 

            // T-127, T-111, T-95, T-79, T-63, T-47, T-31, T-15, the 8 refreshes
            
            else if ((r_init_counter[14:7] ==0) && (r_init_counter[3:0]== 15)) begin
               r_state     <= s_init_ref;
            end 
            
            // T-3, the load mode register 
            else if (r_init_counter == 3) begin
               r_state     <= s_init_mrs;
                 //          -- Mode register is as follows:
                  //         -- resvd   wr_b   OpMd   CAS=2   Seq   bust=full
                r_address   <= 13'b0000000110111;
                         //  -- resvd
               r_bank<=2'b00;
            end 

            
            // T-1 The switch to the FSM (first command will be a NOP
            else if ( r_init_counter == 1) begin
               r_state          <= s_idle;
            end 
	
	end
	s_init_pre: begin
			DRAM_INOUT<=0;
            r_state     <= s_init_nop;
            r_address <= 13'b0;
            r_rf_counter<=0;
            r_rf_counter   <= 10'b0;
            r_bank<=2'b00;
            
            //-- T-130, precharge all banks.
            if (r_init_counter == 130) begin
               r_state     <= s_init_pre;
                r_address   <= 13'b0_0100_0000_0000;
            end 

            // T-127, T-111, T-95, T-79, T-63, T-47, T-31, T-15, the 8 refreshes
            
            else if ((r_init_counter[14:7] ==0) && (r_init_counter[3:0]== 15)) begin
               r_state     <= s_init_ref;
            end 
            
            // T-3, the load mode register 
            else if (r_init_counter == 3) begin
               r_state     <= s_init_mrs;
                 //          -- Mode register is as follows:
                  //         -- resvd   wr_b   OpMd   CAS=2   Seq   bust=full
                r_address   <= 13'b0000000110111;
                         //  -- resvd
               r_bank<=2'b00;
            end 

            
            // T-1 The switch to the FSM (first command will be a NOP
            else if ( r_init_counter == 1) begin
               r_state          <= s_idle;
			   
            end 
	
	end  
   s_init_ref: begin
			DRAM_INOUT<=0;
            r_state     <= s_init_nop;
            r_address <= 13'b0;
            r_rf_counter<=0;
            r_rf_counter   <= 10'b0;
            r_bank<=2'b00;
            
            //-- T-130, precharge all banks.
            if (r_init_counter == 130) begin
               r_state     <= s_init_pre;
                r_address   <= 13'b0_0100_0000_0000;
            end 

            // T-127, T-111, T-95, T-79, T-63, T-47, T-31, T-15, the 8 refreshes
            
            else if ((r_init_counter[14:7] ==0) && (r_init_counter[3:0]== 15)) begin
               r_state     <= s_init_ref;
            end 
            
            // T-3, the load mode register 
            else if (r_init_counter == 3) begin
               r_state     <= s_init_mrs;
                 //          -- Mode register is as follows:
                  //         -- resvd   wr_b   OpMd   CAS=2   Seq   bust=full
                r_address   <= 13'b0000000110111;
                         //  -- resvd
               r_bank<=2'b00;
            end 

            
            // T-1 The switch to the FSM (first command will be a NOP
            else if ( r_init_counter == 1) begin
               r_state          <= s_idle;
            end 
	
	end
   s_init_mrs: begin
			DRAM_INOUT<=0;
            r_state     <= s_init_nop;
            r_address <= 13'b0;
            r_rf_counter<=0;
            r_rf_counter   <= 10'b0;
            r_bank<=2'b00;
            
            //-- T-130, precharge all banks.
           if (r_init_counter == 130) begin
               r_state     <= s_init_pre;
                r_address   <= 13'b0_0100_0000_0000;
            end 

            // T-127, T-111, T-95, T-79, T-63, T-47, T-31, T-15, the 8 refreshes
            
            else if ((r_init_counter[14:7] ==0) && (r_init_counter[3:0]== 15)) begin
               r_state     <= s_init_ref;
            end 
            
            // T-3, the load mode register 
            else if (r_init_counter == 3) begin
               r_state     <= s_init_mrs;
                 //          -- Mode register is as follows:
                  //         -- resvd   wr_b   OpMd   CAS=2   Seq   bust=full
                r_address   <= 13'b0000000110111;
                         //  -- resvd
               r_bank<=2'b00;
            end 

            
            // T-1 The switch to the FSM (first command will be a NOP
            else if ( r_init_counter == 1) begin
               r_state          <= s_idle;
            end 
	
	end  

	s_idle:begin
		r_state<=s_idle;
		r_end_operation<=0;
		if ((r_write==1) || (r_read==1)) begin
			r_state<=s_ra0;
			r_bank<=C_BANK;
		
			r_address<=C_ROW_ADDRESS;
			r_act_row<=C_ROW_ADDRESS;
			r_cnt_pix<=10'b0;
		end
		
		if (r_rf_pending ==1) begin
            r_state        <= s_rf0;
            r_rf_pending <=0;
        end 
		
	end	
	s_ra0: begin
		
		r_state<=s_ra1;
	end	
	s_ra1: begin 
		r_state<=s_ra2;
		if (r_write==1) r_bufer_en<=1; //���� ������  �� ������� ����� ��� ������ ������	

		if (r_read==1)  r_bufer_en<=0; //���� ������ �� ������� ����� ��� ������ ������ ����������	
	end
	s_ra2:begin
		if (r_write==1) begin
			r_state     <= s_wr0;
			r_dq_masks<=2'b00;
			r_address<=13'b0;
			r_bank<=C_BANK;
		end
		else if (r_read==1) begin
			r_state     <= s_rd0;
			r_dq_masks<=2'b00;
			r_address<=13'b0;
			r_bank<=C_BANK;
		
		end
	end
	
	s_rd0:begin
		r_state     <= s_rd1;
		r_dq_masks<=2'b00;
	end
	s_rd1:begin
		r_state     <= s_rd2;
		r_dq_masks<=2'b00;
	end
	s_rd2:begin
		r_state     <= s_rd3;
		
		r_cnt_pix<=r_cnt_pix+1'b1;
		r_dq_masks<=2'b00;
	end
	s_rd3:begin //������, ����� ������ ������� ����� �� ������
		r_bufer_en<=1; 
		if (C_TYPE==1)
		begin
			r_dq_masks<=2'b00;
			//��������� ��������� r_cnt_pix 
			if (r_cnt_pix<(`PIX_IN_ROW/2-3))
			begin
				r_state     <= s_rd3;
				r_cnt_pix<=r_cnt_pix+1'b1;
				
			end
			else if (r_cnt_pix==`PIX_IN_ROW/2-3)
			begin
				
				r_state<=s_brst;
				
				r_cnt_pix<=r_cnt_pix+2'b11;
				//n_bufer_en<=0;
				
			end
			else if ((r_cnt_pix>`PIX_IN_ROW/2-3) &&(r_cnt_pix<`PIX_IN_ROW-3))
			begin
				r_state     <= s_rd3;
				r_cnt_pix<=r_cnt_pix+1'b1;
			end
			else if (r_cnt_pix==`PIX_IN_ROW-3)
			begin
					r_state<=s_brst;
				
				
				
			end
		
		end
		else 
		begin
			if (r_cnt_pix<=`PIX_IN_ROW)
			begin
				r_state     <= s_rd3;
				r_cnt_pix<=r_cnt_pix+1'b1;
				
			end
			else if (r_cnt_pix==`PIX_IN_ROW-3)
			begin
				r_state<=s_brst;
			
				
				
			end
		end
	end
	
	s_drdr0: r_state <= s_drdr1;
	s_drdr1:begin
		r_state <= s_drdr2;
		//if (r_read==1) r_bufer_en<=0;
	end
	s_drdr2: begin
		if (r_read==1) r_bufer_en<=0;
		if ((r_cnt_pix<(`PIX_IN_ROW/2+10))&&(r_cnt_pix>(`PIX_IN_ROW/2-10)))
		begin
			r_state<=s_ra0;
			r_address<=C_ROW_ADDRESS+1'b1;
			r_act_row<=C_ROW_ADDRESS+1'b1;
			r_bank<=C_BANK;
		end
		else
		begin
			r_bufer_en<=0;
			DRAM_INOUT<=0;
			r_state        <= s_rf0;
			  r_rf_pending <=0;
			r_rf_counter <= 10'b0;
		end
         
	end
	s_brst:begin
		if (r_write==1) //�������������� ���������� ��� 
		begin
			r_state     <= s_dr0;
			r_address[10]<=1;
				
		end
		else if (r_read==1)
		begin
			r_state     <= s_drdr0;
			r_address[10]<=1;
		end
		
	end
	s_wr0:begin	
		r_cnt_pix<=r_cnt_pix+1'b1;
		r_dq_masks<=2'b00;
		r_state     <= s_wr1;
	end
	s_wr1:begin	
		if (C_TYPE==1)
		begin
			r_dq_masks<=2'b00;
			
			if (r_cnt_pix<(`PIX_IN_ROW/2-1))
			begin
				r_state     <= s_wr1;
				r_cnt_pix<=r_cnt_pix+1'b1;
			end
			else if (r_cnt_pix==`PIX_IN_ROW/2-1)
			begin
				
				r_state<=s_brst;
				
				r_bufer_en<=0;
			end
			else if ((r_cnt_pix>`PIX_IN_ROW/2-1) &&(r_cnt_pix<`PIX_IN_ROW-1))
			begin
				r_state     <= s_wr1;
				r_cnt_pix<=r_cnt_pix+1'b1;
			end
			else if (r_cnt_pix==`PIX_IN_ROW-1)
			begin
				r_state<=s_brst;
				r_bufer_en<=0;
				
			end
			if (r_cnt_pix==`PIX_IN_ROW/2-2) r_bufer_en<=0;
			else if (r_cnt_pix==`PIX_IN_ROW-2)r_bufer_en<=0;
		end
		else 
		begin
			if (r_cnt_pix<=`PIX_IN_ROW)
			begin
				r_state     <= s_wr1;
				r_cnt_pix<=r_cnt_pix+1'b1;
			end
			else if (r_cnt_pix==`PIX_IN_ROW)
			begin
				r_state<=s_brst;
				r_bufer_en<=0;
				
			end
		end
	
	end
	
	s_dr0: r_state <= s_dr1;
   	s_dr1: begin
		if ((r_cnt_pix<(`PIX_IN_ROW/2+10))&&(r_cnt_pix>(`PIX_IN_ROW/2-10)))
		begin
			r_state<=s_ra0;
			r_address<=C_ROW_ADDRESS+1'b1;
			r_act_row<=C_ROW_ADDRESS+1'b1;
			r_bank<=C_BANK;
		end
		else
		begin
			r_bufer_en<=0;
			r_state        <= s_rf0;
			r_rf_pending <=0;
			//r_address[10] <= 1;
			r_rf_counter <= 10'b0;
			DRAM_INOUT<=0;
		end
	end
	
    s_rf0:r_state <= s_rf1;
    s_rf1:r_state <= s_rf2;
    s_rf2:r_state <= s_rf3;
    s_rf3:r_state <= s_rf4;
    s_rf4:begin 
		r_state <= s_rf5;
		 if (r_write==1) r_end_operation<=1;
		 else if (r_read==1) r_end_operation<=1;
		 else r_end_operation<=0;
	 end	
    s_rf5:begin
		 r_state <= s_idle;
		 r_end_operation<=0;
		 r_write<=0;
		 r_read<=0;
	end
	default:
            r_state <= s_idle;
	endcase
	
	end
end

endmodule
	
