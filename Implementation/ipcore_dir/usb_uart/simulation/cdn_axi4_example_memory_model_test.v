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
// This file contains an example test for the AXI 4 Master and Slave BFMs.
// In this case the slave BFM is configured as a simple memory model and as
// such will automatically generate responses.
// The following test scenarios are shown:
// 1. Write to the full memory with a count number in each byte location and
// then read it all back.
// 2. Write to the full memory with a count number in each transfer and then
// then read it all back.
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
   parameter AWUSER_BUS_WIDTH = 1;
   parameter ARUSER_BUS_WIDTH = 1;
   parameter RUSER_BUS_WIDTH  = 1;
   parameter WUSER_BUS_WIDTH  = 1;
   parameter BUSER_BUS_WIDTH  = 1;
   parameter SLAVE_ADDRESS = 0;
   parameter SLAVE_MEM_SIZE = 4096;
   parameter MAX_OUTSTANDING_TRANSACTIONS = 8;
   // Enable Memory Model Mode in the Slave BFM.
   parameter MEMORY_MODEL_MODE = 1;
   parameter EXCLUSIVE_ACCESS_SUPPORTED = 1;
   
   // Create an instance of the example tb
   cdn_axi4_example_tb #(MASTER_NAME,
                         SLAVE_NAME,
                         DATA_BUS_WIDTH,
                         ADDRESS_BUS_WIDTH,
                         ID_BUS_WIDTH,
                         AWUSER_BUS_WIDTH,
                         ARUSER_BUS_WIDTH,
                         RUSER_BUS_WIDTH,
                         WUSER_BUS_WIDTH,
                         BUSER_BUS_WIDTH,
                         SLAVE_ADDRESS,
                         SLAVE_MEM_SIZE,
                         MAX_OUTSTANDING_TRANSACTIONS,
                         MEMORY_MODEL_MODE,
                         EXCLUSIVE_ACCESS_SUPPORTED) tb();
      
   // Local Variables
   reg [(DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] rd_data;
   reg [(DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] test_data;
   reg [`RESP_BUS_WIDTH-1:0]                        response;
   reg [(`RESP_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] vresponse;
   reg [ADDRESS_BUS_WIDTH-1:0]                       mtestADDR;
   reg [(RUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] v_ruser;
   reg [(WUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] v_wuser;
   
   integer                        mtestID; // Master side testID
   integer                        mtestBurstLength;
   integer                        mtestLockType;
   integer                        mtestBurstSize;
   integer                        mtestCacheType;

   integer                        mtestdatasize;

   integer                        mtestProtectionType;
   integer                        mtestRegion;
   integer                        mtestQOS;
   integer                        mtestBUSER;
   integer                        mtestAWUSER;
   integer                        mtestARUSER;

   integer                        number_of_bytes_in_full_burst;
   integer                        i; // Simple loop integer. 
   integer                        j; // Simple loop integer. 
   integer                        a; // Simple loop integer. 
   integer                        mtestvector; // Master side testvector
   
   integer                        DEBUG = 1;
   
   //------------------------------------------------------------------------
   // Drive the MASTER BFM
   //------------------------------------------------------------------------
   initial begin
      
      // Wait for end of reset
      wait(tb.tb_ARESETn === 0) @(posedge tb.tb_ACLK);
      wait(tb.tb_ARESETn === 1) @(posedge tb.tb_ACLK);

      //---------------------------------------------------------------------
      // Select the correct burst size to match the data bus widths
      //---------------------------------------------------------------------
      case (DATA_BUS_WIDTH)
        8  : mtestBurstSize = `BURST_SIZE_1_BYTE;
        16 : mtestBurstSize = `BURST_SIZE_2_BYTES;
        32 : mtestBurstSize = `BURST_SIZE_4_BYTES;
        64 : mtestBurstSize = `BURST_SIZE_8_BYTES;
        128 : mtestBurstSize = `BURST_SIZE_16_BYTES;
        256 : mtestBurstSize = `BURST_SIZE_32_BYTES;
        512 : mtestBurstSize = `BURST_SIZE_64_BYTES;
        1024 : mtestBurstSize = `BURST_SIZE_128_BYTES;
        default : begin
           $display("-----------------------------------------------------");
           $display("EXAMPLE TEST : FAILED -- Invalid DATA_BUS_WIDTH");
           $display("-----------------------------------------------------");
        end
      endcase
      
      
      //---------------------------------------------------------------------
      // EXAMPLE TEST 1:
      // Write to the full memory with a count number in each byte location
      // and then read it all back.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 1:");
      $display("Full memory write followed by a full memory read");
      $display("---------------------------------------------------------");
      
      mtestID = 1;
      mtestLockType = `LOCK_TYPE_NORMAL;
      mtestBurstLength = `MAX_BURST_LENGTH;
      number_of_bytes_in_full_burst = ((DATA_BUS_WIDTH/8)*(`MAX_BURST_LENGTH+1));

      // adjunstement made in order not to exceed 4KB Boundary
      if (number_of_bytes_in_full_burst > 4*1024) begin
          number_of_bytes_in_full_burst = 4*1024;
	  mtestBurstLength = ((4*1024)/(DATA_BUS_WIDTH/8))-1;
      end

      mtestdatasize = number_of_bytes_in_full_burst;
      mtestCacheType = 0;
      mtestProtectionType = 0;
      mtestRegion = 0;
      mtestQOS = 0;
      mtestAWUSER = 0;
      mtestARUSER = 0;
      v_wuser = 0;
      for (i = 0; i < (SLAVE_MEM_SIZE-SLAVE_ADDRESS)/number_of_bytes_in_full_burst; i = i+1) begin
         // Make the test vector
         for (j = 0; j < number_of_bytes_in_full_burst; j=j+1) begin
            test_data[j*8 +: 8] = j+(i*number_of_bytes_in_full_burst);
         end
         
         mtestADDR = i*number_of_bytes_in_full_burst+SLAVE_ADDRESS;

         tb.master_0.WRITE_BURST(mtestID,              
                                 mtestADDR,
                                 mtestBurstLength,
                                 mtestBurstSize,
                                 `BURST_TYPE_INCR,
                                 mtestLockType,
                                 mtestCacheType,
                                 mtestProtectionType,
                                 test_data,
                                 mtestdatasize,
                                 mtestRegion,
                                 mtestQOS,
                                 mtestAWUSER,
                                 v_wuser,
                                 response,
                                 mtestBUSER);
         $display("EXAMPLE TEST 1 : Burst %0d, WRITE DATA = 0x%h, response = 0x%h",i,test_data,response);

         tb.CHECK_RESPONSE_OKAY(response);
      end
      
 
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 1 : Full memory write finshed.");
      $display("---------------------------------------------------------");
      mtestID = mtestID+1;

      for (i = 0; i < (SLAVE_MEM_SIZE-SLAVE_ADDRESS)/number_of_bytes_in_full_burst; i = i+1) begin
         // Make the expected data vector
         for (j = 0; j < number_of_bytes_in_full_burst; j=j+1) begin
            test_data[j*8 +: 8] = j+(i*number_of_bytes_in_full_burst);
         end
         mtestADDR = i*number_of_bytes_in_full_burst+SLAVE_ADDRESS;
         tb.master_0.READ_BURST(mtestID,
                                mtestADDR,
                                mtestBurstLength,
                                mtestBurstSize,
                                `BURST_TYPE_INCR,
                                mtestLockType,
                                mtestCacheType,
                                mtestProtectionType,
                                mtestRegion,
                                mtestQOS,
                                mtestARUSER,
                                rd_data,
                                vresponse,
                                v_ruser);
         
         $display("EXAMPLE TEST 1 : READ DATA = 0x%h, vresponse = 0x%h",rd_data,vresponse);
         
         tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
         tb.COMPARE_DATA(test_data,rd_data);
         tb.COMPARE_RUSER(0,v_ruser);
         
      end
         
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 1 : Full memory read finshed.");
      $display("---------------------------------------------------------");

      //---------------------------------------------------------------------
      // EXAMPLE TEST 2:
      // Write to the full memory with a count number in each transfer 
      // and then read it all back.
      //---------------------------------------------------------------------

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 2:");
      $display("Full memory write followed by a full memory read");
      $display("---------------------------------------------------------");
      
      mtestID = mtestID+1;
      mtestBurstLength = `MAX_BURST_LENGTH;
      number_of_bytes_in_full_burst = ((DATA_BUS_WIDTH/8)*(`MAX_BURST_LENGTH+1));
      // adjunstement made in order not to exceed 4KB Boundary
      if (number_of_bytes_in_full_burst > 4*1024) begin
          number_of_bytes_in_full_burst = 4*1024;
	  mtestBurstLength = ((4*1024)/(DATA_BUS_WIDTH/8))-1;
      end
      mtestCacheType = 0;
      mtestProtectionType = 0;
      mtestRegion = 1;
      mtestQOS = 1;
      mtestAWUSER = 1;
      mtestARUSER = 1;
      for (a = 0 ; a < (WUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1)); a=a+1) begin
         v_wuser[a] = 1;
      end
      
  
      for (i = 0; i < (SLAVE_MEM_SIZE-SLAVE_ADDRESS)/number_of_bytes_in_full_burst; i = i+1) begin
         // Make the test vector
         for (j = 0; j < (number_of_bytes_in_full_burst/(DATA_BUS_WIDTH/8)); j=j+1) begin
            test_data[j*DATA_BUS_WIDTH +: DATA_BUS_WIDTH] = j+(i*(DATA_BUS_WIDTH/8));
         end
         
         mtestADDR = i*number_of_bytes_in_full_burst+SLAVE_ADDRESS;

         tb.master_0.WRITE_BURST(mtestID,              
                                 mtestADDR,
                                 mtestBurstLength,
                                 mtestBurstSize,
                                 `BURST_TYPE_INCR,
                                 mtestLockType,
                                 mtestCacheType,
                                 mtestProtectionType,
                                 test_data,
                                 mtestdatasize,
                                 mtestRegion,
                                 mtestQOS,
                                 mtestAWUSER,
                                 v_wuser,
                                 response,
                                 mtestBUSER);
         $display("EXAMPLE TEST 2 : Burst %0d, WRITE DATA = 0x%h, response = 0x%h",i,test_data,response);

         tb.CHECK_RESPONSE_OKAY(response);
      end
      
 
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 2 : Full memory write finshed.");
      $display("---------------------------------------------------------");
      mtestID = mtestID+1;

      for (i = 0; i < (SLAVE_MEM_SIZE-SLAVE_ADDRESS)/number_of_bytes_in_full_burst; i = i+1) begin
         // Make the expected data vector
         for (j = 0; j < (number_of_bytes_in_full_burst/(DATA_BUS_WIDTH/8)); j=j+1) begin
            test_data[j*DATA_BUS_WIDTH +: DATA_BUS_WIDTH] = j+(i*(DATA_BUS_WIDTH/8));
         end
         
         mtestADDR = i*number_of_bytes_in_full_burst+SLAVE_ADDRESS;
         tb.master_0.READ_BURST(mtestID,
                                mtestADDR,
                                mtestBurstLength,
                                mtestBurstSize,
                                `BURST_TYPE_INCR,
                                mtestLockType,
                                mtestCacheType,
                                mtestProtectionType,
                                mtestRegion,
                                mtestQOS,
                                mtestARUSER,
                                rd_data,
                                vresponse,
                                v_ruser);
         
         $display("EXAMPLE TEST 2 : READ DATA = 0x%h, vresponse = 0x%h",rd_data,vresponse);
         
         tb.CHECK_RESPONSE_VECTOR_OKAY(vresponse,mtestBurstLength);
         tb.COMPARE_DATA(test_data,rd_data);
         tb.COMPARE_RUSER(0,v_ruser);
      end

      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST 2 : Full memory read finshed.");
      $display("---------------------------------------------------------");

      repeat(10) @(posedge tb.tb_ACLK);
      
      tb.REPORT_MASTER_STATUS(0);
      // Slave memory model model always has 2 pending tasks i.e. waiting
      // for the master to provide transfers:
      // One for the write data path and another for the read data path.
      tb.REPORT_SLAVE_STATUS(2);
      $display("---------------------------------------------------------");
      $display("EXAMPLE TEST : PASSED");
      $display("---------------------------------------------------------");
      $display("---------------------------------------------------------");
      $display("COMPLETE EXAMPLE TEST FINISHED!");
      $display("---------------------------------------------------------");
      $finish;
   end
   
endmodule
//----------------------------------------------------------------------------
// END OF FILE
//----------------------------------------------------------------------------
