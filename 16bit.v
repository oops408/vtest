`timescale 1ns / 1ps

module processor (
  input wire clk,
  input wire reset,
  input wire [15:0] instruction,
  input wire [15:0] data_in,
  output wire [15:0] data_out,
  output wire [3:0] ALU_op,
  output wire [15:0] ALU_A,
  output wire [15:0] ALU_B,
  output wire mem_read,
  output wire mem_write,
  output wire [15:0] mem_address
);
  
  reg [15:0] PC, A, B, R, ALU_out;
  reg [3:0] opcode, func;
  reg mem_read_reg, mem_write_reg;
  reg [15:0] mem_address_reg;
  
  always @(posedge clk) begin
    if (reset) begin
      PC <= 0;
      A <= 0;
      B <= 0;
      R <= 0;
    end else begin
      opcode <= instruction[15:12];
      func <= instruction[11:8];
      case (opcode)
        4'b0000: begin
          PC <= PC + 1;
          mem_read_reg <= 1;
          mem_address_reg <= PC;
        end
        4'b0001: begin
          A <= data_in;
        end
        4'b0010: begin
          B <= data_in;
        end
        4'b0011: begin
          ALU_A <= A;
          ALU_B <= B;
          ALU_op <= func;
        end
        4'b0100: begin
          R <= ALU_out;
        end
        4'b0101: begin
          mem_write_reg <= 1;
          mem_address_reg <= A;
          data_out <= R;
        end
        4'b0110: begin
          PC <= R;
        end
        4'b0111: begin
          PC <= PC + 1;
        end
        default: begin
          PC <= PC;
        end
      endcase
    end
  end
  
  assign mem_read = mem_read_reg;
  assign mem_write = mem_write_reg;
  assign mem_address = mem_address_reg;
  
  always @(*) begin
    case (ALU_op)
      4'b0000: ALU_out <= ALU_A + ALU_B;
      4'b0001: ALU_out <= ALU_A - ALU_B;
      4'b0010: ALU_out <= ALU_A & ALU_B;
      4'b0011: ALU_out <= ALU_A | ALU_B;
      4'b0100: ALU_out <= ALU_A ^ ALU_B;
      4'b0101: ALU_out <= ALU_A <<< ALU_B;
      4'b0110: ALU_out <= ALU_A >>> ALU_B;
      default: ALU_out <= 0
