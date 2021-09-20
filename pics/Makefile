

# width paper 21.0 cm 
# we set 10 cm in packages.tex

pictures=$(wildcard chapter-*.jpg)

targets=$(patsubst %.jpg,%.cropped.jpeg,$(pictures))

# pictures:=$(shell find . -regextype posix-extended -regex 'chapter-\w+.jpg')

all: 
	echo pictures = $(pictures)
	echo targets = $(targets)

convert: $(targets)

%.cropped.jpeg: %.jpg
	magick convert $< -gravity center -crop 210:120 $@


