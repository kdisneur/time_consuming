-module(time_consuming_options).
-export([entry/0]).
-include_lib("time_consuming_records.hrl").

entry() ->
  case kind() of
    list  -> #list_record { week=week() };
    _Else -> #entry_record { kind=kind(), hours=hours(), message=message(), week=week() }
  end.

%% Private

hours() ->
  { ok, [[RawHours]] } = init:get_argument(hours),
  time_consuming_parser:hours_from_string(RawHours).

kind() ->
  { ok, [[RawKind]] } = init:get_argument(kind),
  time_consuming_parser:kind_from_string(RawKind).

message() ->
  { ok, [[Message]] } = init:get_argument(message),
  time_consuming_parser:message_from_string(Message).

week() ->
  Week = week_number(),
  case Week of
    none  ->
      WeekPadding = week_padding(),
      case WeekPadding of
        none -> time_consuming_parser:current_week();
        _Else -> WeekPadding
    end;
    _Else -> Week
  end.

week_number() ->
  try
    { ok, [[WeekNumber]] } = init:get_argument(week),
    time_consuming_parser:week_from_string(absolute, WeekNumber)
  catch
    _:_ -> none
  end.

week_padding() ->
  try
    { ok, [[PaddingNumber]] }  = init:get_argument(previous_week),
    time_consuming_parser:week_from_string(relative, PaddingNumber)
  catch
    _:_ -> none
  end.
