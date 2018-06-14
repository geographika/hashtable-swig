%module mapscript

%{
#include "maphash.h"
%}

/* ========================================================================
 * Include maphash header, first stating declarations to ignore
 * ======================================================================== */

/* ignore the hashObj struct */
%ignore hashObj;

/* ignore items and make numitems immutable */
%ignore items;
%immutable numitems;

%include "maphash.h"





/*
 * Typemap hashTableObj* -> dict
 */
%typemap(out) hashTableObj*
{
  /* %typemap(out) hashTableObj* */
  const char* key;
  hashTableObj *hashTable = $1;
  $result = PyDict_New();
  key = msFirstKeyFromHashTable(hashTable);
  while( key )
  {
    const char* val = msLookupHashTable(hashTable, key);
    if( val )
    {
%#if PY_VERSION_HEX >= 0x03000000
        PyObject *py_key = PyUnicode_FromString(key);
        PyObject *py_val = PyUnicode_FromString(val);
%#else
        PyObject *py_key = PyString_FromString(key);
        PyObject *py_val = PyString_FromString(val);
%#endif

        PyDict_SetItem($result, py_key, py_val );
        Py_DECREF(py_key);
        Py_DECREF(py_val);
    }
    key = msNextKeyFromHashTable(hashTable, key);
  }
}

%typemap(freearg) hashTableObj*
{
  /* %typemap(freearg) hashTableObj* */
  msFreeHashTable( $1 );
}
