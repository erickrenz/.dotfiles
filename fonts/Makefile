UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S), Linux) 
	TARGET_DIR := /home/ekrenz/.local/share/fonts/ 
endif
ifeq ($(UNAME_S), Darwin) 
	TARGET_DIR := /Users/erickrenz/.local/share/fonts/ 
endif

all:
	stow --verbose --target=$(TARGET_DIR) --restow */

clean:
	stow --verbose --target=$(TARGET_DIR) --delete */
