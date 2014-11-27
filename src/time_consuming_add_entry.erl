-module(time_consuming_add_entry).
-export([add/1]).
-include_lib("time_consuming_records.hrl").

add(Entry) when Entry#entry_record.kind == feature orelse Entry#entry_record.kind == maintenance ->
  time_consuming_database:append_line(Entry#entry_record.week, entry_to_line(Entry));
add(_Entry) ->
  Reason = "You can only log maintenance or feature",
  { ko, Reason }.

%%% Private

entry_to_line(Entry) ->
  io_lib:format("~s;~p;~s~n", [Entry#entry_record.kind, Entry#entry_record.hours, Entry#entry_record.message]).
