quit -sim

vlib work

vcom -reportprogress 300 -work work {./cont_4.vhd}
vcom -reportprogress 300 -work work {./cont_mod_60.vhd}
vcom -reportprogress 300 -work work {./cont_mod_100.vhd}
vcom -reportprogress 300 -work work {./cronometro.vhd}
vcom -reportprogress 300 -work work {./dec_bcd_7seg.vhd}
vcom -reportprogress 300 -work work {./divisor.vhd}
vcom -reportprogress 300 -work work {./maquina_de_estados.vhd}
vcom -reportprogress 300 -work work {./top_level.vhd}

vsim -voptargs=+acc work.cronometro_tb
add wave -position insertpoint sim:/cronometro_tb/*
run 100 ns