#!/bin/bash

clear

cd app

echo "Removing CSS, JS and HTML files..."
rm -rf css js index.html app.html

echo "Making CSS folder..."
mkdir css

echo "Making JS folder..."
mkdir js