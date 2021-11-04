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
// This file contains an example test for the AXI 4 Lite Master and Slave BFMs.
// It demonstrates how to stimulate the following conditions from both the
// master and slave perspectives:
// 1  Simple sequential write and read burst transfers example
// 2  Looped sequential write and read transfers example
// 3  Parallel write and read burst transfers example
// 4  Write Bursts performed in two different ways; Data before address, and
//    data and address concurrently
// 5  Outstanding transactions example
// 6  Slave read and write bursts error repsonse example
// 7  Write and Read bursts with different length gaps between channel 
//    transfers example
// 8  Unaligned write and read transfer example
// 9  Write burst with valid data less than data bus width example.
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
   parameter SLAVE_ADDRESS = 0;
   parameter SLAVE_MEM_SIZE = 4096;
   parameter MAX_OUTSTANDING_TRANSACTIONS = 8;
   parameter MEMORY_MODEL_MODE = 0;

   // Create an instance of the example tb
   cdn_axi4_lite_example_tb #(MASTER_NAME,
                              SLAVE_NAME,
                              DATA_BUS_WIDTH,
                              ADDRESS_BUS_WIDTH,
                              SLAVE_ADDRESS,
                              SLAVE_MEM_SIZE,
                              MAX_OUTSTANDING_TRANSACTIONS,
                              MEMORY_MODEL_MODE) tb();
   
   // Local Variables
   reg [DATA_BUS_WIDTH-1:0] rd_data;
   reg [DATA_BUS_WIDTH-1:0] test_data [2:0];
   reg [DATA_BUS_WIDTH-1:0] wr_data [4:0];
   reg [DATA_BUS_WIDTH-1:0] rd_data_a [2:0];
   reg [`RESP_BUS_WIDTH-1:0] response;
   reg [`RESP_BUS_WIDTH-1:0] error_response;
   reg [ADDRESS_BUS_WIDTH-1:0] mtestAddress;
   reg [`PROT_BUS_WIDTH-1:0]   mtestProtection;
   
   integer                     mtestvector; // Master side testvector
   integer                     stestvector; // Slave side testvector
   integer                     i; // Simple loop integer. 
   integer                     j; // Simple loop integer. 

   integer                     mtestdatasize;
   integer                     stestdatasize;
      
   // Test Status Bits
   reg                         slave_finished_example1 = 1'b0;
   reg                         slave_finished_example2 = 1'b0;
   reg                         slave_finished_example3 = 1'b0;
   reg                         slave_finished_example4 = 1'b0;
   reg                         slave_finished_example5 = 1'b0;
   reg                         example_test5_passed = 1'b0;
   reg                         slave_finished_example6 = 1'b0;
   reg                         slave_finished_example7 = 1'b0;
   reg                         slave_finished_example8 = 1'b0;
   reg                         slave_finished_example9 = 1'b0;
   reg                         slave_finished = 1'b0;

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

      mtestvector = 0;
      mtestAddress = SLAVE_ADDRESS;
      mtestProtection = 0;
      mtestdatasize = `MAX_DATA_SIZE;
      
      tb.master_0.WRITE_BURST(mtestAddress,
                              mtestProtection,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      $display("EXAMPLE TEST 1 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);

      tb.CHECK_RESPONSE_OKAY(response);
 
      tb.master_0.READ_BURST(mtestAddress,
                             mtestProtection,
                             rd_data,
                             response);

      $display("EXAMPLE TEST 1 : DATA = 0x%h, response = 0x%h",rd_data,response);

      tb.CHECK_RESPONSE_OKAY(response);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      $display("EXAMPLE TEST 1 : Sequential write and read burst transfers complete from the master side.");
      
      mtestvector = 1;
      mtestAddress = mtestAddress+DATA_BUS_WIDTH;
      
      tb.master_0.WRITE_BURST(mtestAddress,
                              mtestProtection,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      
      $display("EXAMPLE TEST 1 : Data = 0x%h, Response = 0x%h", test_data[mtestvector],response);
      tb.CHECK_RESPONSE_OKAY(response);

      tb.master_0.READ_BURST(mtestAddress,
                             mtestProtection,
                             rd_data,
                             response);

      $display("EXAMPLE TEST 1 : Data = 0x%h, Response = 0x%h", rd_data,response);

      tb.CHECK_RESPONSE_OKAY(response);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      $display("EXAMPLE TEST 1 : Sequential write and read transfers complete from the master side.");
      
      mtestvector = 2;
      mtestAddress = mtestAddress+DATA_BUS_WIDTH;

      tb.master_0.WRITE_BURST(mtestAddress,
                              mtestProtection,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);

      $display("EXAMPLE TEST 1 : Data = 0x%h, Response = 0x%h", test_data[mtestvector],response);
      tb.CHECK_RESPONSE_OKAY(response);

      tb.master_0.READ_BURST(mtestAddress,
                             mtestProtection,
                             rd_data,
                             response);
      
      $display("TESTBENCH DATA = 0x%h, response = 0x%h", rd_data,response);

      tb.CHECK_RESPONSE_OKAY(response);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      $display("EXAMPLE TEST 1 : Sequential write and read transfers complete from the master side.");

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
      mtestAddress = 0;

      for (i = 0; i < 3; i=i+1) begin
         
         tb.master_0.WRITE_BURST(mtestAddress,
                                 mtestProtection,
                                 test_data[i],
                                 mtestdatasize,
                                 response);
         $display("EXAMPLE TEST 2 : DATA = 0x%h, response = 0x%h",test_data[i],response);

         tb.CHECK_RESPONSE_OKAY(response);
         
        
         tb.master_0.READ_BURST(mtestAddress,
                                mtestProtection,
                                rd_data,
                                response);
         
         $display("EXAMPLE TEST 2 : DATA = 0x%h, response = 0x%h",rd_data,response);

         tb.CHECK_RESPONSE_OKAY(response);
         tb.COMPARE_DATA(test_data[i],rd_data);

         mtestAddress = i*DATA_BUS_WIDTH;
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
 
      fork
         begin
            tb.master_0.WRITE_BURST(0,
                                    mtestProtection,
                                    test_data[0],
                                    mtestdatasize,
                                    response);
            tb.CHECK_RESPONSE_OKAY(response);
            tb.master_0.WRITE_BURST(DATA_BUS_WIDTH,
                                    mtestProtection,
                                    test_data[1],
                                    mtestdatasize,
                                    response);
            tb.CHECK_RESPONSE_OKAY(response);
            tb.master_0.WRITE_BURST(DATA_BUS_WIDTH*2,
                                    mtestProtection,
                                    test_data[2],
                                    mtestdatasize,
                                    response);
            tb.CHECK_RESPONSE_OKAY(response);
         end 
         begin
            tb.master_0.READ_BURST(DATA_BUS_WIDTH*3,
                                   mtestProtection,
                                   rd_data_a[0],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
            tb.COMPARE_DATA(test_data[0],rd_data_a[0]);
            tb.master_0.READ_BURST(DATA_BUS_WIDTH*4,
                                   mtestProtection,
                                   rd_data_a[1],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
            tb.COMPARE_DATA(test_data[1],rd_data_a[1]);
            tb.master_0.READ_BURST(DATA_BUS_WIDTH*5,
                                   mtestProtection,
                                   rd_data_a[2],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
            tb.COMPARE_DATA(test_data[2],rd_data_a[2]);
         end
      join
      
      wait(slave_finished_example3 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 3: FINISHED!");
      $display("---------------------------------------------------------");
      
      //---------------------------------------------------------------------
      // EXAMPLE TEST 4
      // Write Bursts performed in two different ways; Data before address,
      // and data and address concurrently.
      // DESCRIPTION:
      // On the master side:
      // 1. Start a write burst concurrently using WRITE_BURST_CONCURRENT
      //    i.e. write address phase and write data phase start concurrently.
      // 2. Start a write burst data first followed by write address phase
      //    using the WRITE_BURST_DATA_FIRST.
      //---------------------------------------------------------------------

      mtestAddress = SLAVE_ADDRESS;

      tb.master_0.WRITE_BURST_CONCURRENT(mtestAddress,
                                         mtestProtection,
                                         test_data[mtestvector],
                                         mtestdatasize,
                                         response);
      $display("EXAMPLE TEST 4 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);
      tb.CHECK_RESPONSE_OKAY(response);

      mtestAddress = SLAVE_ADDRESS+256;
      
      tb.master_0.WRITE_BURST_DATA_FIRST(mtestAddress,
                                         mtestProtection,
                                         test_data[mtestvector],
                                         mtestdatasize,
                                         response);
      $display("EXAMPLE TEST 4 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);
      tb.CHECK_RESPONSE_OKAY(response);

      wait(slave_finished_example4 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 4: FINISHED!");
      $display("---------------------------------------------------------");
      
      //---------------------------------------------------------------------
      // EXAMPLE TEST 5:
      // Outstanding Transactions example
      // DESCRIPTION:
      // The following master code shows how master traffic can be created
      // up to the maximum number of outstanding transactions allowed.
      // During this time we do not want the slave to respond so that the
      // transactions are outstanding.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 5:");
      $display("Outstanding transactions example.");
      $display("---------------------------------------------------------");
      
      mtestAddress = SLAVE_ADDRESS;
      fork
         begin
            // 1
            tb.master_0.READ_BURST(0,
                                   mtestProtection,
                                   rd_data_a[0],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
         end
         begin
            // 2
            tb.master_0.READ_BURST(64,
                                   mtestProtection,
                                   rd_data_a[1],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
         end
         begin
            // 3
            tb.master_0.READ_BURST(124,
                                   mtestProtection,
                                   rd_data_a[2],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
         end
         begin
            // 4
            tb.master_0.READ_BURST(156,
                                   mtestProtection,
                                   rd_data_a[0],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
         end
         begin
            // 5
            tb.master_0.READ_BURST(188,
                                   mtestProtection,
                                   rd_data_a[1],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
         end
         begin
            // 6
            tb.master_0.READ_BURST(256,
                                   mtestProtection,
                                   rd_data_a[2],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
         end
         begin
            // 7
            tb.master_0.READ_BURST(512,
                                   mtestProtection,
                                   rd_data_a[0],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
         end
         begin
            // 8
            tb.master_0.READ_BURST(544,
                                   mtestProtection,
                                   rd_data_a[1],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
         end
         begin
            // 9
            tb.master_0.READ_BURST(1024,
                                   mtestProtection,
                                   rd_data_a[2],
                                   response);
            tb.CHECK_RESPONSE_OKAY(response);
         end
      join
      $display("EXAMPLE TEST 5 - End of MAX_OUTSTANDING_TRANSACTIONS = 8.");
      
      
      wait(slave_finished_example5 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 5: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 6:
      // Slave read and write bursts error response example
      // DESCRIPTION:
      // The following code shows the master doing a normal write burst but
      // the final response is equal to a SLVERR (injected by the slave).
      // The the master does a normal read burst but this time the total
      // response vector has a SLVERR (injected by the slave) in the last 
      // transfer.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 6:");
      $display("Slave read and write bursts error response example.");
      $display("---------------------------------------------------------");

      mtestAddress = SLAVE_ADDRESS;
      
      tb.master_0.WRITE_BURST(mtestAddress,
                              mtestProtection,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      $display("EXAMPLE TEST 6 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);

      // Check that the response was a slave error
      if (response != `RESPONSE_SLVERR) begin
         $display("EXAMPLE TEST 6 : *ERROR: Expected a slave error response instead of 0x%0h",response);
         $stop;
      end
      
 
      tb.master_0.READ_BURST(mtestAddress,
                             mtestProtection,
                             rd_data,
                             response);

      $display("EXAMPLE TEST 6 : DATA = 0x%h, response = 0x%h",rd_data,response);
      if (response != `RESPONSE_SLVERR) begin
         $display("EXAMPLE TEST 6 : *ERROR: Expected a slave error response instead of 0x%0h",response);
         $stop;
      end
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      wait(slave_finished_example6 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 6: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 7:
      // Read and write bursts with different length gaps between data 
      // channel transfers example
      // DESCRIPTION:
      // The following master code just shows a normal write burst followed
      // by a read burst. The gaps between the channel transfers are added
      // by the slave code.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 7:");
      $display("Write and Read bursts with different length gaps between");
      $display("channel transfers example");
      $display("---------------------------------------------------------");

      mtestAddress = SLAVE_ADDRESS;

      // Do a normal write burst and rely on the slave to add gaps between
      // the channel transfers in a burst.
      tb.master_0.WRITE_BURST(mtestAddress,
                              mtestProtection,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      $display("EXAMPLE TEST 7 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);
      tb.CHECK_RESPONSE_OKAY(response);

      // Do a normal read burst and rely on the slave to add gaps between
      // the channel transfers in a burst.

      tb.master_0.READ_BURST(mtestAddress,
                             mtestProtection,
                             rd_data,
                             response);

      $display("EXAMPLE TEST 7 : DATA = 0x%h, response = 0x%h",rd_data,response);

      tb.CHECK_RESPONSE_OKAY(response);
      tb.COMPARE_DATA(test_data[1],rd_data);

      @(posedge tb.tb_ACLK);
      
      wait(slave_finished_example7 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 7: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 8:
      // Unaligned write and read transfers example.
      // DESCRIPTION:
      // The following master code does:
      // 3 of each write and read unaligned transfers
      // NOTE: The slave does not model memory so the data might look wrong
      // but the slave BFM has checked that the strobes are right.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 8:");
      $display("Unaligned write and read transfers example.");
      $display("---------------------------------------------------------");

      mtestAddress = 1;
      mtestvector = 0;
      
      tb.master_0.WRITE_BURST(mtestAddress,
                              mtestProtection,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      tb.CHECK_RESPONSE_OKAY(response);
            

      tb.master_0.READ_BURST(mtestAddress,
                             mtestProtection,
                             rd_data,
                             response);
      tb.CHECK_RESPONSE_OKAY(response);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      mtestAddress = 2;
      mtestvector = 1;
      
      tb.master_0.WRITE_BURST(mtestAddress,
                              mtestProtection,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      tb.CHECK_RESPONSE_OKAY(response);
            

      tb.master_0.READ_BURST(mtestAddress,
                             mtestProtection,
                             rd_data,
                             response);
      tb.CHECK_RESPONSE_OKAY(response);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      mtestAddress = 3;
      mtestvector = 2;
      
      tb.master_0.WRITE_BURST(mtestAddress,
                              mtestProtection,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      tb.CHECK_RESPONSE_OKAY(response);
            

      tb.master_0.READ_BURST(mtestAddress,
                             mtestProtection,
                             rd_data,
                             response);
      tb.CHECK_RESPONSE_OKAY(response);
      tb.COMPARE_DATA(test_data[mtestvector],rd_data);

      wait(slave_finished_example8 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 8: FINISHED!");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 9:
      // Write burst with valid data less than data bus width example.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 9:");
      $display("Write burst with valid data less than data bus width example.");
      $display("---------------------------------------------------------");

      mtestvector = 0;
      mtestAddress = SLAVE_ADDRESS;
      mtestdatasize = 3;
  
      tb.master_0.WRITE_BURST(mtestAddress,
                              mtestProtection,
                              test_data[mtestvector],
                              mtestdatasize,
                              response);
      tb.CHECK_RESPONSE_OKAY(response);

      $display("EXAMPLE TEST 9 : DATA = 0x%h, response = 0x%h",test_data[mtestvector],response);

      @(posedge tb.tb_ACLK);
      
      wait(slave_finished_example9 == 1'b1);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 9: FINISHED!");
      $display("---------------------------------------------------------");
      
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

      stestvector = 0;

      tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[stestvector],stestdatasize);

      // Check that the data received by the slave is the same as the test 
      // vector supplied by the master.
      tb.COMPARE_DATA(test_data[stestvector],wr_data[stestvector]);

      tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_FALSE,test_data[stestvector]);

      $display("EXAMPLE TEST 1 : Slave response to sequential write and read transfers complete.");
      
      stestvector = 1;

      tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[stestvector],stestdatasize);
      tb.COMPARE_DATA(test_data[stestvector],wr_data[stestvector]);

      tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_FALSE,test_data[stestvector]);

      $display("EXAMPLE TEST 1 : Slave response to sequential write and read transfers complete.");

      stestvector = 2;

      tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[stestvector],stestdatasize);
      tb.COMPARE_DATA(test_data[stestvector],wr_data[stestvector]);

      tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_FALSE,test_data[stestvector]);

      $display("EXAMPLE TEST 1 : Slave response to sequential write and read transfers complete.");

      // Slave side of example test 1 complete.
      slave_finished_example1 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 2:
      // Looped sequential write and read transfers example.
      // DESCRIPTION:
      // The following slave code does 3 write and read burst responses in a
      // for loop.
      //---------------------------------------------------------------------
     
      for (j = 0; j < 3; j=j+1) begin
         tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[j],stestdatasize);
         tb.COMPARE_DATA(test_data[j],wr_data[j]);
         tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_FALSE,test_data[j]);
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
         begin
            tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[0],stestdatasize);
            tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[1],stestdatasize);
            tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[2],stestdatasize);
         end
         begin
            tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_FALSE,test_data[0]);
            tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_FALSE,test_data[1]);
            tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_FALSE,test_data[2]);
         end
      join
 
      // Check the write burst data was as expected
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.COMPARE_DATA(test_data[1],wr_data[1]);
      tb.COMPARE_DATA(test_data[2],wr_data[2]);
      
      // Slave side of example test 3 complete.
      slave_finished_example3 = 1'b1;
     
      //---------------------------------------------------------------------
      // EXAMPLE TEST 4
      // Write Bursts performed in two different ways; Data before address,
      // and data and address concurrently.
      // DESCRIPTION:
      // On the slave side, respond to the concurrent write burst and 
      // the data first burst normally.
      //---------------------------------------------------------------------

      tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[0],stestdatasize);
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[1],stestdatasize);
      tb.COMPARE_DATA(test_data[1],wr_data[1]);

      // Slave side of example test 4 complete.
      slave_finished_example4 = 1'b1;
      
      //---------------------------------------------------------------------
      // EXAMPLE TEST 5:
      // Outstanding transactions example
      // DESCRIPTION:
      // The following slave code does the following:
      // Reacts to the master transactions
      //---------------------------------------------------------------------
      repeat(50) @(posedge tb.tb_ACLK);

      example_test5_passed = 0;
     
      fork
         tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_TRUE,test_data[0]);
         tb.slave_0.READ_BURST_RESPOND(64,`ADDRVALID_TRUE,test_data[1]);
         tb.slave_0.READ_BURST_RESPOND(124,`ADDRVALID_TRUE,test_data[2]);
         tb.slave_0.READ_BURST_RESPOND(156,`ADDRVALID_TRUE,test_data[0]);
         tb.slave_0.READ_BURST_RESPOND(188,`ADDRVALID_TRUE,test_data[1]);
         tb.slave_0.READ_BURST_RESPOND(256,`ADDRVALID_TRUE,test_data[2]);
         tb.slave_0.READ_BURST_RESPOND(512,`ADDRVALID_TRUE,test_data[0]);
         tb.slave_0.READ_BURST_RESPOND(544,`ADDRVALID_TRUE,test_data[1]);
         tb.slave_0.READ_BURST_RESPOND(1024,`ADDRVALID_TRUE,test_data[2]);
         // Check that the max outstanding limit was reached at least once.
         if (tb.slave_0.pending_transactions_count == MAX_OUTSTANDING_TRANSACTIONS) example_test5_passed = 1;
      join

      if (example_test5_passed === 0) begin
         $display("Example Test 5 : Failed - pending transactions limit not hit, please check master driving logic.");
         $display("*** TEST FAILED");
         $stop;
      end
      else begin
         $display("Example Test 5 : MAX_OUTSTANDING_TRANSACTIONS limit reached successfully.");
      end
      
      // Slave side of example test 5 complete.
      slave_finished_example5 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 6:
      // Slave read and write bursts error response example
      // DESCRIPTION:
      // The following code shows the slave responding to a normal write burst
      // with a slave error i.e. SLVERR.
      // Then the slave reponds to a normal read burst with an error in the 
      // last transfer.
      //---------------------------------------------------------------------
      repeat(2) @(posedge tb.tb_ACLK);
      tb.slave_0.set_write_response_gap(5);
      tb.slave_0.WRITE_BURST_RESP_CTRL(0,`ADDRVALID_FALSE,`RESPONSE_SLVERR,wr_data[0],stestdatasize);
      tb.COMPARE_DATA(test_data[0],wr_data[0]);

      error_response = `RESPONSE_SLVERR;
      tb.slave_0.set_read_response_gap(5);
      tb.slave_0.READ_BURST_RESP_CTRL(0,`ADDRVALID_FALSE,test_data[0],
                                      error_response);

      // Slave side of example test 6 complete.
      slave_finished_example6 = 1'b1;


      //---------------------------------------------------------------------
      // EXAMPLE TEST 7:
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
      
      tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[0],stestdatasize);
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_FALSE,test_data[1]);

      // Put the reset the variables back to zero.
      tb.slave_0.set_read_response_gap(0);
      tb.slave_0.set_write_response_gap(0);

      // Slave side of example test 7 complete.
      slave_finished_example7 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 8:
      // Unaligned write and read transfers example.
      // DESCRIPTION:
      // The following slave code automatically checks the unaligned 
      // transfers and stobes and provides responses.
      // Please note that the response data used here would not be the data
      // expected from a memory.
      //---------------------------------------------------------------------

      tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[0],stestdatasize);
      tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_FALSE,test_data[0]);
      tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[1],stestdatasize);
      tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_FALSE,test_data[1]);
      tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[2],stestdatasize);
      tb.slave_0.READ_BURST_RESPOND(0,`ADDRVALID_FALSE,test_data[2]);

      // Check the write burst data was as expected
      tb.COMPARE_DATA(test_data[0],wr_data[0]);
      tb.COMPARE_DATA(test_data[1],wr_data[1]);
      tb.COMPARE_DATA(test_data[2],wr_data[2]);

      // Slave side of example test 8 complete.
      slave_finished_example8 = 1'b1;

      //---------------------------------------------------------------------
      // EXAMPLE TEST 9:
      // Write burst with valid data less than data bus width example.
      // DESCRIPTION:
      // The following slave code just does a normal write burst response.
      //---------------------------------------------------------------------
      tb.slave_0.WRITE_BURST_RESPOND(0,`ADDRVALID_FALSE,wr_data[0],stestdatasize);
      if (stestdatasize != 3) begin
         $display("EXAMPLE TEST 9 : *ERROR: Slave received an unexpected number of valid write data bytes (%0d)",stestdatasize);
         $stop;
      end
      tb.COMPARE_DATA(test_data[0],wr_data[0]);

      // Slave side of example test 9 complete.
      slave_finished_example9 = 1'b1;

      // Slave side of example test complete.
      slave_finished = 1'b1;
   end
   
endmodule
//----------------------------------------------------------------------------
// END OF FILE
//----------------------------------------------------------------------------
