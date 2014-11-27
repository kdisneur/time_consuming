-module(time_consuming_database).
-export([all_lines/1, append_line/2]).

append_line(Name, Line) ->
  case file:open(full_path(Name), [append]) of
    { ok, Database } ->
      file:write(Database, Line),
      file:close(Database),
      ok;
    { error, UnderlyingReason } ->
      Reason = io_lib:format("impossible to access the database. Error reason: ~s", [UnderlyingReason]),
      { ko, Reason }
  end.

all_lines(Name) ->
  { ok, Database } = file:open(full_path(Name), [read]),
  lists:map(fun chomp/1, fetch_lines(Database, [])).

%%% Private

chomp(RawString) ->
  [CleanedBinaryString, _] = re:replace(RawString, "\n", ""),
  binary_to_list(CleanedBinaryString).

fetch_lines(Database, Lines) ->
  case io:get_line(Database, "") of
    eof  -> file:close(Database), Lines;
    Line -> fetch_lines(Database, Lines ++ [Line])
  end.

full_path(DatabaseName) ->
  { ok, Home }       = init:get_argument(home),
  DatabaseDirectory  = string:concat(Home, "/.time_consuming-data/"),
  filelib:ensure_dir(DatabaseDirectory),
  string:concat(DatabaseDirectory, io_lib:format("~p.csv", [DatabaseName])).
