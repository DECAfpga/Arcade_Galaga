cat 3200a.bin 3300b.bin 3400c.bin 3500d.bin > galaga_cpu1.bin
./make_vhdl_prom  galaga_cpu1.bin galaga_cpu1.vhd
./make_vhdl_prom  3600e.bin       galaga_cpu2.vhd
./make_vhdl_prom  3700g.bin       galaga_cpu3.vhd

##### difficult to find 2600j.bin 2800l.bin 2700k.bin 
./make_vhdl_prom  2600j.bin       bg_graphx.vhd
cat 2800l.bin 2700k.bin > sp_graphx.bin
./make_vhdl_prom  sp_graphx.bin   sp_graphx.vhd

./make_vhdl_prom  prom-5.5n       rgb.vhd
./make_vhdl_prom  prom-4.2n       bg_palette.vhd
./make_vhdl_prom  prom-3.1c       sp_palette.vhd
./make_vhdl_prom  prom-2.5c       sound_seq.vhd
./make_vhdl_prom  prom-1.1d       sound_samples.vhd
./make_vhdl_prom 54xx.bin        cs54xx_prog.vhd
rm galaga_cpu1.bin
rm sp_graphx.bin
