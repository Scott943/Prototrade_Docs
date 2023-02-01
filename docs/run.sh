#!/bin/bash
 
sphinx-apidoc -f -o source ../../3rd_year_project/prototrade/src/prototrade && make github && git add ../ && git commit -m "Update docs" && git push