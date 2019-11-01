# Pass FNAME name with "FNAME=xxx" command line argument
lint:
	vcs -full64 \
	-sverilog $(FNAME) \
	-timescale=1ns/10ps +neg_tchk +lint=PCWM -notice; \
	rm -rf ./tmp_*

#clean:
#	rm -rf ./tmp_*

clean:
	\rm -rf simv* *.log *.vpd *.dump csrc *.sim *.mra *.log ucli.key session* *.db vcs.key 
