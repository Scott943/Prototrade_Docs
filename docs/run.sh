#!/bin/bash
for f in source/*.rst; do
   if [ f != "source/index.rst" ] && [ f != "source/modules.rst" ] 
   then
      echo "File -> $f"
   fi

  
done

sphinx-apidoc -f -o source ../../3rd_year_project/prototrade/src/prototrade && make github && git add ../ && git commit -m "Update docs" && git push