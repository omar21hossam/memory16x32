all: compile sim
compile:
	vlib work
	vlog -sv memory16x32.sv memory16x32_tb.sv 
sim:
	vsim -logfile sim.log -c -wlf Memory_file.wlf -voptargs="+acc" -do "run -all" work.memory_tb
    # Ensure the .wlf file is generated
	vcd2wlf Memory_file.vcd Memory_file.wlf

wave:
	vsim work.memory_tb -voptargs=+acc
