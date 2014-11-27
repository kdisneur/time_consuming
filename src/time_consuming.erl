-module(time_consuming).
-export([start/0]).
-include_lib("time_consuming_records.hrl").

start() ->
  process(time_consuming_options:entry()).

%%% Private

display(Entry=#entry_record{}) ->
  io:format("~s - ~p hours - ~s~n", [Entry#entry_record.kind, Entry#entry_record.hours, Entry#entry_record.message]).

process(Entry=#entry_record{}) ->
  case time_consuming_add_entry:add(Entry) of
    { ok }         -> io:format("Entry logged~n");
    { ko, Reason } -> io:format("~s~n", Reason)
  end;
process(List=#list_record{}) ->
  lists:map(fun display/1, time_consuming_list_entries:list(List)).
