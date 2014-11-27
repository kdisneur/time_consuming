-module(time_consuming_parser).
-export([current_week/0, hours_from_string/1, kind_from_string/1, message_from_string/1, week_from_string/2]).

current_week() ->
  { _, Week } = calendar:iso_week_number(),
  Week.

hours_from_string(RawHours) ->
  to_integer(RawHours).

kind_from_string(RawKind) ->
  list_to_atom(RawKind).

message_from_string(RawMessage) ->
  RawMessage.

week_from_string(relative, WeekPadding) ->
  previous_week(to_integer(WeekPadding));
week_from_string(absolute, Week) ->
  to_integer(Week).

%%% Private

previous_week(Number) ->
  current_week() - Number.

to_integer(RawString) ->
  { Integer, _ } = string:to_integer(RawString),
  Integer.

