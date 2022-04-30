-module(afile_client).
-export([command/2]).


command(Server,Command) -> 
    case Command of 
        {ls} -> 
            ls(Server);
        {get_file,File} ->
            get_file(Server,File);
        {put_file,File,Content} ->
            put_file(Server,File,Content);
        _ ->
            throw(Command)
    end.

ls(Server) -> 
    Server ! {self(), list_dir},
    receive 
        {Server, FileList} ->
            FileList
    end.

get_file(Server, File) -> 
    Server ! {self(), {get_file, File}},
    receive 
        {Server, Content} ->
            Content
    end.

put_file(Server, File, Content) -> 
    Server ! {self(), {put_file, File, Content}},
    receive 
        {Server, ok} -> ok
    end.