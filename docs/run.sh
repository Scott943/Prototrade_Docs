#!/bin/bash
for f in source/*.rst; do
   if [ f != "index.rst" ] || [ f != "modules.rst" ] 
   then
      echo "File -> $f"
   fi

  
done

sphinx-apidoc -f -o source ../../3rd_year_project/prototrade/src/prototrade && make github && git add ../ && git commit -m "Update docs" && git push