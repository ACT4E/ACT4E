

# width paper 21.0 cm 
# we set 10 cm in packages.tex

pictures=$(wildcard chapter-*.jpg)

targets=$(patsubst %.jpg,%.cropped.jpeg,$(pictures))

# pictures:=$(shell find . -regextype posix-extended -regex 'chapter-\w+.jpg')

all: 
	echo pictures = $(pictures)
	echo targets = $(targets)

convert: $(targets)

# there are 8.2 inches on the page. 300 ppi target 
# 300 * 8.2 = 2460
%.cropped.jpeg: %.jpg
	magick convert $< -gravity center -crop 210:120 -resize 2500x -quality 85% $@


