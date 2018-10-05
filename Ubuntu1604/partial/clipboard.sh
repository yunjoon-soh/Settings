#!/bin/bash
sudo apt install xsel
echo "alias pbcopy='xsel --clipboard --input'" >> ~/.bash_aliases
echo "alias pbpaste='xsel --clipboard --output'" >> ~/.bash_aliases

