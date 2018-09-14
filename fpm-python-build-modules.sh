PYTHON_VERSION=${1?PYTHON Version is required}


if [[ $PYTHON_VERSION == "2.7" ]] ; then

##package python lib using 2.7 version
fpm -s python --python-bin /opt/python$PYTHON_VERSION/bin/python$PYTHON_VERSION --python-easyinstall /opt/python$PYTHON_VERSION/bin/easy_install-$PYTHON_VERSION -t rpm --python-package-name-prefix custom-python-$PYTHON_VERSION $PYTHON_LIB

elif [[ $PYTHON_VERSION == "3.4" ]] ; then

##package python lib using 3.4 version
fpm -s python --python-bin /opt/python$PYTHON_VERSION/bin/python$PYTHON_VERSION --python-easyinstall /opt/python$PYTHON_VERSION/bin/easy_install-$PYTHON_VERSION -t rpm --python-package-name-prefix custom-python-$PYTHON_VERSION $PYTHON_LIB

elif [[ $PYTHON_VERSION == "3.5" ]] ; then

##package python lib using 3.5 version
fpm -s python --python-bin /opt/python$PYTHON_VERSION/bin/python$PYTHON_VERSION --python-easyinstall /opt/python$PYTHON_VERSION/bin/easy_install-$PYTHON_VERSION -t rpm --python-package-name-prefix custom-python-$PYTHON_VERSION $PYTHON_LIB
fi

##gathering dependencies for main python lib.  Packaging those as well!!!

rpm -qpR *.rpm | grep acx |  cut -f1 -d ' ' > list.out
rpm -qpR *.rpm > dep.out
listOfDeps=`cat list.out | cut -d '-' -f 4-`

if [ -z "$listOfDeps" ];then

echo "no deps for $PYTHON_LIB"

else

for depName in $listOfDeps
do 
  echo $depName
  fpm -s python --python-bin /opt/python$PYTHON_VERSION/bin/python$PYTHON_VERSION --python-easyinstall /opt/python$PYTHON_VERSION/bin/easy_install-$PYTHON_VERSION -t rpm --python-package-name-prefix custom-python-$PYTHON_VERSION $depName 
done

fi
