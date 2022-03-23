import os

for entry in os.environ:
    print(entry, '=', os.environ[entry])

    