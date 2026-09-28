#!/bin/python
import math

# with open("out.sv", "w+") as f:
#     f.write("\tinput logic unsigned [9:0] index;\n")
#     f.write("\toutput logic signed [23:0] out;\n")
#     f.write("\talways_comb begin\n")
#     f.write("\t\tcase(index)\n")
#     for i in range(1024):
#         f.write(f"\t\t\t{i}: output = 24'({ int(math.sin(2.0 * math.pi * i / 1024.0) * 2**23) });\n")
#     f.write("\t\t\tdefault: 0;\n")
#     f.write("\t\tendcase\n")
#     f.write("\tend\n")


#!/bin/python
import sys
import numpy as np
from scipy.io import wavfile as wf

DOWNSAMPLING_SCALAR = 4;

samplerate, data = wf.read(sys.argv[1])
samplerate = samplerate // DOWNSAMPLING_SCALAR
number_of_points = len(data) // DOWNSAMPLING_SCALAR
print(f"Sample rate: {samplerate}")

print(f"Number of points: {number_of_points}")

print(f"Counter soft limit: {50_000_000 // samplerate}")
print(f"Counter hard limit: {(50_000_000 // samplerate) * number_of_points}")

with open(sys.argv[2], "wb") as f:
    for i in range(len(data)):
        f.write(int(data[i]).to_bytes(2, signed=True))

with open(sys.argv[3], "w") as f:
    f.write(f"module {sys.argv[4]}(index, out);\n")
    f.write(f"\tinput logic unsigned [{math.ceil(math.log(number_of_points, 2)) - 1}:0] index;\n")
    f.write("\toutput logic signed [15:0] out;\n")
    f.write("\talways_comb begin\n")
    f.write("\t\tcase(index)\n")
    for i in range(0, len(data), DOWNSAMPLING_SCALAR):
        f.write(f"\t\t\t{i // DOWNSAMPLING_SCALAR}: out = 16'({data[i]});\n")
    f.write("\t\t\tdefault: out = 0;\n")
    f.write("\t\tendcase\n")
    f.write("\tend\n")
    f.write("endmodule\n")