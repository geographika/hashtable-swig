#include <stdio.h>
#include "maphash.h"

int main(void)
{
    hashTableObj* hashTable = msCreateHashTable();
    //initHashTable(hashTable);

    if (msInsertHashTable(hashTable, "key1", "value") == NULL) {
        printf("Could not insert");
    }
    else {
        printf("Value added");
    }

    const char* key = msFirstKeyFromHashTable(hashTable);
    printf(key);

    const char* val = msLookupHashTable(hashTable, "key1");



    if (val) {
        printf("The result is %s\n", val);
    }
    else {
        printf("No result found");
    }
    msFreeHashTable(hashTable);

    return 0;
}