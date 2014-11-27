-module(time_consuming_add_entry_tests).
-include_lib("time_consuming_records.hrl").
-include_lib("eunit/include/eunit.hrl").

add_entry_with_an_unauthorized_kind_of_entry_test() ->
  Entry = #entry_record { kind=wrong_kind, hours=3, message="Working hard on Erlang", week=42 },
  { ko, "You can only log maintenance or feature" } = time_consuming_add_entry:add(Entry).

add_entry_with_a_feature_kind_of_entry_test() ->
  Entry = #entry_record { kind=feature, hours=3, message="Working hard on Erlang", week=42 },
  ok = time_consuming_add_entry:add(Entry).

add_entry_with_a_maintenance_kind_of_entry_test() ->
  Entry = #entry_record { kind=maintenance, hours=3, message="Working hard on Erlang", week=42 },
  ok = time_consuming_add_entry:add(Entry).
