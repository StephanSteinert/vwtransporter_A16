events =
{
  -- Called when charging of an entity begins.
  -- entity: the entity that is now charging
  -- charging_entityes: array of player-placed entities associated with charging process.
  on_charging_started = script.generate_event_name(),
  -- Called when an entity is no longer being charged because it moved out of range, something was destroyed, etc.
  -- entity: the affected entity
  -- charging_entityes: array of player-placed entities that were associated with the charging process.
  on_charging_stopped = script.generate_event_name(),
}
