all: compile sim
compile:
	vlib work
	vlog -sv memory16x32.sv memory16x32_tb.sv 
sim:
	vsim -logfile sim.log -c -do "run -all" work.memory_tb
