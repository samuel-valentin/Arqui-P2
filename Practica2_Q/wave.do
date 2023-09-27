onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Practica2_TB/DUV/PROGRAM_MEMORY/Instruction_o
add wave -noupdate /Practica2_TB/DUV/PROGRAM_COUNTER/PC_Value
add wave -noupdate -expand -group ra /Practica2_TB/DUV/REGISTER_FILE_UNIT/Register_ra/DataOutput
add wave -noupdate -expand -group sp /Practica2_TB/DUV/REGISTER_FILE_UNIT/Register_sp/DataOutput
add wave -noupdate -expand -group {Torre A} {/Practica2_TB/DUV/Data_Memory/ram[3]}
add wave -noupdate -expand -group {Torre A} {/Practica2_TB/DUV/Data_Memory/ram[2]}
add wave -noupdate -expand -group {Torre A} {/Practica2_TB/DUV/Data_Memory/ram[1]}
add wave -noupdate -expand -group {Torre B} {/Practica2_TB/DUV/Data_Memory/ram[11]}
add wave -noupdate -expand -group {Torre B} {/Practica2_TB/DUV/Data_Memory/ram[10]}
add wave -noupdate -expand -group {Torre B} {/Practica2_TB/DUV/Data_Memory/ram[9]}
add wave -noupdate -expand -group {Torre C} {/Practica2_TB/DUV/Data_Memory/ram[19]}
add wave -noupdate -expand -group {Torre C} {/Practica2_TB/DUV/Data_Memory/ram[18]}
add wave -noupdate -expand -group {Torre C} {/Practica2_TB/DUV/Data_Memory/ram[17]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 84
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {26 ns}
