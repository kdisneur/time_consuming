-module(time_consuming_list_entries).
-export([list/1]).
-include_lib("time_consuming_records.hrl").

list(List=#list_record{}) ->
  lists:map(fun line_to_entry/1, time_consuming_database:all_lines(List#list_record.week)).

%%% Private

line_to_entry(Line) ->
  [RawKind, RawHours, RawMessage] = string:tokens(Line, ";"),
  #entry_record { kind=time_consuming_parser:kind_from_string(RawKind), hours=time_consuming_parser:hours_from_string(RawHours), message=time_consuming_parser:message_from_string(RawMessage) }.
