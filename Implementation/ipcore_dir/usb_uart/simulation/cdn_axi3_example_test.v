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
// This file contains an example test for the AXI 3 Master and Slave BFMs.
// It demonstrates how to stimulate the following conditions from both the
// master and slave perspectives:
// 1  Simple sequential write and read burst transfers example
// 2  Looped sequential write and read transfers example
// 3  Parallel write and read burst transfers example
// 4  Narrow write and read transfer example
// 5  Unaligned write and read transfer example
// 6  Narrow and unaligned write and read transfer example
// 7  Out of order write and read burst example
// 8  Write Bursts performed in two different ways; Data before address, and
//    data and address concurrently
// 9  Write data interleaving example
// 10 Read data interleaving example
// 11 Outstanding transactions example
// 12 Slave read and write bursts error repsonse example
// 13 Write and Read bursts with different length gaps between data transfers
//    example
// 14 Write and Read bursts with different length gaps between channel 
//    transfers example
// 15 Write burst that is longer than the valid data it is sending example.
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
   parameter ADDRESS_BUS_WIDTH = 32;
   parameter ID_BUS_WIDTH = 4;
   parameter SLAVE_ADDRESS = 0;
   parameter SLAVE_MEM_SIZE = 4096;
   parameter MAX_OUTSTANDING_TRANSACTIONS = 8;
   parameter MEMORY_MODEL_MODE = 0;
   parameter EXCLUSIVE_ACCESS_SUPPORTED = 1;

   // Create an instance of the example tb
   cdn_axi3_example_tb #(MASTER_NAME,
                         SLAVE_NAME,
                         DATA_BUS_WIDTH,
                         ADDRESS_BUS_WIDTH,
                         ID_BUS_WIDTH,
                         SLAVE_ADDRESS,
                         SLAVE_MEM_SIZE,
                         MAX_OUTSTANDING_TRANSACTIONS,
                         MEMORY_MODEL_MODE,
                         EXCLUSIVE_ACCESS_SUPPORTED) tb();

   // Local Variables
   reg [(DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] rd_data;
   reg [(DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] test_data [2:0];
   reg [(DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] wr_data [4:0];
   reg [(DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] rd_data_a [2:0];
   reg [`RESP_BUS_WIDTH-1:0]                        response;
   reg [(`RESP_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] vresponse;
   reg [(`RESP_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] error_vresponse;
   reg [ADDRESS_BUS_WIDTH-1:0]                       mtestADDR;
   
   integer                        mtestID; // Master side testID
   integer                        stestID; // Slave side testID
   integer                        mtestBurstLength;

   integer                        mtestvector; // Master side testvector
   integer                        stestvector; // Slave side testvector
   integer                        i; // Simple loop integer. 
   integer                        j; // Simple loop integer. 

   integer                        mtestdatasize;
   integer                        stestdatasize;
   
   integer                        stestaddress1;
   integer                        stestlength1;
   integer                        stestsize1;
   integer                        stestburst_type1;
   integer                        stestlock_type1;
   integer                        stestcache_type1;
   integer                        stestprotection_type1;
   integer                        stestresponse1;
   
   integer                        stestaddress2;
   integer                        stestlength2;
   integer                        stestsize2;
   integer                        stestburst_type2;
   integer                        stestlock_type2;
   integer                        stestcache_type2;
   integer                        stestprotection_type2;
   integer                        stestresponse2;
   
   // Test Status Bits
   reg                            slave_finished_example1 = 1'b0;
   reg                            slave_finished_example2 = 1'b0;
   reg                            slave_finished_example3 = 1'b0;
   reg                            slave_finished_example4 = 1'b0;
   reg                            slave_finished_example5 = 1'b0;
   reg                            slave_finished_example6 = 1'b0;
   reg                            slave_finished_example7 = 1'b0;
   reg                            slave_finished_example8 = 1'b0;
   reg                            slave_finished_example9 = 1'b0;
   reg                            slave_finished_example10 = 1'b0;
   reg                            slave_finished_example11 = 1'b0;
   reg                            example_test11_passed = 1'b0;
   reg                            slave_finished_example12 = 1'b0;
   reg                            slave_finished_example13 = 1'b0;
   reg                            slave_finished_example14 = 1'b0;
   reg                            slave_finished_example15 = 1'b0;
   reg                            slave_finished = 1'b0;

   //------------------------------------------------------------------------
   // Create the test vectors
   //------------------------------------------------------------------------
   initial begin
      // When performing debug enable all levels of INFO messages.
      tb.master_0.set_channel_level_info(1);
      tb.slave_0.set_channel_level_info(1);

      // Create test data vectors
      test_data[0] = 512'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
      test_data[1] = 512'h00000000111111112222222233333333444444445555555566666666777777778888888899999999AAAAAAAABBBBBBBBCCCCCCCCDDDDDDDDEEEEEEEEFFFFFFFF;
      test_data[2] = 512'h00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
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
      // Simple sequential write and read burst transfers example
      // DESCRIPTION:
      // The following master code does a simple write and read burst for
      // each burst transfer type.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 1:");
      $display("Simple sequential write and read burst transfers example");
      $display("---------------------------------------------------------");
      
      mtestID = 1;
      mtestvector = 0;
      mtestBurstLength = 0;
      mtestADDR = SLAVE_ADDRESS;
      mtestdatasize = `MAX_DATA_SIZE;
      
      tb.master_0.WRITE_BURST(mtestID,              
                              mtestADDR,
                              mtestBurstLength,
                              `BURST_SIZE_4_BYTES,
                              `BURST_TYPE_FIXED,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      $display("EXAMPLE TEST 1 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);

      tb.CHECK_RESPONSE_OKAY(response);
 
      mtestID = mtestID+1;

      tb.master_0.READ_BURST(mtestID,
                             mtestADDR,
                             mtestBurstLength,
                             `BURST_SIZE_4_BYTES,
                             `BURST_TYPE_FIXED,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,
                             vresponse);

      $display("EXAMPLE TEST 1 : DATA = 0x%h, vresponse = 0x%h",rd_data,vresponse);

      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      $display("EXAMPLE TEST 1 : Sequential write and read FIXED burst transfers complete from the master side.");
      
      mtestID = mtestID+1;
      mtestvector = 1;
      mtestADDR = mtestADDR+16;
      
      tb.master_0.WRITE_BURST(mtestID,
                              mtestADDR,
                              `MAX_BURST_LENGTH,
                              `BURST_SIZE_4_BYTES,
                              `BURST_TYPE_INCR,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      
      $display("EXAMPLE TEST 1 : Data = 0x%h, Response = 0x%h", test_data[mtestvector],response);
      tb.CHECK_RESPONSE_OKAY(response);

      mtestID = mtestID+1;

      tb.master_0.READ_BURST(mtestID,
                             mtestADDR,
                             `MAX_BURST_LENGTH,
                             `BURST_SIZE_4_BYTES,
                             `BURST_TYPE_INCR,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,vresponse);

      $display("EXAMPLE TEST 1 : Data = 0x%h, vresponse = 0x%h", rd_data,vresponse);

      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      $display("EXAMPLE TEST 1 : Sequential write and read INCR burst transfers complete from the master side.");
      
      mtestID = mtestID+1;
      mtestvector = 2;
      mtestADDR = mtestADDR+16;

      tb.master_0.WRITE_BURST(mtestID,
                              mtestADDR,
                              `MAX_BURST_LENGTH,
                              `BURST_SIZE_4_BYTES,
                              `BURST_TYPE_WRAP,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);

      $display("EXAMPLE TEST 1 : Data = 0x%h, Response = 0x%h", test_data[mtestvector],response);
      tb.CHECK_RESPONSE_OKAY(response);

      mtestID = mtestID+1;

      tb.master_0.READ_BURST(mtestID,
                             mtestADDR,
                             `MAX_BURST_LENGTH,
                             `BURST_SIZE_4_BYTES,
                             `BURST_TYPE_WRAP,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,vresponse);
      
      $display("TESTBENCH DATA = 0x%h, vresponse = 0x%h", rd_data,vresponse);

      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      $display("EXAMPLE TEST 1 : Sequential write and read WRAP burst transfers complete from the master side.");

      wait(slave_finished_example1 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 1: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 2:
      // Looped sequential write and read transfers example.
      // DESCRIPTION:
      // The following master code does 3 sequential writes and reads in a
      // for loop.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 2:");
      $display("Looped sequential write and read transfers example.");
      $display("---------------------------------------------------------");

      mtestvector = 0;
      mtestBurstLength = 0;
      mtestADDR = 16;
      mtestID = 1;

      for (i = 0; i < 3; i=i+1) begin
         tb.master_0.WRITE_BURST(mtestID+i,
                                 mtestADDR,
                                 mtestBurstLength,
                                 `BURST_SIZE_4_BYTES,
                                 `BURST_TYPE_FIXED,
                                 `LOCK_TYPE_NORMAL,
                                 4'b0000,
                                 3'b000,
                                 test_data[i],
                                 mtestdatasize,
                                 response);
         $display("EXAMPLE TEST 2 : DATA = 0x%h, response = 0x%h",test_data[i],response);

         tb.CHECK_RESPONSE_OKAY(response);
         
        
         tb.master_0.READ_BURST((mtestID+1)+i,
                                mtestADDR,
                                mtestBurstLength,
                                `BURST_SIZE_4_BYTES,
                                `BURST_TYPE_FIXED,
                                `LOCK_TYPE_NORMAL,
                                4'b0000,
                                3'b000,
                                rd_data,vresponse);
         
         $display("EXAMPLE TEST 2 : DATA = 0x%h, vresponse = 0x%h",rd_data,vresponse);

         tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
         tb.COMPARE_DATA(test_data[i],rd_data);
      end

      wait(slave_finished_example2 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 2: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 3:
      // Parallel write and read burst transfers example.
      // DESCRIPTION:
      // The following master code starts 3 sequential writes and 3 
      // sequential reads in parallel.
      // Please note that care must be taken not to violate AXI order 
      // protocol when using parallel option.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 3:");
      $display("Parallel write and read burst transfers example.");
      $display("---------------------------------------------------------");

      // All bursts are length 2 transfers i.e. mtestsBurstLength = 1.
      mtestBurstLength = 1;
      
      fork
         begin
            tb.master_0.WRITE_BURST(15,
                                    0,
                                    mtestBurstLength,
                                    `BURST_SIZE_4_BYTES,
                                    `BURST_TYPE_FIXED,
                                    `LOCK_TYPE_NORMAL,
                                    4'b0000,
                                    3'b000,
                                    test_data[0],
                                    mtestdatasize,
                                    response);
            tb.CHECK_RESPONSE_OKAY(response);
            tb.master_0.WRITE_BURST(14,
                                    16,
                                    mtestBurstLength,
                                    `BURST_SIZE_4_BYTES,
                                    `BURST_TYPE_INCR,
                                    `LOCK_TYPE_NORMAL,
                                    4'b0000,
                                    3'b000,
                                    test_data[1],
                                    mtestdatasize,
                                    response);
            tb.CHECK_RESPONSE_OKAY(response);
            tb.master_0.WRITE_BURST(13,
                                    32,
                                    mtestBurstLength,
                                    `BURST_SIZE_4_BYTES,
                                    `BURST_TYPE_WRAP,
                                    `LOCK_TYPE_NORMAL,
                                    4'b0000,
                                    3'b000,
                                    test_data[2],
                                    mtestdatasize,
                                    response);
            tb.CHECK_RESPONSE_OKAY(response);
         end 
         begin
            tb.master_0.READ_BURST(12,
                                   124,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_FIXED,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[0],vresponse);
            tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
            tb.COMPARE_DATA(test_data[0],rd_data_a[0]);
            tb.master_0.READ_BURST(11,
                                   164,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_INCR,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[1],vresponse);
            tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
            tb.COMPARE_DATA(test_data[1],rd_data_a[1]);
            tb.master_0.READ_BURST(10,
                                   160,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_WRAP,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[2],vresponse);
            tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
            tb.COMPARE_DATA(test_data[2],rd_data_a[2]);
         end
      join
      
      wait(slave_finished_example3 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 3: FINISHED!");
      $display("---------------------------------------------------------");
      
      //---------------------------------------------------------------------
      // EXAMPLE TEST 4:
      // Narrow write and read transfers example.
      // DESCRIPTION:
      // The following master code does a narrow write and read transfer for
      // each transfer type.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 4:");
      $display("Narrow write and read transfers example.");
      $display("---------------------------------------------------------");

      mtestID = 7;
      mtestADDR = 0;
      mtestvector = 0;
      mtestBurstLength = 1;
      
      tb.master_0.WRITE_BURST(mtestID,
                              mtestADDR,
                              mtestBurstLength,
                              `BURST_SIZE_2_BYTES,
                              `BURST_TYPE_FIXED,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      tb.CHECK_RESPONSE_OKAY(response);
            

      tb.master_0.READ_BURST(mtestID+1,
                             mtestADDR,
                             mtestBurstLength,
                             `BURST_SIZE_2_BYTES,
                             `BURST_TYPE_FIXED,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,
                             vresponse);
      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      // Burst type incr
      mtestID = 9;
      mtestADDR = 4;
      mtestvector = 1;

      tb.master_0.WRITE_BURST(mtestID,
                              mtestADDR,
                              mtestBurstLength,
                              `BURST_SIZE_2_BYTES,
                              `BURST_TYPE_INCR,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);

      tb.CHECK_RESPONSE_OKAY(response);

      tb.master_0.READ_BURST(mtestID+1,
                             mtestADDR,
                             mtestBurstLength,
                             `BURST_SIZE_2_BYTES,
                             `BURST_TYPE_INCR,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,
                             vresponse);
      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      // Burst type WRAP
      mtestID = 11;
      mtestADDR = 8;
      mtestvector = 2;

      tb.master_0.WRITE_BURST(mtestID,
                              mtestADDR,
                              mtestBurstLength,
                              `BURST_SIZE_1_BYTE,
                              `BURST_TYPE_WRAP,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);

      tb.CHECK_RESPONSE_OKAY(response);


      tb.master_0.READ_BURST(mtestID+1,
                             mtestADDR,
                             mtestBurstLength,
                             `BURST_SIZE_1_BYTE,
                             `BURST_TYPE_INCR,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,
                             vresponse);
      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      wait(slave_finished_example4 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 4: FINISHED!");
      $display("---------------------------------------------------------");
      
      //---------------------------------------------------------------------
      // EXAMPLE TEST 5:
      // Unaligned write and read transfers example.
      // DESCRIPTION:
      // The following master code does:
      // 1 of each write and read unaligned FIXED transfers
      // 1 of each write and read unaligned INCR transfers
      // NOTE: The slave does not model memory so the data might look wrong
      // but the slave BFM has checked that the strobes are right.
      // Also, a wrapping burst must have an address which is aligned to the
      // burst size thus it is not possible to have an unaligned wrapping 
      // burst unless it is also a narrow transfer.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 5:");
      $display("Unaligned write and read transfers example.");
      $display("---------------------------------------------------------");

      mtestID = 2;
      mtestADDR = 1;
      mtestvector = 0;
      mtestBurstLength = 1;
      
      tb.master_0.WRITE_BURST(mtestID,
                              mtestADDR,
                              mtestBurstLength,
                              `BURST_SIZE_4_BYTES,
                              `BURST_TYPE_FIXED,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      tb.CHECK_RESPONSE_OKAY(response);
            

      tb.master_0.READ_BURST(mtestID+1,
                             mtestADDR,
                             mtestBurstLength,
                             `BURST_SIZE_4_BYTES,
                             `BURST_TYPE_FIXED,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,
                             vresponse);
      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      // Burst type incr
      mtestID = 4;
      mtestADDR = 2;
      mtestvector = 1;

      tb.master_0.WRITE_BURST(mtestID,
                              mtestADDR,
                              mtestBurstLength,
                              `BURST_SIZE_4_BYTES,
                              `BURST_TYPE_INCR,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);

      tb.CHECK_RESPONSE_OKAY(response);

      tb.master_0.READ_BURST(mtestID+1,
                             mtestADDR,
                             mtestBurstLength,
                             `BURST_SIZE_4_BYTES,
                             `BURST_TYPE_INCR,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,
                             vresponse);
      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      wait(slave_finished_example5 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 5: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 6:
      // Narrow and unaligned write and read transfers example.
      // DESCRIPTION:
      // The following master code does:
      // 1 of each write and read unaligned INCR transfers
      // 1 of each write and read unaligned WRAP transfers
      // NOTE: The slave does not model memory so the data might look wrong
      // but the slave BFM has checked that the strobes are right.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 6:");
      $display("Narrow and unaligned write and read transfers example.");
      $display("---------------------------------------------------------");
      
      // Burst type incr
      mtestID = 9;
      mtestADDR = 1;
      mtestvector = 1;

      tb.master_0.WRITE_BURST(mtestID,
                              mtestADDR,
                              mtestBurstLength,
                              `BURST_SIZE_1_BYTE,
                              `BURST_TYPE_INCR,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      tb.CHECK_RESPONSE_OKAY(response);

      tb.master_0.READ_BURST(mtestID+1,
                             mtestADDR,
                             mtestBurstLength,
                             `BURST_SIZE_1_BYTE,
                             `BURST_TYPE_INCR,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,
                             vresponse);
      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      // Burst type WRAP
      mtestID = 11;
      mtestADDR = 3;
      mtestvector = 2;

      tb.master_0.WRITE_BURST(mtestID,
                              mtestADDR,
                              mtestBurstLength,
                              `BURST_SIZE_1_BYTE,
                              `BURST_TYPE_WRAP,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      tb.CHECK_RESPONSE_OKAY(response);


      tb.master_0.READ_BURST(mtestID+1,
                             mtestADDR,
                             mtestBurstLength,
                             `BURST_SIZE_1_BYTE,
                             `BURST_TYPE_INCR,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,
                             vresponse);
      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      wait(slave_finished_example6 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 6: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 7:
      // Out of order write and read burst example.
      // DESCRIPTION:
      // The following code shows the master handling out of order completion
      // and the slave responding out of order to the following conditions:
      // 1. Master read id 1->2, slave read response id 2->1
      // 2. Master write id 3->4, slave write response id 4->3
      // 3. Master sends two writes address id 1->2, then write data bursts 
      //    2->1, slave write response id 1->2
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 7:");
      $display("Out of order write and read burst example.");
      $display("---------------------------------------------------------");

      mtestADDR = 0;
      mtestBurstLength = 1;

      mtestADDR = 0;

      $display("EXAMPLE TEST 7: Start of Master Read ID 1->2, slave response out of order i.e. ID 2->1");
      fork
         begin
            tb.master_0.READ_BURST(1,
                                   mtestADDR,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_INCR,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[0],
                                   vresponse);
            tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
            tb.COMPARE_DATA(test_data[1],rd_data_a[0]);
         end
         begin
            #10 // delay the second read to ensure that the ID order is 1->2
            tb.master_0.READ_BURST(2,
                                   mtestADDR+64,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_INCR,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[1],
                                   vresponse);
            tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
            tb.COMPARE_DATA(test_data[2],rd_data_a[1]);
         end
      join
      
      $display("EXAMPLE TEST 7: End of Master Read ID 1->2, slave response out of order i.e. ID 2->1");

      $display("EXAMPLE TEST 7: Start of Master write id 3->4, slave write response id 4->3");

      fork
         begin
            tb.master_0.WRITE_BURST(3,
                                    mtestADDR,
                                    mtestBurstLength,
                                    `BURST_SIZE_4_BYTES,
                                    `BURST_TYPE_INCR,
                                    `LOCK_TYPE_NORMAL,
                                    4'b0000,
                                    3'b000,
                                    test_data[1],
                                    mtestdatasize,
                                    response);
            tb.CHECK_RESPONSE_OKAY(response);
         end
         begin
            #10 // delay the second write to ensure that the ID order is 3->4
            tb.master_0.WRITE_BURST(4,
                                    mtestADDR+32,
                                    mtestBurstLength,
                                    `BURST_SIZE_4_BYTES,
                                    `BURST_TYPE_INCR,
                                    `LOCK_TYPE_NORMAL,
                                    4'b0000,
                                    3'b000,
                                    test_data[0],
                                    mtestdatasize,
                                    response);
            tb.CHECK_RESPONSE_OKAY(response);
         end
      join
           
      $display("EXAMPLE TEST 7: End of Master write id 3->4, slave write response id 4->3");

      $display("EXAMPLE TEST 7: Start of Master sends two writes address id 1->2, then write data bursts 2->1, slave write response id 1->2");

      tb.master_0.SEND_WRITE_ADDRESS(1,
                                     mtestADDR,
                                     mtestBurstLength,
                                     `BURST_SIZE_4_BYTES,
                                     `BURST_TYPE_INCR,
                                     `LOCK_TYPE_NORMAL,
                                     4'b0000,
                                     3'b000);
      tb.master_0.SEND_WRITE_ADDRESS(2,
                                     mtestADDR+256,
                                     mtestBurstLength,
                                     `BURST_SIZE_4_BYTES,
                                     `BURST_TYPE_INCR,
                                     `LOCK_TYPE_NORMAL,
                                     4'b0000,
                                     3'b000);
      tb.master_0.SEND_WRITE_BURST(2,
                                   mtestADDR+256,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_INCR,
                                   test_data[0],
                                   mtestdatasize);
      tb.master_0.SEND_WRITE_BURST(1,
                                   mtestADDR,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_INCR,
                                   test_data[1],
                                   mtestdatasize);
      tb.master_0.RECEIVE_WRITE_RESPONSE(1,response);
      tb.CHECK_RESPONSE_OKAY(response);
      tb.master_0.RECEIVE_WRITE_RESPONSE(2,response);
      tb.CHECK_RESPONSE_OKAY(response);
           
      $display("EXAMPLE TEST 7: End of Master sends two writes address id 1->2, then write data bursts 2->1, slave write response id 1->2");

      wait(slave_finished_example7 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 7: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 8
      // Write Bursts performed in two different ways; Data before address,
      // and data and address concurrently.
      // DESCRIPTION:
      // On the master side:
      // 1. Start a write burst concurrently using WRITE_BURST_CONCURRENT
      //    i.e. write address phase and write data phase start concurrently.
      // 2. Start a write burst data first followed by write address phase
      //    using the WRITE_BURST_DATA_FIRST.
      //---------------------------------------------------------------------

      mtestID = 14;
      mtestvector = 0;
      mtestBurstLength = `MAX_BURST_LENGTH;
      mtestADDR = SLAVE_ADDRESS;

      tb.master_0.WRITE_BURST_CONCURRENT(mtestID,              
                                         mtestADDR,
                                         mtestBurstLength,
                                         `BURST_SIZE_4_BYTES,
                                         `BURST_TYPE_INCR,
                                         `LOCK_TYPE_NORMAL,
                                         4'b0000,
                                         3'b000,
                                         test_data[mtestvector],
                                         mtestdatasize,
                                         response);
      $display("EXAMPLE TEST 8 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);
      tb.CHECK_RESPONSE_OKAY(response);

      mtestID = 15;
      mtestvector = 1;
      mtestADDR = SLAVE_ADDRESS+256;
      
      tb.master_0.WRITE_BURST_DATA_FIRST(mtestID,              
                                         mtestADDR,
                                         mtestBurstLength,
                                         `BURST_SIZE_4_BYTES,
                                         `BURST_TYPE_INCR,
                                         `LOCK_TYPE_NORMAL,
                                         4'b0000,
                                         3'b000,
                                         test_data[mtestvector],
                                         mtestdatasize,
                                         response);
      $display("EXAMPLE TEST 8 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);
      tb.CHECK_RESPONSE_OKAY(response);

      wait(slave_finished_example8 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 8: FINISHED!");
      $display("---------------------------------------------------------");
      
      //---------------------------------------------------------------------
      // EXAMPLE TEST 9:
      // Write data interleaving example.
      // DESCRIPTION:
      // The following master code does the following:
      // 1. Two write bursts interleaved (i.e. interleave depth 2)
      // 2. Three write bursts interleaved (i.e. interleave depth 3)
      // NOTE: To enable the master BFM to generate data interleaved writes
      // the writes must be done in parallel (i.e. in a fork and join) AND
      // The master control variable "WRITE_BURST_DATA_TRANSFER_GAP" must be
      // greater than 0. This allows other parallel write data bursts time 
      // to access the write data channel.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 9:");
      $display("Write data interleaving example.");
      $display("---------------------------------------------------------");
      
      
      // All bursts are length 2 transfers i.e. mtestsBurstLength = 1.
      mtestBurstLength = 7;

      // ENABLE write burst data transfer gap to give the other write 
      // burst task a chance to interleave.
      $display("EXAMPLE TEST 9 - Start of write data interleave depth 2.");
      // The following code does a write data interleave of depth 2
      tb.master_0.set_write_burst_data_transfer_gap(1);
      fork
         tb.master_0.WRITE_BURST(10,
                                 0,
                                 mtestBurstLength,
                                 `BURST_SIZE_4_BYTES,
                                 `BURST_TYPE_FIXED,
                                 `LOCK_TYPE_NORMAL,
                                 4'b0000,
                                 3'b000,
                                 test_data[0],
                                 mtestdatasize,
                                 response);
         tb.CHECK_RESPONSE_OKAY(response);
         tb.master_0.WRITE_BURST(11,
                                 64,
                                 mtestBurstLength,
                                 `BURST_SIZE_4_BYTES,
                                 `BURST_TYPE_INCR,
                                 `LOCK_TYPE_NORMAL,
                                 4'b0000,
                                 3'b000,
                                 test_data[1],
                                 mtestdatasize,
                                 response);
         tb.CHECK_RESPONSE_OKAY(response);
      join
      $display("EXAMPLE TEST 9 - End of write data interleave depth 2.");

      $display("EXAMPLE TEST 9 - Start of write data interleave depth 3.");
      // The following code does a write data interleave of depth 3
      fork
         tb.master_0.WRITE_BURST(15,
                                 0,
                                 mtestBurstLength,
                                 `BURST_SIZE_4_BYTES,
                                 `BURST_TYPE_FIXED,
                                 `LOCK_TYPE_NORMAL,
                                 4'b0000,
                                 3'b000,
                                 test_data[0],
                                 mtestdatasize,
                                 response);
         tb.CHECK_RESPONSE_OKAY(response);
         tb.master_0.WRITE_BURST(1,
                                 64,
                                 mtestBurstLength,
                                 `BURST_SIZE_4_BYTES,
                                 `BURST_TYPE_INCR,
                                 `LOCK_TYPE_NORMAL,
                                 4'b0000,
                                 3'b000,
                                 test_data[1],
                                 mtestdatasize,
                                 response);
         tb.CHECK_RESPONSE_OKAY(response);
         tb.master_0.WRITE_BURST(2,
                                 128,
                                 mtestBurstLength,
                                 `BURST_SIZE_4_BYTES,
                                 `BURST_TYPE_INCR,
                                 `LOCK_TYPE_NORMAL,
                                 4'b0000,
                                 3'b000,
                                 test_data[1],
                                 mtestdatasize,
                                 response);
         tb.CHECK_RESPONSE_OKAY(response);
      join

      $display("EXAMPLE TEST 9 - End of write data interleave depth 3.");

      tb.master_0.set_write_burst_data_transfer_gap(0);
      
      wait(slave_finished_example9 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 9: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 10:
      // Read data interleaving example.
      // DESCRIPTION:
      // The following master code does the following:
      // 1. Performs two read bursts in parallel. The slave should send the
      // read burst data interleaved by a depth of 2.
      // 2. Performs three read bursts in parallel. The slave should send the
      // read burst data interleaved by a depth of 3.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 10:");
      $display("Read data interleaving example.");
      $display("---------------------------------------------------------");

      $display("EXAMPLE TEST 10 - Start of read data interleave depth 2.");
      fork
         begin
            tb.master_0.READ_BURST(8,
                                   0,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_FIXED,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[1],
                                   vresponse);
            tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
            tb.COMPARE_DATA(test_data[0],rd_data_a[1]);
         end
         begin
            tb.master_0.READ_BURST(9,
                                   64,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_INCR,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[0],
                                   vresponse);
            tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
            tb.COMPARE_DATA(test_data[1],rd_data_a[0]);
         end
      join
      $display("EXAMPLE TEST 10 - End of read data interleave depth 2.");

      $display("EXAMPLE TEST 10 - Start of read data interleave depth 3.");
      fork
         begin
            tb.master_0.READ_BURST(5,
                                   0,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_FIXED,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[0],
                                   vresponse);
            tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
            tb.COMPARE_DATA(test_data[0],rd_data_a[0]);
         end
         begin
            tb.master_0.READ_BURST(6,
                                   64,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_FIXED,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[1],
                                   vresponse);
            tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
            tb.COMPARE_DATA(test_data[1],rd_data_a[1]);
         end
         begin
            tb.master_0.READ_BURST(7,
                                   128,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_INCR,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[2],
                                   vresponse);
            tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
            tb.COMPARE_DATA(test_data[2],rd_data_a[2]);
         end
      join
      $display("EXAMPLE TEST 10 - End of read data interleave depth 3.");

      wait(slave_finished_example10 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 10: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 11:
      // Outstanding Transactions example
      // DESCRIPTION:
      // The following master code shows how master traffic can be created
      // up to the maximum number of outstanding transactions allowed.
      // During this time we do not want the slave to respond so that the
      // transactions are outstanding.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 11:");
      $display("Outstanding transactions example.");
      $display("---------------------------------------------------------");
      
      mtestID = 1;
      mtestvector = 0;
      mtestBurstLength = 4;
      mtestADDR = SLAVE_ADDRESS;
      fork
         begin
            tb.master_0.READ_BURST(1,
                                   0,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_FIXED,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[1],
                                   vresponse);
         end
         begin
            tb.master_0.READ_BURST(2,
                                   64,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_INCR,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[0],
                                   vresponse);
         end
         begin
            tb.master_0.READ_BURST(3,
                                   0,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_FIXED,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[0],
                                   vresponse);
         end
         begin
            tb.master_0.READ_BURST(4,
                                   64,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_FIXED,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[1],
                                   vresponse);
         end
         begin
            tb.master_0.READ_BURST(5,
                                   128,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_INCR,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[2],
                                   vresponse);
         end
         begin
            tb.master_0.READ_BURST(6,
                                   256,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_INCR,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[2],
                                   vresponse);
         end
         begin
            tb.master_0.READ_BURST(7,
                                   512,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_INCR,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[2],
                                   vresponse);
         end
         begin
            tb.master_0.READ_BURST(8,
                                   64,
                                   mtestBurstLength,
                                   `BURST_SIZE_4_BYTES,
                                   `BURST_TYPE_FIXED,
                                   `LOCK_TYPE_NORMAL,
                                   4'b0000,
                                   3'b000,
                                   rd_data_a[1],
                                   vresponse);
         end
      join
      $display("EXAMPLE TEST 11 - End of MAX_OUTSTANDING_TRANSACTIONS = 8.");
      
      
      wait(slave_finished_example11 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 11: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 12:
      // Slave read and write bursts error response example
      // DESCRIPTION:
      // The following code shows the master doing a normal write burst but
      // the final response is equal to a SLVERR (injected by the slave).
      // The the master does a normal read burst but this time the total
      // response vector has a SLVERR (injected by the slave) in the last 
      // transfer.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 12:");
      $display("Slave read and write bursts error response example.");
      $display("---------------------------------------------------------");

      mtestID = 12;
      mtestvector = 0;
      mtestBurstLength = 4;
      mtestADDR = SLAVE_ADDRESS;
      
      tb.master_0.WRITE_BURST(mtestID,              
                              mtestADDR,
                              mtestBurstLength,
                              `BURST_SIZE_4_BYTES,
                              `BURST_TYPE_INCR,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      $display("EXAMPLE TEST 12 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);

      // Check that the response was a slave error
      if (response != `RESPONSE_SLVERR) begin
         $display("EXAMPLE TEST 12 : *ERROR: Expected a slave error response instead of 0x%0h",response);
         $stop;
      end
      
 
      mtestID = mtestID+1;

      tb.master_0.READ_BURST(mtestID,
                             mtestADDR,
                             mtestBurstLength,
                             `BURST_SIZE_4_BYTES,
                             `BURST_TYPE_INCR,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,
                             vresponse);

      $display("EXAMPLE TEST 12 : DATA = 0x%h, vresponse = 0x%h",rd_data,vresponse);

      // Check that the last response was a slave error and all others were
      // OKAY.
      for (i = 0; i < mtestBurstLength+1; i=i+1) begin
         response = vresponse[i*`RESP_BUS_WIDTH +: `RESP_BUS_WIDTH];
         if (i == mtestBurstLength) begin
            if (response != `RESPONSE_SLVERR) begin
               $display("EXAMPLE TEST 12 : *ERROR: Expected a slave error response instead of 0x%0h",response);
               $stop;
            end
         end
         else begin
            tb.CHECK_RESPONSE_OKAY(response);
         end
      end
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      wait(slave_finished_example12 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 12: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 13:
      // Read and write bursts with different length gaps between data 
      // transfers example
      // DESCRIPTION:
      // The following master code shows how to get the master to generate
      // different sized gaps between the write data transfers in a burst.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 13:");
      $display("Write and Read bursts with different length gaps between");
      $display("data transfers example");
      $display("---------------------------------------------------------");

      mtestID = 1;
      mtestvector = 0;
      mtestBurstLength = `MAX_BURST_LENGTH;
      mtestADDR = SLAVE_ADDRESS;

      // To change the gap between write data transfers, the master BFM
      // internal variable WRITE_BURST_DATA_TRANSFER_GAP must be altered on
      // the fly after every write data transfer. To do this we can use
      // the write_data_transfer_complete event in a fork-join:
      fork
         begin
            tb.master_0.WRITE_BURST(mtestID,              
                                    mtestADDR,
                                    mtestBurstLength,
                                    `BURST_SIZE_4_BYTES,
                                    `BURST_TYPE_INCR,
                                    `LOCK_TYPE_NORMAL,
                                    4'b0000,
                                    3'b000,
                                    test_data[mtestvector],
                                    mtestdatasize,
                                    response);
            $display("EXAMPLE TEST 13 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);
            tb.CHECK_RESPONSE_OKAY(response);
         end // fork begin
         begin
            // Create an ever increasing by one gap between write data 
            // transfers.
            for (i = 0; i < mtestBurstLength+1; i=i+1) begin
               @(tb.master_0.write_data_transfer_complete);
               tb.master_0.set_write_burst_data_transfer_gap(i);
            end
         end
      join

      // Do a normal read burst and rely on the slave to add gaps between
      // the data transferes in a burst.
      mtestID = mtestID+1;

      tb.master_0.READ_BURST(mtestID,
                             mtestADDR,
                             mtestBurstLength,
                             `BURST_SIZE_4_BYTES,
                             `BURST_TYPE_INCR,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,
                             vresponse);

      $display("EXAMPLE TEST 13 : DATA = 0x%h, vresponse = 0x%h",rd_data,vresponse);

      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[1],rd_data);

      @(posedge tb.tb_ACLK);

      // Reset the gap variable for other tests.
      tb.master_0.set_write_burst_data_transfer_gap(0);
      
      wait(slave_finished_example13 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 13: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 14:
      // Read and write bursts with different length gaps between data 
      // channel transfers example
      // DESCRIPTION:
      // The following master code just shows a normal write burst followed
      // by a read burst. The gaps between the channel transfers are added
      // by the slave code.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 14:");
      $display("Write and Read bursts with different length gaps between");
      $display("channel transfers example");
      $display("---------------------------------------------------------");

      mtestID = 4;
      mtestvector = 0;
      mtestBurstLength = `MAX_BURST_LENGTH;
      mtestADDR = SLAVE_ADDRESS;

      // Do a normal write burst and rely on the slave to add gaps between
      // the channel transfers in a burst.
      tb.master_0.WRITE_BURST(mtestID,              
                              mtestADDR,
                              mtestBurstLength,
                              `BURST_SIZE_4_BYTES,
                              `BURST_TYPE_INCR,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      $display("EXAMPLE TEST 14 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);
      tb.CHECK_RESPONSE_OKAY(response);

      // Do a normal read burst and rely on the slave to add gaps between
      // the channel transfers in a burst.
      mtestID = mtestID+1;

      tb.master_0.READ_BURST(mtestID,
                             mtestADDR,
                             mtestBurstLength,
                             `BURST_SIZE_4_BYTES,
                             `BURST_TYPE_INCR,
                             `LOCK_TYPE_NORMAL,
                             4'b0000,
                             3'b000,
                             rd_data,
                             vresponse);

      $display("EXAMPLE TEST 14 : DATA = 0x%h, vresponse = 0x%h",rd_data,vresponse);

      tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
      tb.COMPARE_DATA(test_data[1],rd_data);

      @(posedge tb.tb_ACLK);
      
      wait(slave_finished_example14 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 14: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 15:
      // Write burst that is longer than the valid data it is sending.
      // DESCRIPTION:
      // The following master code just shows a write burst that is longer
      // than the valid data it is sending.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 15:");
      $display("Write burst that is longer than the valid data it is sending example.");
      $display("---------------------------------------------------------");

      mtestID = 10;
      mtestvector = 0;
      mtestBurstLength = 3;
      mtestADDR = SLAVE_ADDRESS;
      mtestdatasize = 7;
  
      tb.master_0.WRITE_BURST(mtestID,              
                              mtestADDR,
                              mtestBurstLength,
                              `BURST_SIZE_4_BYTES,
                              `BURST_TYPE_INCR,
                              `LOCK_TYPE_NORMAL,
                              4'b0000,
                              3'b000,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      $display("EXAMPLE TEST 15 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);
      tb.CHECK_RESPONSE_OKAY(response);

      @(posedge tb.tb_ACLK);
      
      wait(slave_finished_example15 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 15: FINISHED!");
      $display("---------------------------------------------------------");

      wait(slave_finished == 1'b1);
      tb.REPORT_MASTER_STATUS(1);
      tb.REPORT_SLAVE_STATUS(0);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST : PASSED");
      $display("---------------------------------------------------------");
      $display("---------------------------------------------------------");
      $display("COMPLETE EXAMPLE TEST FINISHED!");
      $display("---------------------------------------------------------");
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
      // Simple sequential write and read burst transfers example
      // DESCRIPTION:
      // The following slave code responds to the write and read bursts
      // expected from the master.
      //---------------------------------------------------------------------

      stestID = 1;
      stestvector = 0;

      tb.slave_0.WRITE_BURST_RESPOND(stestID,wr_data[stestvector],stestdatasize);

      // Check that the data received by the slave is the same as the test 
      // vector supplied by the master.
      tb.COMPARE_DATA(test_data[stestvector],wr_data[stestvector]);

      stestID = stestID+1;
      tb.slave_0.READ_BURST_RESPOND(stestID,test_data[stestvector]);

      $display("EXAMPLE TEST 1 : Slave response to sequential write and read FIXED burst transfers complete.");
      
      stestID = stestID+1;
      stestvector = 1;

      tb.slave_0.WRITE_BURST_RESPOND(stestID,wr_data[stestvector],stestdatasize);
      tb.COMPARE_DATA(test_data[stestvector],wr_data[stestvector]);

      stestID = stestID+1;
      tb.slave_0.READ_BURST_RESPOND(stestID,test_data[stestvector]);

      $display("EXAMPLE TEST 1 : Slave response to sequential write and read INCR burst transfers complete.");

      stestID = stestID+1;
      stestvector = 2;

      tb.slave_0.WRITE_BURST_RESPOND(stestID,wr_data[stestvector],stestdatasize);
      tb.COMPARE_DATA(test_data[stestvector],wr_data[stestvector]);

      stestID = stestID+1;
      tb.slave_0.READ_BURST_RESPOND(stestID,test_data[stestvector]);

      $display("EXAMPLE TEST 1 : Slave response to sequential write and read WRAP burst transfers complete.");

      // Slave side of example test 1 complete.
      slave_finished_example1 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 2:
      // Looped sequential write and read transfers example.
      // DESCRIPTION:
      // The following slave code does 3 write and read burst responses in a
      // for loop.
      //---------------------------------------------------------------------
      stestID=1;
     
      for (j = 0; j < 3; j=j+1) begin
         tb.slave_0.WRITE_BURST_RESPOND(stestID+j,wr_data[j],stestdatasize);
         tb.COMPARE_DATA(test_data[j],wr_data[j]);
         tb.slave_0.READ_BURST_RESPOND((stestID+1)+j,test_data[j]);
      end
      

      // Slave side of example test 2 complete.
      slave_finished_example2 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 3:
      // Parallel write and read burst transfers example.
      // DESCRIPTION:
      // The following slave code starts 3 write and 3 read burst responses
      // in parallel.
      //---------------------------------------------------------------------

      fork
         tb.slave_0.WRITE_BURST_RESPOND(15,wr_data[0],stestdatasize);
         tb.slave_0.WRITE_BURST_RESPOND(14,wr_data[1],stestdatasize);
         tb.slave_0.WRITE_BURST_RESPOND(13,wr_data[2],stestdatasize);
         tb.slave_0.READ_BURST_RESPOND(12,test_data[0]);
         tb.slave_0.READ_BURST_RESPOND(11,test_data[1]);
         tb.slave_0.READ_BURST_RESPOND(10,test_data[2]);
      join

      // Check the write burst data was as expected
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.COMPARE_DATA(test_data[1],wr_data[1]);
      tb.COMPARE_DATA(test_data[2],wr_data[2]);
      
      // Slave side of example test 3 complete.
      slave_finished_example3 = 1'b1;
     
      //---------------------------------------------------------------------
      // EXAMPLE TEST 4:
      // Narrow write and read transfers example.
      // DESCRIPTION:
      // The following slave code provides responses to the write and read
      // transfers coming from the master.
      // The strobe for the narrow transfers is automatically checked.
      // Please note that the response data used here would not be the data
      // expected from a memory.
      //---------------------------------------------------------------------

      fork
         tb.slave_0.WRITE_BURST_RESPOND(7,wr_data[0],stestdatasize);
         tb.slave_0.WRITE_BURST_RESPOND(9,wr_data[1],stestdatasize);
         tb.slave_0.WRITE_BURST_RESPOND(11,wr_data[2],stestdatasize);
         tb.slave_0.READ_BURST_RESPOND(8,test_data[0]);
         tb.slave_0.READ_BURST_RESPOND(10,test_data[1]);
         tb.slave_0.READ_BURST_RESPOND(12,test_data[2]);
      join

      // Check the write burst data was as expected
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.COMPARE_DATA(test_data[1],wr_data[1]);
      tb.COMPARE_DATA(test_data[2],wr_data[2]);

      // Slave side of example test 4 complete.
      slave_finished_example4 = 1'b1;
     
      //---------------------------------------------------------------------
      // EXAMPLE TEST 5:
      // Unaligned write and read transfers example.
      // DESCRIPTION:
      // The following slave code automatically checks the unaligned 
      // transfers and stobes and provides responses.
      // Please note that the response data used here would not be the data
      // expected from a memory.
      //---------------------------------------------------------------------

      fork
         tb.slave_0.WRITE_BURST_RESPOND(2,wr_data[0],stestdatasize);
         tb.slave_0.WRITE_BURST_RESPOND(4,wr_data[1],stestdatasize);
         tb.slave_0.READ_BURST_RESPOND(3,test_data[0]);
         tb.slave_0.READ_BURST_RESPOND(5,test_data[1]);
      join

      // Check the write burst data was as expected
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.COMPARE_DATA(test_data[1],wr_data[1]);

      // Slave side of example test 5 complete.
      slave_finished_example5 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 6:
      // Narrow and unaligned write and read transfers example.
      // DESCRIPTION:
      // The following slave code automatically checks the narrow and 
      // unaligned transfers and stobes and provides responses.
      // Please note that the response data used here would not be the data
      // expected from a memory.
      //---------------------------------------------------------------------

      fork
         tb.slave_0.WRITE_BURST_RESPOND(9,wr_data[1],stestdatasize);
         tb.slave_0.WRITE_BURST_RESPOND(11,wr_data[2],stestdatasize);
         tb.slave_0.READ_BURST_RESPOND(10,test_data[1]);
         tb.slave_0.READ_BURST_RESPOND(12,test_data[2]);
      join

      // Check the write burst data was as expected
      tb.COMPARE_DATA(test_data[1],wr_data[1]);
      tb.COMPARE_DATA(test_data[2],wr_data[2]);

      // Slave side of example test 6 complete.
      slave_finished_example6 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 7:
      // Out of order write and read burst example.
      // DESCRIPTION:
      // The following slave code ensures that the slave responds out of
      // order to the following conditions:
      // 1. Master sends two reads id 1->2, slave responds id 2->1.
      // 2. Master sends two writes id 3->4, slave write response id 4->3
      // 3. Master sends two writes address id 1->2, then write data bursts 
      //    2->1, slave write response id 1->2
      //---------------------------------------------------------------------

      // Step 1. Master sends two reads id 1->2, slave read responds id 2->1.
      // Step 1.1 Process the read requests in order.
      tb.slave_0.RECEIVE_READ_ADDRESS(1,
                                      `IDVALID_TRUE,
                                      stestaddress1,
                                      stestlength1,
                                      stestsize1,
                                      stestburst_type1,
                                      stestlock_type1,
                                      stestcache_type1,
                                      stestprotection_type1,
                                      stestID);
      tb.slave_0.RECEIVE_READ_ADDRESS(2,
                                      `IDVALID_TRUE,
                                      stestaddress2,
                                      stestlength2,
                                      stestsize2,
                                      stestburst_type2,
                                      stestlock_type2,
                                      stestcache_type2,
                                      stestprotection_type2,
                                      stestID);
      // Step 1.2. Send the read bursts to the master out of order.
      tb.slave_0.SEND_READ_BURST(2,
                                 stestaddress2,
                                 stestlength2,
                                 stestsize2,
                                 stestburst_type2,
                                 stestlock_type2,
                                 test_data[2]);      
      tb.slave_0.SEND_READ_BURST(1,
                                 stestaddress1,
                                 stestlength1,
                                 stestsize1,
                                 stestburst_type1,
                                 stestlock_type1,
                                 test_data[1]);      

      // Step 2. Master sends two writes id 3->4, slave write response id 
      // 4->3
      // Step 2.1 Process the write requests in order.
      tb.slave_0.RECEIVE_WRITE_ADDRESS(3,
                                       `IDVALID_TRUE,
                                       stestaddress1,
                                       stestlength1,
                                       stestsize1,
                                       stestburst_type1,
                                       stestlock_type1,
                                       stestcache_type1,
                                       stestprotection_type1,
                                       stestID);
      tb.slave_0.RECEIVE_WRITE_ADDRESS(4,
                                       `IDVALID_TRUE,
                                       stestaddress2,
                                       stestlength2,
                                       stestsize2,
                                       stestburst_type2,
                                       stestlock_type2,
                                       stestcache_type2,
                                       stestprotection_type2,
                                       stestID);
      // Step 2.2. Receive the write bursts in order.
      tb.slave_0.RECEIVE_WRITE_BURST(3,
                                     `IDVALID_TRUE,
                                     stestaddress1,
                                     stestlength1,
                                     stestsize1,
                                     stestburst_type1,
                                     wr_data[1],
                                     stestdatasize,
                                     stestID);
      tb.slave_0.RECEIVE_WRITE_BURST(4,
                                     `IDVALID_TRUE,
                                     stestaddress2,
                                     stestlength2,
                                     stestsize2,
                                     stestburst_type2,
                                     wr_data[0],
                                     stestdatasize,
                                     stestID);

      // Step 2.3 Send the write response bursts to the master out of order.
      stestresponse1 = `RESPONSE_OKAY;
      stestresponse2 = `RESPONSE_OKAY;
      
      tb.slave_0.SEND_WRITE_RESPONSE(4,stestresponse2);
      tb.slave_0.SEND_WRITE_RESPONSE(3,stestresponse1);
      
      // Check the write burst data was as expected
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.COMPARE_DATA(test_data[1],wr_data[1]);

      // Step 3. Master sends two writes address id 1->2, then write data 
      // bursts 2->1, slave write response id 1->2
      // Step 3.1 Process the write requests in order.
      tb.slave_0.RECEIVE_WRITE_ADDRESS(1,
                                       `IDVALID_TRUE,
                                       stestaddress1,
                                       stestlength1,
                                       stestsize1,
                                       stestburst_type1,
                                       stestlock_type1,
                                       stestcache_type1,
                                       stestprotection_type1,
                                       stestID);
      tb.slave_0.RECEIVE_WRITE_ADDRESS(2,
                                       `IDVALID_TRUE,
                                       stestaddress2,
                                       stestlength2,
                                       stestsize2,
                                       stestburst_type2,
                                       stestlock_type2,
                                       stestcache_type2,
                                       stestprotection_type2,
                                       stestID);
      // Step 3.2. Receive the write bursts out of order.
      tb.slave_0.RECEIVE_WRITE_BURST(2,
                                     `IDVALID_TRUE,
                                     stestaddress2,
                                     stestlength2,
                                     stestsize2,
                                     stestburst_type2,
                                     wr_data[0],
                                     stestdatasize,
                                     stestID);
      tb.slave_0.RECEIVE_WRITE_BURST(1,
                                     `IDVALID_TRUE,
                                     stestaddress1,
                                     stestlength1,
                                     stestsize1,
                                     stestburst_type1,
                                     wr_data[1],
                                     stestdatasize,
                                     stestID);

      // Step 3.3 Send the write response bursts to the master in order.
      stestresponse1 = `RESPONSE_OKAY;
      stestresponse2 = `RESPONSE_OKAY;
      
      tb.slave_0.SEND_WRITE_RESPONSE(1,stestresponse2);
      tb.slave_0.SEND_WRITE_RESPONSE(2,stestresponse1);
      
      // Check the write burst data was as expected
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.COMPARE_DATA(test_data[1],wr_data[1]);

      // Slave side of example test 7 complete.
      slave_finished_example7 = 1'b1;


      //---------------------------------------------------------------------
      // EXAMPLE TEST 8
      // Write Bursts performed in two different ways; Data before address,
      // and data and address concurrently.
      // DESCRIPTION:
      // On the slave side, respond to concurrent write burst normally and
      // use the special WRITE_BURST_RESPOND_DATA_FIRST to respond to the
      // data first then address, write burst.
      //---------------------------------------------------------------------

      tb.slave_0.WRITE_BURST_RESPOND(14,wr_data[0],stestdatasize);
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.slave_0.WRITE_BURST_RESPOND_DATA_FIRST(15,wr_data[1],stestdatasize);
      tb.COMPARE_DATA(test_data[1],wr_data[1]);

      // Slave side of example test 8 complete.
      slave_finished_example8 = 1'b1;
      
      //---------------------------------------------------------------------
      // EXAMPLE TEST 9:
      // Write data interleaving example.
      // DESCRIPTION:
      // The following slave code provides responses to all of the 
      // interleaved write bursts coming from the master.
      // The WRITE_BURST_RESPOND tasks need to be done in parallel as the
      // interleaves bursts will be done in parallel.
      //---------------------------------------------------------------------

      fork
         tb.slave_0.WRITE_BURST_RESPOND(10,wr_data[0],stestdatasize);
         tb.slave_0.WRITE_BURST_RESPOND(11,wr_data[1],stestdatasize);
         tb.slave_0.WRITE_BURST_RESPOND(15,wr_data[2],stestdatasize);
         tb.slave_0.WRITE_BURST_RESPOND(1,wr_data[3],stestdatasize);
         tb.slave_0.WRITE_BURST_RESPOND(2,wr_data[4],stestdatasize);
      join

      // Check the write burst data was as expected
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.COMPARE_DATA(test_data[1],wr_data[1]);
      tb.COMPARE_DATA(test_data[0],wr_data[2]);
      tb.COMPARE_DATA(test_data[1],wr_data[3]);
      tb.COMPARE_DATA(test_data[1],wr_data[4]);

      // Slave side of example test 9 complete.
      slave_finished_example9 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 10:
      // Read data interleaving example.
      // DESCRIPTION:
      // The following slave code does the following:
      // 1. Two read bursts interleaved (i.e. interleave depth 2)
      // 2. Three read bursts interleaved (i.e. interleave depth 3)
      // NOTE: To enable the slave BFM to generate data interleaved reads
      // the reads must be done in parallel (i.e. in a fork and join) AND
      // The slave control variable "READ_BURST_DATA_TRANSFER_GAP" must be
      // greater than 0. This allows other parallel read data bursts time 
      // to access the read data channel.
      //---------------------------------------------------------------------

      // Perform a read burst with data interleaving depth 2
      tb.slave_0.set_read_burst_data_transfer_gap(2);
      fork
         tb.slave_0.READ_BURST_RESPOND(8,test_data[0]);
         tb.slave_0.READ_BURST_RESPOND(9,test_data[1]);
      join

      // Perform a read burst with data interleaving depth 3
      fork
         tb.slave_0.READ_BURST_RESPOND(5,test_data[0]);
         tb.slave_0.READ_BURST_RESPOND(6,test_data[1]);
         tb.slave_0.READ_BURST_RESPOND(7,test_data[2]);
      join

      // Slave side of example test 10 complete.
      slave_finished_example10 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 11:
      // Outstanding transactions example
      // DESCRIPTION:
      // The following slave code does the following:
      // Reacts to the master transactions
      //---------------------------------------------------------------------
      tb.slave_0.set_read_burst_data_transfer_gap(0);
      example_test11_passed = 0;
      
      repeat(50) @(posedge tb.tb_ACLK);
      
      fork
         tb.slave_0.READ_BURST_RESPOND(1,test_data[0]);
         tb.slave_0.READ_BURST_RESPOND(2,test_data[1]);
         tb.slave_0.READ_BURST_RESPOND(3,test_data[0]);
         tb.slave_0.READ_BURST_RESPOND(4,test_data[1]);
         tb.slave_0.READ_BURST_RESPOND(5,test_data[2]);
         tb.slave_0.READ_BURST_RESPOND(6,test_data[0]);
         tb.slave_0.READ_BURST_RESPOND(7,test_data[1]);
         tb.slave_0.READ_BURST_RESPOND(8,test_data[0]);
         // Check that the max outstanding limit was reached at least once.
         if (tb.slave_0.pending_transactions_count == MAX_OUTSTANDING_TRANSACTIONS) example_test11_passed = 1;
      join

      if (example_test11_passed === 0) begin
         $display("Example Test 11 : Failed - pending transactions limit not hit, please check master driving logic.");
         $display("*** TEST FAILED");
         $stop;
      end
      else begin
         $display("Example Test 11 : MAX_OUTSTANDING_TRANSACTIONS limit reached successfully.");
      end

      // Slave side of example test 11 complete.
      slave_finished_example11 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 12:
      // Slave read and write bursts error response example
      // DESCRIPTION:
      // The following code shows the slave responding to a normal write burst
      // with a slave error i.e. SLVERR.
      // Then the slave reponds to a normal read burst with an error in the 
      // last transfer.
      //---------------------------------------------------------------------
      repeat(2) @(posedge tb.tb_ACLK);
      
      tb.slave_0.WRITE_BURST_RESP_CTRL(12,`RESPONSE_SLVERR,wr_data[0],stestdatasize);
      tb.COMPARE_DATA(test_data[0],wr_data[0]);

      // Create the error response vector for the read burst.
      for (j = 0; j < mtestBurstLength+1; j=j+1) begin
         if (j == mtestBurstLength) begin
            error_vresponse[j*`RESP_BUS_WIDTH +: `RESP_BUS_WIDTH] = `RESPONSE_SLVERR;
         
         end
         else begin
            error_vresponse[j*`RESP_BUS_WIDTH +: `RESP_BUS_WIDTH] = `RESPONSE_OKAY;
         end
      end
           
      $display("DEBUG: error response vector = b%0b",error_vresponse);
      
      tb.slave_0.READ_BURST_RESP_CTRL(13,
                                      test_data[0],
                                      error_vresponse);

      // Slave side of example test 12 complete.
      slave_finished_example12 = 1'b1;


      //---------------------------------------------------------------------
      // EXAMPLE TEST 13:
      // Write and read bursts with different length gaps between data 
      // transfers example
      // DESCRIPTION:
      // The following slave code shows how to get the slave to generate
      // different sized gaps between the read data transfers in a burst.
      //---------------------------------------------------------------------

      // Respond to the write burst from the master that should have
      // different sized gaps between transfers.
      tb.slave_0.WRITE_BURST_RESPOND(1,wr_data[0],stestdatasize);
      tb.COMPARE_DATA(test_data[0],wr_data[0]);

      // To change the gap between read data transfers, the slave BFM
      // internal variable READ_BURST_DATA_TRANSFER_GAP must be altered on
      // the fly after every read data transfer. To do this we can use
      // the read_data_transfer_complete event in a fork-join:
      fork
         begin
            tb.slave_0.READ_BURST_RESPOND(2,test_data[1]);
         end
         begin
            // Create an ever increasing by one gap between write data 
            // transfers.
            for (j = 0; j < mtestBurstLength+1; j=j+1) begin
               @(tb.slave_0.read_data_transfer_complete);
               tb.slave_0.set_read_burst_data_transfer_gap(j);
            end
         end
      join

      // Reset the gap variable for other tests.
      tb.slave_0.set_read_burst_data_transfer_gap(0);
      
      // Slave side of example test 13 complete.
      slave_finished_example13 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 14:
      // Write and read bursts with different length gaps between channel 
      // transfers example
      // DESCRIPTION:
      // The following slave code shows how to get the slave to generate
      // different sized gaps between:
      // 1. The read address channel transfer and the read data channel
      //    transfer. Controlled by READ_RESPONSE_GAP variable
      // 2. The write data channel transfer and the write response channel
      //    transfer. Controlled by WRITE_RESPONSE_GAP variable
      //---------------------------------------------------------------------

      // Simply make the READ_RESPONSE_GAP and WRITE_RESPONSE_GAP greater
      // then 0 but less than the TIMEOUT_RESPONSE variable and respond
      // as normal.
      tb.slave_0.set_read_response_gap(10);
      tb.slave_0.set_write_response_gap(10);
      
      tb.slave_0.WRITE_BURST_RESPOND(4,wr_data[0],stestdatasize);
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.slave_0.READ_BURST_RESPOND(5,test_data[1]);

      // Put the reset the variables back to zero.
      tb.slave_0.set_read_response_gap(0);
      tb.slave_0.set_write_response_gap(0);

      // Slave side of example test 14 complete.
      slave_finished_example14 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 15:
      // Write burst that is longer than the valid data it is sending.
      // DESCRIPTION:
      // The following slave code just does a normal write burst response.
      //---------------------------------------------------------------------
      tb.slave_0.WRITE_BURST_RESPOND(10,wr_data[0],stestdatasize);
      if (stestdatasize != 7) begin
         $display("EXAMPLE TEST 15 : *ERROR: Slave received an unexpected number of valid write data bytes (%0d)",stestdatasize);
         $stop;
      end
      tb.COMPARE_DATA(test_data[0],wr_data[0]);

      // Slave side of example test 15 complete.
      slave_finished_example15 = 1'b1;

      // Slave side of example test complete.
      slave_finished = 1'b1;
   end
   
endmodule
//----------------------------------------------------------------------------
// END OF FILE
//----------------------------------------------------------------------------
