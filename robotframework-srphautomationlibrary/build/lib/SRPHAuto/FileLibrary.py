from pathlib import Path
from typing import NamedTuple
from robot.api.deco import keyword

class Directory(NamedTuple):
    """Robot Framework friendly container for directories."""

    path: str
    name: str

    def __str__(self):
        return self.path

    def __fspath__(self):
        # os.PathLike interface
        return self.path
    
    @classmethod
    def from_path(cls, path):
        """Create directory object from pathlib.Path or path string."""
        path = Path(path)
        return cls(str(path.resolve()), path.name)

class File(NamedTuple):
    """Robot Framework friendly container for files."""

    path: str
    name: str
    size: int
    mtime: str

    def __str__(self):
        return self.path

    def __fspath__(self):
        # os.PathLike interface
        return self.path

    @classmethod
    def from_path(cls, path):
        """Create File object from pathlib.Path or path string."""
        path = Path(path)
        stat = path.stat()
        return cls(
            path=str(path.resolve()),
            name=path.name,
            size=stat.st_size,
            mtime=stat.st_mtime,
        )

class FileLibrary:

    @keyword("Find Files")
    def find_files(self, pattern, include_dirs=True, include_files=True):
        """Find files recursively according to a pattern.
        :param pattern:         search path in glob format pattern,
                                e.g. *.xls or **/orders.txt
        :param include_dirs:    include directories in results (defaults to True)
        :param include_files:   include files in results (defaults to True)
        :return:                list of paths that match the pattern
        Example:
        .. code-block:: robotframework
            *** Tasks  ***
            Finding files recursively
                ${files}=    Find files    **/*.log
                FOR    ${file}    IN    @{files}
                    Read file    ${file}
                END
        """
        pattern = Path(pattern)

        if pattern.is_absolute():
            root = Path(pattern.anchor)
            parts = pattern.parts[1:]
        else:
            root = Path.cwd()
            parts = pattern.parts

        pattern = str(Path(*parts))
        matches = []
        for path in root.glob(pattern):
            if path == root:
                continue

            if path.is_dir() and include_dirs:
                matches.append(Directory.from_path(path))
            elif path.is_file() and include_files:
                matches.append(File.from_path(path))

        return sorted(matches)