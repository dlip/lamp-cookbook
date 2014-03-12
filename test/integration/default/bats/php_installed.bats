#!/usr/bin/env bats

@test "php binary is found in PATH" {
  run which php
  [ "$status" -eq 0 ]
}
