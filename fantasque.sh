#!/bin/zsh
fonts=('FantasqueSansMono-BoldItalic.ttf' 'FantasqueSansMono-RegItalic.ttf' 'FantasqueSansMono-Regular.ttf')
fonts_dir='./fonts/'

for font in $fonts; do

	echo patching font: ${fonts_dir}${font} 

	cp ${fonts_dir}${font} S0.ttf
	./patch S0.ttf --symbols=./fonts/fontawesome-webfont.ttf --to-namespace=AWESOME --rename-as=S1 --starting-at='0xe100' --ratio=0.8 --shift-x=100 --shift-y=50
	./patch S1.ttf --symbols=./fonts/octicons-regular.ttf --to-namespace=OCTICONS --rename-as=S2 --starting-at='0xe800' --ratio=0.8 --shift-y=25
	./patch S2.ttf --symbols=./fonts/pomicons-regular.ttf --to-namespace=POMICONS --rename-as=${font}'+Powerline+Awesome' --starting-at='0xf000' --ratio=0.75 --shift-x=-100 --shift-y=25
	cat S1.sh S2.sh >>${font}+Powerline+Awesome.sh
	cp ${font}+Powerline+Awesome.* ~/.fonts
	mv ${font}+Powerline+Awesome.* ./patched
	sudo fc-cache -rv
	rm -rf S?.*

done


