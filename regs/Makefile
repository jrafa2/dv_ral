default: ral
all: ral rtl doc xml c

clean:
	rm -rf regs.sv regs.xml regs.h regs html

ral:
	peakrdl uvm regs.rdl -o regs.sv

rtl:
	peakrdl regblock regs.rdl -o regs

doc:
	peakrdl html regs.rdl -o html

xml:
	peakrdl ip-xact regs.rdl -o regs.xml

c:
	peakrdl c-header regs.rdl -o regs.h