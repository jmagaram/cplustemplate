<h1>VS Code C++ Starter for Windows</h1>
<h2>Make and make files</h2>
<p>Makefile might need to be executed using bash shell. Not sure other shells will work. Set default shell to bash.</p>
<p>The Make (make.exe) command utility can be downloaded and installed separately from the gcc compiler. But it also seems to be included in the compiler bin folder with the name mingw32-make.exe. So I just copied that file to the same folder with the name make.exe.</p>
<h2>Testing</h2>
<p>Test framework from **Doctest** (https://github.com/onqtam/doctest/blob/master/doc/markdown/readme.md#reference) which is super simple since you just include a single .h file to get it working.</p>
<p>Using this extension to easily find and run tests. (https://marketplace.visualstudio.com/items?itemName=matepek.vscode-catch2-test-adapter)</p>
<p>If the extension doesn't find your tests, make sure the search path is correct. In Settings, search for `testmate path`</p>
<h2>Build tasks Ctrl+Shift+B</h2>
<p>Check these out. Several options easily accessible from the keyboard shortcut.</p>
<p>These are configured to work only if the default shell is bash.</p>
