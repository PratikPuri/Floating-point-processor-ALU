// (c) Copyright 2011 - 2012 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.

//----------------------------------------------------------------------------
// Project    : Pheidippides
// Company    : Cadence Design Systems
//----------------------------------------------------------------------------
// Description: 
// This file contains an example test for the AXI 4 streaming Master and 
// Slave BFMs.
// It demonstrates how to stimulate the following conditions from both the
// master and slave perspectives:
// 1  Simple master to slave transfer example
// 2  Looped master to slave transfers example
// 3  Simple master to slave packet example
// 4  Looped master to slave packets example
// 5  Ragged master to slave packet example i.e. less data at the end of the
//    packet than can be supported
// 6  Packet data interleaving example
//----------------------------------------------------------------------------


//----------------------------------------------------------------------------
// The test module.
//----------------------------------------------------------------------------

module test;

   //------------------------------------------------------------------------
   // Configuration Parameters
   //------------------------------------------------------------------------
   parameter MASTER_NAME = "MASTER_0";
   parameter SLAVE_NAME = "SLAVE_0";
   parameter DATA_BUS_WIDTH = 32;
   parameter ID_BUS_WIDTH   = 8;
   parameter DEST_BUS_WIDTH = 4;
   parameter USER_BUS_WIDTH = 8;
   parameter MAX_PACKET_SIZE = 10;
   parameter MAX_OUTSTANDING_TRANSACTIONS = 8;
   parameter STROBE_NOT_USED = 0;
   parameter KEEP_NOT_USED = 0;

   // Create an instance of the example tb
   cdn_axi4_streaming_example_tb #(MASTER_NAME,
                                   SLAVE_NAME,
                                   DATA_BUS_WIDTH,
                                   ID_BUS_WIDTH,
                                   DEST_BUS_WIDTH,
                                   USER_BUS_WIDTH,
                                   MAX_PACKET_SIZE,
                                   MAX_OUTSTANDING_TRANSACTIONS,
                                   STROBE_NOT_USED,
                                   KEEP_NOT_USED) tb();
   
   // Local Variables
   reg [ID_BUS_WIDTH-1:0]       mtestID;  
   reg [DEST_BUS_WIDTH-1:0]     mtestDEST;
   reg [DATA_BUS_WIDTH-1:0]     mtestDATA [3:0];
   reg [(DATA_BUS_WIDTH/8)-1:0] mtestSTRB;
   reg [(DATA_BUS_WIDTH/8)-1:0] mtestKEEP;
   reg                          mtestLAST;
   reg [USER_BUS_WIDTH-1:0]     mtestUSER;
   integer                      mtestDATASIZE;
   reg [(DATA_BUS_WIDTH*(MAX_PACKET_SIZE))-1:0] v_mtestDATA;
   reg [(USER_BUS_WIDTH*(MAX_PACKET_SIZE))-1:0] v_mtestUSER;
   
   reg [ID_BUS_WIDTH-1:0]       stestID;  
   reg [DEST_BUS_WIDTH-1:0]     stestDEST;
   reg [DATA_BUS_WIDTH-1:0]     stestDATA [3:0];
   reg [(DATA_BUS_WIDTH/8)-1:0] stestSTRB;
   reg [(DATA_BUS_WIDTH/8)-1:0] stestKEEP;
   reg                          stestLAST;
   reg [USER_BUS_WIDTH-1:0]     stestUSER;
   integer                      stestDATASIZE;
   reg [(DATA_BUS_WIDTH*(MAX_PACKET_SIZE))-1:0] v_stestDATA [2:0];
   reg [(USER_BUS_WIDTH*(MAX_PACKET_SIZE))-1:0] v_stestUSER [2:0];

   reg [(DATA_BUS_WIDTH/8)-1:0] all_valid_strobe;
   reg [(DATA_BUS_WIDTH/8)-1:0] all_valid_keep;

   integer                     i; // Simple loop integer. 
   integer                     j; // Simple loop integer. 
      
   // Test Status Bits
   reg                         slave_finished_example1 = 1'b0;
   reg                         slave_finished_example2 = 1'b0;
   reg                         slave_finished_example3 = 1'b0;
   reg                         slave_finished_example4 = 1'b0;
   reg                         slave_finished_example5 = 1'b0;
   reg                         slave_finished_example6 = 1'b0;
   reg                         slave_finished = 1'b0;

   //------------------------------------------------------------------------
   // Create the test vectors
   //------------------------------------------------------------------------
   initial begin
      // When performing debug enable all levels of INFO messages.
      tb.master_0.set_channel_level_info(1);
      tb.slave_0.set_channel_level_info(1);
      for (i=0; i < (DATA_BUS_WIDTH/8); i=i+1) begin
         mtestDATA[0][i*8 +: 8] = 8'h00;
         mtestDATA[1][i*8 +: 8] = 8'hAA;
         mtestDATA[2][i*8 +: 8] = 8'h55;
         mtestDATA[3][i*8 +: 8] = 8'hFF;
      end
      
      for (j=0; j < (DATA_BUS_WIDTH/8); j=j+1) begin
         all_valid_strobe[j] = 1'b1;
         all_valid_keep[j] = 1'b1;
      end
      
      for (j=0; j < USER_BUS_WIDTH; j=j+1) begin
         mtestUSER = 1'b1;
      end

      for (j=0; j < ((DATA_BUS_WIDTH*(MAX_PACKET_SIZE))/8); j=j+1) begin
         v_mtestDATA[j*8 +: 8] = j;
      end

      for (j=0; j < ((USER_BUS_WIDTH*(MAX_PACKET_SIZE))/8); j=j+1) begin
         v_mtestUSER[j*8 +: 8] = j;
      end
      
   end
   
   //------------------------------------------------------------------------
   // Drive the MASTER BFM
   //------------------------------------------------------------------------
   initial begin
      // Wait for end of reset
      wait(tb.tb_ARESETn === 0) @(posedge tb.tb_ACLK);
      wait(tb.tb_ARESETn === 1) @(posedge tb.tb_ACLK);
            
      //---------------------------------------------------------------------
      // EXAMPLE TEST 1:
      // Simple master to slave transfer example
      // DESCRIPTION:
      // The following master sends a simple AXI 4 Streaming transfer.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 1:");
      $display("Simple transfer example");
      $display("---------------------------------------------------------");

      mtestID = 4;
      mtestDEST = 2;
      mtestSTRB = all_valid_strobe;
      mtestKEEP = all_valid_keep;
      mtestLAST = 1;
      
      tb.master_0.SEND_TRANSFER(mtestID,
                                mtestDEST,
                                mtestDATA[0],
                                mtestSTRB,
                                mtestKEEP,
                                mtestLAST,
                                mtestUSER);

      wait(slave_finished_example1 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 1: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 2:
      // Looped transfers example.
      // DESCRIPTION:
      // The following master code sends 3 transfers in a loop.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 2:");
      $display("Looped transfers example.");
      $display("---------------------------------------------------------");


      for (i = 0; i < 4; i=i+1) begin
         
         mtestID = i+1;
         mtestDEST = i+4;
         mtestSTRB = all_valid_strobe;
         mtestKEEP = all_valid_keep;
         mtestLAST = 0;
         if (i == 3) mtestLAST = 1;

         tb.master_0.SEND_TRANSFER(mtestID,
                                   mtestDEST,
                                   mtestDATA[i],
                                   mtestSTRB,
                                   mtestKEEP,
                                   mtestLAST,
                                   mtestUSER);
         
         $display("EXAMPLE TEST 2 : Loop = %0d",i);

      end

      wait(slave_finished_example2 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 2: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 3:
      // Simple master to slave packet example
      // DESCRIPTION:
      // The following master sends a simple AXI 4 Streaming packet.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 3:");
      $display("Simple packet example");
      $display("---------------------------------------------------------");

      mtestID = 7;
      mtestDEST = 8;
      mtestDATASIZE = MAX_PACKET_SIZE*(DATA_BUS_WIDTH/8);

      tb.master_0.SEND_PACKET(mtestID,
                              mtestDEST,
                              v_mtestDATA,
                              mtestDATASIZE,
                              v_mtestUSER);

      wait(slave_finished_example3 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 3: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 4:
      // Looped master to slave packets example.
      // DESCRIPTION:
      // The following master code sends 3 packets in a loop.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 4:");
      $display("Looped master to slave packets example.");
      $display("---------------------------------------------------------");


      for (i = 0; i < 4; i=i+1) begin
         
         mtestID = i+1;
         mtestDEST = i+4;

         tb.master_0.SEND_PACKET(mtestID,
                                 mtestDEST,
                                 v_mtestDATA,
                                 mtestDATASIZE,
                                 v_mtestUSER);
         
         $display("EXAMPLE TEST 4 : Loop = %0d",i);

      end

      wait(slave_finished_example4 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 4: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 5:
      // Ragged master to slave packet example
      // DESCRIPTION:
      // The following master sends an AXI 4 Streaming packet with a
      // payload shorter than the max packet size. This is controlled by
      // making the mtestDATASIZE less than the data vector.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 5:");
      $display("Ragged master to slave packet example");
      $display("---------------------------------------------------------");

      mtestID = 7;
      mtestDEST = 8;
      mtestDATASIZE = (MAX_PACKET_SIZE*(DATA_BUS_WIDTH/8))-2;

      tb.master_0.SEND_PACKET(mtestID,
                              mtestDEST,
                              v_mtestDATA,
                              mtestDATASIZE,
                              v_mtestUSER);

      wait(slave_finished_example5 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 5: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 6:
      // Packet Data Interleaving example
      // DESCRIPTION:
      // The following master code sends 3 packets interleaved
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 6:");
      $display("Looped master to slave packets example.");
      $display("---------------------------------------------------------");

      mtestDATASIZE = (MAX_PACKET_SIZE*(DATA_BUS_WIDTH/8));

      // The following code does a write data interleave of depth 3
      tb.master_0.set_packet_transfer_gap(2);

      fork
         begin
            mtestID = 1;
            mtestDEST = 1;
            tb.master_0.SEND_PACKET(mtestID,
                                    mtestDEST,
                                    v_mtestDATA,
                                    mtestDATASIZE,
                                    v_mtestUSER);
         end
         begin
            mtestID = 2;
            mtestDEST = 2;
            tb.master_0.SEND_PACKET(mtestID,
                                    mtestDEST,
                                    v_mtestDATA,
                                    mtestDATASIZE,
                                    v_mtestUSER);
         end
         begin
            mtestID = 3;
            mtestDEST = 3;
            tb.master_0.SEND_PACKET(mtestID,
                                    mtestDEST,
                                    v_mtestDATA,
                                    mtestDATASIZE,
                                    v_mtestUSER);
         end
      join
      

      wait(slave_finished_example6 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 6: FINISHED!");
      $display("---------------------------------------------------------");

      repeat(10) @(posedge tb.tb_ACLK);
      
      wait(slave_finished == 1'b1);
      
      tb.REPORT_MASTER_STATUS(0);
      tb.REPORT_SLAVE_STATUS(0);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST : PASSED");
      $display("---------------------------------------------------------");
      $display("---------------------------------------------------------");
      $display("COMPLETE EXAMPLE TEST FINISHED!");
      $display("---------------------------------------------------------");
      $finish;

      // Catch the sync error if we reach this part of the code.
      $display("EXAMPLE TEST : *ERROR : Simulation has gone out of sync.");
      $finish;
      
   end
   
   //------------------------------------------------------------------------
   // Drive the SLAVE BFM
   //------------------------------------------------------------------------
   initial begin
      slave_finished = 1'b0;
      // Wait for end of reset
      wait(tb.tb_ARESETn === 0) @(posedge tb.tb_ACLK);
      wait(tb.tb_ARESETn === 1) @(posedge tb.tb_ACLK);

      //---------------------------------------------------------------------
      // EXAMPLE TEST 1:
      // Simple master to slave transfer example
      // DESCRIPTION:
      // The following slave code receives a simple AXI 4 Streaming transfer.
      //---------------------------------------------------------------------
      
      tb.slave_0.RECEIVE_TRANSFER(0,
                                  `IDVALID_FALSE,
                                  0,
                                  `DESTVALID_FALSE,
                                  stestID,
                                  stestDEST,                                  
                                  stestDATA[0],
                                  stestSTRB,
                                  stestKEEP,
                                  stestLAST,
                                  stestUSER);
      
      tb.COMPARE_TID(4,stestID);
      tb.COMPARE_TDEST(2,stestDEST);
      tb.COMPARE_TDATA(mtestDATA[0],stestDATA[0]);
      tb.COMPARE_TSTRB(all_valid_strobe,stestSTRB);
      tb.COMPARE_TKEEP(all_valid_keep,stestKEEP);
      tb.COMPARE_TLAST(1,stestLAST);
      tb.COMPARE_TUSER(mtestUSER,stestUSER);

      // Slave side of example test 1 complete.
      slave_finished_example1 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 2:
      // Looped sequential write and read transfers example.
      // DESCRIPTION:
      // The following slave code does 3 write and read burst responses in a
      // for loop.
      //---------------------------------------------------------------------
     
      for (j = 0; j < 4; j=j+1) begin
         tb.slave_0.RECEIVE_TRANSFER(0,
                                     `IDVALID_FALSE,
                                     0,
                                     `DESTVALID_FALSE,
                                     stestID,
                                     stestDEST,
                                     stestDATA[j],
                                     stestSTRB,
                                     stestKEEP,
                                     stestLAST,
                                     stestUSER);
         
         tb.COMPARE_TID(j+1,stestID);
         tb.COMPARE_TDEST(j+4,stestDEST);
         tb.COMPARE_TDATA(mtestDATA[j],stestDATA[j]);
         tb.COMPARE_TSTRB(all_valid_strobe,stestSTRB);
         tb.COMPARE_TKEEP(all_valid_keep,stestKEEP);
         if (j == 3) begin
            tb.COMPARE_TLAST(1'b1,stestLAST);
         end
         else begin
            tb.COMPARE_TLAST(1'b0,stestLAST);
         end
         tb.COMPARE_TUSER(mtestUSER,stestUSER);
      end

      // Slave side of example test 2 complete.
      slave_finished_example2 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 3:
      // Simple master to slave packet example
      // DESCRIPTION:
      // The following slave code receives a simple AXI 4 Streaming packet.
      //---------------------------------------------------------------------
      
      tb.slave_0.RECEIVE_PACKET(0,
                                `IDVALID_FALSE,
                                0,
                                `DESTVALID_FALSE,
                                stestID,
                                stestDEST,
                                v_stestDATA[0],
                                stestDATASIZE,
                                v_stestUSER[0]);
      
      tb.COMPARE_TID(7,stestID);
      tb.COMPARE_TDEST(8,stestDEST);
      tb.COMPARE_DATASIZE(mtestDATASIZE,stestDATASIZE);
      tb.COMPARE_TDATA_VECTOR(v_mtestDATA,v_stestDATA[0]);
      tb.COMPARE_TUSER_VECTOR(v_mtestUSER,v_stestUSER[0]);

      // Slave side of example test 3 complete.
      slave_finished_example3 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 4:
      // Looped packets example.
      // DESCRIPTION:
      // The following slave code receives 3 packets in a row.
      //---------------------------------------------------------------------
     
      for (j = 0; j < 4; j=j+1) begin
         stestID = j+1;
         stestDEST = j+4;

         tb.slave_0.RECEIVE_PACKET(stestID,
                                   `IDVALID_TRUE,
                                   stestDEST,
                                   `DESTVALID_TRUE,
                                   stestID,
                                   stestDEST,
                                   v_stestDATA[0],
                                   stestDATASIZE,
                                   v_stestUSER[0]);
         
         tb.COMPARE_TID(j+1,stestID);
         tb.COMPARE_TDEST(j+4,stestDEST);
         tb.COMPARE_DATASIZE(mtestDATASIZE,stestDATASIZE);
         tb.COMPARE_TDATA_VECTOR(v_mtestDATA,v_stestDATA[0]);
         tb.COMPARE_TUSER_VECTOR(v_mtestUSER,v_stestUSER[0]);
      end

      // Slave side of example test 4 complete.
      slave_finished_example4 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 5:
      // Ragged master to slave packet example
      // DESCRIPTION:
      // The following slave code receives a ragged AXI 4 Streaming packet.
      //---------------------------------------------------------------------
      
      tb.slave_0.RECEIVE_PACKET(0,
                                `IDVALID_FALSE,
                                0,
                                `DESTVALID_FALSE,
                                stestID,
                                stestDEST,
                                v_stestDATA[0],
                                stestDATASIZE,
                                v_stestUSER[0]);
      
      tb.COMPARE_TID(7,stestID);
      tb.COMPARE_TDEST(8,stestDEST);
      tb.COMPARE_DATASIZE(mtestDATASIZE,stestDATASIZE);
      tb.COMPARE_TDATA_VECTOR(v_mtestDATA,v_stestDATA[0]);
      tb.COMPARE_TUSER_VECTOR(v_mtestUSER,v_stestUSER[0]);

      // Slave side of example test 5 complete.
      slave_finished_example5 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 6:
      // Packet Data Interleaving
      // DESCRIPTION:
      // The following slave code receives a set of 3 interleaved AXI 4 
      // Streaming packets.
      //---------------------------------------------------------------------

      fork
         begin
            tb.slave_0.RECEIVE_PACKET(1,
                                      `IDVALID_TRUE,
                                      1,
                                      `DESTVALID_TRUE,
                                      stestID,
                                      stestDEST,
                                      v_stestDATA[0],
                                      stestDATASIZE,
                                      v_stestUSER[0]);
            
            tb.COMPARE_TID(1,stestID);
            tb.COMPARE_TDEST(1,stestDEST);
            tb.COMPARE_DATASIZE(mtestDATASIZE,stestDATASIZE);
            tb.COMPARE_TDATA_VECTOR(v_mtestDATA,v_stestDATA[0]);
            tb.COMPARE_TUSER_VECTOR(v_mtestUSER,v_stestUSER[0]);
         end
         begin
            tb.slave_0.RECEIVE_PACKET(2,
                                      `IDVALID_TRUE,
                                      2,
                                      `DESTVALID_TRUE,
                                      stestID,
                                      stestDEST,
                                      v_stestDATA[1],
                                      stestDATASIZE,
                                      v_stestUSER[1]);
            
            tb.COMPARE_TID(2,stestID);
            tb.COMPARE_TDEST(2,stestDEST);
            tb.COMPARE_DATASIZE(mtestDATASIZE,stestDATASIZE);
            tb.COMPARE_TDATA_VECTOR(v_mtestDATA,v_stestDATA[1]);
            tb.COMPARE_TUSER_VECTOR(v_mtestUSER,v_stestUSER[1]);
         end
         begin
            tb.slave_0.RECEIVE_PACKET(3,
                                      `IDVALID_TRUE,
                                      3,
                                      `DESTVALID_TRUE,
                                      stestID,
                                      stestDEST,
                                      v_stestDATA[2],
                                      stestDATASIZE,
                                      v_stestUSER[2]);
            
            tb.COMPARE_TID(3,stestID);
            tb.COMPARE_TDEST(3,stestDEST);
            tb.COMPARE_DATASIZE(mtestDATASIZE,stestDATASIZE);
            tb.COMPARE_TDATA_VECTOR(v_mtestDATA,v_stestDATA[2]);
            tb.COMPARE_TUSER_VECTOR(v_mtestUSER,v_stestUSER[2]);
         end         
      join
      
      // Slave side of example test 6 complete.
      slave_finished_example6 = 1'b1;

      // Slave side of example test complete.
      slave_finished = 1'b1;
   end
   
endmodule
//----------------------------------------------------------------------------
// END OF FILE
//----------------------------------------------------------------------------
