# Vim Cheat sheet

## Search

### Search characters

    ^    Beginning of the line.
    .    Matches a single character. 
    *    Matches zero or more of the previous character. 
    $    End of the line.
    [    Starts a set of matching (or non-matching) /f[iae]t or /a[^bcd] 
    <    Escape with the backslash to find the ending or beginning of a word. 
    >    As above.

### Search and replace

    :32,56s/guy/gal/g                     Search and replace from line 32 to 56 
    :%s/search_string/replace_string/g    Search and replace entire doc 

#### Global search and replace

Define a list of tasks to do using the command `args`. Then execute a command using `argdo` 

First I will apply the substitute 's' command and then 'update' which will only save the modified files.

    :args app/views/*/*
    :argdo %s/old_string/new_string/gec | update

    The 'e' flag stops Vim alerting if it didn't find the pattern
    The 'c' flag will make Vim ask confirmation before each substitution.

## Movement

    →   ←   description
    --------------------
    /   ?   search for a pattern of text, jump to it by hitting Enter (<CR>)
    *   #   search for the word under cursor
    n   N   jump to the next match for the previous search
    $   ^   position cursor at end of current line
    f   F   position cursor on the character in the same line that matches the next keystroke
    t   T   position cursor before the next character that matches the keystroke
    ;   ,   repeat the last f, F, t, or T
    w   b   move to start of next word
    W   B   move to start of next "WORD" (sequence of non-blank characters)
    }   {   move down one paragraph (block of text separated by blank lines)
      gg    jump to first line of document
      G     jump to end of document
      gf    go to file under cursor
      gd    go to local definition
    ctrl-b  page up
    ctrl-f  page down
    ctrl-d  half page down
    ctrl-u  half page up
    ctrl-G  show current line
      ^^    go back to the last file edited. 

### Method navigation

    ]m  Go to next start of a method definition
    ]M  Go to next end of a method definition
    [m  Go to previous start of a method definition
    [M  Go to previous end of a method definition


### Jumps

A "jump" is one of the following commands: 

    "'", "`", "G", "/", "?", "n", "N", "%", "(", ")", "[[", "]]", "{", "}", ":s", ":tag", "L", "M", "H"

    and the commands that start editing a new file.

If you make the cursor "jump" with one of these commands, the position of the cursor before the jump is remembered.

You can return to that position with the _''_ and _``_ command, unless the line containing that position was changed or deleted.

## Insert mode

    i     insert before character under cursor
    a     insert after cursor
    I     insert at beginning of current line
    A     insert at end of the line
    o     starts insert mode in a new line below current one
    O     insert in a new line above current one
    ciw   ("change inner word") change word under cursor
    ci"   change double-quoted string (but keep the quotes)
    ci(   change text between matching parentheses, also works with brackets
    cc    change whole line
    ysiw] add [ around a word without a space
    ysiw[ add [ around a word with a space
    cst"  change surrounding html tags to quotes
    >>    Indent lines
    S<p>  add <p> tags around visually selected text

## Yank

    P    Paste the specified buffer before the current cursor position or line.
    Y    Yank the current line into the specified buffer. 
    y}   yank until end of paragraph

### Registers

    "aY  yank current line into register "a"
    "ap  paste from register "a"
    "*Y  yank line into special register "*" which is the system clipboard
    "*p  paste from register "*": the system clipboard
    "_D  delete from cursor until the end of line, but don't copy


## Delete 

    D    delete to the end of the line from the current cursor position. 
    d^   deletes from current cursor position to the beginning of the line. 
    d$   deletes from current cursor position to the end of the line. 
    dw   deletes from current cursor position to the end of the word. 
    3dd  deletes three lines from current cursor position downwards. 
    X    delete the character before the cursor. 
    x    delete character under the cursor.

## Windows 

    ctrl+w s      horizontal split
    ctrl+w v      vertical split
    ctrl+w w      switch to previous window
    ctrl+w arrow  switch to window
    ctrl+w +      increase size of window
    ctrl+w x      exchange current window with next one
    ctrl+w r      rotate windows clockwise 
    :copen        open quick fix window
    :ccl          close quick fix window

## Edit file

    :e filename   edit file

## Macros 

    q<letter><do actions>q      - record macro
    20@<letter>                 - run macro 20 times

## Visual mode

    ctrl-v   go into column editing mode. (If you want to insert press I.)
    shift-v  select current line

## Undo

    U       Restore the current line to the state before the cursor entered the line. 
    u       Undo the last change to the file. Typing 'u' again will re-do the change. 
    ctrl-r  Redo last change

## Miscellany 

    ^L      Clear and redraw the screen. 
    ^R      Redraw the screen removing false lines. 
    z       Redraw the screen
    ^[      Escape key. Cancels partially formed command. 
    &       Repeat the previous ":s" command. 
    .       Repeat the last command that modified the file. 
    @       Type the command stored in the specified buffer. 
    m       Mark the current position with the char specified after the 'm' command. 

## Shell execution

Execute a shell with `!`. If a is specified, the program which is executed using ! uses the specified line(s) as standard input, and will replace those lines with the standard output of the program executed.

`!!` executes a program using the current line as input. For example, `!4jsort` will take five lines from the current cursor position and execute sort. After typing the command, there will be a single exclamation point where you can type the command in. 

## Fugitive

    :Gstatus    show git status
    :Glog       load up previous versions into the quick fix window
    :Gblame     open the blame in a vertical split
    :Gmove      git mv on a file and rename buffer

### Commands in status window

    <CR>  |:Gedit|
    -     |:Git| add
    -     |:Git| reset (staged files)
    C     |:Gcommit|
    cA    |Gcommit| --amend --reuse-message=HEAD
    ca    |Gcommit| --amend


## Ruby blocks

When `textobj-rubyblock` is installed you will gain two new text objects, which are triggered by `ar` and `ir` respectively. These follow Vim convention, so that `ar` selects _all_ of a ruby block, and `ir` selects the _inner_ portion of a rubyblock. 

Note that you can use `ir` and `ar` to expand and contract an existing selection.

## NERDCommenter

    ,ca     Changes the comment style used

## Pathogen

   :call pathogen#helptags()    Regenerate doc tags 

## Show mappings

    :map    All mapped commands
    :map ,  All mapped commands starting with ,
