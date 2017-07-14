

# Prepends USE STRICT;

The current perl script reads multiple files from a directory and then verify each file to contain the "use strict;" statement otherwise is prepended after the first comment block of the file (if exists any). If the statement is already declared, perl will skip the file.

![assets/example.gif](assets/example.gif)

#### usage:

the argumento 0 should contains a glob regex pattern which is used to read the files.

```
perl main.pl "./path/to/directory/*"
```

