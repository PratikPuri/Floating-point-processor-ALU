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
// This file is a simple testbench for the AXI BFMs.
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
// Required timescale.
//----------------------------------------------------------------------------
`timescale 1ns / 1ps

//----------------------------------------------------------------------------
// Local Defines.
//----------------------------------------------------------------------------

// Burst Type Defines
`define BURST_TYPE_FIXED 2'b00
`define BURST_TYPE_INCR  2'b01
`define BURST_TYPE_WRAP  2'b10

// Burst Size Defines
`define BURST_SIZE_1_BYTE    3'b000
`define BURST_SIZE_2_BYTES   3'b001
`define BURST_SIZE_4_BYTES   3'b010
`define BURST_SIZE_8_BYTES   3'b011
`define BURST_SIZE_16_BYTES  3'b100
`define BURST_SIZE_32_BYTES  3'b101
`define BURST_SIZE_64_BYTES  3'b110
`define BURST_SIZE_128_BYTES 3'b111

// Lock Type Defines
`define LOCK_TYPE_NORMAL    1'b0
`define LOCK_TYPE_EXCLUSIVE 1'b1

// Response Type Defines
`define RESPONSE_OKAY 2'b00
`define RESPONSE_EXOKAY 2'b01
`define RESPONSE_SLVERR 2'b10
`define RESPONSE_DECERR 2'b11

// AMBA AXI 4 Bus Size Constants
`define LENGTH_BUS_WIDTH 8
`define SIZE_BUS_WIDTH 3
`define BURST_BUS_WIDTH 2
`define LOCK_BUS_WIDTH 1
`define CACHE_BUS_WIDTH 4
`define PROT_BUS_WIDTH 3
`define RESP_BUS_WIDTH 2
`define QOS_BUS_WIDTH 4
`define REGION_BUS_WIDTH 4
  
// AMBA AXI 4 Range Constants
`define MAX_BURST_LENGTH 8'b1111_1111
`define MAX_DATA_SIZE (DATA_BUS_WIDTH*(`MAX_BURST_LENGTH+1))/8

// Required for test of WRAP and FIXED max bursts lengths
`define AXI3_MAX_BURST_LENGTH 8'b0000_1111

// Message defines
`define MSG_WARNING WARNING
`define MSG_INFO    INFO
`define MSG_ERROR   ERROR

// Define for intenal control value
`define ANY_ID_NEXT 100
`define IDVALID_TRUE  1'b1
`define IDVALID_FALSE 1'b0


//----------------------------------------------------------------------------
// Create the testbench.
//----------------------------------------------------------------------------

module cdn_axi4_example_tb;
   
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
   parameter SLAVE_MEM_SIZE = 4;
   parameter MAX_OUTSTANDING_TRANSACTIONS = 8;
   parameter MEMORY_MODEL_MODE = 0;
   parameter EXCLUSIVE_ACCESS_SUPPORTED = 1;
   
   //------------------------------------------------------------------------
   // Other testbench signals
   //------------------------------------------------------------------------
   
   reg tb_ACLK;
   reg tb_ARESETn;

   //------------------------------------------------------------------------
   // Add an instance of the AXI 4 MASTER BFM
   //------------------------------------------------------------------------
   cdn_axi4_master_bfm #(MASTER_NAME,
                         DATA_BUS_WIDTH,
                         ADDRESS_BUS_WIDTH,
                         ID_BUS_WIDTH,
                         AWUSER_BUS_WIDTH,
                         ARUSER_BUS_WIDTH,
                         RUSER_BUS_WIDTH,
                         WUSER_BUS_WIDTH,
                         BUSER_BUS_WIDTH,
                         MAX_OUTSTANDING_TRANSACTIONS,
                         EXCLUSIVE_ACCESS_SUPPORTED)
   master_0(.ACLK    (tb_ACLK),
            .ARESETn (tb_ARESETn),
            // Write Address Channel
            .AWID    (slave_0.AWID),
            .AWADDR  (slave_0.AWADDR),
            .AWLEN   (slave_0.AWLEN),
            .AWSIZE  (slave_0.AWSIZE),
            .AWBURST (slave_0.AWBURST),
            .AWLOCK  (slave_0.AWLOCK),
            .AWCACHE (slave_0.AWCACHE),
            .AWPROT  (slave_0.AWPROT),
            .AWREGION(slave_0.AWREGION),
            .AWQOS   (slave_0.AWQOS),
            .AWUSER  (slave_0.AWUSER),
            .AWVALID (slave_0.AWVALID),
            .AWREADY (slave_0.AWREADY),
            // Write Data Channel Signals.
            .WDATA  (slave_0.WDATA),
            .WSTRB  (slave_0.WSTRB), 
            .WLAST  (slave_0.WLAST), 
            .WUSER  (slave_0.WUSER),
            .WVALID (slave_0.WVALID),
            .WREADY (slave_0.WREADY),
            // Write Response Channel Signals.
            .BID    (slave_0.BID),
            .BRESP  (slave_0.BRESP),
            .BUSER  (slave_0.BUSER),
            .BVALID (slave_0.BVALID),
            .BREADY (slave_0.BREADY),
            // Read Address Channel Signals.
            .ARID    (slave_0.ARID),
            .ARADDR  (slave_0.ARADDR),
            .ARLEN   (slave_0.ARLEN),
            .ARSIZE  (slave_0.ARSIZE),
            .ARBURST (slave_0.ARBURST),
            .ARLOCK  (slave_0.ARLOCK),
            .ARCACHE (slave_0.ARCACHE),
            .ARPROT  (slave_0.ARPROT),
            .ARREGION(slave_0.ARREGION),
            .ARQOS   (slave_0.ARQOS),
            .ARUSER  (slave_0.ARUSER),
            .ARVALID (slave_0.ARVALID),
            .ARREADY (slave_0.ARREADY),
            // Read Data Channel Signals.
            .RID    (slave_0.RID),
            .RDATA  (slave_0.RDATA),
            .RRESP  (slave_0.RRESP),
            .RLAST  (slave_0.RLAST),
            .RUSER  (slave_0.RUSER),
            .RVALID (slave_0.RVALID),
            .RREADY (slave_0.RREADY));
   
   //------------------------------------------------------------------------
   // Add an instance of the AXI 4 SLAVE BFM
   //------------------------------------------------------------------------
   cdn_axi4_slave_bfm #(SLAVE_NAME,
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
                        EXCLUSIVE_ACCESS_SUPPORTED)
   slave_0(.ACLK    (tb_ACLK),
           .ARESETn (tb_ARESETn),
           // Write Address Channel
           .AWID    (master_0.AWID),
           .AWADDR  (master_0.AWADDR),
           .AWLEN   (master_0.AWLEN),
           .AWSIZE  (master_0.AWSIZE),
           .AWBURST (master_0.AWBURST),
           .AWLOCK  (master_0.AWLOCK),
           .AWCACHE (master_0.AWCACHE),
           .AWPROT  (master_0.AWPROT),
           .AWREGION(master_0.AWREGION),
           .AWQOS   (master_0.AWQOS),
           .AWUSER  (master_0.AWUSER),
           .AWVALID (master_0.AWVALID),
           .AWREADY (master_0.AWREADY),
           // Write Data Channel Signals.
           .WDATA  (master_0.WDATA),
           .WSTRB  (master_0.WSTRB), 
           .WLAST  (master_0.WLAST), 
           .WUSER  (master_0.WUSER),
           .WVALID (master_0.WVALID),
           .WREADY (master_0.WREADY),
           // Write Response Channel Signals.
           .BID    (master_0.BID),
           .BRESP  (master_0.BRESP),
           .BUSER  (master_0.BUSER),
           .BVALID (master_0.BVALID),
           .BREADY (master_0.BREADY),
           // Read Address Channel Signals.
           .ARID    (master_0.ARID),
           .ARADDR  (master_0.ARADDR),
           .ARLEN   (master_0.ARLEN),
           .ARSIZE  (master_0.ARSIZE),
           .ARBURST (master_0.ARBURST),
           .ARLOCK  (master_0.ARLOCK),
           .ARCACHE (master_0.ARCACHE),
           .ARPROT  (master_0.ARPROT),
           .ARREGION(master_0.ARREGION),
           .ARQOS   (master_0.ARQOS),
           .ARUSER  (master_0.ARUSER),
           .ARVALID (master_0.ARVALID),
           .ARREADY (master_0.ARREADY),
           // Read Data Channel Signals.
           .RID    (master_0.RID),
           .RDATA  (master_0.RDATA),
           .RRESP  (master_0.RRESP),
           .RLAST  (master_0.RLAST),
           .RUSER  (master_0.RUSER),
           .RVALID (master_0.RVALID),
           .RREADY (master_0.RREADY));
   
   
   //------------------------------------------------------------------------
   // Include Test Level API
   //------------------------------------------------------------------------
   `include "cdn_axi_test_level_api.v"

   //------------------------------------------------------------------------
   // Simple Reset Generator and test
   //------------------------------------------------------------------------

   initial begin
      
      tb_ARESETn = 1'b1;
      #10 tb_ARESETn = 1'b0;
      #50;
      // Release the reset on the posedge of the clk.
      @(posedge tb_ACLK);
      tb_ARESETn = 1'b1;
      @(posedge tb_ACLK);
   end

   
   //------------------------------------------------------------------------
   // Simple Clock Generator
   //------------------------------------------------------------------------
   initial tb_ACLK = 1'b0;
   always #10 tb_ACLK = !tb_ACLK;

   //------------------------------------------------------------------------
   // TEST BENCH LEVEL API: REPORT_MASTER_STATUS
   //------------------------------------------------------------------------
   // Description:
   // REPORT_MASTER_STATUS(number_of_expected_errors_warnings_and_pending)
   // This task calls the masters report_status function which returns the 
   // total of the errors + warnings + pending counters. This return number 
   // is compared with the input 
   // number_of_expected_errors_warnings_and_pending
   //------------------------------------------------------------------------
   task automatic REPORT_MASTER_STATUS;
      input integer number_of_expected_errors_warnings_and_pending;
      integer       result;
      begin
         result = tb.master_0.report_status(0);
         if (result != number_of_expected_errors_warnings_and_pending) begin
            $display("-------------------------------------------------------");
            $display("EXAMPLE TEST : MASTER FAILED");
            $display("-------------------------------------------------------");
            $finish;
         end
         else begin
            $display("-------------------------------------------------------");
            $display("EXAMPLE TEST : MASTER PASSED");
            $display("-------------------------------------------------------");
         end
      end
   endtask
   
   //------------------------------------------------------------------------
   // TEST BENCH LEVEL API: REPORT_SLAVE_STATUS
   //------------------------------------------------------------------------
   // Description:
   // REPORT_SLAVE_STATUS(number_of_expected_errors_warnings_and_pending)
   // This task calls the slaves report_status function which returns the 
   // total of the errors + warnings + pending counters. This return number 
   // is compared with the input 
   // number_of_expected_errors_warnings_and_pending
   //------------------------------------------------------------------------
   task automatic REPORT_SLAVE_STATUS;
      input integer number_of_expected_errors_warnings_and_pending;
      integer       result;
      begin
         result = tb.slave_0.report_status(0);
         if (result != number_of_expected_errors_warnings_and_pending) begin
            $display("-------------------------------------------------------");
            $display("EXAMPLE TEST : SLAVE FAILED");
            $display("-------------------------------------------------------");
            $finish;
         end
         else begin
            $display("-------------------------------------------------------");
            $display("EXAMPLE TEST : SLAVE PASSED");
            $display("-------------------------------------------------------");
         end
      end
   endtask

//------------------------------------------------------------------------
// TEST LEVEL API: COMPARE_WUSER
//------------------------------------------------------------------------
// Description:
// COMPARE_WUSER(expected,actual)
// This task checks if the actual wuser data is equal to the expected data.
// X is used as don't care but it is not permitted for the full vector
// to be don't care.
//------------------------------------------------------------------------
task automatic COMPARE_WUSER;
   input [(WUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] expected;
   input [(WUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] actual;
   begin
      if (expected === 'hx || actual === 'hx) begin
         $display("TESTBENCH ERROR! COMPARE_WUSER cannot be performed with an expected or actual vector that is all 'x'!");
         $stop;
      end
      
      if (actual != expected) begin
         $display("TESTBENCH ERROR! WUSER data expected is not equal to actual.",
                  "\n expected = 0x%h",expected,
                  "\n actual   = 0x%h",actual);
         $stop;
      end
   end
endtask

//------------------------------------------------------------------------
// TEST LEVEL API: COMPARE_RUSER
//------------------------------------------------------------------------
// Description:
// COMPARE_RUSER(expected,actual)
// This task checks if the actual wuser data is equal to the expected data.
// X is used as don't care but it is not permitted for the full vector
// to be don't care.
//------------------------------------------------------------------------
task automatic COMPARE_RUSER;
   input [(RUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] expected;
   input [(RUSER_BUS_WIDTH*(`MAX_BURST_LENGTH+1))-1:0] actual;
   begin
      if (expected === 'hx || actual === 'hx) begin
         $display("TESTBENCH ERROR! COMPARE_RUSER cannot be performed with an expected or actual vector that is all 'x'!");
         $stop;
      end
      
      if (actual != expected) begin
         $display("TESTBENCH ERROR! RUSER data expected is not equal to actual.",
                  "\n expected = 0x%h",expected,
                  "\n actual   = 0x%h",actual);
         $stop;
      end
   end
endtask
   
endmodule

//----------------------------------------------------------------------------
// END OF FILE
//----------------------------------------------------------------------------
